public with sharing class TestLightningView {
    public list<Account> lstacc{get;set;}
    
    public TestLightningView() {
        lstAcc = [select id,name,phone from Account limit 20];
    }

}