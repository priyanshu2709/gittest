public class UploadExcel 
{
    public blob filevalue{get;set;}
    public UploadExcel()
    {
        //filevalue = '';
    }
    public void InsertExcel()
    {
        system.debug('filevalue***'+filevalue.toString());
        string file = filevalue.toString();
        list<string> lstExcelValues = new list<string>(file.split(','));
        system.debug('lstExcelValues&&&'+lstExcelValues);
    }
}