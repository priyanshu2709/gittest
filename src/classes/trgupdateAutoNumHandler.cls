public class trgupdateAutoNumHandler
{
    public void isBeforeUpdate(list<Account> triggernew)
    {
        list<string> lstsplitAuto = new list<string>();
        list<Account> lstaccount = [select id,AccountNumber from Account order by createddate desc limit 1]; 
        integer Count = 0;
        if(!lstaccount.isEmpty() && string.isNotBlank(lstaccount[0].AccountNumber))
        {
            lstsplitAuto = new list<string>(lstaccount[0].AccountNumber.split('-'));
            if(!lstsplitAuto.isEmpty())
            {
                Count = integer.valueof(lstsplitAuto[1]);
            }
        }
        if(!triggernew.isEmpty())
        {
            for(Account objAcc: triggernew)
            {
                Count++;
                objAcc.AccountNumber = 'Auto-'+string.valueof(Count);
            }
        }
    }
}