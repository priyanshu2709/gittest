global class batchupdategeo implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful
{
     set<id> setJobId = new set<id>();
     global batchupdategeo(set<id> setJobId1)
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
             map<string,string> mapstr = geopointe.API.geocodeRecord(objJob.id);
             system.debug('str **'+mapstr );   
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
    Database.executeBatch(new batchupdateGeoArea(setJobid));
    }
}