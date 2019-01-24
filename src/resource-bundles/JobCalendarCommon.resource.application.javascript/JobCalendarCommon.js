
var globals = {	'allEvents' : {}, 
		'gapArray' : undefined,
		'gaps' : {'index': -1, 'slider': false, 'gapsByUser': {}},
		'users' : undefined, 
		'timePeriod' : {'start' : null, 'end' : null, 'dayStart': 6,'dayEnd': 22, 'hourStart' : '08:00', 'hourEnd' : '18:00'}, 
		'menu' : false, 
		'timer' : {'timer' : 0, 'delayReset' : 0, 'delayClose' : 0}, 
		'openDelay' : false,
		'mouse' : {'onDialog' : false, 'onEvent' : false, 'disableDialog' : false, 'onMonthNumber' : false},
		'crud' : false,
		'reset' : false,
		'cntrlDown': false,
		'sliderDuration': 3,
		'eventwindow' :{'iteration': 0, 'showhideid' : null, 'descid' : null}
		};

function getColor(userId){
	logToConsole('getcolor', 'notify');
	return(globals.users[userId].Colour);	
}

function setButtonClass(button, value){
    if(value!= 'true'){
	$( button ).removeClass( "active" );
    }else{
	$( button ).addClass( "active" );
    }	
    setButtonState(button, value);
    if(button.id != 'all'){
	updateUserDisplay(button.id, value);
    }
}

function setOtherButtonClass (value, currentButtonId) {
    $('a.bttn').each(function(i,button){
	if(button.id != currentButtonId){
	    setButtonClass(button, value);
	}
});	

}

function setButtonStateLoop (value) {
    var allBttn = value==undefined ? "true" : value;
    $('a.bttn').each(function(i,button){
	    if(button.id != 'all'){
		var disp = value==undefined ? globals.users[button.id].Display : value;
		setButtonState(button, disp);
		if(disp == "false"){
		    allBttn = "false";
		}
		if(value!= undefined){
		    updateUserDisplay(button.id, value);
		}
	    }	
	});
    $('a.bttn').each(function(i,button){
	    if(button.id == 'all'){
		setButtonClass(button, allBttn);
	    }	
	});
}

function setButtonState(button, value){
    logToConsole(value,'data');
    if(button.id != 'all'){
        if(value=='true'){
            $(button).css("color",function(i,oldvalue){return(getColor(button.id));});
        }else if(value =='false'){
	    $(button).css("color","#7f8c8d");
	}
    }
    
    logToConsole('current bttn active? '+$(button).is(".active"),'data');
    
}

function testFilterAndReturn() {
   globals.allEvents = {};
   var result = filterAndReturn(null, null);
   console.log(result);
}

function setEventStartEnd(event, duration) {
    if(event === undefined){
	return null;
    }else{ 
	if(event.start == null || event.end == null){
            if(duration !== undefined && event.startDateTime == null){
        	event['end'] = new Date(event.endDateTime);
        	var start = moment(event.end).subtract(duration);
        	event['start'] = new Date(start.format());
        	event['startDateTime'] = start.format("YYYY[-]MM[-]DD[T]hh:mm:ss[.000Z]");
            }else if(duration !== undefined && event.endDateTime == null){
        	event['start'] = new Date(event.startDateTime);
        	var end = moment(event.start).add(duration);
        	event['end'] = new Date(end.format());
        	event['endDateTime'] = end.format("YYYY[-]MM[-]DD[T]hh:mm:ss[.000Z]");
            }else{
        	event['start'] = new Date(event.startDateTime);
                event['end'] = new Date(event.endDateTime);
            }
	}
    	return event;
    }
} 
    
function filterEventStartEnd(event, start, end){
    
    if(new Date(event.startDateTime) > start && new Date(event.endDateTime) < end) {
	return event;
    }
    
}

function filterAndReturn(start, end) {
    	logToConsole('filterandReturn','notify');
        // 2 - read the javascript state that determines which users are currently displayed
        // 3 - filter and return the allEvents array using #2 data
        // 4 - filter based on fullcalendar supplied start and end times
    	var dFiltered = [];  
	
	$.each(globals.allEvents, function (i,event){
	    if(globals.users[event.ownerId].Display == 'true'){
		var fEvent = filterEventStartEnd(event, start, end);
	 	if(fEvent != null){
	 	    dFiltered.push(fEvent);	
	 	}
	    }
	    
	 });
	
	//dFiltered.push({"color":"#F34AFF","endDateTime":"2014-02-25T10:30:00.000Z","id":"00UN0000001x8jhMAA","ownerId":"00590000000LO6GAAW","startDateTime":"2014-02-25T08:00:00.000Z","textColor":"#000000","title":"JOB-552923 - Test Job\nShane 1\nTest Job\n123 Main st RINGWOOD VIC 3134","source":{"className":[]},"_id":"00UN0000001x8jhMAA","start":"2014-07-28T08:00:00.000Z","_start":"1970-01-01T00:00:00.000Z","end":"2014-07-28T09:00:00.000Z","_end":null,"allDay":false,"className":[]});
	logToConsole(dFiltered, 'data');
 	logToConsole(globals, 'data');
 	return  dFiltered;
}

