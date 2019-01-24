/***********************************************************************
Apex Class          : MTM_CredentialingExportController
Author                      : Chaitanya M
Created Date                : 18 September 2018
Descritption                : This Apex class is used to display credentialing export records with new insert functionlity.

Change History:

Date            Modified By         Change Made
9/18/2018       Chaitanya M     
************************************************************************/ 
public class MTM_CredentialingExportController {

    @AuraEnabled
    public static List<Credential_Export__c> getRecords() {
        List<Credential_Export__c> credentialsExport = new List<Credential_Export__c>();
        
        credentialsExport = [
            SELECT Id, Name, End_Date__c, Object_Type__c, Plan_Code__c, Start_Date__c, Status__c, Date_Requested__c
            FROM Credential_Export__c
        ];
        return credentialsExport;
    }
}