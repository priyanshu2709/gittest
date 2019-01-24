@isTest
public class TestVerifyDate
{
    static Date objdate = system.today();
    static Date objdate1 = system.today().adddays(20);
    
    static testmethod void checkdate()
    {
        Verifydate.CheckDates(objdate,objdate1);
    }
    static testmethod void checkdate1()
    {
         Date objdate11 = system.today();
         Date objdate22 = system.today().adddays(-20);
        Verifydate.CheckDates(objdate11,objdate22);
    }
}