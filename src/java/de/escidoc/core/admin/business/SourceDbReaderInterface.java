package de.escidoc.core.admin.business;

import java.util.List;
import java.util.Map;

/**
 * Interface providing read access to tables of the source database, i.e. the
 * database that shall be migrated.
 * 
 * @author TTE
 * 
 */
public interface SourceDbReaderInterface {

    /**
     * Gets the content of the specified table.
     * 
     * @param tableName
     *            The name of the table including the schema name, e.g.
     *            aa.user_account.
     * @return Returns the values of a table.
     */
    public List<Map<String, Object>> retrieveTableData(final String tableName);
}