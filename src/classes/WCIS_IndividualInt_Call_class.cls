public class WCIS_IndividualInt_Call_class 
{
    @future(callout=true)
    public static void Call_WCIS_Account(list<id> lstacc)
    {
        account obj = new account(id=lstacc[0]);
        update obj;
    }
}