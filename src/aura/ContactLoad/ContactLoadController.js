({
    gotoRecord : function(component, event, helper) {
        // Fire the event to navigate to the contact record
        var sObjectEvent = $A.get("e.force:navigateToSObject");
        sObjectEvent.setParams({
            "recordId": component.get("v.contact.Id"),
            "slideDevName": 'related'
        })
        sObjectEvent.fire();
    },
    
    editRecord : function(component, event, helper) {
        // Fire the event to navigate to the edit contact page
        var editRecordEvent = $A.get("e.force:editRecord");
        console.log('editRecordEvent***'+editRecordEvent);
        editRecordEvent.setParams({
            "recordId": component.get("v.contact.Id")
        });
        editRecordEvent.fire();
    },
   
    relatedList : function (component, event, helper) {
        // Navigate to the related cases
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "Cases",
            "parentRecordId": component.get("v.contact.Id")
        });
        relatedListEvent.fire();
    }
})