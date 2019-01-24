global class clsTFCDemo
{
    global void testQueary()
    {
        list<Priyank__TFC_04__c> lstTFC4 = [select id from Priyank__TFC_04__c limit 1];
        if(lstTFC4 != null && !lstTFC4.isEmpty())
        {
            Id tfcId = lstTFC4[0].id;
            list<Sushant01__TFC_Base__c> lstTFCDemo = [select id,(select id from TFC_05__r) from Sushant01__TFC_Base__c where Priyank__TFC_04__c =:tfcId];
            system.debug('@#!'+lstTFCDemo);
        }
    }
}