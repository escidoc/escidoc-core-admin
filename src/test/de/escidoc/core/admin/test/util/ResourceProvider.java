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
 * Copyright 2008 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.  
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin.test.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.xml.XmlUtility;

public class ResourceProvider {

    protected static AppLogger log =
        new AppLogger(ResourceProvider.class.getName());

    private static final String DEFAULT_PACKAGE =
        "/de/escidoc/core/test/common/resources/data/";

    public static InputStream getFileInputStream(final String filename)
        throws IOException {
        return getFileInputStreamFromResource(DEFAULT_PACKAGE, filename);
    }

    public static InputStream getFileInputStreamFromResource(
        final String path, final String filename) throws IOException {
        InputStream result = null;

        String search = concatenatePath(path, filename);
        // search = concatenatePath(search.replace(".", "/"), filename);
        result = filename.getClass().getResourceAsStream(search);
        if (result == null) {
            throw new IOException("Resource not found [" + search + "]");
        }

        return result;
    }

    public static InputStream getFileInputStreamFromFile(
        final String path, final String filename) throws IOException {
        InputStream result = null;

        String search = ResourceProvider.concatenatePath(path, filename);
        File file = new File(search);
        if (!file.exists()) {
            // file.mkdirs();
            // file.createNewFile();
        }
        else {
            result = new FileInputStream(file);
            if (result == null) {
                throw new IOException("File not found ["
                    + file.getAbsolutePath() + "]");
            }
        }

        return result;
    }

    /**
     * Save the content to the file described by path and filename.
     * 
     * @param transport
     *            TODO
     * @param path
     *            The path.
     * @param filename
     *            The filename.
     * @param content
     *            The content.
     * 
     * @throws IOException
     *             If anything fails.
     */
    public static void saveToFile(
        final String path, final String filename, final String content)
        throws IOException {

        try {
            File filepath = new File(path);
            filepath.mkdirs();
            FileOutputStream f =
                new FileOutputStream(new File(ResourceProvider.concatenatePath(
                    path, filename)));
            f.write(content.getBytes(XmlUtility.CHARACTER_ENCODING));
            f.flush();
            f.close();
        }
        catch (IOException e) {
            log.error(e);
            throw e;
        }
    }

    /**
     * Concatenates the two given path segments and returns a valid path, i.e.
     * the method takes care that there is only one path seperator between the
     * path segments.
     * 
     * @param path
     *            The path.
     * @param appendix
     *            The path to append.
     * @return The concatenated path.
     * @st
     */
    public static String concatenatePath(
        final String path, final String appendix) {
        String result = path;
        String append = appendix;
        result = result.replace("\\", "/");
        append = append.replace("\\", "/");
        if (!result.endsWith("/")) {
            if (!append.startsWith("/")) {
                result += "/" + append;
            }
            else {
                result += append;
            }
        }
        else {
            if (!append.startsWith("/")) {
                result += append;
            }
            else {
                result += append.substring(1);
            }
        }
        return result;
    }

    public static String getContentsFromInputStream(
        final InputStream inputStream) throws IOException {

        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int b;
        while ((b = inputStream.read()) != -1) {
            out.write(b);
        }
        return new String(out.toByteArray(), XmlUtility.CHARACTER_ENCODING);
    }
}
