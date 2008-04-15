/**
 * SoapExceptionGenerationServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package de.escidoc.www.services.SoapExceptionGenerationService._0_1;

public class SoapExceptionGenerationServiceLocator extends org.apache.axis.client.Service implements de.escidoc.www.services.SoapExceptionGenerationService._0_1.SoapExceptionGenerationService {

    public SoapExceptionGenerationServiceLocator() {
    }


    public SoapExceptionGenerationServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public SoapExceptionGenerationServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for SoapExceptionGenerationService
    private java.lang.String SoapExceptionGenerationService_address = "http://localhost:8080/axis/services/SoapExceptionGenerationService";

    public java.lang.String getSoapExceptionGenerationServiceAddress() {
        return SoapExceptionGenerationService_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SoapExceptionGenerationServiceWSDDServiceName = "SoapExceptionGenerationService";

    public java.lang.String getSoapExceptionGenerationServiceWSDDServiceName() {
        return SoapExceptionGenerationServiceWSDDServiceName;
    }

    public void setSoapExceptionGenerationServiceWSDDServiceName(java.lang.String name) {
        SoapExceptionGenerationServiceWSDDServiceName = name;
    }

    public de.escidoc.www.services.SoapExceptionGenerationService._0_1.SoapExceptionGeneration getSoapExceptionGenerationService() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SoapExceptionGenerationService_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSoapExceptionGenerationService(endpoint);
    }

    public de.escidoc.www.services.SoapExceptionGenerationService._0_1.SoapExceptionGeneration getSoapExceptionGenerationService(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            de.escidoc.www.services.SoapExceptionGenerationService._0_1.SoapExceptionGenerationServiceSoapBindingStub _stub = new de.escidoc.www.services.SoapExceptionGenerationService._0_1.SoapExceptionGenerationServiceSoapBindingStub(portAddress, this);
            _stub.setPortName(getSoapExceptionGenerationServiceWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSoapExceptionGenerationServiceEndpointAddress(java.lang.String address) {
        SoapExceptionGenerationService_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (de.escidoc.www.services.SoapExceptionGenerationService._0_1.SoapExceptionGeneration.class.isAssignableFrom(serviceEndpointInterface)) {
                de.escidoc.www.services.SoapExceptionGenerationService._0_1.SoapExceptionGenerationServiceSoapBindingStub _stub = new de.escidoc.www.services.SoapExceptionGenerationService._0_1.SoapExceptionGenerationServiceSoapBindingStub(new java.net.URL(SoapExceptionGenerationService_address), this);
                _stub.setPortName(getSoapExceptionGenerationServiceWSDDServiceName());
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
        if ("SoapExceptionGenerationService".equals(inputPortName)) {
            return getSoapExceptionGenerationService();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "SoapExceptionGenerationService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "SoapExceptionGenerationService"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("SoapExceptionGenerationService".equals(portName)) {
            setSoapExceptionGenerationServiceEndpointAddress(address);
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
