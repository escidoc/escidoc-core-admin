package de.escidoc.core.admin.business.interfaces;

import java.io.IOException;
import java.io.InputStream;

/**
 * Interface of a database dao.
 * 
 * @author TTE
 * 
 */
public interface DbDaoInterface {

    /**
     * Gets the URL to the used database.
     * 
     * @return Returns the URl to the database as a {@link String}.
     */
    public String getUrl();

    /**
     * Executed the specified SQL script.
     * 
     * @param scriptName
     *            The name of the SQL script.
     * @throws IOException
     *             Thrown if data could not be read from SQL script.
     */
    public abstract void executeSqlScript(final String scriptName)
        throws IOException;

    /**
     * Executed the SQL script contained in the provided {@link InputStream}.
     * 
     * @param resource
     *            The {@link InputStream} containing the SQL script.
     * @throws IOException
     *             Thrown if data could not be read from SQL script.
     */
    public abstract void executeSqlScript(final InputStream resource)
        throws IOException;

    /**
     * Executes the given SQL command.
     * 
     * @param command
     *            The command to execute.
     */
    public abstract void executeSqlCommand(final String command);

    /**
     * Gets the number of rows of the addressed table.
     * 
     * @param tableName
     *            The name of the table including the schema.
     * @return Returns the number of rows in the table.
     */
    public abstract int getNumberOfRows(final String tableName);

}