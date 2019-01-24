@RestResource(urlMapping='/AccountService/*')
global with sharing class AccountWebService {

    @HttpPost
    global static string upsertAccount() {
       
       RestRequest req = RestContext.request;
       System.debug('string body---'+ req.requestBody.toString()); 
       JSONParser jsonParser = JSON.createParser(req.requestBody.toString());
       system.debug('jsonParser.nextToken()***'+jsonParser.nextToken());
        while(jsonParser.nextToken() != null){
        
        system.debug('JSONToken.START_ARRAY***'+JSONToken.START_ARRAY);
        
        system.debug('jsonParser.getCurrentToken()***'+jsonParser.getCurrentToken());
        system.debug('jsonParser.getText()111'+jsonParser.getText());
        system.debug('jsonParser.nextToken()***'+jsonParser.nextToken());
        system.debug('JSONToken.FIELD_NAME***'+JSONToken.FIELD_NAME);
        system.debug('jsonParser.getText()***'+jsonParser.getText());
            if(jsonParser.getCurrentToken() == JSONToken.START_ARRAY ){
                while(jsonParser.nextToken() != JSONToken.END_ARRAY){
                    system.debug('JSONToken.FIELD_NAME***'+JSONToken.FIELD_NAME);
                        if((jsonParser.getCurrentToken() == JSONToken.FIELD_NAME) && (jsonParser.getText() == 'Key')){
                                jsonParser.nextToken();
                                if(jsonParser.getText()== 'Token1'){
                                jsonParser.nextToken();
                                if((jsonParser.getCurrentToken() == JSONToken.FIELD_NAME) && (jsonParser.getText() == 'Value')){
                                jsonParser.nextToken();
                                //uploadToken = jsonParser.getText();
                            }
                        } 
                        else if(jsonParser.getText()== 'Token2'){
                            jsonParser.nextToken();
                            if((jsonParser.getCurrentToken() == JSONToken.FIELD_NAME) && (jsonParser.getText() == 'Value')){
                            jsonParser.nextToken();
                            //destFolderPath = jsonParser.getText();
                        }
                    }
                }
            }
        }
       
       }
       return '';
    }
}