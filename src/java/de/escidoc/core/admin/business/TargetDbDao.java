package de.escidoc.core.admin.business;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import de.escidoc.core.admin.business.interfaces.TargetDbDaoInterface;
import de.escidoc.core.common.util.string.StringUtility;

/**
 * This class encapsulates the writing operations to the new (target) database.
 * 
 * @spring.bean id="de.escidoc.core.admin.TargetDbDao"
 * @author TTE
 * 
 */
public class TargetDbDao extends DbDao implements TargetDbDaoInterface {

    /**
     * Pattern used to escape SQL forbidden characters.
     */
    private static final Pattern PATTERN_SQL_SPECIAL_CHARS =
        Pattern.compile("(['´`])");

    /**
     * See Interface for functional description.
     * 
     * @param tableName
     * @param dropColumns
     * @param tableData
     * @see de.escidoc.core.admin.business.interfaces.TargetDbDaoInterface#insertTableData(java.lang.String,
     *      java.util.List, java.util.List)
     */
    public void insertTableData(
        final String tableName, final List<String> dropColumns,
        final List<Map<String, Object>> tableData) {

        List<String> toBeDropped = dropColumns;
        if (toBeDropped == null) {
            toBeDropped = new ArrayList<String>(0);
        }

        Iterator<Map<String, Object>> iter = tableData.iterator();
        while (iter.hasNext()) {
            Map<String, Object> rowData = iter.next();
            Iterator<String> columnIter = rowData.keySet().iterator();
            StringBuffer cmd = new StringBuffer("INSERT INTO ");
            cmd.append(tableName);
            cmd.append(" VALUES (");
            boolean isNotFirst = false;
            while (columnIter.hasNext()) {
                String name = columnIter.next();
                if (!toBeDropped.contains(name)) {
                    Object value = rowData.get(name);
                    if (isNotFirst) {
                        cmd.append(", ");
                    }
                    if (value instanceof String) {
                        cmd.append("'");
                        final Matcher matcher =
                            PATTERN_SQL_SPECIAL_CHARS.matcher((String) value);
                        cmd.append(matcher.replaceAll("\\\\$1"));
                        cmd.append("'");
                    }
                    else if (value instanceof Date
                        || value instanceof java.sql.Date) {
                        cmd.append("'");
                        cmd.append(value);
                        cmd.append("'");
                    }
                    else {
                        cmd.append(value);
                    }
                    isNotFirst = true;
                }
            }
            cmd.append(");");
            executeSqlCommand(cmd.toString());
        }
    }

    /**
     * See Interface for functional description.
     * 
     * @return
     * @see de.escidoc.core.admin.business.interfaces.TargetDbDaoInterface
     *      #getPoliciesData()
     */
    public List<Map<String, Object>> getPoliciesData() {

        return getJdbcTemplate().queryForList(
            "select id, xml from aa.escidoc_policies");

    }

    /**
     * See Interface for functional description.
     * 
     * @param name
     * @throws IOException
     * @see de.escidoc.core.admin.business.interfaces.TargetDbDaoInterface#executeCreateScript(java.lang.String)
     */
    public void executeCreateScript(final String name) throws IOException {

        executeSqlScript(StringUtility.concatenateToString(name, ".create.sql"));
    }

    /**
     * See Interface for functional description.
     * 
     * @param schemaName
     * @see de.escidoc.core.admin.business.interfaces.TargetDbDaoInterface
     *      #dropSchema(java.lang.String)
     */
    public void dropSchema(final String schemaName) {

        executeSqlCommand(StringUtility.concatenateToString("DROP SCHEMA ",
            schemaName, " CASCADE"));
    }

    /**
     * See Interface for functional description.
     * 
     * @param tableName
     * @param oldName
     * @param newName
     * @see de.escidoc.core.admin.business.interfaces.TargetDbDaoInterface#renameTableColumn(java.lang.String,
     *      java.lang.String, java.lang.String)
     */
    public void renameTableColumn(
        final String tableName, final String oldName, final String newName) {

        executeSqlCommand(StringUtility.concatenateToString("ALTER TABLE ",
            tableName, " RENAME COLUMN ", oldName, " TO ", newName, ";"));
    }

    /**
     * See Interface for functional description.
     * 
     * @param tableName
     * @param columnName
     * @return
     * @see de.escidoc.core.admin.business.interfaces.TargetDbDaoInterface#getMaxOfColumn(java.lang.String,
     *      java.lang.String)
     */
    public Object getMaxOfColumn(final String tableName, final String columnName) {

        return (getJdbcTemplate().queryForObject(StringUtility
            .concatenateToString("SELECT MAX(", columnName, ") from ",
                tableName), Object.class));
    }

    /**
     * See Interface for functional description.
     * 
     * @param tableName
     * @return
     * @see de.escidoc.core.admin.business.interfaces.TargetDbDaoInterface
     *      #existsTable(java.lang.String)
     */
    public boolean existsTable(final String tableName) {

        try {
            getNumberOfRows(tableName);
            return true;
        }
        catch (RuntimeException e) {
            return false;
        }

    }
}
