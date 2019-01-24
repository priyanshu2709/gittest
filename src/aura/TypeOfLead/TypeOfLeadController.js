({
	doInit : function(component, event, helper) {
    var action = component.get("c.getLeadStatus");
    var inputsel = component.find("InputSelectDynamic");
    var opts=[];
    action.setCallback(this, function(a) {
        for(var i=0;i< a.getReturnValue().length;i++){
            console.log(a.getReturnValue()[i]+'ssss');
            opts.push({"class": "optionClass", label: a.getReturnValue()[i], value: a.getReturnValue()[i]});
        }
        inputsel.set("v.options", opts);

    });
    $A.enqueueAction(action); 
},
    showLead: function(component,event,helper){
        var appEvent = $A.get("e.c:EventDisplayTypeOfLead");
        var inputsel = component.find("InputSelectDynamic").get("v.value");
        appEvent.setParams({"LeadType" : inputsel});
        appEvent.fire();

        console.log('inputsel'+inputsel);
    }
})