global class ScheduletransactionforCompRel implements System.Schedulable
{
  global void execute(Schedulablecontext SC)
    {
      batchinitiatetransactionforCompRel obj = new batchinitiatetransactionforCompRel();
      Database.executeBatch(obj,200);
    }
}