function setGlobalTimePeriod(start, end) {
    logToConsole('setGlobalTimePeriod','notify');
    
    var timeArray = [];
    start = start==null?moment():moment(start);
    end = end==null?moment(new Date()):moment(end);
    if(globals.timePeriod.start == null || globals.timePeriod.end == null){
	globals.timePeriod.start = start.subtract('7','days');
	globals.timePeriod.end = end.add('31', 'days');
	var timeObj = {'start' : formatDT(globals.timePeriod.start), 
			 'end' : formatDT(globals.timePeriod.end)};
	timeArray.push(timeObj);
    }else{ 
	    if(globals.timePeriod.start.isAfter(start)){
    	    var timeObj = {'start' : formatDT(start), 
    		    	     'end' : formatDT(globals.timePeriod.start)};
    	    timeArray.push(timeObj);
    	    globals.timePeriod.start = start;
	    
        }	
        
        if(globals.timePeriod.end.isBefore(end)){
    	    var timeObj = {'start' : formatDT(globals.timePeriod.end),
    		    	     'end' : formatDT(end)};
    	    timeArray.push(timeObj);
    	    globals.timePeriod.end = end;
	    
        }
        
        if(globals.crud){
            var timeObj = {'start' : formatDT(start), 
        	    	     'end' : formatDT(end)};
            timeArray.push(timeObj);
            
        }
    }
    return timeArray;
}



function setAllEvents(){
    console.log('setAllEvents');
    var eventArray = [];
    $.each(globals.users,function(i,user){
		eventArray.push.apply(eventArray,user.eventList);
		var lastView;
		var lastDate;
		if(globals.currentUser!==undefined){
		    lastView = globals.currentUser.lastView;
		    lastDate = globals.currentUser.lastDate;
		}
		if(user.lastView!==undefined){
		    globals.currentUser = user;
		    if(lastView!==undefined){globals.currentUser.lastView = lastView};
		    if(lastDate!==undefined){globals.currentUser.lastDate = lastDate};
		}
    });
    $.each(eventArray, function(i,event){
	var sEvent = setEventStartEnd(event)
	if(sEvent.readOnly){
	    sEvent.borderColor = "#000000";
	}
	globals.allEvents[event.id] = sEvent;
	setCalendarStartEnd(sEvent);
    })
    displayCalendar();
}

function refreshOnCrud() {
    globals.currentJobId = undefined;
    globals.crud = true;
    $('#calendar').fullCalendar('refetchEvents');
}

function getDataCallout(start, end, callback) {
    logToConsole(formatDT(start), 'data');
    logToConsole(formatDT(end), 'data');
    var timePeriodArray = setGlobalTimePeriod(start,end);
    logToConsole(timePeriodArray, 'data');
    logToConsole('callout','notify');
    JobCalendarController.getData(
	    timePeriodArray,
	function(results, event) {
	    if(event.type === 'exception'){
	        logToConsole("exception", 'notify');
	    }else if(event.status){
		
	        globals.users = results;
	        logToConsole(globals.users, 'data');
	        makeMenu();
	        setAllEvents();
	        if(callback !== undefined){
	            logToConsole('callback','notify');
	            callback( filterAndReturn(start, end));
	        }else {
	            logToConsole('callback undefined', 'notify');
	            //$('#calendar').fullCalendar('refetchEvents');
	        }
	    }else{
	        logToConsole(event.message, 'notify');
	    }
	}
    );
}

function updateEvents(start, end, callback) {
    logToConsole('updateEvents','notify');
    if ( globals.users === undefined || 
	    globals.crud == true ||
	    moment(start).isBefore(globals.timePeriod.start) || 
	    moment(end).isAfter(globals.timePeriod.end)
	) {
	logToConsole('getDataCallout...', 'notify');
	getDataCallout(start, end, callback);
	globals.crud = false;
    } else {
	logToConsole('updateEventsNoCallout','notify');
	callback( filterAndReturn(start, end));
    }
}
//function firstLoad() {
//    if(globals.users === undefined) {
//	var start = new Date();
//	var end = new Date();
//	logToConsole(start, 'data');
//	start = start.setDate(start.getDate()-7);
//	end = end.setDate(end.getDate()+21);
//	getDataCallout(start, end);
//    }
//}

function logToConsole(o, c){//TODO: change out all console.log() for logToConsole(object, category); Make categories up.
    //categories ==> notify, data
    if(c=='data' ||
	 c=='notify' //||
	 //c=='mouse' 
	){
	console.log(o);
    }
}

function formatDate(d) {return $.fullCalendar.formatDate(d, 'yyyy-MM-dd-HH-mm');}

function formatDT(d) {
    d = new Date(d);
    var dtString =  d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate()+' '+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds();
    return dtString;
}

function formatDateTime(d) {return $.fullCalendar.formatDate(d, 'yyyy-MM-dd HH:mm:ss');}

