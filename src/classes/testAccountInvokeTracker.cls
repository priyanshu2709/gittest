@isTest
public class testAccountInvokeTracker
{
  
    public static testmethod void test()
    {
        //AccountQueryAction obj = new AccountQueryAction();
        list<ID> lstIds = new list<ID>();
        list<string> lstStrings = AccountQueryAction.getAccountNames(lstIds);
    }
}