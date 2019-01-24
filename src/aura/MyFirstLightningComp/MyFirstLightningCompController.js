({
	myAction : function(component, event, helper) {
        var action = component.get("c.helloworld");
		action.setCallback(this, function(response){
        	var state = response.getState();
            if (state === "SUCCESS") {
                console.debug(response.getReturnValue().length);
                component.set("v.test", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})