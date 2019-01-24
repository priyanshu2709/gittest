public class LeadController {
    public Lead objLead{get;set;}
    public LeadController(ApexPages.StandardController controller) {
        objLead = new Lead();
    }

}