({
	doInit : function(component, event, helper) {
        var action = component.get("c.getcontacts");
        action.setCallback(this,function(response){
            var state = response.getState();
            console.debug(state+'state---');
            if(state=="SUCCESS")
            {
                var contacts = response.getReturnValue();
                component.set("v.contacts",contacts);
            }
            
        });
		$A.enqueueAction(action);
	}
})