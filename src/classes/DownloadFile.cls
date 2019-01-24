public class DownloadFile {
    
    @AuraEnabled
     public static string DownloadAttachment(string attachmentName) {
     
        Document objDoc = [select id from document where name=:attachmentName];
        
        /*ContentVersion oldCV = [Select Id,Title,Locked__c,Locked_By__c from ContentVersion Where ContentDocumentId=:DownloadAttachmentID and IsLatest = true ];
        System.Debug('Old LV INitial :'+ oldCV.Id);
        System.Debug('Old Lock :'+ oldCV.Locked__c);*/
        String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm();
        String URlDownload = 'https://homebuilder--c.na40.content.force.com/servlet/servlet.FileDownload?file='+objDoc.id;
        system.debug('Download URL:' +URlDownload);
        return URlDownload;
    } 

}