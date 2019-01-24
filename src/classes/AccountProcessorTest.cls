@isTest
public class AccountProcessorTest
{
    static testmethod void validate()
    {
        Account objacc = new account();
        objacc.name = 'test';
        insert objacc;
        
        Contact objcon = new contact();
        objcon.Lastname = 'test';
        objcon.Accountid = objacc.id;
        insert objcon;
        
        list<id> lstaccid = new list<id>();
        lstaccid.add(objacc.id);
         Test.startTest();
        AccountProcessor.countContacts(lstaccid);
        Test.stopTest();
    }
}