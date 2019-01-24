({
	createCenterStaff : function(component, event, helper) {
        
		var createstaff = component.get('c.getWaxCenterStaffId');
        createstaff.setParams({"objWaxCenterStaff": component.get("v.waxcenterstaff")});
        console.log(component.get("v.waxcenterstaff")+'--component');
        $A.enqueueAction(createstaff);
        createstaff.setCallback(this, 
            function(response) { 
                var recordId = response.getReturnValue();
				debugger;
                console.log(component.get("v.waxcenterstaff")+'component');
                console.log(recordId+'recordId***');
                if(recordId != null ) {
                    var navEvt = $A.get("e.force:navigateToSObject");
                    navEvt.setParams({
                      "recordId": recordId,
                      "slideDevName": "details"
                    });
    				navEvt.fire();
                    
                }
                

                                
            }
        );
        
	}
})