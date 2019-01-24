public class AccountProcessor
{
    @future
    public static void countContacts(list<id> lstAccid)
    {
        if(!lstAccid.isEmpty())
        {
            List<Contact> lstCon = new list<Contact>();
            list<Account> lstAccount = new list<Account>();
            map<id,integer> mapAccidKeyConNumCount = new map<id,integer>();
            lstCon = [select id,accountid from contact where accountid in:lstAccid];
            if(!lstcon.isEmpty())
            {
                for(Contact objCon:lstcon)
                {
                    if(mapAccidKeyConNumCount.get(objcon.Accountid) == null)
                    {
                        mapAccidKeyConNumCount.put(objcon.Accountid,0);
                    }
                    integer i = mapAccidKeyConNumCount.get(objcon.Accountid);
                    i = i+1;
                    mapAccidKeyConNumCount.put(objcon.Accountid,i);
                }
            }
            if(mapAccidKeyConNumCount != null && !mapAccidKeyConNumCount.keyset().isEmpty())
            {
                for(id accid:mapAccidKeyConNumCount.keyset())
                {
                    Account objacc = new Account();
                    objacc.id = accid;
                    objacc.Number_of_Contacts__c = mapAccidKeyConNumCount.get(accid);
                    lstAccount.add(objacc);
                }
            }
            if(!lstAccount.isEmpty())
            {
                update lstAccount;
            }
        }
    }
}