public class Sendsms1

{

   public String phNumber{get;set;}

   public String smsBody{get;set;}
   
   public string MessagingServiceSid{get;set;}

   String accountSid;

   string token;

   String fromPhNumber;

   errorResponseWrapper erw;

   public sendsms1(){

      /*phNumber ='+919212155244';//+Apexpages.currentpage().getparameters().get('phNumber');

       accountSid = 'ACab2027d72bee07fa1b3db0aeb58338af';//'AC1ce0e62d2ae6ec260847068243a90712';

       token = '20414a88c52786dfa737d623e1f4f2c0';//'40a53a3b4c1aea292656d5276788dca0';

       fromPhNumber = '+15742074625';*/
       phNumber ='+15742074625';//+Apexpages.currentpage().getparameters().get('phNumber');

       accountSid = 'AC6411109dcda3959f175ea4bcc828942d';//'AC1ce0e62d2ae6ec260847068243a90712';

       token = '02233d4d85e18b08bddb3fd9a3d177c5';//'40a53a3b4c1aea292656d5276788dca0';

       //fromPhNumber = '+15742074625';
       smsBody = 'Hi, Test Body';
       MessagingServiceSid = 'MG89bdaf4d731ef9dc3b5fd55fb3ea02b9';

   }

 public void processSms(){

       HttpRequest req = new HttpRequest();
        
        String endpoint = 'https://notify.twilio.com/v1/Services/IS75c0521046e81197f773da7b327189f9/Bindings';
        String endpoint2 = 'https://notify.twilio.com/v1/Services/IS75c0521046e81197f773da7b327189f9/Notifications';
       //req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/Messages.json');
       req.setEndpoint(endpoint);
       req.setMethod('POST');

       String VERSION  = '3.2.0';

       req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);

       req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);

       req.setHeader('Accept', 'application/json');

       req.setHeader('Accept-Charset', 'utf-8');

       req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));
       //req.setBody('Identity='+EncodingUtil.urlEncode('12347','UTF-8')+'&Body='+EncodingUtil.urlEncode('Hello! Billu Badshah','UTF-8'));
        
       req.setBody('SERVICE_SID='+EncodingUtil.urlEncode('IS75c0521046e81197f773da7b327189f9','UTF-8')+'&Identity='+EncodingUtil.urlEncode('00001','UTF-8')+'&BindingType='+EncodingUtil.urlEncode('sms','UTF-8')+'&Address='+EncodingUtil.urlEncode('+61414136952','UTF-8'));

       Http http = new Http();

       HTTPResponse res = http.send(req);
        System.debug(res.getStatusCode());
       System.debug(res.getBody());

      /* if(res.getStatusCode()==201)

           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'SMS Sent Successfully'));

       else{

           erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);

           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,erw.message));

       }*/

   }

   public class errorResponseWrapper{

       String code;

       String message;

       String moreInfo;

       String status;    

   }

}