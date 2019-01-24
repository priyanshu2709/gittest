({
    getInput : function(cmp, evt) {
        //var myName = cmp.find("name").get("v.value");
       // var myText = cmp.find("outName");
       // var greet = "Hi, " + myName;
        //myText.set("v.value", greet);
       
        var bntlabel = evt.getSource().get("v.label")
        
        var actiondownload = cmp.get("c.DownloadAttachment");
        actiondownload.setParams({attachmentName : bntlabel});
        actiondownload.setCallback(this, function(b){
            var state = b.getState();
            var linkOne = document.createElement("a");
            linkOne.setAttribute('download',"download");
            //To set the content of the file
            linkOne.href   = b.getReturnValue();
            linkOne.style  = "visibility:hidden";
            
            document.body.appendChild(linkOne);
            
            linkOne.click();   
            
            document.body.removeChild(linkOne);
            
        /*cmp.set("v.Baseurl", b.getReturnValue());
            var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                  "url": b.getReturnValue()
                });
                urlEvent.fire();*/
            });
        $A.enqueueAction(actiondownload);
    }
})