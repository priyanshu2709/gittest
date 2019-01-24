@isTest
public class batchinitiatetransactionTracker
{
    public static Account objacc;
    public static Account objacc1;
    public static Relationship_Hierarchy__c objrel;
    public static Relationship_Hierarchy__c objrel1;
    public static Error_Framework__c objerror;
    public static Error_Framework__c objerror1;
    public static Error_Framework__c objerror2;
    public static Error_Framework__c objerror3;
    public static testmethod void Testmethod1()
    {
        CreateAccont();
        CreateRel();
        CreateRel1();
        createError();
        batchinitiatetransaction obj = new batchinitiatetransaction();
         Test.startTest();
        database.executebatch(obj);
         Test.stopTest();
    }
    public static testmethod void Testmethod2()
    {
        CreateAccont();
        CreateRel();
        CreateRel1();
        CreateAccont1();
        createError();
        batchinitiatetransaction obj = new batchinitiatetransaction();
         Test.startTest();
        database.executebatch(obj);
         Test.stopTest();
    }
    public static testmethod void Testmethod3()
    {
        CreateAccont();
        CreateRel();
        CreateRel1();
        createError();
        createError1();
        batchinitiatetransaction obj = new batchinitiatetransaction();
         Test.startTest();
        database.executebatch(obj);
         Test.stopTest();
    }
     public static void CreateRel()
    {
        
        objrel = new Relationship_Hierarchy__c();
        objrel.Name = 'Test';
        objrel.WCIS_Last_Call_Status__c = 'Success';
        objrel.WCIS_Last_Call_Time__c  = system.today().adddays(-2);
        insert objrel;
    }
    public static void CreateRel1()
    {
        
        objrel1 = new Relationship_Hierarchy__c();
        objrel1.Name = 'Test';
        objrel1.WCIS_Last_Call_Status__c = 'Success';
        objrel1.WCIS_Last_Call_Time__c  = system.today().adddays(2);
        insert objrel1;
    }
    public static void CreateAccont()
    {
        recordtype rt = [select id,name from recordtype where name = 'Company' and sobjecttype = 'Account'];
        objacc = new Account();
        objAcc.Name = 'Test';
        objacc.recordtypeid = rt.id;
        objacc.WCIS_Last_Call_Status__c = 'Success';
        objacc.WCIS_Last_Call_Time__c  = system.today().adddays(-2);
        insert objacc;
    }
    public static void CreateAccont1()
    {
        recordtype rt = [select id,name from recordtype where name = 'Company' and sobjecttype = 'Account'];
        objacc1 = new Account();
        objAcc1.Name = 'Test';
        objacc1.recordtypeid = rt.id;
        objacc1.WCIS_Last_Call_Status__c = 'Success';
        objacc1.WCIS_Last_Call_Time__c  = system.today().adddays(2);
        insert objacc1;
    }
    public static void createError()
    {
        objerror = new Error_Framework__c();
        objerror.Object_Name__c ='Account';
        objerror.Object_Id__c = objacc.id;
        objerror.Service__c = 'WCIS_CompanyInt_call_Class';
        insert objerror;
    }
    public static void createError1()
    {
        objerror1 = new Error_Framework__c();
        objerror1.Object_Name__c ='Relationship_Hierarchy__c';
        objerror1.Object_Id__c = objrel.id;
        objerror1.Service__c = 'WCIS_IndividualInt_Call_class';
        insert objerror1;
    }
    public static void createError2()
    {
        objerror2 = new Error_Framework__c();
        objerror2.Object_Name__c ='Relationship_Hierarchy__c';
        objerror2.Object_Id__c = objrel1.id;
        objerror2.Service__c = 'WCIS_Relationship_Company_call_class';
        insert objerror2;
    }
    public static void createError3()
    {
        objerror3 = new Error_Framework__c();
        objerror3.Object_Name__c ='Relationship_Hierarchy__c';
        objerror3.Object_Id__c = objrel1.id;
        objerror3.Service__c = 'WCIS_Relationship_Indv_Call_Class';
        insert objerror3;
    }
}