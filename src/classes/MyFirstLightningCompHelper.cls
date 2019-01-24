public with sharing class MyFirstLightningCompHelper {
    @AuraEnabled
    public static string helloworld()
    {
        return 'hello world';
    }

}