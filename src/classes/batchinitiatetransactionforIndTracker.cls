@isTest
public class batchinitiatetransactionforIndTracker
{
    public static Account objacc;
    public static Account objacc1;
    public static Error_Framework__c objerror;
    public static Error_Framework__c objerror1;
    
    public static testmethod void Testmethod1()
    {
        CreateAccont();
        createError();
        batchinitiatetransactionforInd obj = new batchinitiatetransactionforInd();
         Test.startTest();
        database.executebatch(obj);
         Test.stopTest();
    }
    public static testmethod void Testmethod2()
    {
        CreateAccont();
        CreateAccont1();
        createError();
        batchinitiatetransactionforInd obj = new batchinitiatetransactionforInd();
         Test.startTest();
        database.executebatch(obj);
         Test.stopTest();
    }
    public static testmethod void Testmethod3()
    {
        CreateAccont();
        createError();
        createError1();
        batchinitiatetransactionforInd obj = new batchinitiatetransactionforInd();
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
    public static void createError()
    {
        objerror = new Error_Framework__c();
        objerror.Object_Name__c ='Account';
        objerror.Object_Id__c = objacc.id;
        objerror.Service__c = 'WCIS_IndividualInt_Call_class_copy';
        insert objerror;
    }
    public static void createError1()
    {
        objerror1 = new Error_Framework__c();
        objerror1.Object_Name__c ='Account';
        objerror1.Object_Id__c = objacc.id;
        objerror1.Service__c = 'WCIS_IndividualInt_Call_class_copy';
        insert objerror1;
    }
}