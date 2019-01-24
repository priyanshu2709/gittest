public class WCIS_CompanyInt_call_Class
{
    
    //@future(callout=true)
    public static void Call_WCIS_Account(list<id> lstacc)
    {
        account obj = new account(id=lstacc[0]);
        update obj;
    }
}