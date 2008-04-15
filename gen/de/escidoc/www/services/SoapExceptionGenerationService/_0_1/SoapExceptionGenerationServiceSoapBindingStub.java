/**
 * SoapExceptionGenerationServiceSoapBindingStub.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package de.escidoc.www.services.SoapExceptionGenerationService._0_1;

public class SoapExceptionGenerationServiceSoapBindingStub extends org.apache.axis.client.Stub implements de.escidoc.www.services.SoapExceptionGenerationService._0_1.SoapExceptionGeneration {
    private java.util.Vector cachedSerClasses = new java.util.Vector();
    private java.util.Vector cachedSerQNames = new java.util.Vector();
    private java.util.Vector cachedSerFactories = new java.util.Vector();
    private java.util.Vector cachedDeserFactories = new java.util.Vector();

    static org.apache.axis.description.OperationDesc [] _operations;

    static {
        _operations = new org.apache.axis.description.OperationDesc[1];
        _initOperationDesc1();
    }

    private static void _initOperationDesc1(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("generateExceptions");
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.ReadonlyVersionException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ReadonlyVersionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.LockingException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "LockingException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.RuleViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "RuleViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.AdminDescriptorNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "AdminDescriptorNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ComponentNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ComponentNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ContainerNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.AlreadyWithdrawnException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyWithdrawnException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ItemNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.FileSystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "FileSystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.WorkflowDefinitionNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "WorkflowDefinitionNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.TmeException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "TmeException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.XmlSchemaValidationException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "XmlSchemaValidationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidAggregationTypeException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidAggregationTypeException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.ReadonlyViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ReadonlyViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidSqlException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidSqlException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidXmlException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidXmlException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.missing.MissingUserListException",
                      new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingUserListException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.IngestionDefinitionNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "IngestionDefinitionNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.PidNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "PidNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.RelationPredicateNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RelationPredicateNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.RelationRuleViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "RelationRuleViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.WorkflowTaskViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "WorkflowTaskViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.XmlParserSystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "XmlParserSystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.FileNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "FileNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.AggregationTypeNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "AggregationTypeNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.IndexNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "IndexNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.AggregationDefinitionNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "AggregationDefinitionNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.SqlDatabaseSystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "SqlDatabaseSystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ResourceNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ResourceNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidPidException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidPidException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.IntegritySystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "IntegritySystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.missing.MissingLicenceException",
                      new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingLicenceException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TocNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.OrganizationalUnitHierarchyViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "OrganizationalUnitHierarchyViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.WorkflowTypeNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "WorkflowTypeNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidContextException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidContextException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ReferencedResourceNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ReferencedResourceNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.RelationTypeNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RelationTypeNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.TripleStoreSystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "TripleStoreSystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.XmlSchemaNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "XmlSchemaNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidContextStatusException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidContextStatusException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.AlreadyPublishedException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyPublishedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ScopeNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ScopeNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.missing.MissingMethodParameterException",
                      new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingMethodParameterException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.ApplicationServerSystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "ApplicationServerSystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ReportDefinitionNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.SearchNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "SearchNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.missing.MissingElementValueException",
                      new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingElementValueException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ContentRelationNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ContentRelationNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.TaskNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TaskNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreOutputFormatException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidTripleStoreOutputFormatException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.IngestionTaskNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "IngestionTaskNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "UserAccountNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.StructuralMapEntryNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "StructuralMapEntryNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidContentModelException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidContentModelException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.AlreadyDeletedException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyDeletedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.WorkflowEngineSystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "WorkflowEngineSystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.TargetBasketNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TargetBasketNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidSearchQueryException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidSearchQueryException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.ScopeContextViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ScopeContextViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ItemReferenceNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ItemReferenceNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidContentException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidContentException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.ReadonlyAttributeViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ReadonlyAttributeViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidStatusException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidStatusException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreQueryException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidTripleStoreQueryException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.EscidocException",
                      new javax.xml.namespace.QName("http://exceptions.common.core.escidoc.de", "EscidocException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.SystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "SystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ActionNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ActionNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.UserNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "UserNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.WebserverSystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "WebserverSystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.AlreadyExistsException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyExistsException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.XmlCorruptedException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "XmlCorruptedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.ReferenceCycleException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "ReferenceCycleException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.missing.MissingWorkflowVariableException",
                      new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingWorkflowVariableException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.MdRecordNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "MdRecordNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.RoleInUseViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "RoleInUseViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidItemStatusException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidItemStatusException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.RelationNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RelationNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.WorkflowViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "WorkflowViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.RevisionNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RevisionNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RoleNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.missing.MissingContentException",
                      new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingContentException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.missing.MissingParameterException",
                      new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingParameterException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowDefinitionException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidWorkflowDefinitionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ContextNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ContextNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidRelationPropertiesException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidRelationPropertiesException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowTypeException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidWorkflowTypeException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.invalid.ValidationException",
                      new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "ValidationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.ContentModelNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ContentModelNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.missing.MissingAttributeValueException",
                      new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingAttributeValueException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.AdminDescriptorViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AdminDescriptorViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.TaskListNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TaskListNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.WorkflowInstanceNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "WorkflowInstanceNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.missing.MissingMdRecordException",
                      new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingMdRecordException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.ApplicationException",
                      new javax.xml.namespace.QName("http://application.exceptions.common.core.escidoc.de", "ApplicationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.system.FedoraSystemException",
                      new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "FedoraSystemException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.VersionNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "VersionNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.TransitionNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TransitionNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.WorkflowTemplateNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "WorkflowTemplateNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.notfound.IngestionSourceNotFoundException",
                      new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "IngestionSourceNotFoundException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.OptimisticLockingException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "OptimisticLockingException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.NotPublishedException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "NotPublishedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.ReadonlyElementViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ReadonlyElementViolationException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "fault"),
                      "de.escidoc.core.common.exceptions.application.violated.TimeFrameViolationException",
                      new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "TimeFrameViolationException"), 
                      true
                     ));
        _operations[0] = oper;

    }

    public SoapExceptionGenerationServiceSoapBindingStub() throws org.apache.axis.AxisFault {
         this(null);
    }

    public SoapExceptionGenerationServiceSoapBindingStub(java.net.URL endpointURL, javax.xml.rpc.Service service) throws org.apache.axis.AxisFault {
         this(service);
         super.cachedEndpoint = endpointURL;
    }

    public SoapExceptionGenerationServiceSoapBindingStub(javax.xml.rpc.Service service) throws org.apache.axis.AxisFault {
        if (service == null) {
            super.service = new org.apache.axis.client.Service();
        } else {
            super.service = service;
        }
        ((org.apache.axis.client.Service)super.service).setTypeMappingVersion("1.2");
            java.lang.Class cls;
            javax.xml.namespace.QName qName;
            javax.xml.namespace.QName qName2;
            java.lang.Class beansf = org.apache.axis.encoding.ser.BeanSerializerFactory.class;
            java.lang.Class beandf = org.apache.axis.encoding.ser.BeanDeserializerFactory.class;
            java.lang.Class enumsf = org.apache.axis.encoding.ser.EnumSerializerFactory.class;
            java.lang.Class enumdf = org.apache.axis.encoding.ser.EnumDeserializerFactory.class;
            java.lang.Class arraysf = org.apache.axis.encoding.ser.ArraySerializerFactory.class;
            java.lang.Class arraydf = org.apache.axis.encoding.ser.ArrayDeserializerFactory.class;
            java.lang.Class simplesf = org.apache.axis.encoding.ser.SimpleSerializerFactory.class;
            java.lang.Class simpledf = org.apache.axis.encoding.ser.SimpleDeserializerFactory.class;
            java.lang.Class simplelistsf = org.apache.axis.encoding.ser.SimpleListSerializerFactory.class;
            java.lang.Class simplelistdf = org.apache.axis.encoding.ser.SimpleListDeserializerFactory.class;
        addBindings0();
        addBindings1();
    }

    private void addBindings0() {
            java.lang.Class cls;
            javax.xml.namespace.QName qName;
            javax.xml.namespace.QName qName2;
            java.lang.Class beansf = org.apache.axis.encoding.ser.BeanSerializerFactory.class;
            java.lang.Class beandf = org.apache.axis.encoding.ser.BeanDeserializerFactory.class;
            java.lang.Class enumsf = org.apache.axis.encoding.ser.EnumSerializerFactory.class;
            java.lang.Class enumdf = org.apache.axis.encoding.ser.EnumDeserializerFactory.class;
            java.lang.Class arraysf = org.apache.axis.encoding.ser.ArraySerializerFactory.class;
            java.lang.Class arraydf = org.apache.axis.encoding.ser.ArrayDeserializerFactory.class;
            java.lang.Class simplesf = org.apache.axis.encoding.ser.SimpleSerializerFactory.class;
            java.lang.Class simpledf = org.apache.axis.encoding.ser.SimpleDeserializerFactory.class;
            java.lang.Class simplelistsf = org.apache.axis.encoding.ser.SimpleListSerializerFactory.class;
            java.lang.Class simplelistdf = org.apache.axis.encoding.ser.SimpleListDeserializerFactory.class;
            qName = new javax.xml.namespace.QName("http://application.exceptions.common.core.escidoc.de", "ApplicationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.ApplicationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://exceptions.common.core.escidoc.de", "EscidocException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.EscidocException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidAggregationTypeException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidAggregationTypeException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidContentException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidContentException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidContentModelException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidContentModelException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidContextException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidContextException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidContextStatusException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidContextStatusException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidItemStatusException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidItemStatusException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidPidException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidPidException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidRelationPropertiesException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidRelationPropertiesException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidSearchQueryException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidSearchQueryException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidSqlException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidSqlException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidStatusException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidStatusException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidTripleStoreOutputFormatException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreOutputFormatException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidTripleStoreQueryException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreQueryException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidWorkflowDefinitionException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowDefinitionException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidWorkflowTypeException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowTypeException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "InvalidXmlException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.InvalidXmlException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "ReferenceCycleException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.ReferenceCycleException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "TmeException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.TmeException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "ValidationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.ValidationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "XmlCorruptedException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.XmlCorruptedException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://invalid.application.exceptions.common.core.escidoc.de", "XmlSchemaValidationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.invalid.XmlSchemaValidationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingAttributeValueException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.missing.MissingAttributeValueException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingContentException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.missing.MissingContentException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingElementValueException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.missing.MissingElementValueException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingLicenceException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.missing.MissingLicenceException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingMdRecordException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.missing.MissingMdRecordException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingMethodParameterException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.missing.MissingMethodParameterException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingParameterException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.missing.MissingParameterException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingUserListException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.missing.MissingUserListException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://missing.application.exceptions.common.core.escidoc.de", "MissingWorkflowVariableException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.missing.MissingWorkflowVariableException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ActionNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ActionNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "AdminDescriptorNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.AdminDescriptorNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "AggregationDefinitionNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.AggregationDefinitionNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "AggregationTypeNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.AggregationTypeNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ComponentNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ComponentNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ContainerNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ContentModelNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ContentModelNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ContentRelationNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ContentRelationNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ContextNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ContextNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "FileNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.FileNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "GrantNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.GrantNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "IndexNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.IndexNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "IngestionDefinitionNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.IngestionDefinitionNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "IngestionSourceNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.IngestionSourceNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "IngestionTaskNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.IngestionTaskNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ItemNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ItemReferenceNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ItemReferenceNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "MdRecordNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.MdRecordNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "OrganizationalUnitNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.OrganizationalUnitNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "PidNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.PidNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ReferencedResourceNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ReferencedResourceNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RelationNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.RelationNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RelationPredicateNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.RelationPredicateNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RelationTypeNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.RelationTypeNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ReportDefinitionNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ResourceNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ResourceNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RevisionNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.RevisionNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "RoleNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "ScopeNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.ScopeNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "SearchNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.SearchNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "StagingFileNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.StagingFileNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "StructuralMapEntryNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.StructuralMapEntryNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TargetBasketNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.TargetBasketNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TaskListNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.TaskListNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TaskNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.TaskNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TocNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "TransitionNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.TransitionNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "UserAccountNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "UserNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.UserNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "VersionNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.VersionNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "WorkflowDefinitionNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.WorkflowDefinitionNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "WorkflowInstanceNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.WorkflowInstanceNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "WorkflowTemplateNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.WorkflowTemplateNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "WorkflowTypeNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.WorkflowTypeNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://notfound.application.exceptions.common.core.escidoc.de", "XmlSchemaNotFoundException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.notfound.XmlSchemaNotFoundException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://security.application.exceptions.common.core.escidoc.de", "AuthenticationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.security.AuthenticationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://security.application.exceptions.common.core.escidoc.de", "AuthorizationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.security.AuthorizationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://security.application.exceptions.common.core.escidoc.de", "SecurityException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.security.SecurityException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "ApplicationServerSystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.ApplicationServerSystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "FedoraSystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.FedoraSystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "FileSystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.FileSystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "IntegritySystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.IntegritySystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "SqlDatabaseSystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.SqlDatabaseSystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "SystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.SystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "TripleStoreSystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.TripleStoreSystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "WebserverSystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.WebserverSystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "WorkflowEngineSystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.WorkflowEngineSystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://system.exceptions.common.core.escidoc.de", "XmlParserSystemException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.system.XmlParserSystemException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AdminDescriptorViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.AdminDescriptorViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyActiveException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.AlreadyActiveException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyDeactiveException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.AlreadyDeactiveException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyDeletedException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.AlreadyDeletedException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyExistsException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.AlreadyExistsException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyPublishedException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.AlreadyPublishedException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyRevokedException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.AlreadyRevokedException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "AlreadyWithdrawnException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.AlreadyWithdrawnException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ContextNameNotUniqueException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.ContextNameNotUniqueException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "LockingException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.LockingException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

    }
    private void addBindings1() {
            java.lang.Class cls;
            javax.xml.namespace.QName qName;
            javax.xml.namespace.QName qName2;
            java.lang.Class beansf = org.apache.axis.encoding.ser.BeanSerializerFactory.class;
            java.lang.Class beandf = org.apache.axis.encoding.ser.BeanDeserializerFactory.class;
            java.lang.Class enumsf = org.apache.axis.encoding.ser.EnumSerializerFactory.class;
            java.lang.Class enumdf = org.apache.axis.encoding.ser.EnumDeserializerFactory.class;
            java.lang.Class arraysf = org.apache.axis.encoding.ser.ArraySerializerFactory.class;
            java.lang.Class arraydf = org.apache.axis.encoding.ser.ArrayDeserializerFactory.class;
            java.lang.Class simplesf = org.apache.axis.encoding.ser.SimpleSerializerFactory.class;
            java.lang.Class simpledf = org.apache.axis.encoding.ser.SimpleDeserializerFactory.class;
            java.lang.Class simplelistsf = org.apache.axis.encoding.ser.SimpleListSerializerFactory.class;
            java.lang.Class simplelistdf = org.apache.axis.encoding.ser.SimpleListDeserializerFactory.class;
            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "NotPublishedException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.NotPublishedException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "OptimisticLockingException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.OptimisticLockingException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "OrganizationalUnitHasChildrenException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.OrganizationalUnitHasChildrenException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "OrganizationalUnitHierarchyViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.OrganizationalUnitHierarchyViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "OrganizationalUnitNameNotUniqueException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.OrganizationalUnitNameNotUniqueException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "PidAlreadyAssignedException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.PidAlreadyAssignedException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ReadonlyAttributeViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.ReadonlyAttributeViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ReadonlyElementViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.ReadonlyElementViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ReadonlyVersionException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.ReadonlyVersionException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ReadonlyViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.ReadonlyViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "RelationRuleViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.RelationRuleViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "RoleInUseViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.RoleInUseViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "RuleViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.RuleViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "ScopeContextViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.ScopeContextViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "TimeFrameViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.TimeFrameViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "UniqueConstraintViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.UniqueConstraintViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "WorkflowTaskViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.WorkflowTaskViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://violated.application.exceptions.common.core.escidoc.de", "WorkflowViolationException");
            cachedSerQNames.add(qName);
            cls = de.escidoc.core.common.exceptions.application.violated.WorkflowViolationException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

    }

    protected org.apache.axis.client.Call createCall() throws java.rmi.RemoteException {
        try {
            org.apache.axis.client.Call _call = super._createCall();
            if (super.maintainSessionSet) {
                _call.setMaintainSession(super.maintainSession);
            }
            if (super.cachedUsername != null) {
                _call.setUsername(super.cachedUsername);
            }
            if (super.cachedPassword != null) {
                _call.setPassword(super.cachedPassword);
            }
            if (super.cachedEndpoint != null) {
                _call.setTargetEndpointAddress(super.cachedEndpoint);
            }
            if (super.cachedTimeout != null) {
                _call.setTimeout(super.cachedTimeout);
            }
            if (super.cachedPortName != null) {
                _call.setPortName(super.cachedPortName);
            }
            java.util.Enumeration keys = super.cachedProperties.keys();
            while (keys.hasMoreElements()) {
                java.lang.String key = (java.lang.String) keys.nextElement();
                _call.setProperty(key, super.cachedProperties.get(key));
            }
            // All the type mapping information is registered
            // when the first call is made.
            // The type mapping information is actually registered in
            // the TypeMappingRegistry of the service, which
            // is the reason why registration is only needed for the first call.
            synchronized (this) {
                if (firstCall()) {
                    // must set encoding style before registering serializers
                    _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
                    _call.setEncodingStyle(org.apache.axis.Constants.URI_SOAP11_ENC);
                    for (int i = 0; i < cachedSerFactories.size(); ++i) {
                        java.lang.Class cls = (java.lang.Class) cachedSerClasses.get(i);
                        javax.xml.namespace.QName qName =
                                (javax.xml.namespace.QName) cachedSerQNames.get(i);
                        java.lang.Object x = cachedSerFactories.get(i);
                        if (x instanceof Class) {
                            java.lang.Class sf = (java.lang.Class)
                                 cachedSerFactories.get(i);
                            java.lang.Class df = (java.lang.Class)
                                 cachedDeserFactories.get(i);
                            _call.registerTypeMapping(cls, qName, sf, df, false);
                        }
                        else if (x instanceof javax.xml.rpc.encoding.SerializerFactory) {
                            org.apache.axis.encoding.SerializerFactory sf = (org.apache.axis.encoding.SerializerFactory)
                                 cachedSerFactories.get(i);
                            org.apache.axis.encoding.DeserializerFactory df = (org.apache.axis.encoding.DeserializerFactory)
                                 cachedDeserFactories.get(i);
                            _call.registerTypeMapping(cls, qName, sf, df, false);
                        }
                    }
                }
            }
            return _call;
        }
        catch (java.lang.Throwable _t) {
            throw new org.apache.axis.AxisFault("Failure trying to get the Call object", _t);
        }
    }

    public void generateExceptions() throws java.rmi.RemoteException, de.escidoc.core.common.exceptions.application.violated.ReadonlyVersionException, de.escidoc.core.common.exceptions.application.violated.LockingException, de.escidoc.core.common.exceptions.application.violated.RuleViolationException, de.escidoc.core.common.exceptions.application.notfound.AdminDescriptorNotFoundException, de.escidoc.core.common.exceptions.application.notfound.ComponentNotFoundException, de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException, de.escidoc.core.common.exceptions.application.violated.AlreadyWithdrawnException, de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException, de.escidoc.core.common.exceptions.system.FileSystemException, de.escidoc.core.common.exceptions.application.notfound.WorkflowDefinitionNotFoundException, de.escidoc.core.common.exceptions.application.invalid.TmeException, de.escidoc.core.common.exceptions.application.invalid.XmlSchemaValidationException, de.escidoc.core.common.exceptions.application.invalid.InvalidAggregationTypeException, de.escidoc.core.common.exceptions.application.violated.ReadonlyViolationException, de.escidoc.core.common.exceptions.application.invalid.InvalidSqlException, de.escidoc.core.common.exceptions.application.invalid.InvalidXmlException, de.escidoc.core.common.exceptions.application.missing.MissingUserListException, de.escidoc.core.common.exceptions.application.notfound.IngestionDefinitionNotFoundException, de.escidoc.core.common.exceptions.application.notfound.PidNotFoundException, de.escidoc.core.common.exceptions.application.notfound.RelationPredicateNotFoundException, de.escidoc.core.common.exceptions.application.violated.RelationRuleViolationException, de.escidoc.core.common.exceptions.application.violated.WorkflowTaskViolationException, de.escidoc.core.common.exceptions.system.XmlParserSystemException, de.escidoc.core.common.exceptions.application.notfound.FileNotFoundException, de.escidoc.core.common.exceptions.application.notfound.AggregationTypeNotFoundException, de.escidoc.core.common.exceptions.application.notfound.IndexNotFoundException, de.escidoc.core.common.exceptions.application.notfound.AggregationDefinitionNotFoundException, de.escidoc.core.common.exceptions.system.SqlDatabaseSystemException, de.escidoc.core.common.exceptions.application.notfound.ResourceNotFoundException, de.escidoc.core.common.exceptions.application.invalid.InvalidPidException, de.escidoc.core.common.exceptions.system.IntegritySystemException, de.escidoc.core.common.exceptions.application.missing.MissingLicenceException, de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException, de.escidoc.core.common.exceptions.application.violated.OrganizationalUnitHierarchyViolationException, de.escidoc.core.common.exceptions.application.notfound.WorkflowTypeNotFoundException, de.escidoc.core.common.exceptions.application.invalid.InvalidContextException, de.escidoc.core.common.exceptions.application.notfound.ReferencedResourceNotFoundException, de.escidoc.core.common.exceptions.application.notfound.RelationTypeNotFoundException, de.escidoc.core.common.exceptions.system.TripleStoreSystemException, de.escidoc.core.common.exceptions.application.notfound.XmlSchemaNotFoundException, de.escidoc.core.common.exceptions.application.invalid.InvalidContextStatusException, de.escidoc.core.common.exceptions.application.violated.AlreadyPublishedException, de.escidoc.core.common.exceptions.application.notfound.ScopeNotFoundException, de.escidoc.core.common.exceptions.application.missing.MissingMethodParameterException, de.escidoc.core.common.exceptions.system.ApplicationServerSystemException, de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException, de.escidoc.core.common.exceptions.application.notfound.SearchNotFoundException, de.escidoc.core.common.exceptions.application.missing.MissingElementValueException, de.escidoc.core.common.exceptions.application.notfound.ContentRelationNotFoundException, de.escidoc.core.common.exceptions.application.notfound.TaskNotFoundException, de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreOutputFormatException, de.escidoc.core.common.exceptions.application.notfound.IngestionTaskNotFoundException, de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException, de.escidoc.core.common.exceptions.application.notfound.StructuralMapEntryNotFoundException, de.escidoc.core.common.exceptions.application.invalid.InvalidContentModelException, de.escidoc.core.common.exceptions.application.violated.AlreadyDeletedException, de.escidoc.core.common.exceptions.system.WorkflowEngineSystemException, de.escidoc.core.common.exceptions.application.notfound.TargetBasketNotFoundException, de.escidoc.core.common.exceptions.application.invalid.InvalidSearchQueryException, de.escidoc.core.common.exceptions.application.violated.ScopeContextViolationException, de.escidoc.core.common.exceptions.application.notfound.ItemReferenceNotFoundException, de.escidoc.core.common.exceptions.application.invalid.InvalidContentException, de.escidoc.core.common.exceptions.application.violated.ReadonlyAttributeViolationException, de.escidoc.core.common.exceptions.application.invalid.InvalidStatusException, de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreQueryException, de.escidoc.core.common.exceptions.EscidocException, de.escidoc.core.common.exceptions.system.SystemException, de.escidoc.core.common.exceptions.application.notfound.ActionNotFoundException, de.escidoc.core.common.exceptions.application.notfound.UserNotFoundException, de.escidoc.core.common.exceptions.system.WebserverSystemException, de.escidoc.core.common.exceptions.application.violated.AlreadyExistsException, de.escidoc.core.common.exceptions.application.invalid.XmlCorruptedException, de.escidoc.core.common.exceptions.application.invalid.ReferenceCycleException, de.escidoc.core.common.exceptions.application.missing.MissingWorkflowVariableException, de.escidoc.core.common.exceptions.application.notfound.MdRecordNotFoundException, de.escidoc.core.common.exceptions.application.violated.RoleInUseViolationException, de.escidoc.core.common.exceptions.application.invalid.InvalidItemStatusException, de.escidoc.core.common.exceptions.application.notfound.RelationNotFoundException, de.escidoc.core.common.exceptions.application.violated.WorkflowViolationException, de.escidoc.core.common.exceptions.application.notfound.RevisionNotFoundException, de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException, de.escidoc.core.common.exceptions.application.missing.MissingContentException, de.escidoc.core.common.exceptions.application.missing.MissingParameterException, de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowDefinitionException, de.escidoc.core.common.exceptions.application.notfound.ContextNotFoundException, de.escidoc.core.common.exceptions.application.invalid.InvalidRelationPropertiesException, de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowTypeException, de.escidoc.core.common.exceptions.application.invalid.ValidationException, de.escidoc.core.common.exceptions.application.notfound.ContentModelNotFoundException, de.escidoc.core.common.exceptions.application.missing.MissingAttributeValueException, de.escidoc.core.common.exceptions.application.violated.AdminDescriptorViolationException, de.escidoc.core.common.exceptions.application.notfound.TaskListNotFoundException, de.escidoc.core.common.exceptions.application.notfound.WorkflowInstanceNotFoundException, de.escidoc.core.common.exceptions.application.missing.MissingMdRecordException, de.escidoc.core.common.exceptions.application.ApplicationException, de.escidoc.core.common.exceptions.system.FedoraSystemException, de.escidoc.core.common.exceptions.application.notfound.VersionNotFoundException, de.escidoc.core.common.exceptions.application.notfound.TransitionNotFoundException, de.escidoc.core.common.exceptions.application.notfound.WorkflowTemplateNotFoundException, de.escidoc.core.common.exceptions.application.notfound.IngestionSourceNotFoundException, de.escidoc.core.common.exceptions.application.violated.OptimisticLockingException, de.escidoc.core.common.exceptions.application.violated.NotPublishedException, de.escidoc.core.common.exceptions.application.violated.ReadonlyElementViolationException, de.escidoc.core.common.exceptions.application.violated.TimeFrameViolationException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[0]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("http://www.escidoc.de/services/SoapExceptionGenerationService/0.1", "generateExceptions"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        extractAttachments(_call);
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.ReadonlyVersionException) {
              throw (de.escidoc.core.common.exceptions.application.violated.ReadonlyVersionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.LockingException) {
              throw (de.escidoc.core.common.exceptions.application.violated.LockingException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.RuleViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.RuleViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.AdminDescriptorNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.AdminDescriptorNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ComponentNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ComponentNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.AlreadyWithdrawnException) {
              throw (de.escidoc.core.common.exceptions.application.violated.AlreadyWithdrawnException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.FileSystemException) {
              throw (de.escidoc.core.common.exceptions.system.FileSystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.WorkflowDefinitionNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.WorkflowDefinitionNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.TmeException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.TmeException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.XmlSchemaValidationException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.XmlSchemaValidationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidAggregationTypeException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidAggregationTypeException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.ReadonlyViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.ReadonlyViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidSqlException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidSqlException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidXmlException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidXmlException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.missing.MissingUserListException) {
              throw (de.escidoc.core.common.exceptions.application.missing.MissingUserListException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.IngestionDefinitionNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.IngestionDefinitionNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.PidNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.PidNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.RelationPredicateNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.RelationPredicateNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.RelationRuleViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.RelationRuleViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.WorkflowTaskViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.WorkflowTaskViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.XmlParserSystemException) {
              throw (de.escidoc.core.common.exceptions.system.XmlParserSystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.FileNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.FileNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.AggregationTypeNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.AggregationTypeNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.IndexNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.IndexNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.AggregationDefinitionNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.AggregationDefinitionNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.SqlDatabaseSystemException) {
              throw (de.escidoc.core.common.exceptions.system.SqlDatabaseSystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ResourceNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ResourceNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidPidException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidPidException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.IntegritySystemException) {
              throw (de.escidoc.core.common.exceptions.system.IntegritySystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.missing.MissingLicenceException) {
              throw (de.escidoc.core.common.exceptions.application.missing.MissingLicenceException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.OrganizationalUnitHierarchyViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.OrganizationalUnitHierarchyViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.WorkflowTypeNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.WorkflowTypeNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidContextException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidContextException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ReferencedResourceNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ReferencedResourceNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.RelationTypeNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.RelationTypeNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.TripleStoreSystemException) {
              throw (de.escidoc.core.common.exceptions.system.TripleStoreSystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.XmlSchemaNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.XmlSchemaNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidContextStatusException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidContextStatusException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.AlreadyPublishedException) {
              throw (de.escidoc.core.common.exceptions.application.violated.AlreadyPublishedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ScopeNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ScopeNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.missing.MissingMethodParameterException) {
              throw (de.escidoc.core.common.exceptions.application.missing.MissingMethodParameterException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.ApplicationServerSystemException) {
              throw (de.escidoc.core.common.exceptions.system.ApplicationServerSystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.SearchNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.SearchNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.missing.MissingElementValueException) {
              throw (de.escidoc.core.common.exceptions.application.missing.MissingElementValueException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ContentRelationNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ContentRelationNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.TaskNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.TaskNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreOutputFormatException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreOutputFormatException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.IngestionTaskNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.IngestionTaskNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.StructuralMapEntryNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.StructuralMapEntryNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidContentModelException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidContentModelException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.AlreadyDeletedException) {
              throw (de.escidoc.core.common.exceptions.application.violated.AlreadyDeletedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.WorkflowEngineSystemException) {
              throw (de.escidoc.core.common.exceptions.system.WorkflowEngineSystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.TargetBasketNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.TargetBasketNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidSearchQueryException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidSearchQueryException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.ScopeContextViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.ScopeContextViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ItemReferenceNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ItemReferenceNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidContentException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidContentException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.ReadonlyAttributeViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.ReadonlyAttributeViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidStatusException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidStatusException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreQueryException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidTripleStoreQueryException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.EscidocException) {
              throw (de.escidoc.core.common.exceptions.EscidocException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.SystemException) {
              throw (de.escidoc.core.common.exceptions.system.SystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ActionNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ActionNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.UserNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.UserNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.WebserverSystemException) {
              throw (de.escidoc.core.common.exceptions.system.WebserverSystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.AlreadyExistsException) {
              throw (de.escidoc.core.common.exceptions.application.violated.AlreadyExistsException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.XmlCorruptedException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.XmlCorruptedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.ReferenceCycleException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.ReferenceCycleException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.missing.MissingWorkflowVariableException) {
              throw (de.escidoc.core.common.exceptions.application.missing.MissingWorkflowVariableException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.MdRecordNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.MdRecordNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.RoleInUseViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.RoleInUseViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidItemStatusException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidItemStatusException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.RelationNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.RelationNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.WorkflowViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.WorkflowViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.RevisionNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.RevisionNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.missing.MissingContentException) {
              throw (de.escidoc.core.common.exceptions.application.missing.MissingContentException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.missing.MissingParameterException) {
              throw (de.escidoc.core.common.exceptions.application.missing.MissingParameterException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowDefinitionException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowDefinitionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ContextNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ContextNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidRelationPropertiesException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidRelationPropertiesException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowTypeException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.InvalidWorkflowTypeException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.invalid.ValidationException) {
              throw (de.escidoc.core.common.exceptions.application.invalid.ValidationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.ContentModelNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.ContentModelNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.missing.MissingAttributeValueException) {
              throw (de.escidoc.core.common.exceptions.application.missing.MissingAttributeValueException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.AdminDescriptorViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.AdminDescriptorViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.TaskListNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.TaskListNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.WorkflowInstanceNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.WorkflowInstanceNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.missing.MissingMdRecordException) {
              throw (de.escidoc.core.common.exceptions.application.missing.MissingMdRecordException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.ApplicationException) {
              throw (de.escidoc.core.common.exceptions.application.ApplicationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.system.FedoraSystemException) {
              throw (de.escidoc.core.common.exceptions.system.FedoraSystemException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.VersionNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.VersionNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.TransitionNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.TransitionNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.WorkflowTemplateNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.WorkflowTemplateNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.notfound.IngestionSourceNotFoundException) {
              throw (de.escidoc.core.common.exceptions.application.notfound.IngestionSourceNotFoundException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.OptimisticLockingException) {
              throw (de.escidoc.core.common.exceptions.application.violated.OptimisticLockingException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.NotPublishedException) {
              throw (de.escidoc.core.common.exceptions.application.violated.NotPublishedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.ReadonlyElementViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.ReadonlyElementViolationException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof de.escidoc.core.common.exceptions.application.violated.TimeFrameViolationException) {
              throw (de.escidoc.core.common.exceptions.application.violated.TimeFrameViolationException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

}
