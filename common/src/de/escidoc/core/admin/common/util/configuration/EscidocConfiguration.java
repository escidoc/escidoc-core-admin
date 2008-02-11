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
package de.escidoc.core.admin.common.util.configuration;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Iterator;
import java.util.Properties;

import de.escidoc.core.common.exceptions.EscidocException;
import de.escidoc.core.common.exceptions.system.SystemException;
import de.escidoc.core.common.util.logger.AppLogger;

/**
 * Handles properties.
 * 
 * @author Michael Hoppe
 * @common
 * 
 */
public final class EscidocConfiguration {

    public static final String ESCIDOC_CORE_URL = "escidoc.core.url";

    public static final String GSEARCH_URL = "gsearch.url";

    private static final String CATALINA_HOME = "catalina.home";

    private static final AppLogger LOG =
        new AppLogger(EscidocConfiguration.class.getName());

    private static EscidocConfiguration instance = null;

    private final Properties properties;

    private static final String PROPERTIES_BASEDIR =
        System.getProperty(CATALINA_HOME) + "/";

    private static final String PROPERTIES_DIR = PROPERTIES_BASEDIR + "conf/";

    private static final String PROPERTIES_FILENAME = "escidoc-core.properties";

    private static final String PROPERTIES_DEFAULT_FILENAME =
        PROPERTIES_FILENAME + ".default";

    /**
     * Private Constructor, in order to prevent instantiation of this utility
     * class. read the Properties and fill it in properties attribute.
     * 
     * @throws EscidocException
     *             e
     * 
     * @common
     */
    private EscidocConfiguration() throws EscidocException {
        this.properties = loadProperties();
    }

    /**
     * Returns and perhabs initializes Object.
     * 
     * @return EscidocConfiguration self
     * @throws IOException
     *             e
     * 
     * @common
     */
    public static synchronized EscidocConfiguration getInstance()
        throws IOException {
        if (instance == null) {
            try {
                instance = new EscidocConfiguration();
            }
            catch (EscidocException e) {
                StringWriter w = new StringWriter();
                PrintWriter pw = new PrintWriter(w);
                e.printStackTrace(pw);
                throw new IOException(
                    "Problem while loading properties! Caused by:\n"
                        + w.toString());
            }
        }
        return instance;
    }

    /**
     * Returns the property with the given name or null if property was not
     * found.
     * 
     * @param name
     *            The name of the Property.
     * @return Value of the given Property as String.
     * @common
     */
    public String get(final String name) {
        return (String) properties.get(name);
    }

    /**
     * Returns the property with the given name or the second parameter as
     * default value if property was not found.
     * 
     * @param name
     *            The name of the Property.
     * @param defaultValue
     *            The default vaule if property isn't given.
     * @return Value of the given Property as String.
     * @common
     */
    public String get(final String name, final String defaultValue) {
        String prop = (String) properties.get(name);

        if (prop == null) {
            prop = defaultValue;
        }
        return prop;
    }

    /**
     * Loads the Properties from the possible files. First loads properties from
     * the file escidoc-core.properties.default. Afterwards tries to load
     * specific properties from the file escidoc.properties and merges them with
     * the default properties. If any key is included in default and specific
     * properties, the value of the specific property will overwrite the default
     * property.
     * 
     * @return The properties
     * @throws SystemException
     *             If the loading of the default properties (file
     *             escidoc-core.properties.default) fails.
     * 
     * @common
     */
    private synchronized Properties loadProperties() throws SystemException {
        Properties result;
        try {
            result = getProperties(PROPERTIES_DEFAULT_FILENAME);
        }
        catch (IOException e) {
            throw new SystemException("Default properties not found.");
        }

        if (LOG.isDebugEnabled()) {
            LOG.debug("Default properties: " + result);
        }
        Properties specific = null;
        try {
            specific = getProperties(PROPERTIES_FILENAME);
        }
        catch (IOException e) {
            try {
                specific =
                    getProperties(PROPERTIES_BASEDIR + PROPERTIES_FILENAME);
            }
            catch (IOException e1) {
                try {
                    specific =
                        getProperties(PROPERTIES_DIR + PROPERTIES_FILENAME);
                }
                catch (IOException e2) {
                    specific = new Properties();
                }
            }
        }
        if (LOG.isDebugEnabled()) {
            LOG.debug("Specific properties: " + specific);
        }
        result.putAll(specific);
        if (LOG.isDebugEnabled()) {
            LOG.debug("Merged properties: " + result);
        }
        // set Properties as System-Variables
        Iterator iter = result.keySet().iterator();
        while (iter.hasNext()) {
            String key = (String) iter.next();
            String value = result.getProperty(key);
            value = replaceEnvVariables(value);
            System.setProperty(key, value);
        }
        return result;
    }

    /**
     * Get the properties from a file.
     * 
     * @param filename
     *            The name of the properties file.
     * @return The properties.
     * @throws IOException
     *             If access to the specified file fails.
     */
    private synchronized Properties getProperties(final String filename)
        throws IOException {

        Properties result = new Properties();
        InputStream propertiesStream = getInputStream(filename);
        result.load(propertiesStream);
        return result;
    }

    /**
     * Get an InputStream for the given file.
     * 
     * @param filename
     *            The name of the file.
     * @return The InputStream or null if the file could not be located.
     * @throws FileNotFoundException
     *             If access to the specified file fails.
     */
    private synchronized InputStream getInputStream(final String filename)
        throws FileNotFoundException {

        InputStream inputStream =
            getClass().getClassLoader().getResourceAsStream(filename);
        if (inputStream == null) {
            inputStream = new FileInputStream(new File(filename));
        }
        return inputStream;
    }

    /**
     * Retrieves the Properties from File.
     * 
     * @param property
     *            value of property with env-variable-syntax (eg ${java.home})
     * @return String replaced env-variables
     * 
     * @common
     */
    private synchronized String replaceEnvVariables(final String property) {
        String replacedProperty = property;
        if (property.indexOf("${") > -1) {
            String[] envVariables = property.split("\\}.*?\\$\\{");
            if (envVariables != null) {
                for (int i = 0; i < envVariables.length; i++) {
                    envVariables[i] =
                        envVariables[i].replaceFirst(".*?\\$\\{", "");
                    envVariables[i] = envVariables[i].replaceFirst("\\}.*", "");
                    if (System.getProperty(envVariables[i]) != null
                        && !System.getProperty(envVariables[i]).equals("")) {
                        String envVariable =
                            System.getProperty(envVariables[i]);
                        envVariable = envVariable.replaceAll("\\\\", "/");
                        replacedProperty =
                            replacedProperty.replaceAll("\\$\\{"
                                + envVariables[i] + "}", envVariable);
                    }
                }
            }
        }
        return replacedProperty;
    }

}
