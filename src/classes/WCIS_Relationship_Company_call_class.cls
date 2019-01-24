public class WCIS_Relationship_Company_call_class
{
    
    @future(callout=true)
    public static void Call_WCIS_Relationship_Comp(list<id> lstacc)
    {
        Relationship_Hierarchy__c obj = new Relationship_Hierarchy__c(id=lstacc[0]);
        update obj;
    }
}