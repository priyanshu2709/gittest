global class ScheduletransactionforRelInd implements System.Schedulable
{
  global void execute(Schedulablecontext SC)
    {
      batchinitiatetransactionforRelInd obj = new batchinitiatetransactionforRelInd();
      Database.executeBatch(obj,200);
    }
}