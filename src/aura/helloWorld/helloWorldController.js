({
	getValue : function(component, event, helper) {
		var name1 = event.getSource().get("v.name");
        console.log('12345'+name1);
        var lstDta = component.get("v.lst1");
        lstDta.push({
            value: name1
          });
        console.log(lstDta+'---');
	},
   clickme : function(component, evnet, helper) {
       var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/mtm"
        });
       urlEvent.fire();
   },
    doInit : function(component, event, helper) {
        //console.log(component.get("v.pageReference").state.testAttribute);
        //var j$ = jQuery.noConflict();
        jQuery("document").ready(function(){
          //$( "#datepicker" ).datepicker({  maxDate: new Date() });
      });
        
    }
})