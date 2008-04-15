/**
 * Access.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package de.escidoc.www.services.access._0_1;

public interface Access extends javax.xml.rpc.Service {
    public java.lang.String getaccessAddress();

    public de.escidoc.www.services.access._0_1.FedoraAccessDeviationHandler getaccess() throws javax.xml.rpc.ServiceException;

    public de.escidoc.www.services.access._0_1.FedoraAccessDeviationHandler getaccess(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
