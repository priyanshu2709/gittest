global class batchinitiatetransaction implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful
{
     set<id> setRelationshipIds = new set<id>();
     set<id> setAccids = new set<id>();
     map<id,Account> mapAccount = new map<id,Account>();
     map<id,Relationship_Hierarchy__c> mapRelationship = new map<id,Relationship_Hierarchy__c>();
     map<id,string> mapErrorFramework = new map<id,string>();
     list<Error_Framework__c> lstErrorframeworkAll = new list<Error_Framework__c>();
     global Database.Querylocator start(Database.BatchableContext BC)
    {
        Datetime objrecenttime;
        list<Error_Framework__c> lstErrorFramerecords = new list<Error_Framework__c>();
        
            return Database.getQueryLocator([Select id,Object_Name__c,Error_Summary__c,Description__c,
                                            Object_Id__c,createddate,Service__c,Method_Name__c,
                                    severity__c from Error_Framework__c order by createddate desc]);
            
        
    }
    global void execute(Database.BatchableContext BC, list<Error_Framework__c> lstErrorFramework)
    {
        list<Account> lstAcc = new list<Account>();
        list<Relationship_Hierarchy__c> lstHierarchy = new list<Relationship_Hierarchy__c>();
        
        
                
        if(lstErrorFramework != null && lstErrorFramework.size() > 0)
        {
            for(Error_Framework__c objError : lstErrorFramework)
            {
                if(objError.Object_Name__c != null && objerror.Object_Id__c != null)
                {
                    //Here we are creating diffrent sets for account and relationship hierarchy.
                    if(objError.Object_Name__c != '' && objError.Object_Name__c == 'Account' && !setAccids.contains(objerror.Object_Id__c))
                    {
                        setAccids.add(objerror.Object_Id__c);
                    }
                    else if(objError.Object_Name__c != '' && objError.Object_Name__c == 'Relationship_Hierarchy__c' && !setRelationshipIds.contains(objerror.Object_Id__c))
                    {
                        setRelationshipIds.add(objerror.Object_Id__c);
                    }                    
                }
            }
            lstErrorframeworkAll.addall(lstErrorFramework);
        }
       
    }
    global void finish(Database.BatchableContext BC)
    {
        set<id> setIdforDupeCheck = new set<id>();
        list<id> lstCompHierarchy = new list<id>();
        list<id> lstIndHierarchy = new list<id>();
        list<ID> lstCompAccIds = new list<Id>();
        list<Id> lstIndAccIds = new list<Id>();
        list<Error_Framework__c> lstErrortoUpdate = new list<Error_Framework__c>();
         system.debug('setAccids&&&'+setAccids);
        if(setAccids!= null && setAccids.size() > 0)
        {
            mapAccount = new map<id,account>([select id,recordtypeid,recordtype.name,WCIS_Last_Call_Status__c,WCIS_Last_Call_Time__c 
                        from Account where id in:setAccids]);
        }
        
        if(setRelationshipIds != null && setRelationshipIds.size() > 0)
        {
            mapRelationship = new map<id,Relationship_Hierarchy__c>([select id,Parent_Account__c,WCIS_Last_Call_Status__c,WCIS_Last_Call_Time__c from
                                                                    Relationship_Hierarchy__c where id in:setRelationshipIds]);
        }
        if(((mapAccount != null && mapAccount.size() > 0) || (mapRelationship != null && mapRelationship.size() > 0)) && lstErrorframeworkAll != null &&
            lstErrorframeworkAll.size() > 0)
        {
            for(Error_Framework__c objError : lstErrorframeworkAll)
            {
                system.debug('test');
                if(!String.isempty(objError.Object_Name__c) && !string.isEmpty(objError.Object_ID__c) && objError.Object_Name__c == 'Account' && 
                    !setIdforDupeCheck.contains(objError.Object_ID__c))
                {
                    setIdforDupeCheck.add(objError.Object_ID__c);
                    
                    if(mapAccount.get(objError.Object_ID__c) != null && mapAccount.get(objError.Object_ID__c).WCIS_Last_Call_Status__c == 'Success' && 
                        mapAccount.get(objError.Object_ID__c).WCIS_Last_Call_Time__c > objError.createddate)
                    {
                        mapErrorFramework.put(objError.id,'Skipped');
                    }
                    
                    else if(mapAccount.get(objError.Object_ID__c) != null && mapAccount.get(objError.Object_ID__c).WCIS_Last_Call_Time__c < objError.createddate
                            && objError.Service__c == 'WCIS_CompanyInt_call_Class')
                    {
                        lstCompAccIds.add(objError.Object_ID__c);
                        system.debug('enter here');
                        mapErrorFramework.put(objError.id,'Completed');
                    }
                    else if(mapAccount.get(objError.Object_ID__c) != null && mapAccount.get(objError.Object_ID__c).WCIS_Last_Call_Time__c < objError.createddate
                            && objError.Service__c == 'WCIS_IndividualInt_Call_class')
                    {
                        lstIndAccIds.add(objError.Object_ID__c);
                        mapErrorFramework.put(objError.id,'Completed');
                    }
                    
                }
                else if(!String.isempty(objError.Object_Name__c) && !string.isEmpty(objError.Object_ID__c) && objError.Object_Name__c == 'Account' && 
                    setIdforDupeCheck.contains(objError.Object_ID__c))
                    {
                        mapErrorFramework.put(objError.id,'Skipped');
                    }
                else if(!String.isempty(objError.Object_Name__c) && !string.isEmpty(objError.Object_ID__c) && objError.Object_Name__c == 'Relationship_Hierarchy__c' && 
                       !setIdforDupeCheck.contains(objError.Object_ID__c))
                   {
                       setIdforDupeCheck.add(objError.Object_ID__c);
                       if(mapRelationship.get(objError.Object_ID__c) != null  && mapRelationship.get(objError.Object_ID__c).WCIS_Last_Call_Status__c == 'Success' && 
                        mapRelationship.get(objError.Object_ID__c).WCIS_Last_Call_Time__c > objError.createddate )
                        {
                            mapErrorFramework.put(objError.id,'Skipped');
                        }
                        else if(mapRelationship.get(objError.Object_ID__c) != null && mapRelationship.get(objError.Object_ID__c).WCIS_Last_Call_Time__c < objError.createddate
                            && objError.Service__c == 'WCIS_Relationship_Company_call_class')
                            {
                                lstCompHierarchy.add(objError.Object_ID__c);
                                mapErrorFramework.put(objError.id,'Completed');
                            }
                            else if(mapRelationship.get(objError.Object_ID__c) != null && mapRelationship.get(objError.Object_ID__c).WCIS_Last_Call_Time__c < objError.createddate
                                    && objError.Service__c == 'WCIS_Relationship_Indv_Call_Class')
                            {
                                lstIndHierarchy.add(objError.Object_ID__c);
                                mapErrorFramework.put(objError.id,'Completed');
                            }
                       
                   }
                   else if(!String.isempty(objError.Object_Name__c) && !string.isEmpty(objError.Object_ID__c) && objError.Object_Name__c == 'Relationship_Hierarchy__c' && 
                    setIdforDupeCheck.contains(objError.Object_ID__c))
                    {
                        mapErrorFramework.put(objError.id,'Skipped');
                    }
            }
        }
        system.debug('&&&lstCompAccIds'+lstCompAccIds);
        //Here we are passing list of different object ids to their corresponding class and methods.
        if(lstCompAccIds != null && lstCompAccIds.size() > 0)
        {
           // WCIS_CompanyInt_call_Class.Call_WCIS_Account(lstCompAccIds);
        }
        if(lstIndAccIds != null && lstIndAccIds.size() > 0)
        {
            
            //WCIS_IndividualInt_Call_class.Call_WCIS_Account(lstIndAccIds);
        }
        if(lstCompHierarchy != null && lstCompHierarchy.size() > 0)
        {
            
            //WCIS_Relationship_Company_call_class.Call_WCIS_Relationship_Comp(lstCompHierarchy);
        }
        if(lstIndHierarchy != null && lstIndHierarchy.size() > 0)
        {
            
            //WCIS_Relationship_Indv_Call_Class.Call_WCIS_Relationship_Ind(lstIndHierarchy);
        }
        if(mapErrorFramework != null && mapErrorFramework.size() > 0)
        {
            for(ID Errorid : mapErrorFramework.keyset())
            {
                if(mapErrorFramework.get(Errorid)!= null && mapErrorFramework.get(ErrorId) != '')
                {
                    Error_Framework__c objError = new Error_Framework__c(id=Errorid);
                    objError.Processing_Status__c = mapErrorFramework.get(ErrorId);
                    lstErrortoUpdate.add(objError);
                }
            }
            if(lstErrortoUpdate != null && lstErrortoUpdate.size() > 0)
            {
                update lstErrortoUpdate;
            }
        }
    }

}