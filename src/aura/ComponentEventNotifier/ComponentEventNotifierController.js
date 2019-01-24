/* ceNotifierController.js */
{
    fireComponentEvent : function(cmp, event) {
        // Get the component event by using the
        // name value from aura:registerEvent
        debugger;
        var inputsel = cmp.find("InputSelectDynamic").get("v.value");
        var cmpEvent = cmp.getEvent("cmpEvent");        
        cmpEvent.setParams({"LeadStatus" : inputsel});
        cmpEvent.fire();
        console.log('inputsel'+inputsel);
        
    },
    doInit : function(component, event, helper) {
        debugger;
    var action = component.get("c.getLeadStatus");
    var inputsel = component.find("InputSelectDynamic");
    var opts=[];
    action.setCallback(this, function(a) {
        var state = a.getState();
		if (state === "SUCCESS") {
            for(var i=0;i< a.getReturnValue().length;i++){
                console.log(a.getReturnValue()[i]+'ssss');
                opts.push({"class": "optionClass", label: a.getReturnValue()[i], value: a.getReturnValue()[i]});
            }
            inputsel.set("v.options", opts);
        } else if (state === "ERROR") {
            console.log('Error');
        }


    });
    $A.enqueueAction(action); 
}
}