package de.escidoc.core.admin.business.interfaces;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Interface of a target db writer.
 * 
 * @author TTE
 * 
 */
public interface TargetDbDaoInterface extends DbDaoInterface {

    /**
     * Inserts the provided table data into the new table.
     * 
     * @param tableName
     *            The name of the table, including the schema name, e.g.
     *            aa.user_account.
     * @param dropColumns
     *            {@link List} containing the name of the columns that shall be
     *            dropped, i.e. will not be copied. This parameter may be
     *            <code>null</code>.
     * @param tableData
     *            The table data.
     */
    public abstract void insertTableData(
        final String tableName, final List<String> dropColumns,
        final List<Map<String, Object>> tableData);

    /**
     * Gets the policies data from the database.
     * 
     * @return Returns the policies data.
     */
    public List<Map<String, Object>> getPoliciesData();

    /**
     * Execute create script.<br>
     * The name of the script that is executed is built using the provided value
     * and the suffix ".create.sql".
     * 
     * @param name
     *            The prefix of the script name.
     * @throws IOException
     *             Thrown if access to the resource failed.
     * 
     */
    public void executeCreateScript(final String name) throws IOException;

    /**
     * Drops the addressed schema.<br>
     * 
     * @param schemaName
     *            The name of the schema to drop.
     */
    public void dropSchema(final String schemaName);

    /**
     * Renames a column of a table.
     * 
     * @param tableName
     *            The name of the table including the schema name.
     * @param oldName
     *            The name of the colun to be renamed.
     * @param newName
     *            The new name of the column.
     */
    public void renameTableColumn(
        final String tableName, final String oldName, final String newName);

    /**
     * Gets the maximum value of the addressed database tabel column.
     * 
     * @param tableName
     *            The name of the table including the schema name.
     * @param columnName
     *            The name of the column.
     */
    public Object getMaxOfColumn(final String tableName, final String columnName);

    /**
     * Checks if a table with the provided name exists.
     * 
     * @param tableName
     *            The name of the table including the schema name.
     * @return Returns <code>true</code> if the table exists.
     */
    public boolean existsTable(final String tableName);

}