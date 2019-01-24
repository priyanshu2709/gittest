({
    doInit : function(component, event, helper) {
        // Retrieve contacts during component initialization
        helper.getContacts(component);
    },
    //Delimiter for future code
    createRecord : function (component, event, helper) {
    // Open the create record page
    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
        "entityApiName": "Contact"
    });
    createRecordEvent.fire();
},

select : function(component, event, helper){
    // Get the selected value of the ui:inputSelect component
    var selectCmp = component.find("selection");
    var selectVal = selectCmp.get("v.value");
    
    // Display all primary contacts or all contacts
    if (selectVal==="All Primary"){
        var action = component.get("c.getPrimary");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.contacts", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
    else {
        // Return all contacts
        helper.getContacts(component);
    }
}
    
})