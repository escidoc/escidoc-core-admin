<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd" xmlns:audit="info:fedora/fedora-system:def/audit#" xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:organizational-unit="http://www.escidoc.de/schemas/organizationalunit/0.3" xmlns:escidocRelations="http://www.nsdl.org/ontologies/relationships/" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<xsl:import href="Context.xsl"/>
<xsl:import href="Component.xsl"/>
<xsl:import href="Container.xsl"/>
<xsl:import href="Item.xsl"/>
<xsl:import href="Ou.xsl"/>
<xsl:import href="ContentModel.xsl"/>
<xsl:variable name="objectType" select="/foxml:digitalObject/foxml:datastream/foxml:datastreamVersion/foxml:xmlContent/rdf:RDF/rdf:Description/escidocRelations:objectType"/>
	<xsl:output encoding="utf-8" method="xml"/>
	<xsl:template match="/">
	<xsl:if test="($objectType = 'content-model') or ($objectType = 'context') or ($objectType = 'organizational-unit')
	 or ($objectType = 'item') or ($objectType = 'container') or ($objectType = 'component')" >
	<xsl:for-each select="foxml:digitalObject">
	
			<xsl:element name="foxml:digitalObject"
				namespace="info:fedora/fedora-system:def/foxml#">
				<!-- alle Attribute und Namespaces ans Root-Element anhängen -->
				<xsl:for-each select="@*">
					<xsl:copy />
					<xsl:if test="'@fedoraxsi:schemaLocation'">
						<xsl:attribute name="xsi:schemaLocation"
							namespace="http://www.w3.org/2001/XMLSchema-instance"
							select=" 'info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-1.xsd'" />
						<xsl:attribute name="VERSION" select="'1.1'" />
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="foxml:objectProperties">
					<xsl:element name="foxml:objectProperties"
						namespace="info:fedora/fedora-system:def/foxml#">
						<xsl:for-each select="foxml:property[(@NAME!='info:fedora/fedora-system:def/model#contentModel') and (@NAME!='http://www.w3.org/1999/02/22-rdf-syntax-ns#type')]">
							<xsl:element name="foxml:property"
								namespace="info:fedora/fedora-system:def/foxml#">
								<xsl:for-each select="@*">
									<xsl:copy />
								</xsl:for-each>
							</xsl:element>	
						</xsl:for-each>
					</xsl:element>
				</xsl:for-each>
				<!-- falls Audit, dann Inhalt kopieren  -->
						<xsl:for-each select="foxml:datastream[@ID='AUDIT']">
						<xsl:copy-of select="."
								copy-namespaces="no" />
						
						</xsl:for-each>
		<xsl:choose>
										<xsl:when test="$objectType = 'content-model'">
											<xsl:call-template name="cmTemplate"/>
										</xsl:when>
										<xsl:when test="$objectType = 'context'">
											<xsl:call-template name="contextTemplate"/>
										</xsl:when>
										<xsl:when test="$objectType = 'organizational-unit'">
											<xsl:call-template name="ouTemplate"/>
										</xsl:when>
										<xsl:when test="$objectType = 'item'">
											<xsl:call-template name="itemTemplate"/>
										</xsl:when>
										<xsl:when test="$objectType = 'container'">
											<xsl:call-template name="containerTemplate"/>
										</xsl:when>
										<xsl:when test="$objectType = 'component'">
											<xsl:call-template name="componentTemplate"/>
										</xsl:when>
									</xsl:choose>
									</xsl:element>
						</xsl:for-each>
						</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>