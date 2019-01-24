@RestResource(urlMapping='/CheckAccountInfoByABNACROrNameService/*')
global with sharing class CheckAccountInfoByABNACROrNameService {

    @HttpPost
    global static String checkCustomerStatus() {
       RestResponse res = RestContext.response; 
       RestRequest req = RestContext.request;
       system.debug('req.requestBody'+req.requestBody.toString());
       /*if(String.isNotEmpty(req.requestBody.toString())) {
            
            string jsonRequestBody = req.requestBody.toString();
            //res = ParseJsonRequest.parseJson(jsonRequestBody);
            
       }*/
       String success = JSON.Serialize('{Success : Request has been accepted.}');
       return success;
    }
}