function handleEventChange(event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) {
	// using getTime() for maximum cross-browser compatibility
    	console.log(revertFunc);
    	var start = event.start.getTime();
    	var end = event.end!=null?event.end.getTime():start;
    	if(event.readOnly==true){
    	    revertFunc();
    	    alert('This event is Read Only');
	}else{
	    var b = conflictAlert(event, revertFunc);
	    if(b){
		sendEventUpdate(event.id, start, end, event.timeLogged);
	    }
    	}
}

function handleEventResize(event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view){
    handleEventChange(event, dayDelta, minuteDelta, false, revertFunc, jsEvent, ui, view);
}
function updateUserDisplay(userId, value) {
	if(value=='true'){
		globals.users[userId].Display='true';
	} else {
		globals.users[userId].Display='false';
	}
	sendDisplayUpdate(userId, value);
}

function openJob(jobId) {
	$.fancybox.close();
	window.open('/'+jobId);
}

function openResource(userId) {
    //console.log(globals.users);
    var resId = globals.users[userId].resourceId;
    window.open('/'+resId);
}

function openAllResources() {
    window.open('/a0J');
}


function closeDialog(event, jsEvent, view) {
    logToConsole('mouseout event', 'mouse');
    globals.mouse.onEvent = false;
    if(globals.timer.timer) {
	globals.timer.delayClose = setTimeout(function(){
	    				killDialog();
	},50);	
	clearTimeout(globals.timer.timer);
    	globals.timer.timer = 0;
    }
    globals.timer.delayReset = setTimeout(function(){
                	    globals.openDelay = true;
                	},350);
    
    
}

function fadeDialog() {
    //console.log("fadeStart");
    $( ".ui-dialog" ).fadeOut(600,function(){
	//console.log("fadeEnd");
	killDialog();});
}

function killDialog() {
    if(globals.mouse.onDialog == false && globals.mouse.onEvent == false) {
	var dialog = $( "#eventHover" ).dialog( "instance" );
	if(dialog!==undefined){
	    $("#eventHover").dialog( "close" );
	}
	$("#eventTitle").html('');
	$("#eventLine1").text('');
	$("#eventLine2").text('');
	$("#eventLine3").text('');
	$("#eventLine4").text('');
	$("#eventDescription").html('').css('border','none');
    }
}

function openDialog(event, jsEvent, view){
    logToConsole('mouseOn event', 'mouse');
    globals.mouse.onEvent = true;
    if(globals.timer.limitTimer !== undefined){
	clearTimeout(globals.timer.limitTimer);
	globals.timer.limitTimer = undefined;
    }
    setMouseOverLimit();
    if(!globals.timer.timer && globals.mouse.disableDialog == false) {
	if(globals.openDelay){
	    globals.timer.timer = startTimer(event, jsEvent, 1000);
	}else{
	    globals.timer.timer = startTimer(event, jsEvent, 10);
	}    
    }
}

function drawDialog(event, jsEvent) {
    globals.openDelay = false;
    var eventDiv = this;	
    if(event.job !== undefined){
	htmlForJobEventDialog(event);
    }else{
	htmlForEventDialog(event);
    }
    var editor = getEditor();
    $("#eventHover")
	.dialog( {
	dialogClass: "no-close",
	draggable: false,
	width: 300,
	minHeight: 20,
	modal: false,
	position: { my:"left bottom", at:"bottom", of:jsEvent},
	show: { effect:"fade", delay: 0, duration: 0, easing:"linear"}
	}).on('click', function() {
	    console.log('opening the box');
	    $.fancybox.open([
	       {
	       type: 'iframe',
	       href : editor+'?id='+event.id,
	       }
	   ]);
	}).css('cursor', 'pointer');
}

function startTimer(event, jsEvent, delay) {
    if(globals.timer.delayReset){
	clearTimeout(globals.timer.delayReset);
	globals.timer.delayReset = 0;
    }
    return (setTimeout(function(){   
	drawDialog(event, jsEvent);},	
    	delay));
}

function closeFancybox() {
    killDialog();
    //$.fancybox.close(true);
    window.setTimeout(function(){
	console.log('closing the box....');
	$.fancybox.close(true);
	},100);
    return true;
}

function htmlForJobEventDialog(event){
    //logToConsole(event.job, 'data');
    $("#eventTitle").html('<a href="/'+event.job.Id+'" onclick="return closeFancybox();" target="_blank">'+event.job.Name+'</a>');
    $("#eventLine3").text(event.job.Street__c);
    $("#eventLine4").text(event.job.Suburb__c+', '+event.job.State__c);
    $("#eventDescription").text('').css('border','none');
    if(event.readOnly != true){
	$("#eventLine1").text(event.job.First_Name__c+' '+event.job.Last_Name__c);
	$("#eventLine2").text(event.job.Mobile__c);
	if(event.rtDescription !== '' && event.rtDescription !== undefined){
            $("#eventDescription").html(stringToHTML(event.rtDescription)).css('border','1px solid black');
        }
    }
}

