({
	doInit : function(component, event, helper) {
        var action = component.get("c.getAccounts");
        action.setCallback(this,function(response){
            var state = response.getState();
            console.debug(state+'state---');
            if(state=="SUCCESS")
            {
                var accounts = response.getReturnValue();
                component.set("v.Accounts",accounts);
            }
            
        });
		$A.enqueueAction(action);
	},
    editRecord : function(component, event, helper) {
        var editRecordEvent = $A.get("e.force:editRecord");
        var esource = event.getSource().get("v.value");
        console.log(esource);
        editRecordEvent.setParams({
             "recordId": esource
       });
    editRecordEvent.fire();
	},
    deleteRecord : function(component, event, helper) {
        
        var action = component.get("c.deleteAccount");
        var esource = event.getSource().get("v.value");
        action.setParams({ 
            "acc": esource
        });
        
    	$A.enqueueAction(action);
        $A.get('e.force:refreshView').fire();
	},
    showOppmodal: function(component, event, helper) {
     //Toggle CSS styles for opening Modal
    helper.toggleClass(component,'backdrop','slds-backdrop--');
    helper.toggleClass(component,'modaldialog','slds-fade-in-');
	},

	hideModal : function(component, event, helper) {
     //Toggle CSS styles for hiding Modal
    helper.toggleClassInverse(component,'backdrop','slds-backdrop--');
    helper.toggleClassInverse(component,'modaldialog','slds-fade-in-');
  },
    showModal : function(component, event, helper) {
        
    	var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
        $A.util.addClass(spinner, "slds");
        
        document.getElementById("newClientSectionId").style.display = "block";
        $A.util.addClass(spinner, "slds-hide");
        $A.util.removeClass(spinner, "slds");
    },
    
    hideModal : function(component,event, helper){
    
       	var spinner = component.find("mySpinner");
        $A.util.toggleClass(spinner, "slds-show"); 
        $A.get('e.force:refreshView').fire();
        
        document.getElementById("newClientSectionId").style.display = "none" ;
        $A.util.toggleClass(spinner, "slds-hide");
   },
    
    insertAcc : function(component,event, helper){
       var newAcc = component.get("v.acc");
        var action = component.get("c.insertAccount");
        action.setParams({ 
            "acc": newAcc
        });
    $A.enqueueAction(action);
   },
    showSpinner : function(component, event, helper) {
        
    	var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
        $A.util.addClass(spinner, "slds");
        
    },
})