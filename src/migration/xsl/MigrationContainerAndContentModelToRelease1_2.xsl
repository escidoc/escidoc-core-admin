<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:escidocVersions="http://www.escidoc.de/schemas/versionhistory/0.3"
	xmlns:java="de.escidoc.core.om.business.CallJavaFromXslt"
	exclude-result-prefixes="java">
	<xsl:import href="Container.xsl"/>
    <xsl:import href="ContentModelToRelease1_2.xsl"/>
	<xsl:variable name="objectType"
		select="/foxml:digitalObject/foxml:datastream/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description/rdf:type/@rdf:resource" />
	<xsl:variable name="creationDateRelsExt"
		select="/foxml:digitalObject/foxml:datastream[@ID='RELS-EXT']/foxml:datastreamVersion[position()=last()]/@CREATED" />
	<xsl:variable name="creationDateVersionHistory"
		select="/foxml:digitalObject/foxml:datastream[@ID='version-history']/foxml:datastreamVersion/@CREATED" />
	<xsl:variable name="objectId" select="/foxml:digitalObject/@PID" />
	<xsl:variable name="fileName" select="java:getFileName($objectId)" />
	<xsl:variable name="pathEscidocRelsExt" select="java:getNewPath($creationDateRelsExt)" />
	<xsl:variable name="pathVersionHistory"
		select="java:getNewPath($creationDateVersionHistory)" />

	<xsl:variable name="counter"
		select="/foxml:digitalObject/foxml:datastream[@ID='RELS-EXT']/count(foxml:datastreamVersion)-1" />



	<xsl:output encoding="utf-8" method="xml" />
	<xsl:template match="/">
		<xsl:if
			test="($objectType = 'http://escidoc.de/core/01/resources/Container')
			or ($objectType = 'http://escidoc.de/core/01/resources/ContentModel')">
			<xsl:for-each select="foxml:digitalObject">
				<xsl:element name="foxml:digitalObject" namespace="info:fedora/fedora-system:def/foxml#">
					<!-- alle Attribute und Namespaces ans Root-Element anhängen -->
					<xsl:for-each select="@*">
						<xsl:copy />
					</xsl:for-each>
					<xsl:for-each select="foxml:objectProperties">
						<xsl:copy-of select="." copy-namespaces="no" />

					</xsl:for-each>
					
					<xsl:choose>
										<xsl:when test="$objectType = 'http://escidoc.de/core/01/resources/Container'">
											<xsl:call-template name="containerTemplate"/>
										</xsl:when>
										<xsl:when test="$objectType = 'http://escidoc.de/core/01/resources/ContentModel'">
											<xsl:call-template name="cmTemplate"/>
										</xsl:when>
									</xsl:choose>
					
				</xsl:element>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
