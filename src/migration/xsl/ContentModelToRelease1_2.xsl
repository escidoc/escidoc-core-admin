<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"

	fedoraxsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-0.xsd"

	xmlns:fedoraxsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"

	exclude-result-prefixes="fedoraxsi xsl rdf">
	<xsl:import href="DcTemplate.xsl"/>
	<xsl:output encoding="utf-8" method="xml" />
	<!--
		<xsl:template match="/"> <xsl:call-template name="cmTemplate" />
		</xsl:template>
	-->
	<xsl:variable name="PID" select="/foxml:digitalObject/@PID" />
	<xsl:variable name="label"
		select="/foxml:digitalObject/foxml:objectProperties/foxml:property[@NAME='info:fedora/fedora-system:def/model#label']/@VALUE" />

	<xsl:template name="cmTemplate">
		<xsl:param name="createdDate"/>
		<xsl:param name="lmDate"/>
		
		<!-- hier wird das neue XML erzeugt -->
		<xsl:for-each select="foxml:datastream">
			<xsl:choose>
				<!-- falls 'DC', dann Inhalt kopieren -->
				<xsl:when test="@ID='DC'">
					<xsl:call-template name="dcTemplate"/>
				</xsl:when>
				<!-- falls 'DC-MAPPING', dann Inhalt kopieren -->
				<xsl:when test="@ID='DC-MAPPING'">
					<xsl:copy-of select="." copy-namespaces="no" />
				</xsl:when>
				<!-- falls 'datastream', weglassen  -->
				<xsl:when test="@ID='datastream'">
				</xsl:when>

				<!-- falls 'RELS-EXT', dann Inhalt anpassen  -->
				<xsl:when test="@ID='RELS-EXT'">
					<xsl:element name="foxml:datastream"
						namespace="info:fedora/fedora-system:def/foxml#">
						<!-- Attribute übernehmen -->
						<xsl:for-each select="@*">
							<xsl:copy />
						</xsl:for-each>

						<!--  dann das Tagging teilweise original übernehmen -->
						<xsl:element name="foxml:datastreamVersion"
							namespace="info:fedora/fedora-system:def/foxml#">
							<xsl:attribute name="ID" select="'RELS-EXT.0'" />
							<xsl:attribute name="LABEL" select="'RELS_EXT DATASTREAM'" />
							<xsl:attribute name="CREATED" select="$createdDate" />
							<xsl:attribute name="MYMETYPE" select="'text/xml'" />
							<xsl:attribute name="SIZE" select="'0'" />
							<!-- diesen Tag original übernehmen -->
							<xsl:element name="foxml:xmlContent"
								namespace="info:fedora/fedora-system:def/foxml#">
								<xsl:element name="rdf:RDF"
									namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
									<xsl:element name="rdf:Description"
										namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
										<xsl:attribute name="rdf:about"
											namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of select="concat('info:fedora/',$PID)" />
													</xsl:attribute>
										<xsl:element name="system:build"
											namespace="http://escidoc.de/core/01/system/">
											<xsl:value-of select="'1.2beta1'" />
										</xsl:element>
										<xsl:element name="rdf:type"
											namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
											<xsl:value-of
												select="'http://escidoc.de/core/01/resources/ContentModel'" />
										</xsl:element>
										<xsl:element name="hasModel"
											namespace="info:fedora/fedora-system:def/model#">
											<xsl:attribute name="rdf:resource"
												namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">info:fedora/fedora-system:ContentModel-3.0</xsl:attribute>

										</xsl:element>
										<xsl:element name="srel:created-by"
											namespace="http://escidoc.de/core/01/structural-relations/">
											<xsl:attribute name="rdf:resource"
												namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">info:fedora/escidoc:exuser:1</xsl:attribute>
										</xsl:element>

										<xsl:element name="prop:public-status"
											namespace="http://escidoc.de/core/01/properties/">
											<xsl:value-of select="'pending'" />
										</xsl:element>
										<xsl:element name="prop:public-status-comment"
											namespace="http://escidoc.de/core/01/properties/">
											<xsl:value-of select="'Content Model created.'" />
										</xsl:element>
										<xsl:element name="prop:created-by-title"
											namespace="http://escidoc.de/core/01/properties/">
											<xsl:value-of select="'System Administrator User'" />
										</xsl:element>
										<xsl:element name="version:number"
											namespace="http://escidoc.de/core/01/properties/version/">
											<xsl:value-of select="'1'" />
										</xsl:element>
										<xsl:element name="version:date"
											namespace="http://escidoc.de/core/01/properties/version/">
											<xsl:value-of select="'---'" />
										</xsl:element>
										<xsl:element name="version:status"
											namespace="http://escidoc.de/core/01/properties/version/">
											<xsl:value-of select="'pending'" />
										</xsl:element>
										<xsl:element name="srel:modified-by"
											namespace="http://escidoc.de/core/01/structural-relations/">
											<xsl:attribute name="rdf:resource"
												namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">info:fedora/escidoc:exuser:1</xsl:attribute>
										</xsl:element>
										<xsl:element name="prop:modified-by-title"
											namespace="http://escidoc.de/core/01/properties/">
											<xsl:value-of select="'System Administrator User'" />
										</xsl:element>
										<xsl:element name="version:comment"
											namespace="http://escidoc.de/core/01/properties/version/">
											<xsl:value-of select="'Content Model created.'" />
										</xsl:element>

									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
						<xsl:element name="foxml:datastreamVersion"
							namespace="info:fedora/fedora-system:def/foxml#">
							<xsl:attribute name="ID" select="'RELS-EXT.1'" />
							<xsl:attribute name="LABEL" select="'RELS_EXT DATASTREAM'" />
							<xsl:attribute name="CREATED" select="$lmDate" />
							<xsl:attribute name="MYMETYPE" select="'text/xml'" />
							<xsl:attribute name="SIZE" select="'0'" />
							<!-- diesen Tag original übernehmen -->
							<xsl:element name="foxml:xmlContent"
								namespace="info:fedora/fedora-system:def/foxml#">
								<xsl:element name="rdf:RDF"
									namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
									<xsl:element name="rdf:Description"
										namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
										<xsl:attribute name="rdf:about"
											namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><xsl:value-of select="concat('info:fedora/',$PID)" />
													</xsl:attribute>
										<xsl:element name="system:build"
											namespace="http://escidoc.de/core/01/system/">
											<xsl:value-of select="'1.2beta1'" />
										</xsl:element>
										<xsl:element name="rdf:type"
											namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
											<xsl:value-of
												select="'http://escidoc.de/core/01/resources/ContentModel'" />
										</xsl:element>
										<xsl:element name="hasModel"
											namespace="info:fedora/fedora-system:def/model#">
											<xsl:attribute name="rdf:resource"
												namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">info:fedora/fedora-system:ContentModel-3.0</xsl:attribute>

										</xsl:element>
										<xsl:element name="srel:created-by"
											namespace="http://escidoc.de/core/01/structural-relations/">
											<xsl:attribute name="rdf:resource"
												namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">info:fedora/escidoc:exuser:1</xsl:attribute>
										</xsl:element>

										<xsl:element name="prop:public-status"
											namespace="http://escidoc.de/core/01/properties/">
											<xsl:value-of select="'pending'" />
										</xsl:element>
										<xsl:element name="prop:public-status-comment"
											namespace="http://escidoc.de/core/01/properties/">
											<xsl:value-of select="'Content Model created.'" />
										</xsl:element>
										<xsl:element name="prop:created-by-title"
											namespace="http://escidoc.de/core/01/properties/">
											<xsl:value-of select="'System Administrator User'" />
										</xsl:element>
										<xsl:element name="version:number"
											namespace="http://escidoc.de/core/01/properties/version/">
											<xsl:value-of select="'1'" />
										</xsl:element>
										<xsl:element name="version:date"
											namespace="http://escidoc.de/core/01/properties/version/">
											<xsl:value-of select="$createdDate" />
										</xsl:element>
										<xsl:element name="version:status"
											namespace="http://escidoc.de/core/01/properties/version/">
											<xsl:value-of select="'pending'" />
										</xsl:element>
										<xsl:element name="srel:modified-by"
											namespace="http://escidoc.de/core/01/structural-relations/">
											<xsl:attribute name="rdf:resource"
												namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">info:fedora/escidoc:exuser:1</xsl:attribute>
										</xsl:element>
										<xsl:element name="prop:modified-by-title"
											namespace="http://escidoc.de/core/01/properties/">
											<xsl:value-of select="'System Administrator User'" />
										</xsl:element>
										<xsl:element name="version:comment"
											namespace="http://escidoc.de/core/01/properties/version/">
											<xsl:value-of select="'Content Model created.'" />
										</xsl:element>

									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>

					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:element name="foxml:datastream" namespace="info:fedora/fedora-system:def/foxml#">
			<xsl:attribute name="ID" select="'DS-COMPOSITE-MODEL'" />
			<xsl:attribute name="CONTROL_GROUP" select="'X'" />
			<xsl:attribute name="STATE" select="'A'" />
			<xsl:attribute name="VERSIONABLE" select="'true'" />
			<xsl:element name="foxml:datastreamVersion" namespace="info:fedora/fedora-system:def/foxml#">
				<xsl:attribute name="CREATED" select="$createdDate" />
				<xsl:attribute name="ID" select="'DS-COMPOSITE-MODEL.0'" />
				<xsl:attribute name="LABEL" select="''" />
				<xsl:attribute name="MYMETYPE" select="'text/xml'" />
				<xsl:attribute name="SIZE" select="'0'" />
				<xsl:element name="foxml:xmlContent" namespace="info:fedora/fedora-system:def/foxml#">
					<xsl:element name="dsCompositeModel"
						namespace="info:fedora/fedora-system:def/dsCompositeModel#">
						<xsl:namespace name="schema"
							select="'http://ecm.sourceforge.net/types/dscompositeschema/0/1/#'" />
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>

		<xsl:element name="foxml:datastream" namespace="info:fedora/fedora-system:def/foxml#">
			<xsl:attribute name="ID" select="'version-history'" />
			<xsl:attribute name="CONTROL_GROUP" select="'X'" />
			<xsl:attribute name="STATE" select="'A'" />
			<xsl:attribute name="VERSIONABLE" select="'true'" />
			<xsl:element name="foxml:datastreamVersion" namespace="info:fedora/fedora-system:def/foxml#">
				<xsl:attribute name="CREATED" select="$lmDate" />
				<xsl:attribute name="ID" select="'version-history.0'" />
				<xsl:attribute name="LABEL" select="''" />
				<xsl:attribute name="MYMETYPE" select="'text/xml'" />
				<xsl:attribute name="SIZE" select="'0'" />
				<xsl:element name="foxml:xmlContent" namespace="info:fedora/fedora-system:def/foxml#">
					<xsl:element name="escidocVersions:version-history"
						namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
						<xsl:element name="escidocVersions:version"
							namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
							<xsl:attribute name="objid" select="concat($PID,':1')" />
							<xsl:attribute name="timestamp" select="$createdDate" />
							<xsl:attribute name="xlink:href" namespace="http://www.w3.org/1999/xlink"
								select="concat('/ir/content-model/',$PID,':1')" />
							<xsl:attribute name="xlink:title" namespace="http://www.w3.org/1999/xlink"
								select="$label" />
							<xsl:attribute name="xlink:type" namespace="http://www.w3.org/1999/xlink"
								select="'simple'" />
							<xsl:element name="escidocVersions:version-number"
								namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
								<xsl:value-of select="'1'" />
							</xsl:element>
							<xsl:element name="escidocVersions:timestamp"
								namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
								<xsl:value-of select="$createdDate" />
							</xsl:element>
							<xsl:element name="escidocVersions:version-status"
								namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
								<xsl:value-of select="'pending'" />

							</xsl:element>
							<xsl:element name="escidocVersions:comment"
								namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
								<xsl:value-of select="'Content Model created.'" />
							</xsl:element>
							<xsl:element name="escidocVersions:events"
								namespace="http://www.escidoc.de/schemas/versionhistory/0.3">
								<xsl:element name="premis:event"
									namespace="http://www.loc.gov/standards/premis/v1">
									<xsl:attribute name="xmlID" select="'v1e1'" />
									<xsl:element name="premis:eventIdentifier"
										namespace="http://www.loc.gov/standards/premis/v1">
										<xsl:element name="premis:eventIdentifierType"
											namespace="http://www.loc.gov/standards/premis/v1">
											<xsl:value-of select="'URL'" />
										</xsl:element>
										<xsl:element name="premis:eventIdentifierValue"
											namespace="http://www.loc.gov/standards/premis/v1">
											<xsl:value-of
												select="concat('/ir/item/',$PID,':1/version-history#v1e1')" />
										</xsl:element>
									</xsl:element>
									<xsl:element name="premis:eventType"
										namespace="http://www.loc.gov/standards/premis/v1">
										<xsl:value-of select="'create'" />
									</xsl:element>
									<xsl:element name="premis:eventDateTime"
										namespace="http://www.loc.gov/standards/premis/v1">
										<xsl:value-of select="$createdDate" />
									</xsl:element>
									<xsl:element name="premis:eventDetail"
										namespace="http://www.loc.gov/standards/premis/v1">
										<xsl:value-of select="'Content Model created.'" />
									</xsl:element>
									<xsl:element name="premis:linkingAgentIdentifier"
										namespace="http://www.loc.gov/standards/premis/v1">
										<xsl:attribute name="xlink:href"
											namespace="http://www.w3.org/1999/xlink" select="'/aa/user-account/escidoc:exuser1'" />
										<xsl:attribute name="xlink:title"
											namespace="http://www.w3.org/1999/xlink" select="'System Administrator User'" />
										<xsl:attribute name="xlink:type"
											namespace="http://www.w3.org/1999/xlink" select="'simple'" />

										<xsl:element name="premis:linkingAgentIdentifierType"
											namespace="http://www.loc.gov/standards/premis/v1">
											<xsl:value-of select="'escidoc-internal'" />
										</xsl:element>
										<xsl:element name="premis:linkingAgentIdentifierValue"
											namespace="http://www.loc.gov/standards/premis/v1">
											<xsl:value-of select="'escidoc:exuser1'" />
										</xsl:element>
									</xsl:element>
									<xsl:element name="premis:linkingObjectIdentifier"
										namespace="http://www.loc.gov/standards/premis/v1">
										<xsl:element name="premis:linkingObjectIdentifierType"
											namespace="http://www.loc.gov/standards/premis/v1">
											<xsl:value-of select="'escidoc-internal'" />
										</xsl:element>
										<xsl:element name="premis:linkingObjectIdentifierValue"
												namespace="http://www.loc.gov/standards/premis/v1">
												<xsl:value-of select="$PID" />
											</xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>

