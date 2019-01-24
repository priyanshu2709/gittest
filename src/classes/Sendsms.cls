public class Sendsms

{

   public String phNumber{get;set;}

   public String smsBody{get;set;}

   String accountSid;

   string token;

   String fromPhNumber;

   errorResponseWrapper erw;

   public sendsms(){

      phNumber ='+61458883222';//+Apexpages.currentpage().getparameters().get('phNumber');

       accountSid = 'ACab2027d72bee07fa1b3db0aeb58338af';//'AC1ce0e62d2ae6ec260847068243a90712';

       token = '20414a88c52786dfa737d623e1f4f2c0';//'40a53a3b4c1aea292656d5276788dca0';

       fromPhNumber = '+15742074625';
       smsBody = 'Hi, Test Body';

   }

 public void processSms(){

       HttpRequest req = new HttpRequest();

       req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');

       req.setMethod('POST');

       String VERSION  = '3.2.0';

       req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);

       req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);

       req.setHeader('Accept', 'application/json');

       req.setHeader('Accept-Charset', 'utf-8');

       req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));

       req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+smsBody);

       Http http = new Http();

       HTTPResponse res = http.send(req);

       System.debug(res.getBody());

       if(res.getStatusCode()==201)

           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'SMS Sent Successfully'));

       else{

           erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);

           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,erw.message));

       }

   }

   public class errorResponseWrapper{

       String code;

       String message;

       String moreInfo;

       String status;    

   }

}