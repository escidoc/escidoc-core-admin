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
package de.escidoc.core.admin.sb.gsearch.business;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.HashSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import de.escidoc.core.admin.common.util.configuration.EscidocConfiguration;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.service.HttpRequester;
import de.escidoc.core.common.util.xml.XmlUtility;

/**
 * Execute http-request to fedoragsearch. Update with requestIndexing, delete
 * with requestDeletion.
 * 
 * @sb
 */
public class GsearchHandler {

    private static AppLogger log =
        new AppLogger(GsearchHandler.class.getName());

    private HashMap<String, HashMap<String, String>> 
    							indexConfigurations = null;

    private HashMap<String, String>	repositoryInfo = null;

    private HashSet<String>	supportedMimeTypes = null;

    /**
     * requests indexing by calling fedoragsearch-servlet.
     * 
     * <pre>
     *        execute get-request with hardcoded index + repositoryname
     *        to fedoragsearch.
     * </pre>
     * 
     * @param resource
     *            String resource.
     * @param index
     *            String name of the index.
     * @param language
     *            String language of index.
     * 
     * @return String response
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @sb
     */
    public String requestIndexing(
        final String resource, String index, String language)
        throws ApplicationServerSystemException {
    	if (index == null) {
    		index = "";
    	}
        String updateIndexParams = Constants.GSEARCH_UPDATE_INDEX_PARAMS;
        updateIndexParams =
            updateIndexParams.replaceFirst("\\$\\{INDEX_NAME\\}", index);
        updateIndexParams =
            updateIndexParams.replaceFirst("\\$\\{VALUE\\}", resource);
        try {
            String gsearchUrl =
                EscidocConfiguration.getInstance().get(
                    EscidocConfiguration.GSEARCH_URL);

            // replace stylesheet-parameters.
            // send language and supported mime-types
            String stylesheetParameters =
                Constants.GSEARCH_STYLESHEET_PARAMS;
            if (language == null || language.equals("")) {
                stylesheetParameters =
                    stylesheetParameters.replaceFirst(
                    		"LANGUAGE=\\$\\{LANGUAGE\\},", "");
            } else {
                stylesheetParameters =
                    stylesheetParameters.replaceFirst("\\$\\{LANGUAGE\\}",
                        language);
            }
            stylesheetParameters =
                stylesheetParameters.replaceFirst(
                		"\\$\\{SUPPORTED_MIMETYPES\\}",
                    URLEncoder.encode(
                    		getRepositoryInfo().get("SupportedMimeTypes")
                    		, XmlUtility.CHARACTER_ENCODING));
            updateIndexParams = updateIndexParams + stylesheetParameters;

            HttpRequester requester = new HttpRequester(gsearchUrl);
            String response = requester.doGet(updateIndexParams);

            // Catch Exceptions
            if (response.matches("(?s).*Exception.*")) {
                // If index-directory does not exist yet
                // (first time indexer runs)
                // create empty index directory and then recall
                // indexing
                log.error(response);
                if (response.matches("(?s).*IndexModifier new error.*")
                    && (response.matches("(?s).*segments.*") || response
                        .matches("(?s).*not a directory.*"))) {
                    String createEmptyParams =
                        Constants.GSEARCH_CREATE_EMPTY_INDEX_PARAMS;
                    createEmptyParams =
                        createEmptyParams.replaceFirst("\\$\\{INDEX_NAME\\}",
                            index);
                    response = requester.doGet(createEmptyParams);
                    if (response.matches("(?s).*Exception.*")) {
                        throw new Exception(response);
                    }
                    response = requester.doGet(updateIndexParams);
                    if (response.matches("(?s).*Exception.*")) {
                        throw new Exception(response);
                    }
                }
                else if (response.matches("(?s).*Lock obtain timed out.*")) {
                    try {
                        String lockfilePath =
                            response.replaceFirst("(?s).*Lock@", "");
                        lockfilePath = lockfilePath.replaceFirst("(?s)<.*", "");
                        File file = new File(lockfilePath);
                        file.delete();
                    }
                    catch (Exception e) {
                        log.error(e);
                    }
                    response = requester.doGet(updateIndexParams);
                    if (response.matches("(?s).*Exception.*")) {
                        throw new Exception(response);
                    }
                }
                else {
                    throw new Exception(response);
                }
            }
            
            //Optimize Index?
            checkOptimize(response, index);
            return response;
        }
        catch (Exception e) {
            log.error(getStackTrace(e));
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * requests deletion of one index-entry by calling fedoragsearch-servlet.
     * 
     * <pre>
     *        execute get-request with hardcoded index + repositoryname
     *        to fedoragsearch.
     * </pre>
     * 
     * @param resource
     *            String resource.
     * @param index
     *            String name of the index.
     * 
     * @return String response
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @sb
     */
    public String requestDeletion(final String resource, String index)
        throws ApplicationServerSystemException {
    	if (index == null) {
    		index = "";
    	}
        String replacedResource = resource.replaceFirst(".*\\/", "");
        String deleteIndexParams = Constants.GSEARCH_DELETE_INDEX_PARAMS;
        deleteIndexParams =
            deleteIndexParams.replaceFirst("\\$\\{INDEX_NAME\\}", index);
        deleteIndexParams =
            deleteIndexParams.replaceFirst("\\$\\{VALUE\\}", replacedResource);
        try {
            String gsearchUrl =
                EscidocConfiguration.getInstance().get(
                    EscidocConfiguration.GSEARCH_URL);
            HttpRequester requester = new HttpRequester(gsearchUrl);
            String response = "";
            response = requester.doGet(deleteIndexParams);
            // Catch Exceptions
            if (response.matches("(?s).*Exception.*")) {
                if (response.matches("(?s).*Lock obtain timed out.*")) {
                    try {
                        String lockfilePath =
                            response.replaceFirst("(?s).*Lock@", "");
                        lockfilePath = lockfilePath.replaceFirst("(?s)<.*", "");
                        File file = new File(lockfilePath);
                        file.delete();
                    }
                    catch (Exception e) {
                        log.error(e);
                    }
                    response = requester.doGet(deleteIndexParams);
                    if (response.matches("(?s).*Exception.*")) {
                        throw new Exception(response);
                    }
                }
                else {
                    throw new Exception(response);
                }
            }
            //Optimize Index?
            checkOptimize(response, index);
            return response;
        }
        catch (Exception e) {
            log.error(getStackTrace(e));
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * requests optimization of the given index by calling fedoragsearch-servlet.
     * 
     * <pre>
     *        execute get-request with hardcoded index
     *        to fedoragsearch.
     * </pre>
     * 
     * @param index
     *            String name of the index.
     * 
     * @return String response
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @sb
     */
    public String requestOptimize(String index)
        throws ApplicationServerSystemException {
    	if (index == null) {
    		index = "";
    	}
        String optimizeIndexParams = Constants.GSEARCH_OPTIMIZE_INDEX_PARAMS;
        optimizeIndexParams =
            optimizeIndexParams.replaceFirst("\\$\\{INDEX_NAME\\}", index);
        try {
            String gsearchUrl =
                EscidocConfiguration.getInstance().get(
                    EscidocConfiguration.GSEARCH_URL);
            HttpRequester requester = new HttpRequester(gsearchUrl);
            String response = "";
            response = requester.doGet(optimizeIndexParams);
            // Catch Exceptions
            if (response.matches("(?s).*Exception.*")) {
                if (response.matches("(?s).*Lock obtain timed out.*")) {
                    try {
                        String lockfilePath =
                            response.replaceFirst("(?s).*Lock@", "");
                        lockfilePath = lockfilePath.replaceFirst("(?s)<.*", "");
                        File file = new File(lockfilePath);
                        file.delete();
                    }
                    catch (Exception e) {
                        log.error(e);
                    }
                    response = requester.doGet(optimizeIndexParams);
                    if (response.matches("(?s).*Exception.*")) {
                        throw new Exception(response);
                    }
                }
                else {
                    throw new Exception(response);
                }
            }
            return response;
        }
        catch (Exception e) {
            log.error(getStackTrace(e));
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * requests available index-configurations from fedoragsearch.
     * 
     * <pre>
     *        execute get-request to fedoragsearch.
     * </pre>
     * 
     * @return HashMap<String, HashMap<String, String>> index-configurations
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @sb
     */
    private HashMap<String, HashMap<String, String>> requestIndexConfiguration()
        throws ApplicationServerSystemException {
        try {
            String gsearchUrl =
                EscidocConfiguration.getInstance().get(
                    EscidocConfiguration.GSEARCH_URL);
            HttpRequester requester = new HttpRequester(gsearchUrl);
            String response = "";
            response = requester.doGet(
            		Constants.GSEARCH_GET_INDEX_CONFIGURATION_PARAMS);
            // Catch Exceptions
            if (response.matches("(?s).*Exception.*")) {
                throw new Exception(response);
            }
            return readIndexConfigurationXml(response);
        }
        catch (Exception e) {
            log.error(getStackTrace(e));
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * requests information about repository.
     * 
     * <pre>
     *        execute get-request to fedoragsearch.
     * </pre>
     * 
     * @return HashMap<String, String> repository-info
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @sb
     */
    private HashMap<String, String> requestRepositoryInfo()
        throws ApplicationServerSystemException {
        try {
            String gsearchUrl =
                EscidocConfiguration.getInstance().get(
                    EscidocConfiguration.GSEARCH_URL);
            HttpRequester requester = new HttpRequester(gsearchUrl);
            String response = "";
            response = requester.doGet(
            		Constants.GSEARCH_GET_REPOSITORY_INFO_PARAMS);
            // Catch Exceptions
            if (response.matches("(?s).*Exception.*")) {
                throw new Exception(response);
            }
            return readRepositoryInfoXml(response);
        }
        catch (Exception e) {
            log.error(getStackTrace(e));
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * Transforms xml-String with configuration into HashMap.
     * 
     * @param xml as String
     * @return HashMap<String, HashMap<String, String>> index-configurations
     * 
     * @sb
     */
    private HashMap<String, HashMap<String, String>> 
    			readIndexConfigurationXml(final String xml) {
    	HashMap<String, HashMap<String, String>> indexConfig = 
    		new HashMap<String, HashMap<String, String>>();
    	String[] indexes = xml.split("<index>");
		Pattern indexNamePattern = Pattern.compile("(?s).*?<name>(.*?)</name>.*");
		Pattern propertiesKeyPattern = Pattern.compile("(?s).*?<key>(.*?)</key>.*");
		Pattern propertiesValuePattern = Pattern.compile("(?s).*?<value>(.*?)</value>.*");
    	for (int i = 1; i < indexes.length; i++) {
			String indexName = null;
			Matcher indexNameMatcher = indexNamePattern.matcher(indexes[i]);
			if (indexNameMatcher.find()) {
				indexName = indexNameMatcher.group(1);
			}
			if (indexName != null) {
				indexConfig.put(indexName, new HashMap<String, String>());
				String[] properties = indexes[i].split("<property>");
				for (int j = 1; j < properties.length; j++) {
					String key = null;
					Matcher propertiesKeyMatcher = propertiesKeyPattern.matcher(properties[j]);
					if (propertiesKeyMatcher.find()) {
						key = propertiesKeyMatcher.group(1);
					}
					String value = null;
					Matcher propertiesValueMatcher = propertiesValuePattern.matcher(properties[j]);
					if (propertiesValueMatcher.find()) {
						value = propertiesValueMatcher.group(1);
					}
					if (key != null && value != null) {
						indexConfig.get(indexName).put(key, value);
					}
				}
			}
		}
    	
    	return indexConfig;
    }

    /**
     * Transforms xml-String with repositoryInfo into HashMap.
     * 
     * @param xml as String
     * @return HashMap<String, String> repository-info
     * 
     * @sb
     */
    private HashMap<String, String>
    			readRepositoryInfoXml(final String xml) {
    	HashMap<String, String> repositoryInfo = 
    		new HashMap<String, String>();
		Pattern mimeTypePattern = Pattern.compile("(?s).*?<SupportedMimeTypes>(.*?)</SupportedMimeTypes>.*");
    	Matcher mimeTypeMatcher = mimeTypePattern.matcher(xml);
    	if (mimeTypeMatcher.matches()) {
    		repositoryInfo.put("SupportedMimeTypes", mimeTypeMatcher.group(1));
    	}
    	return repositoryInfo;
    }

	/**
	 * checks if index has to get optimized
	 * (if mod(docCount/Constants.OPTIMIZE_DOCUMENT_COUNT) == 0,
	 * index has to get optimized.
	 * exctracts the docCount out of the given xml-String
	 * docCount is the number of docs in the index.
	 * 
	 * @param response xml returned by request to fedoragsearch.
	 * @param index name of the index to check/optimize.
	 */
	public void checkOptimize(String response, String index) {
		int docCount = 1;
		String docCountStr = response.replaceAll(
				"(?s).*?<docCount>(.*?)</docCount>.*", "$1");
		try {
			docCount = new Integer(docCountStr).intValue();
		} catch (Exception e){}
        if (docCount 
        		% Constants.OPTIMIZE_DOCUMENT_COUNT == 0) {
        	try {
                requestOptimize(index);
        	} catch (Exception e) {
        		log.error(e);
        	}
        }
	}

    /**
     * Get Stack Trace of Exception.
     * 
     * @param e
     *            Exception
     * @return String Stack Trace
     * @sb
     */
    private String getStackTrace(final Exception e) {
        StringBuffer stack = new StringBuffer("");
        if (e != null) {
            stack.append(e.getMessage()).append("\n");
            StackTraceElement[] stackElements = e.getStackTrace();
            if (stackElements != null) {
                for (int i = 0; i < stackElements.length; i++) {
                    StackTraceElement stackElement = stackElements[i];
                    stack.append(stackElement.toString()).append("\n");
                }
            }
        }

        return stack.toString();
    }

	/**
	 * @return the indexConfigurations
	 * @throws ApplicationServerSystemException e
	 */
	public HashMap<String, HashMap<String, String>> getIndexConfigurations() 
								    throws ApplicationServerSystemException {
		if (indexConfigurations == null) {
			indexConfigurations = requestIndexConfiguration();
		}
		return indexConfigurations;
	}

	/**
	 * @return the repositoryInfo
	 * @throws ApplicationServerSystemException e
	 */
	public HashMap<String, String> getRepositoryInfo() 
								    throws ApplicationServerSystemException {
		if (repositoryInfo == null) {
			repositoryInfo = requestRepositoryInfo();
		}
		return repositoryInfo;
	}

	/**
	 * @return the supportedMimeTypes
	 */
	public HashSet<String> getSupportedMimeTypes() 
				throws ApplicationServerSystemException {
		if (supportedMimeTypes == null) {
			supportedMimeTypes = new HashSet<String>();
			getRepositoryInfo();
			if (repositoryInfo.get("SupportedMimeTypes") != null) {
				String[] supportedMimeTypesArr = 
					repositoryInfo.get("SupportedMimeTypes").split("\\s");
				for (int i = 0; i < supportedMimeTypesArr.length; i++) {
					supportedMimeTypes.add(supportedMimeTypesArr[i]);
				}
			}
		}
		return supportedMimeTypes;
	}

}
