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
package de.escidoc.core.admin.business;

import de.escidoc.core.common.util.logger.AppLogger;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

/**
 * This tool does XSL transformation on a set of files. It is a replacement for
 * the built in Ant task "xslt" which cannot deal with a large number of files.
 * 
 * @author sche
 */
public class FoxmlMigrationTool {
    /**
     * Print the number of already processed files for every SHOW_COUNT files.
     */
    private static final int SHOW_COUNT = 100;

    /**
     * Charset used for file I/O.
     */
    private static final String CHARSET = "utf-8";
    
    /*
     * A Pattern to parse a String in order to create a Date
     */
    public static final String PATH_DATE_PATTERN =
        "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

    /*
     * A Pattern to create a path in the file system from a Date
     */
    public static final String PATH_DATE_PATTERN2 = "yyyy/MMdd/HH/mm";

    /**
     * The logger.
     */
    private static AppLogger log =
        new AppLogger(FoxmlMigrationTool.class.getName());

    private final String srcDirectory;
    private final String destDirectory;
    private final Transformer transformer;
    private static String datastreamDestDirectory;

    private int count = 0;

    /**
     * Constructor.
     *
     * @param srcDirectory base directory where the original Foxml files are
     *                     located
     * @param destDirectory base directory where the transformed Foxml files
     *                      will be placed (the directory will be created
     *                      automatically if needed)
     * @param stylesheet XSL style sheet to use for transformation
     *
     * @throws Exception thrown if the XSL transformation failed
     */
    public FoxmlMigrationTool(final String srcDirectory,
        final String destDirectory, final String datastreamDirectory, 
        final String stylesheet) throws Exception {
        this.srcDirectory  = srcDirectory;
        this.destDirectory = destDirectory;
        datastreamDestDirectory = datastreamDirectory;

        TransformerFactory factory = TransformerFactory.newInstance();

        transformer = factory.newTransformer(new StreamSource(stylesheet));
        scanDir(srcDirectory);
    }

    /**
     * Create all parent directories of the given file if they do not yet exist.
     *
     * @param file Foxml file for which all parent directories must exist
     */
    private void createParentDirectories(final File file) {
        new File(file.getParent()).mkdirs();
    }

    /**
     * Create the complete path for the target Foxml file from the source Foxml
     * file.
     *
     * @param srcPath path to the source Foxml file
     *
     * @return path to the target Foxml file
     */
    private File getDestPath(final String srcPath) {
        return new File(destDirectory,
            srcPath.substring(srcDirectory.length() + 1));
    }

    /**
     * Scan a directory recursively and start the XSL transformation for every
     * file.
     *
     * @param dirName name of the directory to scan
     *
     * @throws Exception thrown if the XSL transformation failed
     */
    private void scanDir(final String dirName) throws Exception {
        File directory = new File(dirName);
        System.out.println("directory " + dirName);
        String [] files = directory.list();

        if (files != null) {
            for (String f : files) {
                File file = new File(directory, f);

                if (file.isDirectory()) {
                    scanDir(file.getPath());
                }
                else {
                    transform(file);
                }
            }
        }
    }

    /**
     * Do a XSL transformation for the given Foxml file. The target Foxml file
     * will be put into the destination directory preserving the same sub
     * directory structure.
     *
     * @param file source Foxml file
     *
     * @throws Exception thrown if the XSL transformation failed
     */
    private void transform(final File file) throws Exception {
        File target = getDestPath(file.getPath());

        createParentDirectories(target);

        Reader source = new InputStreamReader(new FileInputStream(file), CHARSET);
        Writer result = new OutputStreamWriter(new FileOutputStream(target),
            CHARSET);

        try {
            transformer.transform(new StreamSource(source),
                new StreamResult(result));
        }
        catch (Exception e) {
            log.error("failed to transform " + file, e);
            throw new Exception(e);
        }
        finally {
            source.close();
            result.close();
        }
        count++;
        if (count % SHOW_COUNT == 0) {
            System.out.println("processed " + count + " files");
        }
    }

    
    /**
     * Replaces a semicolon in a provided String by an underscore.
     * 
     * @param fedoraObjid
     * @return a String with a replaced semicolon
     */
    public static String getFileName(final String fedoraObjid) {
        return fedoraObjid.replaceFirst(":", "_");
    }

    /**
     * Generates a path of the directories hierarchy in the file system from the
     * provided time stamp. Creates directories according the generated path.
     * 
     * @param creationDate
     *            provided time stamp
     * @return a path of the directories hierarchy
     * @throws ParseException
     */
    public static String getNewPath(String creationDate) throws ParseException {
        DateFormat formatter1 = new SimpleDateFormat(PATH_DATE_PATTERN);
        DateFormat formatter2 = new SimpleDateFormat(PATH_DATE_PATTERN2);

        TimeZone tz = TimeZone.getDefault();
        formatter1.setTimeZone(tz);
        Date date = formatter1.parse(creationDate);
       
        formatter2.setTimeZone(tz);
        String path = formatter2.format(date);

        File dir = new File(datastreamDestDirectory, path);

        dir.mkdirs();
        path = dir.getPath();

        return path;
    }
    
    /**
     * Returns a rank of a framework from a provided build number.
     */
    public static String getFrameworkRank(String buildNr) throws ParseException {
        if ((buildNr != null) && buildNr.contains("1.2")) {
            return new String("1.2");
        }
        return new String("other");

    }

    /**
     * Main method to start the XSL transformation.
     *
     * @param args expected three arguments: source directory, target directory and
     *             XSL stylesheet
     *
     * @throws Exception thrown if the XSL transformation failed
     */
    public static void main(final String [] args) throws Exception {
        if (args.length == 3) {
            new FoxmlMigrationTool(args [0], args[1], args[2], args[4]);
        }
        else {
            System.err.println(
                "usage: FoxmlMigration <src directory> <dest directory> "
                + "<XSL stylesheet>");
        }
    }
}
