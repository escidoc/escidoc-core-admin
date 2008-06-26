package de.escidoc.core.admin.business;

import java.net.MalformedURLException;
import java.net.URL;

/**
 * Xslt functions used in the admin tool.
 * 
 * @author TTE
 * 
 */
public class EscidocXsltFunctions {

    public static boolean isValidUrl() {
        return isValidUrl(null);
    }

    /**
     * Checks if the provided value is a valid URL.
     * 
     * @param url
     *            The {@link String} to check if it is a valid URL.
     */
    public static boolean isValidUrl(final String url) {

        if (url == null || url.length() == 0) {
            return false;
        }
        else {
            try {
                new URL(url);
                return true;
            }
            catch (MalformedURLException e) {
                return false;
            }
        }
    }
}
