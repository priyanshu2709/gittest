global class ScheduletransactionForComp implements System.Schedulable
{
  global void execute(Schedulablecontext SC)
    {
      batchinitiatetransactionForComp obj = new batchinitiatetransactionForComp();
      Database.executeBatch(obj,200);
    }
}