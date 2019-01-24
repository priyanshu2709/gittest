public class firstApexClass
{
    public firstApexClass()
    {
        
    }
    
    public static void updateAccount()
    {
        /*List<Account> lstAccount = [Select AccountNumber from Account where Name = 'Accenture'];
        
        List<Account> lstTempAcount = new List<Account>();
        for(Account acc : lstAccount)
        {
            acc.AccountNumber = '1234567';
            lstTempAcount.add(acc);
        }
        
        if(lstTempAcount.size() > 0)
        {
            update lstTempAcount;
        }
        */
        Account newacc = new Account();
        newacc.Name = 'Kashish';
        newacc.Phone = '987654321';
        newacc.Website = 'www.google.com'; 
        newacc.Active__c = 'No';
        
        insert newacc;
    }
}