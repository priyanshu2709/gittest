public class PopulateJeo {
    public Job__c objjob{get;set;}
    public string lat{get;set;}
    public string lng{get;set;}
    public PopulateJeo(ApexPages.StandardController controller) {
        objjob = new Job__c();
        lat = '';
        lng = '';
    }
    public pagereference gotorecord()
    {
        
        insert objjob;
        pagereference obj = new pagereference('/'+objjob.id);
        return obj;
    }
}