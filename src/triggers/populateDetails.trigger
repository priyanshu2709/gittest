trigger populateDetails on Job__c (after insert,before update) 
{
    if(trigger.isBefore && trigger.isupdate)
    {
        if(!trigger.new.isEmpty())
        {
            for(Job__c objJob : trigger.new)
            {
                if(objjob.Assignment_Area__c != null || trigger.oldmap.get(objjob.id).Assignment_Area__c !=objjob.Assignment_Area__c)
                {
                    map<id,geopointe__GP_Assignment_Area__c> mapAA = new map<id,geopointe__GP_Assignment_Area__c>([select id,(select id from Territories__r) from geopointe__GP_Assignment_Area__c]);
                    for(Job__c obj: trigger.new)
                    {
                                if(mapAA.get(obj.Assignment_Area__c) != null && !mapAA.get(obj.Assignment_Area__c).Territories__r.isEmpty())
                                {
                                    
                                    
                                    obj.Territory__c = mapAA.get(obj.Assignment_Area__c).Territories__r[0].id;
                                    
                                }
                     }
                 }
            }
        }
    }
    if(trigger.isAfter && trigger.isInsert)
    {
        /*if(!trigger.new.isempty())
        {
            for(Job__c objJob: trigger.new)
            {
                system.debug('test');
                map<string,string> mapstr = geopointe.API.geocodeRecord(objJob.id);
                system.debug('str **'+mapstr );
                
            }
            
        }*/
        set<id> setJobid = new set<id>();
         for(Job__c objJob: trigger.new)
        {
            setJobid.add(objJob.id);
        }
        system.debug(setJobid+'setJobid**');
        Database.executeBatch(new batchupdategeo(setJobid));
        
    }
    
    /*if(trigger.isafter && trigger.isinsert)
    {
        list<id> recid = new list<id>();
        list<job__c> lstjob = new list<job__c>();
        
        list<id> assid = new list<id>{'a1Q90000008tJq6'};
        system.debug('trigger.new**'+trigger.new);
        for(Job__c objJob: trigger.new)
        {
            if(objjob.Location__Latitude__s != null)
            {
                
                recid.add(objJob.id);
            }
        }
        geopointe.API.assignRecords(recid,assid,null);
        map<id,geopointe__GP_Assignment_Area__c> mapAA = new map<id,geopointe__GP_Assignment_Area__c>([select id,(select id from Territories__r) from geopointe__GP_Assignment_Area__c]);
        for(Job__c obj: trigger.new)
        {
            if(mapAA.get(obj.Assignment_Area__c) != null && !mapAA.get(obj.Assignment_Area__c).Territories__r.isEmpty())
            {
                
                
                obj.Territory__c = mapAA.get(obj.Assignment_Area__c).Territories__r[0].id;
                
            }
        }
        
    }*/
    
   
}