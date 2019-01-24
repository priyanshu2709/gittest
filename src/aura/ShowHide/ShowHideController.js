({
	toggle : function(component, event, helper) {
        var comp = component.find("text");
		$A.util.toggleClass(comp,"toggle");
	}
})