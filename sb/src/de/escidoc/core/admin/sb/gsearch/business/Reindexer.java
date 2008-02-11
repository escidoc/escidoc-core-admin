package de.escidoc.core.admin.sb.gsearch.business;

import java.io.ByteArrayInputStream;
import java.util.HashMap;

import de.escidoc.core.admin.common.util.EscidocCoreHandler;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.stax.handler.MultipleExtractor;
import de.escidoc.core.common.util.xml.XmlUtility;

public class Reindexer {
	
	private GsearchHandler gsearchHandler;

	/**
	 * TODO: Describe Method
	 *
	 * @param args
	 */
	public void reindex() {
		//get all released items from om
		EscidocCoreHandler escidocHandler = new EscidocCoreHandler();
		try {
			String filter = "<param><filter name=\"public-status\">withdrawn</filter></param>";
			String result = escidocHandler.requestEscidoc("/ir/items/filter/refs", filter);

			StaxParser sp = new StaxParser();
	        HashMap extractPathes = new HashMap();
	        extractPathes.put("/item-ref-list/item-ref", "xlink:href");
	        MultipleExtractor me = new MultipleExtractor(extractPathes, sp);

	        try {
	            sp.parse(new ByteArrayInputStream(result.getBytes(XmlUtility.CHARACTER_ENCODING)));
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	        }

	        HashMap streams = me.getOutputStreams();
	        System.out.println("OK");
		} catch (ApplicationServerSystemException e) {
			e.printStackTrace();
		}
	}

}
