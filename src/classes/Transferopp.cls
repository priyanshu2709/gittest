public with sharing class Transferopp {
      public string fromUserID { get; set; }      
      public string toUserID { get; set; }  
      
      
     public Opportunity oldowneropp = new Opportunity();
    public Opportunity newowneropp = new Opportunity();
     public Opportunity gettoUserLookup()  
       { 
       return oldowneropp; 
       }
    public Opportunity getfromUserLookup() 
      { 
      return newowneropp; 
      }
      public boolean optSendeMailToOwner { get; set; }
      
      public List<transferopportunitySearchResults> searchResults = new List<transferopportunitySearchResults>();
      private Map<String, Schema.SObjectField> oppFieldMap = null;
      
      public Transferopp()
      {
      oppFieldMap = Schema.SObjectType.Opportunity.fields.getMap();
      }
      public List<SelectOption> getFromUsersOther() 
      {
      List<SelectOption> options = new List<SelectOption>();
       for(User u : [Select ID, Name FROM User])
       {
       options.add(new selectOption(u.ID, u.Name));
     
       }
       return options;
      }
      
      public pageReference doSearch() {
        searchResults.clear();        
        this.fromUserID = newowneropp.OwnerId;       
        Set <String> oppFlds = oppFieldMap.keySet();   
        system.debug('ownerid***'+newowneropp.ownerid);
        string oppFieldsList = '';
        for (string f : oppFlds) 
        {
            string fldType = ('' + oppFieldMap.get(f).getDescribe().getType()).replace('Schema.DisplayType.', '');                      
            }        
        string cSOQL = 'SELECT ' + oppFieldsList + 'Opportunity.Name '  + ',Owner.Name ' + ',ID ' + 
             'FROM Opportunity WHERE OwnerID = \'' + String.escapeSingleQuotes(fromUserID) + '\' ';
        
        try 
        {
            searchResults.clear();
            system.debug('cSOQL&&&'+cSOQL);
            List<Opportunity> results = Database.Query(cSOQL);

             for (Opportunity o : results) 
             {
                searchResults.add( new transferopportunitySearchResults(o) ) ;
              }

          } 
        catch (Exception ex) 
        {             
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Query Error: ' + ex.getMessage()));
        }
        return null;
      }
                                
    public list<transferopportunitySearchResults> getSearchResults() 
      {
        if (fromUserID != '')
         {
            return this.searchResults;
        } 
        else 
        {
            return null ;
        }
    }
    
    public pageReference doTransfer() {

        this.toUserID = oldowneropp.OwnerId; 
        if (toUserID == '' || toUserID == null) {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'ERROR: A "To User" must be specified'));
            return null;
        }
        
        List<string> IDs = New List<string>();
        for (transferopportunitySearchResults o : searchResults) 
        {
            if (o.selected)
            { 
            IDs.add(o.opportunityID) ;
            }
        }
        
        system.debug('toUserID&&&'+toUserID);
        
        List<opportunity> lstopp = new List<opportunity>();
                for (opportunity o : [SELECT ID, Name, OwnerID from Opportunity where Id In : IDs])
                {
                lstopp.add(o);
                }
                
        List<opportunity> lstonew = [SELECT ID, OwnerID, Name FROM opportunity WHERE ID IN :IDs];
        for (opportunity onew : lstonew) 
        {
            onew.ownerID = toUserID;
        }
        update lstonew;
        return null;
     }


     public class transferopportunitySearchResults{
 
        public boolean selected {get; set; }
        public string opportunityID;
        public transient opportunity opportunity  {get; private set;}

        public transferopportunitySearchResults() { }
        public transferopportunitySearchResults(opportunity o) { 
            opportunity = o;
            opportunityID = o.id; 
            selected = true; 
        }

    }
   
}