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

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.InputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.TreeSet;
import javax.sql.DataSource;

import de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface;
import de.escidoc.core.common.exceptions.system.IntegritySystemException;
import de.escidoc.core.common.util.logger.AppLogger;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;

/**
 * Provides a method used for migrating the database to the most current version.
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
    private static final String TABLE_NAME = "common.version";

    /**
     * Database column name for the major number.
     */
    private static final String COLUMN_MAJOR_NUMBER = "major_number";

    /**
     * Database column name for the minor number.
     */
    private static final String COLUMN_MINOR_NUMBER = "minor_number";

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
        "SELECT * FROM " + TABLE_NAME + " WHERE " + COLUMN_DATE + "=(SELECT MAX("
        + COLUMN_DATE + ") FROM " + TABLE_NAME + ")";

    /**
     * Directory which contains the SQL scripts.
     */
    private static final String DIRECTORY_SCRIPTS = "db";

    /**
     * The logger.
     */
    private static AppLogger log =
        new AppLogger(DataBaseMigrationTool.class.getName());

    /**
     * Database prefix for other databases than Postgres.
     */
    private final String scriptPrefix;

    /**
     * Construct a new DataBaseMigrationTool object.
     * 
     * @param scriptPrefix
     *            prefix for database script names (mainly for MySQL)
     */
    public DataBaseMigrationTool(final String scriptPrefix) {
        this.scriptPrefix = scriptPrefix;
    }

    /**
     * Get the current database version from the database.
     *
     * @return current database version
     */
    private Version getDBVersion() {
        Version result = null;

        try {
            result = (Version) getJdbcTemplate().query(QUERY_LATEST_VERSION,
                new ResultSetExtractor() {
                    public Object extractData(final ResultSet rs)
                        throws SQLException {
                        Version result = null;

                        if (rs.next()) {
                            result = new Version(
                                rs.getInt(COLUMN_MAJOR_NUMBER),
                                rs.getInt(COLUMN_MINOR_NUMBER),
                                rs.getInt(COLUMN_REVISION_NUMBER));
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
     * Get an ordered list of all available updates found in the given directory.
     *
     * @param dirName directory which contains sub directories with the SQL scripts
     *
     * @return ordered list of all available updates
     */
    private Collection <Version> getUpdates(final String dirName) {
        Collection <Version> result = new TreeSet <Version>();
        File dir = new File(dirName);
        File [] updates = dir.listFiles(new FileFilter() {
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
     * See Interface for functional description.
     * 
     * @throws IntegritySystemException Thrown in case the content of the database is not as expected.
     * @see de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface#migrate()
     */
    public void migrate() throws IntegritySystemException {
        Collection <Version> updates = getUpdates(DIRECTORY_SCRIPTS);

        log.info("available updates: " + updates);

        Version dbVersion = getDBVersion();

        log.info("current DB version: " + dbVersion);
        try {
            for (Version version : updates) {
                if (version.compareTo(dbVersion) > 0) {
                    log.info("migrate to " + version + " ...");
                    update(version);
                }
            }
        }
        catch (IOException e) {
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
     * Update the database to the given version.
     *
     * @param version the new version of the database
     *
     * @throws IOException Thrown if an error occurred while reading the SQL scripts
     */
    private void update(final Version version) throws IOException {
        File sqlDir = new File(
            new File(DIRECTORY_SCRIPTS, version.toString()), scriptPrefix);
        String [] scripts = sqlDir.list(new FilenameFilter() {
                public boolean accept(final File dir, final String name) {
                    return (name != null) && (name.endsWith(".sql"));
                }
            });

        for (String script : scripts) {
            log.info("process " + script + " ...");

            InputStream reader = null;

            try {
                reader = new BufferedInputStream(new FileInputStream(new File(
                    sqlDir, script)));
                executeSqlScript(reader);
            }
            finally {
                if (reader != null) {
                    reader.close();
                }
            }
        }
    }
}
