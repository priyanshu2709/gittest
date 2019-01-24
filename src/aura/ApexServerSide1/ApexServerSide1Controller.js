({
	createLead : function(component, event, helper) {
		
        var newlead = component.get("v.NewLead");
        var action = component.get("c.saveLead");
        action.setParams({"objlead": newlead});
		action.setCallback(this, function(a) {
		var state = a.getState();
		 if (state === "SUCCESS") {
			var name = a.getReturnValue();
				 alert("hello from here"+name.LastName);
	            }
	        });
	    $A.enqueueAction(action)
	}
})