function htmlForEventDialog(event){
    $("#eventTitle").html(event.title.replace('\n','<br>'));
    $("#eventLine1").html('');
    $("#eventLine2").text('');
    $("#eventLine3").text('');
    $("#eventLine4").text('');
    //logToConsole(event, 'data');
    $("#eventDescription").html('').css('border','none');
    if(event.Description !== '' && event.Description !== undefined && event.readOnly != true){
	$("#eventDescription").text(event.Description).css('border','1px solid black');
    }
}

function setMouseOverLimit() {
    //console.log("&&");
    globals.timer.limitTimer = setTimeout(function(){
                                	//console.log("#");
                                	globals.mouse.onEvent = false;
                                	fadeDialog();
                                    }, 5000);
    
}
function setMouseOnDialog() {
    $("#eventHover").on('mouseenter', function() {
	globals.mouse.onDialog = true;
        logToConsole('mouseOnDialog', 'mouse');
    }).on('mouseleave', function() {
	logToConsole('mouseOffDialog', 'mouse');
	globals.mouse.onDialog = false;
        killDialog();
    });
}  

function stringToHTML(s) {
    if(s !== null && s !== '' && s !== undefined){
        var div = document.createElement('div');
        div.innerHTML = s;
        return div.firstChild.nodeValue;
    }
    return '';
}

function displayCalendar(){
    console.log(globals.currentUser.lastView);
    var gotoDate = moment(globals.currentUser.lastDate, "YYYY-MM-DDTHH:mm:ss.sssZ");
    console.log(gotoDate);
    
    
    $('#calendar').fullCalendar('getView').calendar.options.minTime = globals.timePeriod.dayStart;
    $('#calendar').fullCalendar('getView').calendar.options.maxTime = globals.timePeriod.dayEnd;
    console.log('change view - display calendar');
    $('#calendar').fullCalendar('changeView', globals.currentUser.lastView);
    $('#calendar').fullCalendar('gotoDate', gotoDate._d);
    console.log('here');
    $('#calendar').show().fullCalendar('render');
    $('.fl.throbber').appendTo('.fc-header-left');
    zumaMaker();
}

function setCalendarStartAndEndOfDay(user){
    logToConsole('setStartEndOfDay','notify');
    if(user.jobMap !== undefined){
	globals.timePeriod.dayStart = user.dayStart;
	globals.timePeriod.dayEnd = user.dayEnd;
    }
}

function setCalendarStartEnd(event) { //TODO find cleaner way to do this....
    var start = event.start.getHours();
    var end = event.end.getHours();
    if(event.end.getMinutes()>0){
	end = end+1
    }
    var updated = false;
    var dayStart = globals.timePeriod.dayStart;
    if(dayStart.substring(0,dayStart.indexOf(':')) > start) {
	globals.timePeriod.dayStart = start+':00';
	updated = true;
    }
    var dayEnd = globals.timePeriod.dayEnd;
    if(dayEnd.substring(0,dayEnd.indexOf(':')) < end) {
	globals.timePeriod.dayEnd = end+':00';
	updated = true;
    }
    return updated;
}

function dateFromString(s) {
    var string = s.substr(6,4)+'-'+s.substr(3,2)+'-'+s.substr(0,2)+'T';
    var hour = s.slice(s.indexOf(' ')+1,s.indexOf(':'));
    if(hour.toString().length== 1){
	string += '0';
    }
    if(s.slice(-2)=="AM"){
	 string += hour;
    }else{
	string+= (hour+12);
    }
    string+=':'+s.slice(-5,-3)+':00.000Z';
    var mom = moment(string).subtract(moment().zone()/-1, 'minutes');
    return mom;
}
function resetCalendarStartEnd(start, end) {
    var sfStart = dateFromString(start);
    var sfEnd = dateFromString(end);
    var sfEvent = {'startDateTime' : sfStart, 'endDateTime': sfEnd};
    console.log(sfEvent);
    var event = setEventStartEnd(sfEvent);
    if(setCalendarStartEnd(event)==true) {
	console.log('reload');
	globals['reset'] = true;
    }    
}    

function resetCalendar() {
    if(globals.reset){
	globals.reset = false;
	location.reload();
    }else{
	refreshOnCrud();
    }
    $('#calendar').fullCalendar('removeEvents', 'drop');
}

function isUnlocked() {
    var e = $('#calendar').fullCalendar('getView').calendar.options.editable;
    return e;
}

function eventClick (calEvent, jsEvent, view) {
    console.log('eventClick');
    if(isUnlocked()) {
        console.log(calEvent);
        if(globals.cntrlDown) {
            window.open('/'+calEvent.id);
        }else if(calEvent.id.lastIndexOf('gap',0)==0 || calEvent.id == 'drop'){
        	$.fancybox.open([
        	     {
        	        type: 'iframe',
        	        href : getEditor()+'?start='+formatDate(calEvent.start)+'&end='+formatDate(calEvent.end)+
        	        	'&res='+calEvent.resId+'&ownerName='+calEvent.title+'&jobId='+getJobId()+
        	        	'&readOnly='+calEvent.readOnly+'&tid='+calEvent.id,
        	     }
        	 ]);
        }else{
            $.fancybox.open([
                {
                    type: 'iframe',
                    href : getEditor()+'?id='+calEvent.id+'&readOnly='+calEvent.readOnly,
                }
            ]);
        }
    }
}

