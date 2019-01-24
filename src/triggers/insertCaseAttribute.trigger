trigger insertCaseAttribute on Case (after insert) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        list<Case_Attribute__c> lstCaseAttribute = new list<Case_Attribute__c>();
        set<id> setOppId = new set<id>();
        set<id> setOppProdId = new set<id>();
        map<id,Opportunity> mapOppty = new map<id,Opportunity>();
        list<Asset> lstAsset = new list<Asset>();
        Recordtype rt = [select id,name from recordtype where name = 'Altegra Implementation' and sobjecttype = 'Case'];
        if(!trigger.new.isEmpty())
        {
            for(case objcase: trigger.new)
            {
                if(rt.id == objcase.recordtypeid)
                {
                    if(objCase.Opportunity__c != null)
                    {
                        setOppId.add(objCase.Opportunity__c);
                    }
                    
                    if(objcase.Opportunity_Product_Id__c != null)
                    {
                        setOppProdId.add(objcase.Opportunity_Product_Id__c);
                    }                   
                }
                
            }
            if(!setOppId.isEmpty())
            {
                mapOppty = new map<id,Opportunity>([select id,Accountid,Market_Type__c,Scheduling_Location__c,Coding_Location__c,
                                                    clinical_Review_Method__c,Chart_Retrieval_Method__c,Account.name,
                                                    (select id,Quantity,Product_Data_Load_Date__c,Product2Id from OpportunityLineItems
                                                     where id in:setOppProdId) from
                                                   Opportunity where id in:setOppId]);
                if(mapOppty != null && mapOppty.size() > 0)
                {
                    for(Case objCase: trigger.new)
                    {
                        if(mapOppty.get(objCase.Opportunity__c) != null)
                        {
                            Case_Attribute__c objCA = new Case_Attribute__c();
                            objCA.name = 'Market Type';
                            objCA.Case__c = objCase.id;
                            objCA.Opportunity__c = objCase.Opportunity__c;
                            objCA.Initial_Value__c = mapOppty.get(objCase.Opportunity__c).Market_Type__c;
                            objCA.Current_Value__c = mapOppty.get(objCase.Opportunity__c).Market_Type__c;
                            objCA.String_Value__c = mapOppty.get(objCase.Opportunity__c).Market_Type__c;
                            objCA.FieldUnique__c = 'Market Type'+''+objCase.id;
                            lstCaseAttribute.add(objCA);
                            
                            Case_Attribute__c objCA1 = new Case_Attribute__c();
                            objCA1.name = 'Scheduling Location';
                            objCA1.Case__c = objCase.id;
                            objCA1.Opportunity__c = objCase.Opportunity__c;
                            objCA1.Initial_Value__c = mapOppty.get(objCase.Opportunity__c).Scheduling_Location__c;
                            objCA1.Current_Value__c = mapOppty.get(objCase.Opportunity__c).Scheduling_Location__c;
                            objCA1.String_Value__c = mapOppty.get(objCase.Opportunity__c).Scheduling_Location__c;
                            objCA1.FieldUnique__c = 'Scheduling Location'+''+objCase.id;
                            lstCaseAttribute.add(objCA1);
                            
                            Case_Attribute__c objCA2 = new Case_Attribute__c();
                            objCA2.name = 'Coding Location';
                            objCA2.Case__c = objCase.id;
                            objCA2.Opportunity__c = objCase.Opportunity__c;
                            objCA2.Initial_Value__c = mapOppty.get(objCase.Opportunity__c).Coding_Location__c;
                            objCA2.Current_Value__c = mapOppty.get(objCase.Opportunity__c).Coding_Location__c;
                            objCA2.String_Value__c = mapOppty.get(objCase.Opportunity__c).Coding_Location__c;
                            objCA2.FieldUnique__c = 'Coding Location'+''+objCase.id;
                            lstCaseAttribute.add(objCA2);
                            
                            Case_Attribute__c objCA3 = new Case_Attribute__c();
                            objCA3.name = 'Clinical Review Method';
                            objCA3.Case__c = objCase.id;
                            objCA3.Opportunity__c = objCase.Opportunity__c;
                            objCA3.Initial_Value__c = mapOppty.get(objCase.Opportunity__c).clinical_Review_Method__c;
                            objCA3.Current_Value__c = mapOppty.get(objCase.Opportunity__c).clinical_Review_Method__c;
                            objCA3.String_Value__c = mapOppty.get(objCase.Opportunity__c).clinical_Review_Method__c;
                            objCA3.FieldUnique__c = 'Clinical Review Method'+''+objCase.id;
                            lstCaseAttribute.add(objCA3);
                            
                            Case_Attribute__c objCA4 = new Case_Attribute__c();
                            objCA4.name = 'Chart Retrival method';
                            objCA4.Case__c = objCase.id;
                            objCA4.Opportunity__c = objCase.Opportunity__c;
                            objCA4.Initial_Value__c = mapOppty.get(objCase.Opportunity__c).Chart_Retrieval_Method__c ;
                            objCA4.Current_Value__c = mapOppty.get(objCase.Opportunity__c).Chart_Retrieval_Method__c ;
                            objCA4.String_Value__c = mapOppty.get(objCase.Opportunity__c).Chart_Retrieval_Method__c ;
                            objCA4.FieldUnique__c = 'Chart Retrival method'+''+objCase.id;
                            lstCaseAttribute.add(objCA4);
                            
                            if(mapOppty.get(objCase.Opportunity__c).OpportunityLineItems != null && 
                                mapOppty.get(objCase.Opportunity__c).OpportunityLineItems.size() > 0)
                                {
                                    Case_Attribute__c objCA5 = new Case_Attribute__c();
                                    objCA5.name = 'Quantity';
                                    objCA5.Case__c = objCase.id;
                                    objCA5.Opportunity__c = objCase.Opportunity__c;
                                    objCA5.Initial_Value__c = string.valueof(mapOppty.get(objCase.Opportunity__c).OpportunityLineItems[0].Quantity) ;
                                    objCA5.Current_Value__c = string.valueof(mapOppty.get(objCase.Opportunity__c).OpportunityLineItems[0].Quantity) ;
                                    objCA5.Number_Value__c = mapOppty.get(objCase.Opportunity__c).OpportunityLineItems[0].Quantity;
                                    objCA5.FieldUnique__c = 'Quantity'+''+objCase.id;
                                    lstCaseAttribute.add(objCA5);
                                    
                                    Case_Attribute__c objCA6 = new Case_Attribute__c();
                                    objCA6.name = 'Product Data Load Date';
                                    objCA6.Case__c = objCase.id;
                                    objCA6.Opportunity__c = objCase.Opportunity__c;
                                    objCA6.Initial_Value__c = string.valueof(mapOppty.get(objCase.Opportunity__c).OpportunityLineItems[0].Product_Data_Load_Date__c);
                                    objCA6.Current_Value__c = string.valueof(mapOppty.get(objCase.Opportunity__c).OpportunityLineItems[0].Product_Data_Load_Date__c);
                                    objCA6.Date_Value__c = mapOppty.get(objCase.Opportunity__c).OpportunityLineItems[0].Product_Data_Load_Date__c;
                                    objCA6.FieldUnique__c = 'Product Data Load Date'+''+objCase.id;
                                    lstCaseAttribute.add(objCA6);
                                    
                                    
                                    Asset objAsset = new Asset();
                                    objAsset.Accountid = mapOppty.get(objCase.Opportunity__c).Accountid;
                                    if(mapOppty.get(objCase.Opportunity__c).OpportunityLineItems[0].Quantity != null)
                                    objAsset.Quantity = mapOppty.get(objCase.Opportunity__c).OpportunityLineItems[0].Quantity;
                                    objAsset.Product2id = mapOppty.get(objCase.Opportunity__c).OpportunityLineItems[0].Product2Id;
                                    objAsset.name = mapOppty.get(objCase.Opportunity__c).Account.Name;
                                    lstAsset.add(objAsset);
                                    
                               }
                               
                            
                            
                        }
                    }
                    if(!lstCaseAttribute.isEmpty())
                    {
                        insert lstCaseAttribute;
                    }
                    if(!lstAsset.isEmpty())
                    {
                        insert lstAsset;
                    }
                }
            }
        }    
    }
}