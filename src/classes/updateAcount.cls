public class updateAcount
{
    public updateAcount()
    {
     }
     public static void newAcc()
     {
         List<Account> Idstry = [select Industry from Account where Name = 'kashish'];
         List<Account> lstTempAcount = new List<Account>();
        for(Account acc : idstry)
        {
            acc.Industry = 'Infosys';
            lstTempAcount.add(acc);
            acc.Industry = 'Wipro';
            lstTempAcount.add(acc);
            acc.Industry = 'TaTa';
            lstTempAcount.add(acc);
            
        }
        
        if(lstTempAcount.size() > 0)
        {
            update lstTempAcount;
        }
         
         
        
        }
         
     Account newUpdate = new Account();
     //newUpdate.Name = 'Priyank';
    // newUpdate.ShippingAddress = 'Nyay Khand 1 indirapuram';
   // newUpdate.Fax = '01343250006';
     //newUpdate.Site = 'www.google.com';
     
    // insert newUpdate;
     
    // newUpdate.CustomerPriority__c= cp<CustomerPriority__c>;
}