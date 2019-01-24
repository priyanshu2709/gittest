({
	handleClick : function(component, event, helper) {
		var attr=component.get("v.text");
        console.log('attr'+attr);
        var target = event.getSource();
        component.set("v.text",target.get("v.label"));
	}
})