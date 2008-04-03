package de.escidoc.core.admin.business;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 * This class encapsulates the reading operations on the original database.
 * 
 * @spring.bean id="de.escidoc.core.admin.Reader"
 * @author TTE
 * 
 */
public class SourceDbReader extends JdbcDaoSupport
    implements SourceDbReaderInterface {

    // CHECKSTYLE:JAVADOC-OFF

    /**
     * See Interface for functional description.
     * 
     * @param tableName
     * @return
     * @see de.escidoc.core.admin.business.SourceDbReaderInterface#retrieveTableData(java.lang.String)
     */
    public List<Map<String, Object>> retrieveTableData(final String tableName) {

        final StringBuffer cmd = new StringBuffer("select * from ");
        cmd.append(tableName);
        cmd.append(";");
        return getJdbcTemplate().queryForList(cmd.toString());
    }

    // CHECKSTYLE:JAVADOC-ON
}