function jcSelect ( startDate, endDate, allDay, jsEvent, view ) {
    console.log('jcSelect');
    console.log(globals.mouse.onMonthNumber);
    if(globals.mouse.onMonthNumber==false){
        $.fancybox.open([
            {
                type: 'iframe',
                href : getEditor()+'?start='+formatDate(startDate)+'&end='+formatDate(endDate)+'&jobId='+getJobId(),
            }
        ]);
    }
}

function dayClick (date, allDay, jsEvent, view) {
    console.log('dayClick');
    console.log(globals.mouse.onMonthNumber);
    if(globals.mouse.onMonthNumber==false){
        $.fancybox.open([
            {
                type: 'iframe',
                href : getEditor()+'?start='+formatDate(date)+'&jobId='+getJobId(),
            }
        ]);
    }
}

function conflictAlert(eventToCheck, revertFunc) {
    jcEvent = globals.allEvents[eventToCheck.id];
    
    var result = checkConflict(globals.users[jcEvent.ownerId].eventList, jcEvent)
    if(result == 'conflict'){
	if(!confirm('This Event conflicts with another appointment for the same resource.\n\nPress cancel to undo changes.')){
	    revertFunc();
	    return false;
	}else{return true;}
    }else if(result == 'adjacent'){
	if(!confirm('Warning! This event is immediately adjacent to another event for the same resource.\n\nPress cancel to undo changes.')){
	    revertFunc();
	    return false;
	}else{return true;}
    }else{return true;}
    
}

function checkEndOfDayConflict(event, endOfDay){
    
    endOfDay = endOfDay === undefined ? moment(event.startDateTime).hour(globals.users[event.resId].dayEnd.substr(0,2)).minute(00):endOfDay;
    if(!moment.isMoment(endOfDay)){
	endOfDay = moment(endOfDay).locale('en-AU');
    }
    //console.log(endOfDay);
    //console.log(event);
    if(moment(event.end).isAfter(endOfDay)){
	console.log('end of day conflict');
	return true;
    }else{
	return false;
    }
}

function checkStartOfDayConflict(event, startOfDay){
    //console.log(event);
    startOfDay = startOfDay === undefined ? moment(event.startDateTime).hour(globals.users[event.resId].dayStart.substr(0,2)).minute(00):startOfDay;
    if(!moment.isMoment(startOfDay)){
	startOfDay = moment(startOfDay).locale('en-AU');
    }
    //console.log(startOfDay);
    //console.log(event);
    console.log('estart ');
    console.log(moment(event.start));
    console.log('sod ');
    console.log(startOfDay);
    if(moment(event.start).isBefore(startOfDay)){
	console.log('start of day conflict');
	return true;
    }else{
	return false;
    }
}

function checkConflict (userEvents, chkEvent) {
    var conflictFound = false;
    var msg = '';
    var adjacentFound = false;
    if(userEvents !== undefined){
        $.each(userEvents, function(i, event){
            var eventStart = event.start.getTime();
            var eventEnd = event.end!=null?event.end.getTime():eventStart;
            var jcStart;
            var jcEnd;
            if(chkEvent.start._isAMomentObject){
                jcStart = chkEvent.start.valueOf();
                jcEnd = chkEvent!=null?chkEvent.end.valueOf():jcStart;
            }else{
                jcStart = chkEvent.start.getTime();
                jcEnd = chkEvent.end!=null?chkEvent.end.getTime():jcStart;
            }
        	if(event.id != chkEvent.id){
                	//console.log('Start '+jcStart+' - '+eventStart);
            	//console.log('End '+jcEnd+' - '+eventEnd);
        			if(jcStart >= eventStart && jcStart < eventEnd){ //conflict true
        			    //console.log('conflict true');
        			    conflictFound = true;
        			    msg = '';
        			    //return false;
        			}else if(jcEnd > eventStart && jcEnd <= eventEnd){
        			    //console.log('conflict true');
        			    conflictFound = true;
        			    msg = '';
        			    //return false;
        			}else if(jcStart < eventStart && jcEnd > eventEnd){
        			    //console.log('conflict true');
        			    conflictFound = true;
        			    msg = '';
        			    //return false;
        			}else if(eventStart == jcEnd){
        			    //console.log('adjacent');
        			    adjacentFound = true;
        			    msg = '';
        			}else if(eventEnd == jcStart){
        			    //console.log('adjacent');
        			    adjacentFound = true;
        			    msg = '';
        			}
            }	
        });
        if(conflictFound){
    	return 'conflict';
        }else if(adjacentFound){
    	return 'adjacent';
        }else{
    	return 'OK';
        }
    }else return 'OK';    
}
//function findNext(dayBegin, dayEnd, duration, anyUser){
	//for each actively displayed user collect 100 next available blocks and add to ordered list(array object whatever)
	//
	//Next available is determined by not matching any of the 4 criteria  
					// 1. start of event is before start AND end of event is after start
					// 2. start of event is between start and end
					// 3. end of event is between start and end
					// 4. check startTime is in permissable hours (between dayBegin and dayEnd-duration)
	//first event to match use end of event as new start
	//if no events match add startTime and user id to a list and set new startTime as start plus duration
	
	//order list by start time
	//if any user is true create event for 1st chronological in list
	//if any user is false then for each event check other users using same rules as above
		//on return of event use next chrono event from event endTime.
		//if no match for all other active users add startTime and object of userIds to allUserList
		//use first entry in allUserList to create event with multi users pre-selected 
	 
