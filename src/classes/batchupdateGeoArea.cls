global class batchupdateGeoArea implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful
{
    set<id> setJobId = new set<id>();
    list<id> recid = new list<id>();
    list<id> assid = new list<id>{'a1Q90000008tJq6'};
     global batchupdateGeoArea(set<id> setJobId1)
     {
         setJobId = setJobId1;
         system.debug('setJobId***'+setJobId);
     }
     global Database.QueryLocator start(Database.BatchableContext BC) {
                 system.debug('setJobId***'+setJobId);
                return DataBase.getQueryLocator([SELECT Id,Country__c,Location__c,Postcode__c,State__c,Street__c,Suburb__c,Territory__c
                                         FROM Job__c WHERE id IN : setJobId]);
                                     
    }
    global void execute(Database.BatchableContext BC,List<Job__c> lstJob) {
        for(Job__c objJob: lstJob)
        {
             recid.add(objJob.id);
             system.debug('str **'+recid);   
        }
        
    }
     global void finish(Database.BatchableContext BC) {
     
         //Send an email to the User after your batch completes
        /*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'priyank.rajvanshi@saasfocus.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Apex Batch Job is done');
        mail.setPlainTextBody('The batch Apex Job Processed Successfully');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
        system.debug('recid'+recid);
        system.debug('assid'+assid);
        string str = geopointe.API.assignRecords(recid,assid,null);
        system.debug('str**'+str);
         Database.executeBatch(new batchupdateGeoAreaifNotInshape(setJobid));
        
    }
}