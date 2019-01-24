({
	myAction : function(component, event, helper) {
		var LeadType = event.getParam("LeadType");
        console.log('LeadType**'+LeadType);
        var action = component.get("c.getLead");
    	action.setParams({
        	leadstatus : LeadType
    		});
		action.setCallback(this, function(a) {
            console.log('a.getState()&&&'+a.getState());
        if (a.getState() === "SUCCESS") {
            component.set("v.LeadList", a.getReturnValue());
        } else if (a.getState() === "ERROR") {
            $A.log("Errors", a.getError());
        }
    });
	$A.enqueueAction(action);

	}
})