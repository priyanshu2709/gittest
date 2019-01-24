({
	myAction : function(component, event, helper) {
		debugger;
        var LeadType1 = event.getParam("LeadStatus");
        console.log('LeadStatus**'+LeadType1);
        var action = component.get("c.getLead");
    	action.setParams({leadstatus : LeadType1});
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