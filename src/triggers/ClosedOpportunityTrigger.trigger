trigger ClosedOpportunityTrigger on Opportunity (after insert) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        list<Task> lstTaskInsert = new list<Task>();
        if(!trigger.new.isEmpty())
        {
            for(Opportunity objOpp : trigger.new)
            {
                if(string.isNotBlank(objOpp.stagename) && objOpp.stagename == 'Closed Won')
                {
                    Task objtask = new Task();
                    objtask.whatid = objopp.id;
                    objtask.subject = 'Follow Up Test Task';
                    objtask.status = 'In Progress';
                    lstTaskInsert.add(objtask);
                }
            }
            if(!lstTaskInsert.isEmpty())
            {
                insert lstTaskInsert;
            }
        }
    }
}