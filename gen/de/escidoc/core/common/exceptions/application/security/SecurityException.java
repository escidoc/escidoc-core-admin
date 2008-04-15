/**
 * SecurityException.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package de.escidoc.core.common.exceptions.application.security;

public class SecurityException  extends de.escidoc.core.common.exceptions.EscidocException  implements java.io.Serializable {
    private java.lang.String redirectLocation;

    public SecurityException() {
    }

    public SecurityException(
           int httpStatusCode,
           java.lang.String httpStatusLine,
           java.lang.String httpStatusMsg,
           java.lang.String redirectLocation) {
        super(
            httpStatusCode,
            httpStatusLine,
            httpStatusMsg);
        this.redirectLocation = redirectLocation;
    }


    /**
     * Gets the redirectLocation value for this SecurityException.
     * 
     * @return redirectLocation
     */
    public java.lang.String getRedirectLocation() {
        return redirectLocation;
    }


    /**
     * Sets the redirectLocation value for this SecurityException.
     * 
     * @param redirectLocation
     */
    public void setRedirectLocation(java.lang.String redirectLocation) {
        this.redirectLocation = redirectLocation;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof SecurityException)) return false;
        SecurityException other = (SecurityException) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.redirectLocation==null && other.getRedirectLocation()==null) || 
             (this.redirectLocation!=null &&
              this.redirectLocation.equals(other.getRedirectLocation())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = super.hashCode();
        if (getRedirectLocation() != null) {
            _hashCode += getRedirectLocation().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(SecurityException.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://security.application.exceptions.common.core.escidoc.de", "SecurityException"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("redirectLocation");
        elemField.setXmlName(new javax.xml.namespace.QName("", "redirectLocation"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
