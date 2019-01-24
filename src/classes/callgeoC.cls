public class callgeoC
{
    @future(callout=true)
    public static void callgeo(id jobid)
    {
        map<string,string> mapstr = geopointe.API.geocodeRecord(jobid);
        system.debug('str **'+mapstr );
    }
}