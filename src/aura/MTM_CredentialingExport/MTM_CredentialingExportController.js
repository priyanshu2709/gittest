({
    doInit  : function(component, event, helper) {
        // Prepare a new record from template
        debugger;
        component.find("exportRecordCreator").getNewRecord(
            "Priyank__Credential_Export__c", // sObject type (objectApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newCredentialingExport");
                var error = component.get("v.newCredentialingExportError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec);
            })
        );        
        var action = component.get("c.getRecords");
        action.setCallback(this,function(response) {
            var state = response.getState();
            if(state === 'SUCCESS'){
                var returnValue = response.getReturnValue();
                console.log('returnValue'+returnValue);
                component.set("v.exports",returnValue);
            }
        });
        $A.enqueueAction(action);
    },
    showNew : function(component, event, helper) {
        component.set("v.showNew",true);
    },
    handleSaveContact : function(component, event, helper) {
        debugger;
        var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set("v.simpleCredentialingExport.Priyank__Status__c", "In Progress");
        component.set("v.simpleCredentialingExport.Priyank__Date_Requested__c", today);
        component.find("exportRecordCreator").saveRecord(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                // record is saved successfully
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Saved",
                    "message": "The record was saved."
                });
                resultsToast.fire();
                
            } else if (saveResult.state === "INCOMPLETE") {
                // handle the incomplete state
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                // handle the error state
                console.log('Problem saving contact, error: ' + JSON.stringify(saveResult.error));
            } else {
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
        });
    }
})