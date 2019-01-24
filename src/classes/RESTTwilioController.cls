@RestResource(urlMapping='/RestTwilio/*')
global with sharing class RESTTwilioController {

@HttpPost
  global static string getOpenCases() {
    
    String sms_number = RestContext.request.params.get('To');//parameters.get('to');  // Get To Number
        String sender_number = RestContext.request.params.get('From');//parameters.get('from'); // Get Message Body
        String messageBody = RestContext.request.params.get('Body');//parameters.get('Body');  // Get Message Body
        String mediaUrl = RestContext.request.params.get('MediaUrl10');//parameters.get('MediaUrl0'); // Get Media URL
        string secretkey = RestContext.request.params.get('secretkey');
        //string signature = RestContext.request.params.get('X-Twilio-Signature');
        String expectedSignature = RestContext.request.headers.get('X-Twilio-Signature');
        
        system.debug('secretkey&&&'+secretkey);
        system.debug(sms_number+'sms_number&&');
        system.debug(sender_number+'sender_number&&');
        system.debug(messageBody+'messageBody&&');
        System.debug('processing');
        validateRequestOfTwilio objvalidate = new validateRequestOfTwilio();
        
        String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        System.debug('baseUrl =' + baseUrl);
        
        String url = 'https://' + RestContext.request.headers.get('Host') + '/services/apexrest' + RestContext.request.requestURI;
        //string url = 'https://mycustomerportal121-developer-edition.ap1.force.com/services/apexrest/Priyank/RestTwilio';
        Map <String, String> params = RestContext.request.params;
        boolean ismatched = objvalidate.validateRequest1(expectedSignature, url, params);
        
        
        if(ismatched)//if(secretkey != null && secretkey != '')
        {
            Case caseToAdd = new Case();
                
            caseToAdd.Origin = 'SMS';
            //caseToAdd.AccountId = c.AccountId;
           // caseToAdd.ContactId = c.Id;
            caseToAdd.Subject = sms_number +'& '+sender_number+'--Signature--'+expectedSignature ; 
            caseToAdd.Description =  messageBody+' secret key--'+secretkey+ '&&-signature Match--'+ismatched+'baseUrl&&'+baseUrl;
            caseToAdd.SuppliedPhone = sender_number;
            //caseToAdd.Sentiment_Score__c = sentiment;
             
            insert caseToAdd;
             return 'success...!!';
        }
       return 'invalid request..!!';
  }
}