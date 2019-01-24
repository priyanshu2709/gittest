public with sharing class leadcaching {
    @auraenabled
    public list<Lead> getlead()
    {
        list<Lead> lstlead = [select id,name,mobilephone,email from Lead];
        return lstlead;
        
    }

}