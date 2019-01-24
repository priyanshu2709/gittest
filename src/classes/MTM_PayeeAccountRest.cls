@RestResource(urlMapping='/PayeeAccount/*')
global class MTM_PayeeAccountRest {

    @HttpPost
    global static Result createAccount(payeeAccount account) {
        Result res=new Result();
        
        
        String recordTypeName='Payee';
        
        // query for dupe checking
        
        string test1 = '';
        if(test1 != null){
            res.isSuccess=false;
            res.errors.add('The Payee record already exists in Salesforce');
        }else{
            Account acc = new Account();
            acc.RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
            
            
            
            String test = account.associatedMember.familyAssociation;
            
            
            
            Account member;
            // insert record
            Database.SaveResult sr = Database.insert(acc, false);
            Database.SaveResult srMember = Database.insert(member, false);
        
        if (sr.isSuccess()) {
            // Operation was successful, so get the ID of the record that was processed
            res.AccountId=sr.getId();
            
        }
        else {
            // Operation failed, so get all errors
            res.isSuccess=false;           
            for(Database.Error err : sr.getErrors()) {
                if(err.getFields().size()>0){
                    for(String errorField:err.getFields()){
                        list<String> errLst=new list<String>();
                        if(res.FieldErrors.containskey(errorField)){
                           errLst=res.FieldErrors.get(errorField);
                           errLst.add(err.getStatusCode() + ': ' + err.getMessage());
                           res.FieldErrors.put(errorField,errLst); 
                        }else{
                           errLst.add(err.getStatusCode() + ': ' + err.getMessage());
                           res.FieldErrors.put(errorField,errLst); 
                        }
                    }    
                }else{
                    res.errors.add(err.getStatusCode() + ': ' + err.getMessage());
                }
            }
        }
        if (!srMember.isSuccess()) {
            
            // Operation failed, so get all errors
            res.isSuccess=false;           
            for(Database.Error err : srMember.getErrors()) {
                if(err.getFields().size()>0){
                    for(String errorField:err.getFields()){
                        list<String> errLst=new list<String>();
                        if(res.FieldErrors.containskey(errorField)){
                           errLst=res.FieldErrors.get(errorField);
                           errLst.add(err.getStatusCode() + ': ' + err.getMessage());
                           res.FieldErrors.put(errorField,errLst); 
                        }else{
                           errLst.add(err.getStatusCode() + ': ' + err.getMessage());
                           res.FieldErrors.put(errorField,errLst); 
                        }
                    }    
                }else{
                    res.errors.add(err.getStatusCode() + ': ' + err.getMessage());
                }
            }
        }
        }
        return res;
    }
    
    global class payeeAccount{
        //More fields can be added here. 
        public String FirstName {get; set;}
        public String LastName {get; set;}
        public String MiddleName {get; set;}
        public Date DOB {get; set;}
        public String MailingStreet {get; set;}
        public String MailingCity {get; set;}
        public String MailingState {get; set;}
        public String MailingZip {get; set;}
        public String MailingCountry {get; set;}
        public String Gender {get; set;}
        public String Email {get; set;}
        public String Mobile {get; set;}
        public String Phone {get; set;}
        public String DriverLicenseNumber {get; set;}
        public String DriverLicenseState {get; set;}
        public Date DriverLicenseExpirationDate {get; set;}
        public String PreferredLanguage {get; set;}
        public String CardStatus {get; set;}
        public String AS400PayeeID {get; set;}
        public String PlanID {get; set;}
        public String BenefitGroupID {get; set;}
        public AssociatedMember associatedMember {get;set;}
}
     global class AssociatedMember {
        public String familyAssociation;
        public String memberId;
        public String firstName;
        public String lastName;
    }
    
    global class Result {
        
        
        public Boolean isSuccess { get; set; }
        public Id AccountId { get; set; }
        public List<String> errors { get; set; }
        public Map<String,List<String>> FieldErrors { get; set; }
         
        public Result () {
            isSuccess=true;
            FieldErrors=new Map<String,List<String>>();
            errors=new List<String>();            
        }
    }
}