//function getNextStartTime(event) {
//    return event.end;
//}
function toggleBttn(string) {
    //console.log('** '+$("#srchBttn").text());
    if($("#srchBttn").get(0).value == ""){
	$("#srchBttn").text(string);
    }else{
	$("#srchBttn").get(0).value=string;
    }
}
function toggleSingleBttn(string){
    if($("#singleBttn").get(0).value == ""){
	$("#singleBttn").text(string);
    }else{
	$("#singleBttn").get(0).value = string;
    }
}
function runSingleGapFinder(){
    var dur = $("#sliderValue").text();
    if(globals.gapArray === undefined){
	runGapFinder(false);
    }else{
	displayGap();
    }
}
function runGapFinder(all) {
    var dur = $("#sliderValue").text();
    if(globals.gapArray=== undefined){
        var view = $('#calendar').fullCalendar('getView');
        if(view.name == 'agendaWeek'){
    	console.log(view.name);
            var gArray = findem(dur);
            if(gArray != null && gArray.length >0){
        	globals['gapArray'] = gArray;
        	globals.gaps.slider = false;
        	console.log('all '+all);
        	if(all){
        	    displayAllGaps();
        	    toggleBttn('Remove All Gaps');
        	}else{
        	    displayGap();
        	    toggleSingleBttn('Next gap');
        	    toggleBttn('Remove Gaps');
        	}
        	
            }else{
                alert('No '+dur+' gaps found');
            }
        }else{
    	alert('Search is only available in week view');
        }
    }else{
	removeAllGaps();
	toggleBttn('Find');
    }
}

function displayAllGaps(){
    console.log('display gaps');
    $('#calendar').fullCalendar('addEventSource', gapSource);
}

function gapSource(start,end,callback){
    callback(globals.gapArray);
}
function removeAllGaps(callback){
    if(globals.gapArray !== undefined){
	$('#calendar').fullCalendar('removeEventSource', gapSource);
	globals.gapArray = undefined;
	removeGap();
    }
    if(callback){
	runGapFinder(true);
    }
}

function displayGap(){
    console.log('display gap');
    $('#calendar').fullCalendar('removeEventSource', indexedGapSource);
    indexGaps();
    $('#calendar').fullCalendar('addEventSource', indexedGapSource);
    $('#calendar').fullCalendar('refetchEvents');
    
}

function indexGaps() {
    globals.gaps.index ++; 
}

function indexedGapSource(start,end,callback){
    var index = globals.gaps.index;
    if(index >-2){
        var array = [];
        $.each(globals.gaps.gapsByUser, function(i, eventArray){
            if(eventArray.length > index){
                array.push(eventArray[index]);
            }
        });
        if(array.length > 0){
            callback(array);
        }else{
            index = -1;
            toggleSingleBttn('Incremental Find');
            alert('There are no more suggestions');
        }
    }    
}

function removeGap(callback){
    if(globals.gaps.gapsByUser !== undefined){
	$('#calendar').fullCalendar('removeEventSource', indexedGapSource);
	toggleSingleBttn("Incremental Find")
	globals.gaps.gapsByUser = {};
	globals.gaps.index = -1;
    }
    console.log(callback);
    if(callback){
	console.log('funFinder');
	removeAllGaps(true);
	runGapFinder();
    }
}

function findem(dur){
    if(dur !== undefined){
        var allGaps = [];
        var duration = moment.duration(dur);
        var users = [];
        $.each(globals.users, function(i, user){
            console.log(user.Display);
    		if(user.Display=='true'){
    		    users.push(user);
    		}
        });
        console.log(users);
        $.each(users, function(i, user){
            var array = getStartOfDayGaps(duration,user);
            globals.gaps.gapsByUser[user.Id] = array;
            if(globals.users[user.Id].eventList !== undefined){
                array = array.concat(findAvailableBeforeGaps(duration, user));
                globals.gaps.gapsByUser[user.Id] = array;
                array = array.concat(findAvailableAfterGaps(duration, user));
                globals.gaps.gapsByUser[user.Id] = array.sort(function(a, b){return a.start-b.start});
                
            }    
    	allGaps=allGaps.concat(array);
        });
        //console.log(allGaps);
        return allGaps;
    }else{
	return null;
    }
}

function isFuture(event) {
    return(moment(event.start).isAfter());
}

