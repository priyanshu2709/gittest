public with sharing class contactscontroller {
    
 @AuraEnabled
    public static List<contact> getcontacts() {
         list<contact> lstcontact =[select id,name,Account.name,Email,Phone from contact limit 10];
        return lstcontact;
    }
	 @AuraEnabled
    public static List<Account> getAccounts() {
         list<Account> lstaccount =[select id,name,billingcity from account order by createddate desc limit 10 ];
        return lstaccount;
    }
    @AuraEnabled
    public static void insertAccount(Account acc) {
        
        insert acc;
    }
    @AuraEnabled
    public static void deleteAccount(Account acc) {
        
        delete acc;
    }
}