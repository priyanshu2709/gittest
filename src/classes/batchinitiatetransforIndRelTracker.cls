@isTest
public class batchinitiatetransforIndRelTracker
{
    public static Account objacc;
    public static Account objacc1;
    public static Relationship_Hierarchy__c objrel;
    public static Relationship_Hierarchy__c objrel1;
    public static Error_Framework__c objerror;
    public static Error_Framework__c objerror1;
    
    public static testmethod void Testmethod1()
    {
        CreateAccont();
        CreateAccont1();
        CreateRel();
        createError();
        batchinitiatetransactionforRelInd obj = new batchinitiatetransactionforRelInd();
         Test.startTest();
        database.executebatch(obj);
         Test.stopTest();
    }
    public static testmethod void Testmethod2()
    {
        CreateAccont();
        CreateAccont1();
        CreateRel();
        CreateRel1();
        createError();
        batchinitiatetransactionforRelInd obj = new batchinitiatetransactionforRelInd();
         Test.startTest();
        database.executebatch(obj);
         Test.stopTest();
    }
    public static testmethod void Testmethod3()
    {
        CreateAccont();
        CreateAccont1();
        CreateRel();
        createError();
        createError1();
        batchinitiatetransactionforRelInd obj = new batchinitiatetransactionforRelInd();
         Test.startTest();
        database.executebatch(obj);
         Test.stopTest();
    }
    public static void CreateAccont()
    {
        recordtype rt = [select id,name from recordtype where name = 'Individual' and sobjecttype = 'Account'];
        objacc = new Account();
        objAcc.Name = 'Test';
        objacc.recordtypeid = rt.id;
        objacc.WCIS_Last_Call_Status__c = 'Success';
        objacc.WCIS_Last_Call_Time__c  = system.today().adddays(-2);
        insert objacc;
    }
    public static void CreateAccont1()
    {
        recordtype rt = [select id,name from recordtype where name = 'Individual' and sobjecttype = 'Account'];
        objacc1 = new Account();
        objAcc1.Name = 'Test';
        objacc1.recordtypeid = rt.id;
        objacc1.WCIS_Last_Call_Status__c = 'Success';
        objacc1.WCIS_Last_Call_Time__c  = system.today().adddays(2);
        insert objacc1;
    }
    public static void CreateRel()
    {
        
        objrel = new Relationship_Hierarchy__c();
        objrel.Name = 'Test';
        objrel.Child_Account__c = objacc1.id;
        objrel.Parent_Account__c = objacc.id;
        objrel.WCIS_Last_Call_Status__c = 'Success';
        objrel.WCIS_Last_Call_Time__c  = system.today().adddays(-2);
        insert objrel;
    }
    public static void CreateRel1()
    {
        
        objrel1 = new Relationship_Hierarchy__c();
        objrel1.Name = 'Test';
        objrel1.Child_Account__c = objacc1.id;
        objrel1.Parent_Account__c = objacc.id;
        objrel1.WCIS_Last_Call_Status__c = 'Success';
        objrel1.WCIS_Last_Call_Time__c  = system.today().adddays(2);
        insert objrel1;
    }
    public static void createError()
    {
        objerror = new Error_Framework__c();
        objerror.Object_Name__c ='Relationship_Hierarchy__c';
        objerror.Object_Id__c = objrel.id;
        objerror.Service__c = 'WCIS_Relationship_Indv_Call_Class';
        insert objerror;
    }
    public static void createError1()
    {
        objerror1 = new Error_Framework__c();
        objerror1.Object_Name__c ='Relationship_Hierarchy__c';
        objerror1.Object_Id__c = objrel.id;
        objerror1.Service__c = 'WCIS_Relationship_Indv_Call_Class';
        insert objerror1;
    }
}