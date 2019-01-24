public class RandomContactFactory
{
    public static list<Contact> generateRandomContacts(integer contactcount,string lastname)
    {
        list<Contact> lstcontact = new list<Contact>();
        if(contactcount !=null && string.isNotEmpty(lastname))
        {
            for(integer i =0;i< contactcount;i++)
            {
                Contact objCon = new Contact();
                objcon.FirstName = 'test'+i;
                objcon.lastname = lastname;
                lstcontact.add(objcon);
            }
        }
        if(!lstcontact.isEmpty())
        {
            return lstcontact;
        }
        return null;
    }
}