trigger AccountAddressTrigger on Account (before insert) 
{
    if(trigger.isbefore && trigger.isInsert)
    {
        if(!trigger.new.isEmpty())
        {
            ByPass_Setting1__c objCS = ByPass_Setting1__c.getInstance(Userinfo.getUserId());
            system.debug('cs***'+objCS.CaseTriggerByPass__c);
            if(objCS!= null && !objCS.CaseTriggerByPass__c)
            {

                for(Account objAcc: trigger.new)
                {
                    if(string.isNotBlank(objAcc.BillingPostalCode))
                    {
                        objAcc.ShippingPostalCode = objAcc.BillingPostalCode;
                    }
                }
            }
        }
    }

}