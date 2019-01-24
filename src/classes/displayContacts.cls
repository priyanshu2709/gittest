//Controller for WrapperDemo - 1

public class displayContacts
   {  
      
      
      //Get the respective Account id
      ID accountId;
     
      //Store the wrapped Contacts
      public List<contactWrapper> conWrapper{get;set;}
    
     //COnstructor 
     public displayContacts()
      {   
         accountId= string.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('id'));  
     
     //Initialize list
     conWrapper = new List<contactWrapper>();
     for(Contact tempCon :[select FirstName,LastNAme,Email,phone,createddate from contact where accountid=:accountid])
     { 
        //create the object for the wrapper class
        contactWrapper tempWrapper = new contactWrapper(tempCon);
        conwrapper.add(tempWrapper);
     }
     
     
  
      } //End of Constructor
      }