public class displayleadstatus
{
   
    @AuraEnabled
    public static List<String> getLeadStatus(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = lead.status.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getLabel());
        }
        
        return options;}
     @AuraEnabled
     public static list<Lead> getLead(string leadstatus)
     {
         list<Lead> lstLead = [select FirstName,Lastname,Email,Status from lead where status=:leadstatus];
         return lstlead;
     }
}