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

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

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

    private final String srcDirectory;
    private final String destDirectory;
    private final String stylesheet;
    private final Transformer transformer;

    private int count = 0;

    /**
     * Constructor.
     *
     * @param srcDirectory base directory where the original Foxml files are
     *                     located
     * @param destDirectory base directory where the transformed Foxml files
     *                      will be placed (the directory will be created
     *                      automatically if needed)
     * @param stylesheet XSL stylesheet to use for transformation
     *
     * @throws Exception thrown if the XSL transformation failed
     */
    public FoxmlMigrationTool(final String srcDirectory,
        final String destDirectory, final String stylesheet) throws Exception {
        this.srcDirectory  = srcDirectory;
        this.destDirectory = destDirectory;
        this.stylesheet    = stylesheet;

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

        FileReader source = new FileReader(file);
        FileWriter result = new FileWriter(target);

        try {
            transformer.transform(new StreamSource(source), new StreamResult(result));
        }
        catch (Exception e) {
            System.err.println("failed to transform " + file);
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
     * Main method to start the XSL transformation.
     *
     * @param args expected three arguments: source directory, target directory and
     *             XSL stylesheet
     *
     * @throws Exception thrown if the XSL transformation failed
     */
    public static void main(final String [] args) throws Exception {
        if (args.length == 3) {
            new FoxmlMigrationTool(args [0], args[1], args[2]);
        }
        else {
            System.err.println(
                "usage: FoxmlMigration <src directory> <dest directory> " +
                "<XSL stylesheet>");
        }
    }
}
