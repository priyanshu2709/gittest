global with sharing class AnyObjectSignatureController 
{
    public string accountid{get;set;}
    public account objaccount{get;set;}
    public AnyObjectSignatureController(ApexPages.StandardController controller) {
        accountid = ApexPages.currentPage().getParameters().get('id');
        system.debug('accountid&&'+accountid);
        objaccount = findAccounts(accountid);
    }

    public AnyObjectSignatureController()
    {
    }
    @RemoteAction
    global static Account findAccounts(String accid)
    {
    //name = '%' + name + '%';
    Account accounts = [Select Id, Name from Account where id = :accid];
    return accounts;
    }
    @RemoteAction
    global static String saveSignature(String signatureBody, String parentId) 
    {
        try
        {
        system.debug('Record Id == ' + parentId);
        system.debug(signatureBody);
        Attachment a = new Attachment();
        a.ParentId = parentId;
        a.Body = EncodingUtil.base64Decode(signatureBody);
        a.ContentType = 'image/png';
        a.Name = 'Signature Capture.png';
        insert a;
        return '{success:true, attachId:' + a.Id + '}';
        }
        catch(Exception e)
        {
            return JSON.serialize(e);
        }
        return null;
    }

}