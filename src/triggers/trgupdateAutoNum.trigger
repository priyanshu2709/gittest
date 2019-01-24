trigger trgupdateAutoNum on Account (before insert) 
{
    trgupdateAutoNumHandler obj = new trgupdateAutoNumHandler();
    if(trigger.isBefore && trigger.isInsert)
    {
        obj.isBeforeUpdate(trigger.new);
    }
}