/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License, Version 1.0 only
 * (the "License").  You may not use this file except in compliance
 * with the License.
 *
 * You can obtain a copy of the license at license/ESCIDOC.LICENSE
 * or http://www.escidoc.de/license.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at license/ESCIDOC.LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */

/*
 * Copyright 2006-2009 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin.business;

import java.io.File;
import java.io.FileFilter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.Collection;
import java.util.TreeSet;
import javax.sql.DataSource;

import de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface;
import de.escidoc.core.admin.business.interfaces.SmMigrationInterface;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.exceptions.system.IntegritySystemException;
import de.escidoc.core.common.util.Version;
import de.escidoc.core.common.util.db.Fingerprint;
import de.escidoc.core.common.util.logger.AppLogger;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.Target;
import org.apache.tools.ant.taskdefs.SQLExec;
import org.apache.tools.ant.types.FileSet;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;

/**
 * Provides a method used for migrating the database to the most current
 * version.
 * 
 * @author Andr&eacute; Schenk
 * 
 * @spring.bean id="de.escidoc.core.admin.DataBaseMigrationTool"
 * 
 */
public class DataBaseMigrationTool extends DbDao
    implements DataBaseMigrationInterface {
    /**
     * Database table name for the version information.
     */
    private static final String VERSION_TABLE_NAME = "adm.version";

    /**
     * Database column name for the major number.
     */
    private static final String COLUMN_MAJOR_NUMBER = "major_number";

    /**
     * Database column name for the minor number.
     */
    private static final String COLUMN_MINOR_NUMBER = "minor_number";

    /**
     * Database column name for the owner name.
     */
    private static final String COLUMN_USENAME = "usename";

    /**
     * Database column name for the revision number.
     */
    private static final String COLUMN_REVISION_NUMBER = "revision_number";

    /**
     * Database column name for the version date.
     */
    private static final String COLUMN_DATE = "date";

    /**
     * Database query to get the latest version.
     */
    private static final String QUERY_LATEST_VERSION =
        "SELECT * FROM " + VERSION_TABLE_NAME + " WHERE " + COLUMN_DATE
            + "=(SELECT MAX(" + COLUMN_DATE + ") FROM " + VERSION_TABLE_NAME
            + ")";

    /**
     * Database query to get the owner.
     */
    private static final String QUERY_OWNER =
        "SELECT * FROM pg_database, pg_user WHERE usesysid=pg_database.datdba "
            + "AND datname=''{0}''";

    /**
     * Database query to check the creator id.
     */
    private static final String QUERY_CREATOR_ID =
        "SELECT id FROM aa.user_account WHERE id=''{0}''";

    /**
     * Directory which contains the SQL scripts.
     */
    private static final String DIRECTORY_SCRIPTS = "db-processed";

    private SmMigrationInterface smMigration;
    
    /**
     * The logger.
     */
    private static AppLogger log =
        new AppLogger(DataBaseMigrationTool.class.getName());

    /**
     * Database settings.
     */
    private final String driverClassName;

    private final String url;

    private final String username;

    private final String password;

    private final String scriptPrefix;

    private final String creatorId;

    /**
     * Attributes needed to call an Ant target.
     */
    private Project project = new Project();

    private Target target = new Target();

    /**
     * Construct a new DataBaseMigrationTool object.
     * 
     * @param driverClassName
     *            name of the JDBC driver
     * @param url
     *            JDBCL URL
     * @param username
     *            name of the database user
     * @param password
     *            password of the database user
     * @param scriptPrefix
     *            prefix for database script names (mainly for MySQL)
     * @param creatorId
     *            id of a user account which will be inserted as creator in the
     *            SQL scripts
     */
    public DataBaseMigrationTool(final String driverClassName,
        final String url, final String username, final String password,
        final String scriptPrefix, final String creatorId) {
        this.driverClassName = driverClassName;
        this.url = url;
        this.username = username;
        this.password = password;
        this.scriptPrefix = scriptPrefix;
        this.creatorId = creatorId;
        project.init();
        target.setProject(project);
    }

    /**
     * Check if the configured creator id exists in the database.
     * 
     * @return true if the creator id exists
     * @throws SQLException
     *             Thrown if the SQL query failed.
     */
    private boolean creatorExists() throws SQLException {
        return getJdbcTemplate().query(
            MessageFormat.format(QUERY_CREATOR_ID, creatorId),
            new ResultSetExtractor() {
                public Object extractData(final ResultSet rs)
                    throws SQLException {
                    String result = null;

                    if (rs.next()) {
                        result = rs.getString(1);
                    }
                    return result;
                }
            }) != null;
    }

    /**
     * Get the owner of the current database.
     * 
     * @return database owner
     * @throws SQLException
     *             Thrown if the structure of the database could not be
     *             determined
     */
    private String getDBOwner() throws SQLException {
        return (String) getJdbcTemplate().query(
            MessageFormat.format(QUERY_OWNER, getConnection().getCatalog()),
            new ResultSetExtractor() {
                public Object extractData(final ResultSet rs)
                    throws SQLException {
                    String result = null;

                    if (rs.next()) {
                        result = rs.getString(COLUMN_USENAME);
                    }
                    return result;
                }
            });
    }

    /**
     * Get the current database version from the database.
     * 
     * @return current database version
     */
    private Version getDBVersion() {
        Version result = null;

        try {
            result =
                (Version) getJdbcTemplate().query(QUERY_LATEST_VERSION,
                    new ResultSetExtractor() {
                        public Object extractData(final ResultSet rs)
                            throws SQLException {
                            Version result = null;

                            if (rs.next()) {
                                result =
                                    new Version(rs.getInt(COLUMN_MAJOR_NUMBER),
                                        rs.getInt(COLUMN_MINOR_NUMBER), rs
                                            .getInt(COLUMN_REVISION_NUMBER));
                            }
                            return result;
                        }
                    });
            if (result == null) {
                // version table is empty
                result = new Version(1, 0, 0);
            }
        }
        catch (DataAccessException e) {
            // version table doesn't exist
            result = new Version(1, 0, 0);
        }
        return result;
    }

    /**
     * Get an ordered list of all available updates found in the given
     * directory.
     * 
     * @param dirName
     *            directory which contains sub directories with the SQL scripts
     * 
     * @return ordered list of all available updates
     */
    private Collection<Version> getUpdates(final String dirName) {
        Collection<Version> result = new TreeSet<Version>();
        File dir = new File(dirName);
        File[] updates = dir.listFiles(new FileFilter() {
            public boolean accept(final File pathname) {
                return (pathname != null) && (pathname.isDirectory());
            }
        });

        if (updates != null) {
            for (File update : updates) {
                result.add(new Version(update.getName()));
            }
        }
        return result;
    }

    /**
     * Compare the current database structure with the structure stored in an
     * XML file.
     * 
     * @throws IntegritySystemException
     *             Thrown in case the content of the database is not in a
     *             consistent state.
     */
    private void checkConsistency() throws IntegritySystemException {
        Version dbVersion = getDBVersion();
        String fingerprintFile =
            "/de/escidoc/core/common/util/db/fingerprints/"
                + dbVersion.toString() + ".xml";
        try {
            Fingerprint currentFingerprint = new Fingerprint(getConnection());
            Fingerprint storedFingerprint =
                Fingerprint.readObject(getClass().getResourceAsStream(
                    fingerprintFile));

            if (storedFingerprint.compareTo(currentFingerprint) != 0) {
                throw new IntegritySystemException(
                    "The database is not in the expected state to run "
                        + "the migration. Please compare the file \""
                        + System.getProperty("java.io.tmpdir")
                        + "/fingerprint.xml\" " + "with \"" + fingerprintFile
                        + "\" which is included in the class path.");
            }
        }
        catch (IOException e) {
            throw new IntegritySystemException(
                "could not check the database consistency", e);
        }
        catch (SQLException e) {
            throw new IntegritySystemException(
                "could not check the database consistency", e);
        }
    }

    /**
     * See Interface for functional description.
     * 
     * @throws IntegritySystemException
     *             Thrown in case the content of the database is not as
     *             expected.
     * @see de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface#migrate()
     */
    public void migrate() throws IntegritySystemException {
        // check database owner
        try {
            final String owner = getDBOwner();

            if (!owner.equals(username)) {
                throw new IntegritySystemException(
                    "The configured database user \"" + username
                        + "\" differs from the database owner \"" + owner
                        + "\".");
            }
        }
        catch (Exception e) {
            throw new IntegritySystemException(
                "could not check the database consistency", e);
        }

        // check if the creator exists
        try {
            if (!creatorExists()) {
                throw new IntegritySystemException(
                    "The configured creator id \"" + creatorId
                        + "\" does not exist in the database.");
            }
        }
        catch (SQLException e) {
            throw new IntegritySystemException(
                "could not check if the creator id exists", e);
        }

        // search for all available updates
        Collection<Version> updates = getUpdates(DIRECTORY_SCRIPTS);

        log.info("available updates: " + updates);

        try {
            for (Version version : updates) {
                Version dbVersion = getDBVersion();

                if (version.compareTo(dbVersion) > 0) {
                    log.info("current DB version: " + dbVersion);

                    // check database structure before migration
                    checkConsistency();

                    // do the migration
                    log.info("migrate to " + version + " ...");
                    update(version);
                    if (version.toString().equals("1.3.0")) {
                        smMigration.migrate();
                    }
                }
            }
            // check database structure after migration
            checkConsistency();
        }
        catch (IOException e) {
            throw new IntegritySystemException(e);
        }
        catch (ApplicationServerSystemException e) {
            throw new IntegritySystemException(e);
        }
    }

    /**
     * Injects the data source.
     * 
     * @spring.property ref="escidoc-core.DataSource"
     * @param myDataSource
     *            data source from Spring
     */
    public final void setMyDataSource(final DataSource myDataSource) {
        super.setDataSource(myDataSource);
    }

    /**
     * Injects the sm migration tool.
     * 
     * @spring.property ref="de.escidoc.core.admin.SmMigrationTool"
     * @param smMigration smMigrationTool
     */
    public final void setSmMigrationTool(final SmMigrationInterface smMigration) {
        this.smMigration = smMigration;
    }

    /**
     * Update the database to the given version.
     * 
     * @param version
     *            the new version of the database
     * 
     * @throws IOException
     *             Thrown if an error occurred while reading the SQL scripts
     */
    private void update(final Version version) throws IOException {
        File sqlDir =
            new File(new File(DIRECTORY_SCRIPTS, version.toString()),
                scriptPrefix);
        SQLExec sqlExec = new SQLExec();
        String[] scripts = sqlDir.list(new FilenameFilter() {
            public boolean accept(final File dir, final String name) {
                return (name != null) && (name.endsWith(".sql"));
            }
        });
        FileSet set = new FileSet();

        sqlExec.setProject(project);
        sqlExec.setOwningTarget(target);
        sqlExec.setDriver(driverClassName);
        sqlExec.setUrl(url);
        sqlExec.setUserid(username);
        sqlExec.setPassword(password);
        set.setDir(sqlDir);
        set.setProject(project);
        for (String script : scripts) {
            set.setIncludes(script);
        }
        sqlExec.addFileset(set);
        sqlExec.execute();
    }
}
