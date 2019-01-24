public class validateRequestOfTwilio
{
    public boolean validateRequest1(String expectedSignature, String url, Map<String,String> params) {
        try {
            // sort the params alphabetically, and append the key and value of each to the url
            string authToken = '20414a88c52786dfa737d623e1f4f2c0';
            //string authToken = '12345';
            String data = url;  
            string prm = '';
                  
            if(params!=null){
                List<String> sortedKeys = new List<String>(params.keySet());
                sortedKeys.sort();
                
                for (String s: sortedKeys) {
                    data += s;
                    prm+=s;
                    String v='';
                    if (params.get(s)!=null)
                        v=params.get(s);
                    data += v;
                    prm+=v;
                }
            }
            
            //compute the hmac on input data bytes, with AuthToken as key
            Blob mac = Crypto.generateMac('HmacSHA1', Blob.valueOf(data), Blob.valueOf(authToken));
              
            //base64-encode the hmac
            String signature = EncodingUtil.base64Encode(mac);
            system.debug('sig' + signature);
            //if(signature.equals(expectedSignature))
            return signature.equals(expectedSignature);
            
           
        } catch (Exception e) {
            return false;
        }
    }
}