global class batchinitiatetransactionForComp implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful
{
     
     set<id> setAccids = new set<id>();
     map<id,Account> mapAccount = new map<id,Account>();
    
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
                                    and Object_Name__c = 'Account' and service__c = 'WCIS_CompanyInt_call_Class' order by createddate desc]);
            
        
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
                                        
                }
            }
            lstErrorframeworkAll.addall(lstErrorFramework);
        }
        set<id> setIdforDupeCheck = new set<id>();
        list<ID> lstCompAccIds = new list<Id>();
        list<Error_Framework__c> lstErrortoUpdate = new list<Error_Framework__c>();
         system.debug('setAccids&&&'+setAccids);
        if(setAccids!= null && setAccids.size() > 0)
        {
            mapAccount = new map<id,account>([select id,recordtypeid,recordtype.name,WCIS_Last_Call_Status__c,WCIS_Last_Call_Time__c 
                        from Account where id in:setAccids]);
        }
        
        
        if((mapAccount != null && mapAccount.size() > 0) && lstErrorframeworkAll != null &&
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
                    
                }
                else if(!String.isempty(objError.Object_Name__c) && !string.isEmpty(objError.Object_ID__c) && objError.Object_Name__c == 'Account' && 
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
            //WCIS_CompanyInt_call_Class.Call_WCIS_Account(lstCompAccIds);
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