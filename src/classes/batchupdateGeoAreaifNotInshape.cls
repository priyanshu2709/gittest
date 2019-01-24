global class batchupdateGeoAreaifNotInshape implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful
{
    set<id> setJobId = new set<id>();
    list<id> recid = new list<id>();
    string destination_address = '';
    string origin_address = '';
    list<Account> lstAccount = new list<Account>();
    list<Job_Potential_Franchise__c> lstJPF = new list<Job_Potential_Franchise__c>();
    map<string,geopointe__GP_Assignment_Area__c> mapJobidGPAAid = new map<string,geopointe__GP_Assignment_Area__c>();
    list<geopointe__GP_Assignment_Area__c> lstGPAA = new list<geopointe__GP_Assignment_Area__c>();
     global batchupdateGeoAreaifNotInshape(set<id> setJobId1)
     {
         setJobId = setJobId1;
         system.debug('setJobId***'+setJobId);
         lstAccount = [select id,Address__c from Account where Address__c != ''];
         if(!lstAccount.isEmpty())
         {
             for(Account objAcc: lstAccount)
             {
                 if(objAcc.Address__c != '')
                 {
                     destination_address = destination_address + objAcc.Address__c+'|';
                 }    
             }
             destination_address = destination_address.replaceAll('\\s','+');
         }
         //lstGPAA  = [select id,geopointe__Shape__c,geopointe__Shape__r.geopointe__Lat_Lng_1__c from geopointe__GP_Assignment_Area__c];
     }
     global Database.QueryLocator start(Database.BatchableContext BC) {
                 system.debug('setJobId***'+setJobId);
                return DataBase.getQueryLocator([SELECT Id,Country__c,Location__c,Postcode__c,State__c,Street__c,Suburb__c,Territory__c,
                                                Location__Latitude__s,Location__Longitude__s,Assignment_Area__c
                                         FROM Job__c WHERE id IN : setJobId and Assignment_Area__c = null]);
                                     
    }
    global void execute(Database.BatchableContext BC,List<Job__c> lstJob) {
        set<string> setJobIdAccId = new set<string>();
        if(!lstAccount.isEmpty())
        {
            for(Job__c objJob: lstJob)
            {
                origin_address = origin_address + objjob.Street__c+','+objJob.Suburb__c+','+objjob.State__c+','+objJob.Country__c+','+objJob.Postcode__c+'|';
                
            
            }
            origin_address = origin_address.replaceAll('\\s','+');
            system.debug('destination_address***'+destination_address);
            system.debug('origin_address***'+origin_address);
            //for(Job__c objJob: lstJob)
            //{
                   
                   //origin_address = objjob.Street__c+','+objJob.Suburb__c+','+objjob.State__c+','+objJob.Country__c+','+objJob.Postcode__c;
                   //origin_address = origin_address.replaceAll('\\s','+');
                   //for(Account objAcc: lstAccount)
                   //{
                        //destination_address = objAcc.Address__c;
                        //destination_address = destination_address.replaceAll('\\s','+');
                        Http http = new Http();
                        HttpRequest req = new HttpRequest();
                        string endpoint ='https://maps.googleapis.com/maps/api/distancematrix/json?origins='+origin_address+'&destinations='+destination_address+'&mode=driving&key=AIzaSyAejaPoKxU4Xqnaug_xH9WEkEjymEAYRy4'; 
                        req.setEndpoint(endpoint);
                        req.setMethod('GET');
                        req.setTimeout(100000);

                        httpresponse resp = http.send(req);
                        //system.debug(resp.getBody()+'response');
                        //system.debug(resp.getStatusCode()+'response');
                        JSON2Apex lstjson = JSON2Apex.parse(resp.getBody());
                        system.debug('lstjson***'+lstjson);
                        list<JSON2Apex.rows> lstrows = lstjson.rows;
                        system.debug('lstrows'+lstrows);
                        if(!lstrows.isEmpty())
                        {
                            for(JSON2Apex.rows objrows: lstrows)
                            {
                                list<JSON2Apex.elements> lstelement = objrows.elements;
                                system.debug('lstelement***'+lstelement);
                                if(!lstelement.isEmpty())
                                {
                                    for(JSON2Apex.elements objElement: lstelement)
                                    {
                                        JSON2Apex.Distance objDistance = objElement.distance;
                                        system.debug('Distance'+objDistance.value);
                                        system.debug('Distance'+objDistance.text);
                                        for(Job__c objJob: lstJob)
                                        {
                                            for(Account objAcc: lstAccount)
                                            {
                                                if(!setJobIdAccId.contains(objJob.id+'@'+objAcc.id))
                                                {
                                                    Job_Potential_Franchise__c obj = new Job_Potential_Franchise__c();
                                                    obj.Account__c = objAcc.id;
                                                    obj.Job__c = objJob.id;
                                                    //decimal dist = objDistance.value/1000;
                                                    obj.Distance__c = objDistance.text;
                                                    setJobIdAccId.add(objJob.id+'@'+objAcc.id);
                                                    lstJPF.add(obj);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                   //}
                    

                   /*decimal mindistance = 0.00;
                   if(objJob.Assignment_Area__c == null)
                   {
                       for(geopointe__GP_Assignment_Area__c objGPAA : lstGPAA)
                       {
                           if(objGPAA.geopointe__Shape__c != null && objGPAA.geopointe__Shape__r.geopointe__Lat_Lng_1__c != null && 
                              objGPAA.geopointe__Shape__r.geopointe__Lat_Lng_1__c !='' )
                           {
                                string str = objGPAA.geopointe__Shape__r.geopointe__Lat_Lng_1__c;
                                integer fstindex = str.indexof('[[');
                                integer lstindex = str.lastIndexOf(']]');
                                system.debug('fstindex'+fstindex);
                                system.debug('lstindex'+lstindex);
                                string updatedstr = str.substring(fstindex+3,lstindex);
                                system.debug('updatedstr**'+updatedstr);
                                set<string> setstr = new set<string>(updatedstr.split('],'));
                                for(string str1: setstr)
                                {
                                    string repstr = '\\[';
                                    string repstr1 = ']';
                                    string strup =str1.replaceAll(repstr, '');
                                    strup = strup.replaceAll(repstr1, '');
                                    system.debug('str***'+strup);
                                    list<string> lstlat = strup.split(',');
                                    system.debug(lstlat+'setlat');
                                    decimal lat=decimal.valueof(lstlat[1]);
                                    decimal lng = decimal.valueof(lstlat[0]);
                                    decimal distance = geopointe.API.getDistance(objjob.Location__Latitude__s,objjob.Location__Longitude__s,lat,lng,geopointe.API.units.KILOMETERS);
                                    if(mindistance == 0)
                                    {
                                        mindistance = distance;
                                        mapJobidGPAAid.put(objJob.id,objGPAA);
                                    }
                                    else
                                    {
                                        if(distance <mindistance)
                                        {
                                            mindistance = distance;
                                            mapJobidGPAAid.put(objJob.id,objGPAA);
                                        }
                                    }
                                }
                           }
                       }
                   }
            }*/
            if(!lstJPF.isEmpty())
            {
                insert lstJPF;
            }
        }
        
    }
    global void finish(Database.BatchableContext BC) {
        /*list<Job__c> lstjob = new list<Job__c>();
        system.debug('mapJobidGPAAid***'+mapJobidGPAAid);
        if(mapJobidGPAAid != null && mapJobidGPAAid.size() > 0)
        {
            for(string jobid : mapJobidGPAAid.keyset())
            {
                Job__c objJob = new job__c(id=jobid);
                objjob.Assignment_Area__c = mapJobidGPAAid.get(jobid).id;
                lstjob.add(objjob);
            }
        }
        system.debug('lstjob***'+lstjob);
        if(!lstjob.isEmpty())
        {
            update lstjob;
        }*/
    }    
    
}