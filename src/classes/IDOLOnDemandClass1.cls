public class IDOLOnDemandClass1 {
    
    public static String Twiml;    
    public String getTwiml () {
          return Twiml;
    }
    
    @Future(callout=true)
    public static void processTwilioRequest(){
            
        Map<String, String> parameters = System.currentPageReference().getParameters();
        
        String sms_number = parameters.get('to');  // Get To Number
        String sender_number = parameters.get('from'); // Get Message Body
        String messageBody = parameters.get('Body');  // Get Message Body
        String mediaUrl = parameters.get('MediaUrl0'); // Get Media URL
        
        system.debug(sms_number+'sms_number&&');
        system.debug(sender_number+'sender_number&&');
        system.debug(messageBody+'messageBody&&');
        System.debug('processing');
        Case caseToAdd = new Case();
            
        caseToAdd.Origin = 'SMS';
        //caseToAdd.AccountId = c.AccountId;
       // caseToAdd.ContactId = c.Id;
        caseToAdd.Subject = sms_number +'& '+sender_number ; 
        caseToAdd.Description =  messageBody;
        caseToAdd.SuppliedPhone = sender_number;
        //caseToAdd.Sentiment_Score__c = sentiment;
         
        insert caseToAdd;
        if(sms_number  != null && sender_number != null && messageBody  != null && mediaUrl != null)
        {    
            String detectLanguageResponse = detectLanguage(messageBody);
            String[] detectedLanguages = IDOLOnDemandParserClass1.parseLanguageDetectionResponse(detectLanguageResponse);
            String language = detectedLanguages[0];
            String languageSummary = detectedLanguages[1];
            
            String analyzeSentimentResponse =   analyzeSentiment(messageBody, language);
            String[] sentiment1 = IDOLOnDemandParserClass1.parseSentimentAnalysisResponse(analyzeSentimentResponse);
            String aggregate = sentiment1[0];
            String summary = sentiment1[1];
            
            // Create page template variable
            Twiml = '\r\n\r\nsms_number: ' + sms_number +  
                        '\r\nsender_number: '+sender_number+
                        '\r\nmessageBody: '+messageBody+
                        '\r\nmediaUrl: '+mediaUrl+'\r\n\r\n'+
                        '\r\nIDOL OnDemand: \r\n' + 
                        'Detect Language: ' + languageSummary + 
                        'summary: '+summary+
                        'aggregate: '+aggregate;// analyzeSentimentResponse;
                
            createNewCase(messageBody, sender_number, languageSummary + '\r\n\r\n' + summary, aggregate);                  
       }
    }
    
    public static String detectLanguage(String messageBody){
        
        String uri1 = 'https://api.idolondemand.com/1/api/sync/identifylanguage/v1?';
        String apikey1 = 'd02863eb-bc30-4b0b-93fa-a002ecf44470';
        String additionalMetadata1 = 'true';
        String text1 = EncodingUtil.urlEncode(messageBody, 'UTF-8');
        uri1 += 'text='+text1;
        uri1 += '&additional_metadata='+additionalMetadata1;
        uri1 += '&apikey='+apikey1;   
        Http h1 = new Http();
        
        HttpRequest req1 = new HttpRequest();
        req1.setEndpoint(uri1);
        req1.setMethod('GET');
        
        HttpResponse res1 = h1.send(req1);
        String response1 = res1.getBody();
        return response1;        
    }
    
    public static String analyzeSentiment(String messageBody, String language){
        
        String uri2 = 'https://api.idolondemand.com/1/api/sync/analyzesentiment/v1?';
        String apikey2 = 'd02863eb-bc30-4b0b-93fa-a002ecf44470';
        String language2 = language;
        String text2 = EncodingUtil.urlEncode(messageBody, 'UTF-8');
        uri2 += 'text='+text2;
        uri2 += '&language='+language2;
        uri2 += '&apikey='+apikey2;   
        System.debug('uri='+uri2);
        Http h2 = new Http();
        
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req2 = new HttpRequest();
        req2.setEndpoint(uri2);
        req2.setMethod('GET');
        
        // Send the request, and return a response
        HttpResponse res2 = h2.send(req2);
        String response2 = res2.getBody();
        
        return response2;        
    }

    public static void createNewCase(String subject, String sender_number, String languageSummary, String sentiment){
         
         try {
            /*Account a = [SELECT Id, Name 
               FROM Account 
               WHERE Name='Personal Account' LIMIT 1];
            // AccountId='001F000001IqNecIAF'
            
            List<Contact> contactList = [SELECT Id, FirstName, LastName, AccountId
                         FROM Contact 
                         WHERE Phone = :sender_number]; 
             
            Contact c = null;
            if(! contactList.isEmpty()){
                 // assuming unique phonenumbers
                 c = contactList.get(0);
                 //System.debug('Contact Id: ' + c.Id + ', ' + c.LastName + ' ' + c.FirstName);
                 // found existing contact
            } else {
                 //System.debug('Create new contact');
                 // create new contact
                 c = new Contact();
                 c.FirstName = 'Unknown';
                 c.LastName = 'Unknown';
                 c.Phone = sender_number;
                 c.AccountId = a.Id;
                
                 insert c;
            }
             
            Case caseToAdd = new Case();
            
            caseToAdd.Origin = 'SMS';
            caseToAdd.AccountId = c.AccountId;
            caseToAdd.ContactId = c.Id;
            caseToAdd.Subject = subject; 
            caseToAdd.Description = '\r\n' +languageSummary;
            caseToAdd.SuppliedPhone = sender_number;
            //caseToAdd.Sentiment_Score__c = sentiment;
             
            insert caseToAdd;*/
             
        }catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }        
    }
}