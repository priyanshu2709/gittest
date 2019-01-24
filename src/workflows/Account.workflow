<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>test</fullName>
        <apiVersion>43.0</apiVersion>
        <endpointUrl>https://mocksvc.mulesoft.com/mocks/d9c2dceb-d12a-47a2-a4ae-3a97755db0cd/leads/</endpointUrl>
        <fields>AccountNumber</fields>
        <fields>AccountSource</fields>
        <fields>AnnualRevenue</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>priyanshu2709@gmail.com</integrationUser>
        <name>test</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Fire at specified time</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Account.Active__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Initiate_Date__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Account.Initiate_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
