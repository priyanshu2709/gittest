public with sharing class ApexServerSidecontroller1 {
   @AuraEnabled
    public static Lead saveLead(Lead objlead)
    {
        system.debug('lead'+objlead);
        upsert objlead;
        return objlead;
    }

}