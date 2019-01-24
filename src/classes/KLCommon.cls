public class KLCommon
{
    public static id getRecordTypeId(string objectAPIName, string recordTypeName)
    {
        if(string.isEmpty(objectAPIName) || string.isEmpty(recordTypeName)){
            return null;
        }
        //Get schema information
        Map<String, Schema.SObjectType> globalDescription =  Schema.getGlobalDescribe();
        Schema.SObjectType sObjType = globalDescription.get(objectAPIName);  
        Schema.DescribeSObjectResult cfrSchema = sObjType.getDescribe();
        Map<String,Schema.RecordTypeInfo> RecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id recordTypeId = RecordTypeInfo.get(recordTypeName).getRecordTypeId();
        return recordTypeId;
    }
}