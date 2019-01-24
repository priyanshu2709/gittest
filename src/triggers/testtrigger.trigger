trigger testtrigger on Lead (before insert,after insert) {
    if(trigger.isInsert && trigger.isbefore)
    {
        map<string,Account> mapAcc= new map<string,Account>();
        Account objAcc;
        for(Lead objlead: trigger.new){
            if(objLead.Company != null){
                objAcc = new Account(Name=objLead.Company);
                mapAcc.put(objLead.Company,objAcc);
                objlead.Account__c = objacc.id;
                
            }
        }
        insert objacc;
        system.debug(mapAcc+'------');
    }
    if(trigger.isInsert && Trigger.isAfter)
    {
        system.debug(trigger.new+'----------');
    }
}