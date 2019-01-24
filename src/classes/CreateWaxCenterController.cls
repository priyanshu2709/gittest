public class CreateWaxCenterController {
    
    @AuraEnabled
    public static id getWaxCenterStaffId(Priyank__WaxCenterStaff__c objWaxCenterStaff) {
        system.debug('objWaxCenterStaff***'+objWaxCenterStaff);
        Priyank__WaxCenterStaff__c objWaxCenterStaffNew = new Priyank__WaxCenterStaff__c();
        objWaxCenterStaffNew.Name = objWaxCenterStaff.Name;
        objWaxCenterStaffNew.Priyank__Contact__c = objWaxCenterStaff.Priyank__Contact__c ;
        objWaxCenterStaffNew.Priyank__Wax_Center__c = objWaxCenterStaff.Priyank__Wax_Center__c ;
        objWaxCenterStaffNew.Priyank__Role__c = objWaxCenterStaff.Priyank__Role__c;
        
        insert objWaxCenterStaffNew;
        return objWaxCenterStaffNew.id;
    }
}