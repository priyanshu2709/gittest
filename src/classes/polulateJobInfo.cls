public class polulateJobInfo {
  @InvocableMethod(label='populate geo locaiton' description='.')
  public static void getAccountNames(list<ID> ids) {
  for(Id strid: ids)
  {
    map<string,string> mapstr = geopointe.API.geocodeRecord(strid);
    system.debug('mapstr**'+mapstr );
   }
    }
  }