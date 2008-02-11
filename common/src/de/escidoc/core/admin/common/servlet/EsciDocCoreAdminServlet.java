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
 * Copyright 2006-2007 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.  
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin.common.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import de.escidoc.core.admin.sb.gsearch.business.Reindexer;
import de.escidoc.core.common.exceptions.system.SystemException;
import de.escidoc.core.common.servlet.invocation.MapperInterface;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.service.BeanLocator;
import de.escidoc.core.common.util.service.UserContext;
import de.escidoc.core.common.util.xml.XmlUtility;

/**
 * The eSciDoc servlet. Maps a REST request to the specified resource and
 * invokes the specified (if one is configured).<br/>All methods of this class
 * that send an http response have to assure that this response is properly
 * initalized by calling the one of the <code>initHttpResponse</code> methods.
 * 
 * @author MSC
 * @common
 */
public class EsciDocCoreAdminServlet extends HttpServlet {

	/**
	 * The serial version UID.
	 */
	private static final long serialVersionUID = 7530500912744342535L;

	/** The logger. */
	private static AppLogger logger = new AppLogger(EsciDocCoreAdminServlet.class
			.getName());

	private static final int HTTP_AUTHORIZATION_ERROR = 401;

	public static final String ENCODING = XmlUtility.CHARACTER_ENCODING;

	/**
	 * The central service method. Maps a REST request to the specified resource
	 * and invokes the specified (if one is configured). If a GET or HEAD
	 * request contains user handle information in the URL (as parameter), a
	 * redirect to the same URL without the handle parameter is sent back to
	 * enable browsers to remove this security information from the displayed
	 * URL.
	 * 
	 * @param request
	 *            The servlet request.
	 * @param response
	 *            The servlet response
	 * @throws ServletException
	 *             If anything fails.
	 * @throws IOException
	 *             If anything fails.
	 * @common
	 */
	public void service(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException,
			IOException {
//		if (request.getHeader("Authorization") == null
//				|| request.getHeader("Authorization").equals("")) {
//			response.sendError(HTTP_AUTHORIZATION_ERROR);
//		} else {
			// Get Username and Password////////////////////////////////////////
			String authHeader = request.getHeader("Authorization");
			authHeader = authHeader.substring(authHeader.indexOf(" "));
			String decoded = new String(Base64.decode(authHeader));
			int i = decoded.indexOf(":");
			String username = decoded.substring(0, i);
			String pwd = decoded.substring(i + 1, decoded.length());
			// /////////////////////////////////////////////////////////////////

			String operation = request.getParameter("operation");
			StringBuffer resultXml;
			try {
				if ("reindex".equals(operation)) {
					resultXml = new StringBuffer(reindex());
				} else {
					resultXml = new StringBuffer("<resultPage/>");
					if (operation != null && !"".equals(operation))
						throw new ServletException("ERROR: operation "
								+ operation + " is unknown!");
				}
			} catch (SystemException e) {
				resultXml = new StringBuffer("<resultPage>");
				resultXml.append("<error><message><![CDATA[" + e.getMessage()
						+ "]]></message></error>");
				resultXml.append("</resultPage>");
				logger.error(e);
				e.printStackTrace();
			}
//		}
	}
	
	private String reindex() throws SystemException {
		Reindexer reindexer = new Reindexer();
		reindexer.reindex();
		return "OK";
	}

}
