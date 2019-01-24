global class KLBatchActivetaskCase implements Database.Batchable < sObject > {
   
        string strPresalesRecordtypeId = KLCommon.getRecordTypeId('Lead', 'Finance');
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        
         
        return Database.getQueryLocator([SELECT Id, Priority,Status, Type, (select id, WhatID, OwnerId, Priority, Status from Tasks) 
                                         FROM Case]);
    }
    global void execute(Database.BatchableContext bc, List < Case > records) {
        system.debug('strPresalesRecordtypeId '+strPresalesRecordtypeId );
    }
    global void finish(Database.BatchableContext BC) {
        
    }

}