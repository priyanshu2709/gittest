({
toggleClass: function(component,componentId,className) {
    var modal = component.find(componentId);
    $A.util.addClass(modal,className+'open');
    $A.util.removeClass(modal,className+'hide');
    
},

toggleClassInverse: function(component,componentId,className) {
    var modal = component.find(componentId);
    $A.util.addClass(modal,className+'hide');
    $A.util.removeClass(modal,className+'open');
    }
 })