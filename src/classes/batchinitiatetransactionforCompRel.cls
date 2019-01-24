global class batchinitiatetransactionforCompRel implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful
{
     set<id> setRelationshipIds = new set<id>();
     map<id,Relationship_Hierarchy__c> mapRelationship = new map<id,Relationship_Hierarchy__c>();
     map<id,string> mapErrorFramework = new map<id,string>();
     list<Error_Framework__c> lstErrorframeworkAll = new list<Error_Framework__c>();
     global Database.Querylocator start(Database.BatchableContext BC)
    {
        Datetime objrecenttime;
        string str1 = date.today().format() + ' 11:00 PM';
        Datetime dtoday = datetime.parse(str1);
        string str2 = date.today().adddays(-1).format() + ' 11:00 PM';
        Datetime dtytrdy = datetime.parse(str2);
        list<Error_Framework__c> lstErrorFramerecords = new list<Error_Framework__c>();
        
             return Database.getQueryLocator([Select id,Object_Name__c,Error_Summary__c,Description__c,
                                            Object_Id__c,createddate,Service__c,Method_Name__c,
                                    severity__c from Error_Framework__c where createddate >: dtytrdy and createddate <: dtoday 
                                    and Object_Name__c = 'Relationship_Hierarchy__c' and service__c = 'WCIS_Relationship_Company_call_class' order by createddate desc]);
            
        
    }
    global void execute(Database.BatchableContext BC, list<Error_Framework__c> lstErrorFramework)
    {
        
        list<Relationship_Hierarchy__c> lstHierarchy = new list<Relationship_Hierarchy__c>();
        set<id> setIdforDupeCheck = new set<id>();
        list<id> lstCompHierarchy = new list<id>();
        
        list<Error_Framework__c> lstErrortoUpdate = new list<Error_Framework__c>();
        
                
        if(lstErrorFramework != null && lstErrorFramework.size() > 0)
        {
            for(Error_Framework__c objError : lstErrorFramework)
            {
                if(objError.Object_Name__c != null && objerror.Object_Id__c != null)
                {
                   if(objError.Object_Name__c != '' && objError.Object_Name__c == 'Relationship_Hierarchy__c' && !setRelationshipIds.contains(objerror.Object_Id__c))
                    {
                        setRelationshipIds.add(objerror.Object_Id__c);
                    }                    
                }
            }
            lstErrorframeworkAll.addall(lstErrorFramework);
        }
        if(setRelationshipIds != null && setRelationshipIds.size() > 0)
        {
            mapRelationship = new map<id,Relationship_Hierarchy__c>([select id,Parent_Account__c,WCIS_Last_Call_Status__c,WCIS_Last_Call_Time__c from
                                                                    Relationship_Hierarchy__c where id in:setRelationshipIds]);
        }
        if((mapRelationship != null && mapRelationship.size() > 0) && lstErrorframeworkAll != null &&
            lstErrorframeworkAll.size() > 0)
        {
            for(Error_Framework__c objError : lstErrorframeworkAll)
            {
                 if(!String.isempty(objError.Object_Name__c) && !string.isEmpty(objError.Object_ID__c) && objError.Object_Name__c == 'Relationship_Hierarchy__c' && 
                       !setIdforDupeCheck.contains(objError.Object_ID__c))
                   {
                       setIdforDupeCheck.add(objError.Object_ID__c);
                       if(mapRelationship.get(objError.Object_ID__c) != null  && mapRelationship.get(objError.Object_ID__c).WCIS_Last_Call_Status__c == 'Success' && 
                        mapRelationship.get(objError.Object_ID__c).WCIS_Last_Call_Time__c > objError.createddate )
                        {
                            mapErrorFramework.put(objError.id,'Skipped');
                        }
                        else if(mapRelationship.get(objError.Object_ID__c) != null && (mapRelationship.get(objError.Object_ID__c).WCIS_Last_Call_Time__c == null || 
                                mapRelationship.get(objError.Object_ID__c).WCIS_Last_Call_Time__c < objError.createddate)
                            && objError.Service__c == 'WCIS_Relationship_Company_call_class')
                            {
                                lstCompHierarchy.add(objError.Object_ID__c);
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
        
        if(lstCompHierarchy != null && lstCompHierarchy.size() > 0)
        {
            
            //WCIS_Relationship_Company_call_class.Call_WCIS_Relationship_Comp(lstCompHierarchy);
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
    global void finish(Database.BatchableContext BC)
    {
        
        
        
    }

}