package de.escidoc.core.admin.business;

import java.io.IOException;
import java.io.InputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import de.escidoc.core.admin.business.interfaces.DbDaoInterface;
import de.escidoc.core.common.util.string.StringUtility;

/**
 * Abstract class to access a database.
 * 
 * @author TTE
 * 
 */
public abstract class DbDao extends JdbcDaoSupport implements DbDaoInterface {

    /**
     * The logger.
     */
    private static Logger log = LoggerFactory.getLogger(DbDao.class);

    /**
     * The url to the used database.
     */
    private String url;

    /**
     * See Interface for functional description.
     * 
     * @param scriptName
     * @throws IOException
     * @see de.escidoc.core.admin.business.interfaces.DbDaoInterface#executeSqlScript(java.lang.String)
     */
    public void executeSqlScript(final String scriptName) throws IOException {

        InputStream resource =
            getClass().getClassLoader().getResourceAsStream(scriptName);
        if (resource == null) {
            throw new IOException("Resource \"" + scriptName + "\" not found");
        }
        executeSqlScript(resource);
    }

    /**
     * See Interface for functional description.
     * 
     * @param resource
     * @throws IOException
     * @see de.escidoc.core.admin.business.interfaces.DbDaoInterface#executeSqlScript(java.io.InputStream)
     */
    public void executeSqlScript(final InputStream resource) throws IOException {
        int c = resource.read();
        StringBuffer cmd = new StringBuffer();
        while (c != -1) {
            cmd.append((char) c);
            if (c == ';') {
                executeSqlCommand(cmd.toString());
                cmd = new StringBuffer();
            }
            c = resource.read();
        }
    }

    /**
     * See Interface for functional description.
     * 
     * @param command
     * @see de.escidoc.core.admin.business.interfaces.DbDaoInterface#executeSqlCommand(java.lang.String)
     */
    public void executeSqlCommand(final String command) {

        log.debug(command);
        getJdbcTemplate().execute(command);
    }

    /**
     * See Interface for functional description.
     * 
     * @param tableName
     * @return
     * @see de.escidoc.core.admin.business.interfaces.DbDaoInterface#getNumberOfRows(java.lang.String)
     */
    public int getNumberOfRows(final String tableName) {

        final Integer numberRows =
            ((Integer) getJdbcTemplate().queryForObject(
                new StringBuffer("SELECT COUNT(*) from ")
                    .append(tableName).toString(), Integer.class));
        return numberRows.intValue();
    }

    /**
     * See Interface for functional description.
     * 
     * @return
     * @see de.escidoc.core.admin.business.interfaces.DbDaoInterface #getUrl()
     */
    public String getUrl() {

        return url;
    }

    /**
     * Injects the URL to the database.
     * 
     * @param url
     *            The url to the database. This must be the same value as it is
     *            used in the datasource set for this instance.
     */
    public void setUrl(final String url) {

        this.url = url;
    }

}