function checkDuplicateGaps(user, event) {
    var duplicate = false;
    $.each(globals.gaps.gapsByUser[user.Id], function(i, gapEvent){
	if(moment(event.start).isSame(moment(gapEvent.start), 'minute')){
	    duplicate = true;
	    return false;
	}
    });
    return duplicate;
}

function getStartOfDayGaps(duration, user) {
    var array = [];
    var bgCol = colorLuminance(user.Colour, -.6);
    var dayStart = globals.users[user.Id].dayStart!==undefined?globals.users[user.Id].dayStart:globals.timePeriod.hourStart;
    var i = 0;
    for(i=1;i<36;i++){
	var startDate = moment().add(i,'days').hour(dayStart.substr(0,2)).minutes(00).seconds('00').format("YYYY[-]MM[-]DD[T]hh:mm:ss[.000]Z");
	console.log(startDate);
	var aEvent = {'id':'gaps'+user.Id+i,'startDateTime':startDate, 'endDateTime':null, 'title': user.Name, 'backgroundColor': bgCol, 'borderColor': bgCol, 'textColor': '#FFFFFF',
		'resId':user.Id};
        var nEvent = setEventStartEnd(aEvent, duration);
        console.log(nEvent);
        var aResult = checkConflict(globals.users[user.Id].eventList,nEvent);
        if(aResult != 'conflict'){
            array.push(nEvent);
            console.log(nEvent);
        }
    }
    
    return array;
    
}
function findAvailableBeforeGaps( duration, user, start, end){
    console.log('find Available Before');
    //console.log(duration);
    var slots = [];
    var bgCol = colorLuminance(user.Colour, -.6);
    $.each(globals.users[user.Id].eventList,function(i, event){
	console.log(event);
	var bEvent = {'id':'gapb'+event.ownerId+i,'startDateTime':null, 'endDateTime':event.startDateTime, 'title': user.Name, 'backgroundColor': bgCol, 'borderColor': bgCol, 'textColor': '#FFFFFF',
				'resId':user.Id};
        var pEvent = setEventStartEnd(bEvent, duration);
        var bResult = checkConflict(globals.users[user.Id].eventList,pEvent);
        if(bResult != 'conflict' && !checkStartOfDayConflict(pEvent, start) && !checkEndOfDayConflict(pEvent, end) && isFuture(pEvent) && !checkDuplicateGaps(user,pEvent)){
            slots.push(pEvent);
            //console.log(pEvent);
        }
    });
    return slots;
}
function findAvailableAfterGaps( duration, user, start, end){
    console.log('find Available After');
    //console.log(duration);
    var slots = [];
    var bgCol = colorLuminance(user.Colour, -.6);
    $.each(globals.users[user.Id].eventList,function(i, event){
	//console.log(event);
	var aEvent = {'id':'gapa'+event.ownerId+i,'startDateTime':event.endDateTime, 'endDateTime':null, 'title': user.Name, 'backgroundColor': bgCol, 'borderColor': bgCol, 'textColor': '#FFFFFF',
				'resId':user.Id};
	var nEvent = setEventStartEnd(aEvent, duration);
	var aResult = checkConflict(globals.users[user.Id].eventList,nEvent);
	if(aResult != 'conflict' && !checkStartOfDayConflict(nEvent, start) && !checkEndOfDayConflict(nEvent, end) && isFuture(nEvent) && !checkDuplicateGaps(user,nEvent)){
	    slots.push(nEvent);
	    //console.log(nEvent);
	}
    });
    return slots;
}

function handleSliderChange(event, ui) {
    console.log('slider change...');
    var hour = Math.floor(ui.value);
    var min = ui.value - hour;
    min = min==0 ? "00" : min*60;
    $('#sliderValue').text(hour+':'+min+' ');
}

function handleSliderStop(event, ui) {
    if(globals.gapArray !== undefined || globals.gaps.slider){
	if(globals.gaps.index > -1) {
	    console.log('singleGap');
	    globals.gaps.slider = true;
	    removeGap(true);
	}else{
	    console.log('all gaps')
	    globals.gaps.slider = true;
	    removeAllGaps(true);
	    
	}
    }
}

function updateWorkOrder(eventId) {
    updateWO(eventId);
}

function updateLastViewed() {
    console.log('updating sticky last viewed...');
    var view = $('#calendar').fullCalendar('getView');
    var moment = $('#calendar').fullCalendar('getDate');
    setLastViewed(view.name, moment.toISOString());
    updateLastViewedAF(view.name, moment.toISOString());
}

function setLastViewed(view, date) {
    console.log('setLastViewed');
    //console.log(view);
    globals.currentUser.lastView = view;
    if(date!==undefined)globals.currentUser.lastDate = date;
}

function setLastViewedUpdateListeners() {
    console.log('setting update last viewed listeners...');
    $('.fc-header-center > .fc-button').mouseup(function(){
		setLastViewed(''+$(this).html());
		window.setTimeout(zumaMaker, 750);
		window.setTimeout(updateLastViewed, 1000);
    });
    $('.fc-header-right > .fc-button').mouseup(function(){
    	window.setTimeout(zumaMaker, 750);
    	window.setTimeout(updateLastViewed, 1000);
    });
}

