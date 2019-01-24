@istest
public class clsTFCDemoTracker
{
    public static testmethod void testTFC()
    {
        clsTFCDemo objTFC = new clsTFCDemo();
        Priyank__TFC_04__c obj = new Priyank__TFC_04__c();
        obj.Name = 'test';
        insert obj;
        objTFC.testQueary();
    }
}