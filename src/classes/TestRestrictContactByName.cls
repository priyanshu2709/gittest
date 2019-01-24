@isTest
public class TestRestrictContactByName
{
       static testmethod void validate()
       {
           Contact objcon = new Contact();
           objcon.lastname = 'INVALIDNAME';
           insert objcon;
       }
}