function colorLuminance(hex, lum) {

	// validate hex string
	hex = String(hex).replace(/[^0-9a-f]/gi, '');
	if (hex.length < 6) {
		hex = hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2];
	}
	lum = lum || 0;

	// convert to decimal and change luminosity
	var rgb = "#", c, i;
	for (i = 0; i < 3; i++) {
		c = parseInt(hex.substr(i*2,2), 16);
		c = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16);
		rgb += ("00"+c).substr(c.length);
	}

	return rgb;
}
//zuma add in to make agenda week day headers and month numbers clickable and open agenda day view
function zumaMaker() {
    console.log('zuma Maker...');
    var view = $('#calendar').fullCalendar('getView');
    if(view.name=='agendaWeek'){
        var arrayUIDays = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
        for (var m = 0; m < arrayUIDays.length; m++) {
           var dim = ".fc-widget-header.fc-" + arrayUIDays[m]; //.fc-day-header
           var dok = $(dim).html();
           var data = [dok, dim];
           $(dim).attr("onclick", "zumaMethod('" + dok + "','" + dim + "');");
           $(dim).addClass("showHover");
        }
    }else if(view.name=='month'){
	$(".fc-day").each(function(index,item){
	    var date = $(this).attr("data-date");
	    //console.log(date);
	    var divs = $(this).children();
	    $.each(divs,function(ind,itm){
		var children = $(this).children();
        	$.each(children,function(i,ch){
        	    var clss = $(this).attr("class");
        	    //console.log(clss);
        		if(clss=="fc-day-number"){
        		    //console.log($(this));
        		    $(this).addClass("showHover");
        		    $(this).mouseover(function(){setMouseOnNumber(true)}).mouseout(function(){setMouseOnNumber(false)});
        		    $(this).attr("onmousedown", "zumaMonthMethod('" + date + "','"+view.name+"');");
        		}
        	});
	    });
	});
    }
}

function setMouseOnNumber(bool){
    //console.log(bool);
    globals.mouse.onMonthNumber = bool;
    //console.log(globals.mouse.onMonthNumber);
}

function zumaMonthMethod(date, view) {
    globals.mouse.onMonthNumber=false;
    //console.log(date);  
    var off_date = moment(date + "T00:00:00.000Z", "YYYY-MM-DDTHH:mm:ss.sssZ");
    //console.log(off_date._d);
    console.log('change view - zumaMonth');
    $("#calendar").fullCalendar('changeView', 'agendaDay');
    $("#calendar").fullCalendar('gotoDate', off_date._d);
    $(".fc-col0.fc-widget-header").css("cursor", "pointer");
    $(".fc-col0.fc-widget-header").attr("onclick", "zumaMethodRevert('"+view+"');");
    $(".fc-col0.fc-widget-header").addClass("showHover");
    updateLastViewed();
}

function zumaMethod(doma, diver) {
    //console.log(doma+' == '+diver);  
    var date = doma.split(" ")[1].split("/");
    var day = date[0];
    var month = date[1];
    var currDate = $("#calendar").fullCalendar('getDate');
    var year = currDate.getFullYear();
    var off_date = moment(year + "-" + month + "-" + day + "T00:00:00.000Z", "YYYY-MM-DDTHH:mm:ss.sssZ");
    //console.log(off_date._d);
    console.log('change view - zumaMethod');
    $("#calendar").fullCalendar('changeView', 'agendaDay');
    $("#calendar").fullCalendar('gotoDate', off_date._d);
    $(diver).css("cursor", "pointer");
    $(diver).attr("onclick", "zumaMethodRevert('week');");
    $(diver).addClass("showHover");
    updateLastViewed();
}

function zumaMethodRevert(view) {
    console.log('revert...');
    if(view=='week'){
	console.log('change view - revert');
	$("#calendar").fullCalendar('changeView', 'agendaWeek');
    }else if(view=='month'){
	console.log('change view - revert');
	$("#calendar").fullCalendar('changeView', 'month');
    }
    updateLastViewed();
    zumaMaker();
}
   
function removeEventFromView(id) {
	console.log('removing id..... ');
	console.log(id);
	if(id == 'drop'){
	    $('#calendar').fullCalendar('removeEvents','drop');
	    
	}else if(id.lastIndexOf('gap',0)==0 ) {
	    $('#calendar').fullCalendar('removeEvents',id);
	}
	console.log(globals.gapArray);
	console.log(globals.gaps);
    	if(globals.gapArray!== undefined){
    	    $.each(globals.gapArray,function(i,event) {
    		if(event.id == id){
    		    globals.gapArray.splice(i,1);
    		}
    	    });
    	}
    	if(globals.gaps!==undefined){
    	    $.each(globals.gaps,function(i,array) {
    		$.each(array,function(n,event) {
    		    if(event.id == id){
    			globals.gaps[i].splice(n,1);
    		    }
    		});
    	    });
    	}
	
}

