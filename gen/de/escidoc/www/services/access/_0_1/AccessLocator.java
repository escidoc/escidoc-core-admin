/**
 * AccessLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package de.escidoc.www.services.access._0_1;

public class AccessLocator extends org.apache.axis.client.Service implements de.escidoc.www.services.access._0_1.Access {

    public AccessLocator() {
    }


    public AccessLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public AccessLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for access
    private java.lang.String access_address = "http://localhost:8080/axis/services/access";

    public java.lang.String getaccessAddress() {
        return access_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String accessWSDDServiceName = "access";

    public java.lang.String getaccessWSDDServiceName() {
        return accessWSDDServiceName;
    }

    public void setaccessWSDDServiceName(java.lang.String name) {
        accessWSDDServiceName = name;
    }

    public de.escidoc.www.services.access._0_1.FedoraAccessDeviationHandler getaccess() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(access_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getaccess(endpoint);
    }

    public de.escidoc.www.services.access._0_1.FedoraAccessDeviationHandler getaccess(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            de.escidoc.www.services.access._0_1.AccessSoapBindingStub _stub = new de.escidoc.www.services.access._0_1.AccessSoapBindingStub(portAddress, this);
            _stub.setPortName(getaccessWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setaccessEndpointAddress(java.lang.String address) {
        access_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (de.escidoc.www.services.access._0_1.FedoraAccessDeviationHandler.class.isAssignableFrom(serviceEndpointInterface)) {
                de.escidoc.www.services.access._0_1.AccessSoapBindingStub _stub = new de.escidoc.www.services.access._0_1.AccessSoapBindingStub(new java.net.URL(access_address), this);
                _stub.setPortName(getaccessWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("access".equals(inputPortName)) {
            return getaccess();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://www.escidoc.de/services/access/0.1", "access");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://www.escidoc.de/services/access/0.1", "access"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("access".equals(portName)) {
            setaccessEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
