//Wrapper class for Contact
      public class contactWrapper
      {      
         public String contactName{get;set;}
         public String createdDate{get;set;}
         public string phoneC{get;set;}
         public string emailC{get;set;}
                 
         public contactWrapper(Contact con)
           {
             contactName=con.FirstName+' '+con.LastName;
             createdDate=con.createddate.month() +'/'+ con.createddate.day() +'/'+ con.createddate.year();
             phoneC=con.phone;
             emailC=con.email;
              
           }//End of Wrapper constructor
 
     }//End of wrapper class