/*
 * Created on Sep 25, 2008
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package de.escidoc.core.admin.common.util;

import de.escidoc.core.client.TransportProtocol;
import de.escidoc.core.common.business.fedora.resources.ResourceType;

public class NameValueBean implements Comparable {
    private String fileName;

    private String objectId;

    private ResourceType type;

    private TransportProtocol transport;

    public NameValueBean(String fileName, String objectId, ResourceType type,
        TransportProtocol transportProtocol) {
        super();
        this.fileName = fileName;
        this.objectId = objectId;
        this.type = type;
        this.transport = transportProtocol;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getObjectId() {
        return objectId;
    }

    public void setObjectId(String objectId) {
        this.objectId = objectId;
    }

    public ResourceType getType() {
        return type;
    }

    public void setType(ResourceType type) {
        this.type = type;
    }

    /**
     * @param transport
     *            the transport to set
     */
    public void setTransport(TransportProtocol transport) {
        this.transport = transport;
    }

    /**
     * @return the transport
     */
    public TransportProtocol getTransport() {
        return transport;
    }

    /**
     * Compare to instances of Name Value Bean
     */
    public final int compareTo(Object o) {
        if (o instanceof NameValueBean) {
            return (((NameValueBean) o).getFileName().compareTo(this
                .getFileName()));
        }
        throw new RuntimeException("comparison not allowed for type "
            + o.getClass().getName() + ". Must be of type NameValueBean");
    }

}
