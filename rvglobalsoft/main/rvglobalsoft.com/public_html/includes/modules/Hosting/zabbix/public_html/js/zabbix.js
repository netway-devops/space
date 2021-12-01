var action = "view";
var aTrafficNetwork = {};
var aDiscovery = {};
var aMedia = {};

(function(jQuery) {
	
	 $.zabbix = {};
	 
	 $.zabbix.init = function() {
		 $.zabbix.makeUi();
		 $.zabbix.makeEvent();
	 };
	 
	 $.zabbix.makeUi = function() {
		 $.zabbix.makeUiTrafficBandwidthSlider();
		 
		 //$.zabbix.makeUiSwitchDiscoveryUpDown();
		 //$.zabbix.makeUiSwitchDiscoveryDownDelay();
		 //$.zabbix.makeUiSwitchDiscoveryUpDelay();
		 //$.zabbix.makeUiSwitchNetworkTrafficTrigger()
		 
		 $.zabbix.makeUiInlineDiscoveryMedia();
	 };

	 $.zabbix.makeEvent = function() {
		 $.zabbix.makeEventView();
		 /*$.zabbix.makeEventDoViewDiscoveryIp();*/ // Onclick
		 
		 $.zabbix.makeEventSwitchDiscoveryUpDown();
		 $.zabbix.makeEventInputDiscoveryUpDown();
		 $.zabbix.makeEventSwitchDiscoveryDownDelay();
		 $.zabbix.makeEventInputDiscoveryDownDelay();
		 $.zabbix.makeEventSwitchDiscoveryUpDelay();
		 $.zabbix.makeEventInputDiscoveryUpDelay();
		 
		 /*$.zabbix.makeEventInlineEdit();*/ // Onclick
		 $.zabbix.makeEventAddRowDiscoverMedia();
		 $.zabbix.makeEventAddRowNetworkTrafficMediaAdmin();
		 /*$.zabbix.makeEventRemoveRowDiscoverMedia();*/ //Onclick
		 /* $.zabbix.makeEventAddDiscoverMedia();*/ //Inline Edit
		 /* makeEventAddNetworkTrafficMediaAdmin() */ //Inline Edit
		 
		 /*$.zabbix.makeEventTrafficBandwidthGraph();*/ // Change Slide
		 /*$.zabbix.makeEventTrafficNetworkSelectHost();*/ // Onchange
		 
		 /* $.zabbix.makeEventViewTrafficBandwidth();*/ // Widgets
		 /* $.zabbix.makeEventViewDiscovery();*/ // Widgets
		 
		 $.zabbix.makeEventDoViewNetworkTrafficTrigger("network-traffic-trigger-list-name-0"); // Onclick
		 $.zabbix.makeEventSwitchNetworkTrafficTrigger();
		 
	 };
	 	 
	 $.zabbix.makeUiTrafficBandwidthSlider = function() {
		
		 $( "#traffic-bandwidth-slider" ).slider({
		      value: 1,
		      min: 1,
		      max: 90,
		      step: 1,
		      slide: function( event, ui ) {
		        $("#traffic-bandwidth-display-value-slider").html("History Traffic Bandwidth: " +ui.value + " days");
		      },
		      change: function(event, ui) { 
		    	  //alert("value = " + ui.value);
		    	  $.zabbix.makeEventTrafficBandwidthGraph();
		      }
		    });
		 
		    $("#traffic-bandwidth-display-value-slider").html("History Traffic Bandwidth: " + $("#traffic-bandwidth-slider").slider("value") + " days");
	 };
	 
	 $.zabbix.makeUiSwitchDiscoveryUpDown = function() {
		 $("#zabbix-switch-discovery-up-down").iButton("destroy");
		 $("#zabbix-switch-discovery-up-down").iButton();
	 };
	 
	 $.zabbix.makeUiSwitchDiscoveryDownDelay = function() {
		 $("#zabbix-switch-discovery-down-delay").iButton("destroy");
		 $("#zabbix-switch-discovery-down-delay").iButton();
	 };
	 
	 $.zabbix.makeUiSwitchDiscoveryUpDelay = function() {
		 $("#zabbix-switch-discovery-up-delay").iButton("destroy");
		 $("#zabbix-switch-discovery-up-delay").iButton();
	 }; 
	 
	 $.zabbix.makeUiSwitchNetworkTrafficTrigger = function() {
		 $("#zabbix-switch-network-traffic-trigger").iButton("destroy");
		 $("#zabbix-switch-network-traffic-trigger").iButton();
	 }; 
	 
	 $.zabbix.makeUiInlineDiscoveryMedia = function() {
		 /*$('#discovery-media-table').dynoTable({
				 addRowButtonId: '#add-row-discovery-media',
				 onRowRemove: function() {
			 			// this.currentObj.find("p").text()
		 		 }
		 });*/
	 };
	 
	 $.zabbix.makeEventSwitchNetworkTrafficTrigger = function() {
		 
		  
		 $("#zabbix-switch-network-traffic-trigger").change(function () {
			 
			 status = "0";
			 
			 if ($(this).is(':checked') == true) {
				 //$("#zabbix-switch-network-traffic-trigger-bytes-value").attr("disabled", false);
				 //$("#zabbix-switch-network-traffic-items-delay-value").attr("disabled", false);
				 
				 // TODO
				 $("#zabbix-switch-network-traffic-trigger-bytes-select").prop({
					  "disabled": false
				 });
				 $("#zabbix-switch-network-traffic-items-delay-select").prop({
					  "disabled": false
				 });
				 
				 status = "0";
			 } else {
				 //$("#zabbix-switch-network-traffic-trigger-bytes-value").attr("disabled", true);
				 //$("#zabbix-switch-network-traffic-items-delay-value").attr("disabled", true);
				 
				// TODO
				 $("#zabbix-switch-network-traffic-trigger-bytes-select").prop({
					  "disabled": true
				 });
				 $("#zabbix-switch-network-traffic-items-delay-select").prop({
					  "disabled": true
				 });
				 
				 status = "1";
			 }
			 
			 
			 var attrId = $("#network-traffic-trigger-info-hidden").val();
			 var attrExpression = $("#" + attrId).attr("attrExpression");
			 var expression = attrExpression.replace(/}(.*)$/g, "");
			 //var triggerByte = $("#zabbix-switch-network-traffic-trigger-bytes-value").val();
			 var triggerByte = $("#zabbix-switch-network-traffic-trigger-bytes-select").val();
			 expression += "}>" + triggerByte;
			 
			
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doNetworkTrafficTrigger",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 target: "on-off",
					 triggerId: $("#" + attrId).attr("attrTriggerId"),
					 itemId: $("#" + attrId).attr("attrItemId"),
					 status: status,
					 //triggerByte: $("#zabbix-switch-network-traffic-trigger-bytes-value").val(),
					 //itemDelay: $("#zabbix-switch-network-traffic-items-delay-value").val(),
					 triggerByte: $("#zabbix-switch-network-traffic-trigger-bytes-select").val(),
					 itemDelay: $("#zabbix-switch-network-traffic-items-delay-select").val(),
					 expression: expression
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
				    	  	 if (status == "0") {
								 $("#" + attrId).attr("attrTriggerStatus", "0");
							 } else {
								 $("#" + attrId).attr("attrTriggerStatus", "1");
							 }
							 
				    	  	 //$("#" + attrId).attr("attrTriggerByte", $("#zabbix-switch-network-traffic-trigger-bytes-value").val());
							 //$("#" + attrId).attr("attrItemDelay", $("#zabbix-switch-network-traffic-items-delay-value").val());
							 
							 $("#" + attrId).attr("attrTriggerByte", $("#zabbix-switch-network-traffic-trigger-bytes-select").val());
							 $("#" + attrId).attr("attrItemDelay", $("#zabbix-switch-network-traffic-items-delay-select").val());
							 
			          }
			       }
			});
			 
			 
			 
		 });
		 
		 
		 
		 
		 
		 
		 //$("#zabbix-switch-network-traffic-trigger-bytes-value").change(function () {
		 $("#zabbix-switch-network-traffic-trigger-bytes-select").change(function () {	 
			 
			 status = "0";
			 
			 if ($("#zabbix-switch-network-traffic-trigger").is(':checked') == true) {
				 //$("#zabbix-switch-network-traffic-trigger-bytes-value").attr("disabled", false);
				 //$("#zabbix-switch-network-traffic-items-delay-value").attr("disabled", false);
				 
				// TODO
				 $("#zabbix-switch-network-traffic-trigger-bytes-select").prop({
					  "disabled": false
				 });
				 $("#zabbix-switch-network-traffic-items-delay-select").prop({
					  "disabled": false
				 });
				 
				 status = "0";
			 } else {
				 //$("#zabbix-switch-network-traffic-trigger-bytes-value").attr("disabled", true);
				 //$("#zabbix-switch-network-traffic-items-delay-value").attr("disabled", true);
				 
				 $("#zabbix-switch-network-traffic-trigger-bytes-select").prop({
					  "disabled": true
				 });
				 $("#zabbix-switch-network-traffic-items-delay-select").prop({
					  "disabled": true
				 });
				 
				 status = "1";
			 }
			 
			 
			 var attrId = $("#network-traffic-trigger-info-hidden").val();
			 var attrExpression = $("#" + attrId).attr("attrExpression");
			 var expression = attrExpression.replace(/}(.*)$/g, "");
			 //var triggerByte = $("#zabbix-switch-network-traffic-trigger-bytes-value").val();
			 var triggerByte = $("#zabbix-switch-network-traffic-trigger-bytes-select").val();
			 expression += "}>" + triggerByte;
			 
			
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doNetworkTrafficTrigger",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 target: "triggerExpression",
					 triggerId: $("#" + attrId).attr("attrTriggerId"),
					 itemId: $("#" + attrId).attr("attrItemId"),
					 status: status,
					 //triggerByte: $("#zabbix-switch-network-traffic-trigger-bytes-value").val(),
					 //itemDelay: $("#zabbix-switch-network-traffic-items-delay-value").val(),
					 triggerByte: $("#zabbix-switch-network-traffic-trigger-bytes-select").val(),
					 itemDelay: $("#zabbix-switch-network-traffic-items-delay-select").val(),
					 expression: expression
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
				    	  	 if (status == "0") {
								 $("#" + attrId).attr("attrTriggerStatus", "0");
							 } else {
								 $("#" + attrId).attr("attrTriggerStatus", "1");
							 }
				    	  	 
							 //$("#" + attrId).attr("attrTriggerByte", $("#zabbix-switch-network-traffic-trigger-bytes-value").val());
							 //$("#" + attrId).attr("attrItemDelay", $("#zabbix-switch-network-traffic-items-delay-value").val());
							 
				    	  	$("#" + attrId).attr("attrTriggerByte", $("#zabbix-switch-network-traffic-trigger-bytes-select").val());
							$("#" + attrId).attr("attrItemDelay", $("#zabbix-switch-network-traffic-items-delay-select").val());
							 
			          }
			       }
			});
			 
			 
			 
			 
		 });	
		 
		 
		 
		 
		 
		 
		 //$("#zabbix-switch-network-traffic-items-delay-value").change(function () {
		 $("#zabbix-switch-network-traffic-items-delay-select").change(function () { 
			 
			 status = "0";
			 
			 if ($("#zabbix-switch-network-traffic-trigger").is(':checked') == true) {
				 //$("#zabbix-switch-network-traffic-trigger-bytes-value").attr("disabled", false);
				 //$("#zabbix-switch-network-traffic-items-delay-value").attr("disabled", false);
				 
				 $("#zabbix-switch-network-traffic-trigger-bytes-select").prop({
					  "disabled": false
				 });
				 $("#zabbix-switch-network-traffic-items-delay-select").prop({
					  "disabled": false
				 });
				 
				 status = "0";
			 } else {
				 //$("#zabbix-switch-network-traffic-trigger-bytes-value").attr("disabled", true);
				 //$("#zabbix-switch-network-traffic-items-delay-value").attr("disabled", true);
				 
				 $("#zabbix-switch-network-traffic-trigger-bytes-select").prop({
					  "disabled": true
				 });
				 $("#zabbix-switch-network-traffic-items-delay-select").prop({
					  "disabled": true
				 });
				 
				 status = "1";
			 }
			 
			 
			 var attrId = $("#network-traffic-trigger-info-hidden").val();
			 var attrExpression = $("#" + attrId).attr("attrExpression");
			 var expression = attrExpression.replace(/}(.*)$/g, "");
			 //var triggerByte = $("#zabbix-switch-network-traffic-trigger-bytes-value").val();
			 var triggerByte = $("#zabbix-switch-network-traffic-trigger-bytes-select").val();
			 expression += "}>" + triggerByte;
			 
			
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doNetworkTrafficTrigger",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 target: "itemDelay",
					 triggerId: $("#" + attrId).attr("attrTriggerId"),
					 itemId: $("#" + attrId).attr("attrItemId"),
					 status: status,
					 //triggerByte: $("#zabbix-switch-network-traffic-trigger-bytes-value").val(),
					 //itemDelay: $("#zabbix-switch-network-traffic-items-delay-value").val(),
					 triggerByte: $("#zabbix-switch-network-traffic-trigger-bytes-select").val(),
					 itemDelay: $("#zabbix-switch-network-traffic-items-delay-select").val(),
					 expression: expression
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
				    	  	if (status == "0") {
								 $("#" + attrId).attr("attrTriggerStatus", "0");
							 } else {
								 $("#" + attrId).attr("attrTriggerStatus", "1");
							 }
				    	  	
							 //$("#" + attrId).attr("attrTriggerByte", $("#zabbix-switch-network-traffic-trigger-bytes-value").val());
							 //$("#" + attrId).attr("attrItemDelay", $("#zabbix-switch-network-traffic-items-delay-value").val());
							 
				    	  	$("#" + attrId).attr("attrTriggerByte", $("#zabbix-switch-network-traffic-trigger-bytes-select").val());
							$("#" + attrId).attr("attrItemDelay", $("#zabbix-switch-network-traffic-items-delay-select").val());
							 
			          }
			       }
			});
			 
			 			 
			 
			 
		 });	
		 
		 
		 
		 
		 
	 };
	 
	 
	 $.zabbix.makeEventDoViewNetworkTrafficTrigger = function(id) {
		
		 var attrTriggerStatus = $("#" + id).attr("attrTriggerStatus");
		 var attrTriggerByte = $("#" + id).attr("attrTriggerByte");
		 var attrItemDelay = $("#" + id).attr("attrItemDelay");
		 var attrId = $("#" + id).attr("attrId");
		 
		 $("#container-zabbix-switch-network-traffic").show();
		 $("#network-traffic-trigger-info-hidden").val(attrId);
		 
		 //$("#zabbix-switch-network-traffic-trigger-bytes-value").val(attrTriggerByte);
		 //$("#zabbix-switch-network-traffic-items-delay-value").val(attrItemDelay);
		 
		 // TODO
		 $("#zabbix-switch-network-traffic-trigger-bytes-select option[value='" + attrTriggerByte + "']").prop({
			  "selected": "selected"
		 });
		 $("#zabbix-switch-network-traffic-items-delay-select option[value='" + attrItemDelay + "']").prop({
			  "selected": "selected"
		 });
		 
		 // Current Display Trigger
		 var attrTriggerDesc = $("#" + id).attr("attrTriggerDesc");
		 $("#zabbix-network-traffic-display-current-trigger").html(attrTriggerDesc);
		 
		 if (attrTriggerStatus == "0" || attrTriggerStatus == 0) {
			 // On
			 //$("#zabbix-switch-network-traffic-trigger").attr("checked", true);
			 $("#zabbix-switch-network-traffic-trigger").prop({
				  "checked": true
			 });
			 
			 //$("#zabbix-switch-network-traffic-trigger-bytes-value").attr("disabled", false);
			 //$("#zabbix-switch-network-traffic-items-delay-value").attr("disabled", false);
			 
			 // TODO
			 $("#zabbix-switch-network-traffic-trigger-bytes-select").prop({
				  "disabled": false
			 });
			 $("#zabbix-switch-network-traffic-items-delay-select").prop({
				  "disabled": false
			 });
			 
		 } else {
			 // Off
			 //$("#zabbix-switch-network-traffic-trigger").attr("checked", false);
			 $("#zabbix-switch-network-traffic-trigger").prop({
				  "checked": false
			 });
			 
			 //$("#zabbix-switch-network-traffic-trigger-bytes-value").attr("disabled", true);
			 //$("#zabbix-switch-network-traffic-items-delay-value").attr("disabled", true);
			 
			 
			// TODO
			 $("#zabbix-switch-network-traffic-trigger-bytes-select").prop({
				  "disabled": true
			 });
			 $("#zabbix-switch-network-traffic-items-delay-select").prop({
				  "disabled": true
			 });
			 
		 }
		 
		 
		 $.zabbix.makeUiSwitchNetworkTrafficTrigger();
	 };
	 
	 
	 $.zabbix.makeEventTrafficNetworkSelectHost = function() {
		 
		 var hostId = $("#traffic-bandwidth-select-host").val();
		 i = 0;
		 $('#traffic-bandwidth-select-graph').html("");
		 jQuery.each(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["GraphId"][hostId], function(key, values) {

			if (i == 0) {
	 			$('#traffic-bandwidth-select-graph').append($('<option>', { value : values }).text(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["GraphName"][hostId][key]));
	 			$("#traffic-bandwidth-select-graph option[value='" + values + "']").attr("selected","selected");
	 		 } else {
	 			$('#traffic-bandwidth-select-graph').append($('<option>', { value : values }).text(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["GraphName"][hostId][key])); 
	 		 }
			
		 		 
		 	     
		 		 i++;
		 });
		 if (i>0) {
		 	$("#traffic-bandwidth-select-graph-display").show();
		 }
		 
		 
		 $.zabbix.makeEventTrafficBandwidthGraph();
	 }
	 
	 $.zabbix.makeEventViewTrafficBandwidth = function() {
		 
		 $.getJSON("?cmd=zabbix&action=viewTrafficNetwork", {
			 
			 accountId: $("#account-id").val(),
			 serverId: $("#server-id").val(),
			 hostId: $("#traffic-bandwidth-select-host").val(),
			 hostName: $("#traffic-bandwidth-select-host").text(),
			 graphId: $("#traffic-bandwidth-select-graph").val(),
			 period : $("#traffic-bandwidth-slider").slider("value")
				 
			 
		 }, function(data) {
			 
				 json = data.aResponse;
				 
				 jQuery.each(json, function(preViewAs) {
					 
					 $.zabbix.validatePreviewAs(json, preViewAs);
					 
				 });
				 
				 $.zabbix.makeEventTrafficBandwidthGraph();
				 
				 
		});
		 
		 
	 };
	 
	 $.zabbix.makeEventTrafficBandwidthGraph = function() {
		 
		 var api_call = {
				 cmd	: "zabbix",
				 action: "doTrafficBandwidthGraph",
				 
				 accountId: $("#account-id").val(),
				 serverId: $("#server-id").val(),
				 hostId: $("#traffic-bandwidth-select-host").val(),
				 hostName: $("#traffic-bandwidth-select-host").text(),
				 graphId: $("#traffic-bandwidth-select-graph").val(),
				 period : $("#traffic-bandwidth-slider").slider("value")
		 };
		 
		 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
		      waitDialog: function() {},
		      callback: {
		          /*doError: function(data) {
		          },*/
		          doSuccess: function(data) {
				    	try {
				    		 jQuery.each(data, function(preViewAs) {
								 $.zabbix.validatePreviewAs(data, preViewAs);
							 });
				  	 	} catch (e) {
				  			// Handle exception
				  		}
		          }
		       }
		});
		 
		 
	 };
	 
	 
	 $.zabbix.makeEventAddNetworkTrafficMediaAdmin = function($$) {
		 
		 attrStatus = $$.attr("attrStatus");
		 emailName = $$.text();
		 
		 if (attrStatus == "add") {
			 
			 
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doNetworkTrafficMediaAdmin",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 status: "add",
					 emailName: emailName
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
			    	  		$$.attr("attrStatus", "edit");
			    	  		$$.attr("attrMediaId", data.mediaid);
			          }
			       }
			});
			 
			 
			 
		 } else if (attrStatus== "edit") {
						 
			 attrMediaId = $$.attr("attrMediaId");
			 
			 if (attrMediaId == "") {
				 alert("media id missing");
			 } else {
				 
				 
				 var api_call = {
						 cmd	: "zabbix",
						 action: "doNetworkTrafficMediaAdmin",
						 
						 accountId: $("#account-id").val(),
						 serverId: $("#server-id").val(),
						 status: "edit",
						 emailName: emailName,
						 mediaId: attrMediaId
				 };
				 
				 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
				      waitDialog: function() {},
				      callback: {
				          /*doError: function(data) {
				          },*/
				          doSuccess: function(data) {
				          }
				       }
				});
				 
				 
			 }
			 
		 }
		 
	 }
	 
	 
	 $.zabbix.makeEventAddDiscoverMedia = function($$) {
		 
		 attrStatus = $$.attr("attrStatus");
		 emailName = $$.text();
		 
		 if (attrStatus == "add") {
			 
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doDiscoveryMedia",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 status: "add",
					 emailName: emailName
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
			    	  		$$.attr("attrStatus", "edit");
							$$.attr("attrMediaId", data.mediaid);
			          }
			       }
			});
			 
			 
		 } else if (attrStatus== "edit") {
			 
			 attrMediaId = $$.attr("attrMediaId");
			 
			 if (attrMediaId == "") {
				 $.zabbix.raiseError("media id missing");
			 } else {
				 
				 var api_call = {
						 cmd	: "zabbix",
						 action: "doDiscoveryMedia",
						 
						 accountId: $("#account-id").val(),
						 serverId: $("#server-id").val(),
						 status: "edit",
						 emailName: emailName,
						 mediaId: attrMediaId
				 };
				 
				 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
				      waitDialog: function() {},
				      callback: {
				          /*doError: function(data) {
				          },*/
				          doSuccess: function(data) {
				          }
				       }
				});
				 
				 
			 }
			 
		 }
		 
	 }
	 
	 
	 $.zabbix.makeEventRemoveRowNetworkTrafficMedia = function($$) {
		 
		 attrNum = $$.attr("attrNum");
		 attrMediaId = $("#inline-edit-traffic-bandwidth-media-" + attrNum).attr("attrMediaId");
		 emailName = $("#inline-edit-traffic-bandwidth-media-" + attrNum).text();
		 
		 if (!confirm('Are you sure?')) {
		        return false;
		 }
		 		 
		 if (attrMediaId == "") {
			 $("table#traffic-bandwidth-media-admin-table tr#tr-traffic-bandwidth-" + attrNum).remove();
		 } else {
			 
			 
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doNetworkTrafficMediaAdmin",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 status: "delete",
					 emailName: emailName
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
			    	  		$("table#traffic-bandwidth-media-admin-table tr#tr-traffic-bandwidth-" + attrNum).remove();
			          }
			       }
			});
			 
			 
			 
			 
		 }
		 
 };
	 
	 
	 $.zabbix.makeEventRemoveRowDiscoverMedia = function($$) {
		 
			 attrNum = $$.attr("attrNum");
			 attrMediaId = $("#inline-edit-discovery-media-" + attrNum).attr("attrMediaId");
			 emailName = $("#inline-edit-discovery-media-" + attrNum).text();
			 
			 
			 if (!confirm('Are you sure?')) {
				 return false;
			}
			 
			 
			 if (attrMediaId == "") {
				 $("table#discovery-media-table tr#tr-discovery-" + attrNum).remove();
			 } else {
				 
				 
				 var api_call = {
						 cmd	: "zabbix",
						 action: "doDiscoveryMedia",
						 
						 accountId: $("#account-id").val(),
						 serverId: $("#server-id").val(),
						 status: "delete",
						 emailName: emailName
				 };
				 
				 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
				      waitDialog: function() {},
				      callback: {
				          /*doError: function(data) {
				          },*/
				          doSuccess: function(data) {
				    	  		$("table#discovery-media-table tr#tr-discovery-" + attrNum).remove();
				          }
				       }
				});
				 
				 
			 }
			 
	 };
	 
	 
	 
	 $.zabbix.makeEventAddRowNetworkTrafficMediaAdmin = function() {
		 
		 $("#add-row-traffic-bandwidth-media-admin").click(function () {
			 
			 countRow = 0;
			 $('#traffic-bandwidth-media-admin-table tr').each(function() {
				 countRow++;
			 });
			 
			 html = "<tr id=\"tr-traffic-bandwidth-" + countRow + "\">";
			 html += "<td align=\"left\" valign=\"top\" class=\"bg\">";
		     html += "<p id=\"inline-edit-traffic-bandwidth-media-" + countRow + "\" attrMediaId=\"\" class=\"inline-edit-traffic-bandwidth-media-class edit\" attrStatus=\"add\" onclick=\"$.zabbix.makeEventInlineEdit($(this), 'makeEventAddNetworkTrafficMediaAdmin');\">Edit here..</p>";
			 html += "</td>";
			 html += "<td align=\"center\" valign=\"top\" class=\"bg\">";
			 html += "<img class=\"traffic-bandwidth-remove-media\" id=\"traffic-bandwidth-discovery-remove-media-" + countRow + "\" attrNum=\"" + countRow + "\" src=\"" + system_url + "includes/modules/Hosting/zabbix/public_html/images/delete.gif\" alt=\"Remove Row\" onclick=\"$.zabbix.makeEventRemoveRowNetworkTrafficMedia($(this));\"/>";
		     html += "</td>";
		     html += "</tr>";
		     
		     
		     // TODO if not tr:last
			 $('#traffic-bandwidth-media-admin-table tr:last').after(html);
			 
			 
		 });
		 
	 };
	 
	 
	 
	 $.zabbix.makeEventAddRowDiscoverMedia = function() {
		 
		 $("#add-row-discovery-media").click(function () {
			 
			 countRow = 0;
			 $('#discovery-media-table tr').each(function() {
				 countRow++;
			 });
			 
			 html = "<tr id=\"tr-discovery-" + countRow + "\">";
			 html += "<td align=\"left\" valign=\"top\" class=\"bg\">";
		     html += "<p id=\"inline-edit-discovery-media-" + countRow + "\" attrMediaId=\"\" class=\"inline-edit-discovery-media-class edit\" attrStatus=\"add\" onclick=\"$.zabbix.makeEventInlineEdit($(this), 'makeEventAddDiscoverMedia');\">Edit here..</p>";
			 html += "</td>";
			 html += "<td align=\"center\" valign=\"top\" class=\"bg\">";
			 html += "<img class=\"discovery-remove-media\" id=\"discovery-remove-media-" + countRow + "\" attrNum=\"" + countRow + "\" src=\"" + system_url + "includes/modules/Hosting/zabbix/public_html/images/delete.gif\" alt=\"Remove Row\" onclick=\"$.zabbix.makeEventRemoveRowDiscoverMedia($(this));\"/>";
		     html += "</td>";
		     html += "</tr>";
		     
		     
		     // TODO if not tr:last
			 $('#discovery-media-table tr:last').after(html);
			 
			 
		 });
		 
	 };
	 
	 
	 $.zabbix.makeEventView = function() {
		 
		 /*var api_call = {
				cmd    : "zabbix",
				action : "doView"
		 };*/
		 
		 $.getJSON("?cmd=zabbix&action=view", {
			 
			 accountId: $("#account-id").val(),
			 serverId: $("#server-id").val(),
			 hostId: $("#traffic-bandwidth-select-host").val(),
			 hostName: $("#traffic-bandwidth-select-host option:selected").text(),
			 graphId: $("#traffic-bandwidth-select-graph").val(),
			 period : $("#traffic-bandwidth-slider").slider("value")
				 
			 
		 }, function(data) {
			 
			 json = data.aResponse;
			 
			 jQuery.each(json, function(preViewAs) {
				 
				 $.zabbix.validatePreviewAs(json, preViewAs);
				 
			 });
			 
			 $.zabbix.makeEventTrafficBandwidthGraph();
			 
		 });
		 
	 };
	 
	 
	 $.zabbix.makeEventViewDiscovery = function() {
		 
		 /*var api_call = {
				cmd    : "zabbix",
				action : "doView"
		 };*/
		 
		 $.getJSON("?cmd=zabbix&action=viewDiscovery", {
			 
			 accountId: $("#account-id").val(),
			 serverId: $("#server-id").val()
				 
			 
		 }, function(data) {
			 
			 json = data.aResponse;
			 
			 jQuery.each(json, function(preViewAs) {
				 
				 $.zabbix.validatePreviewAs(json, preViewAs);
				 
			 });
			 
			 
		 });
		 
	 };
	 
	  
	 
	 $.zabbix.makeEventDoViewDiscoveryIp = function(ip) {
		 
		 var api_call = {
				 cmd	: "zabbix",
				 action: "doViewDiscoveryIp",
				 
				 accountId: $("#account-id").val(),
				 serverId: $("#server-id").val(),
				 ip: ip
		 };
		 
		 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
		      waitDialog: function() {},
		      callback: {
		          /*doError: function(data) {
		          },*/
		          doSuccess: function(data) {
					 jQuery.each(data, function(preViewAs) {
						 $.zabbix.validatePreviewAs(data, preViewAs);
					 });
					 $("#zabbix-discovery-display-current-ip").html("Discovery Rule IP " + ip);
					 
		          }
		       }
		});
		
		 
	 };
	 
	 
	 $.zabbix.validatePreviewAs = function(json, preViewAs) {
		 
		 action = json.action;
		 
		 switch(preViewAs) {
			 case 'traffic_network':
				 		$.zabbix.setVarTrafficNetwork(json);
				 		$.zabbix.setCssTrafficNetwork();
			   break;
			 case 'discovery':
				 		$.zabbix.setVarDiscovery(json);
				 		$.zabbix.setCssDiscovery();
			   break;
			 /*case 'media':
				 		$.zabbix.setVarMedia(json);
				 		$.zabbix.setCssMedia();
			 default: */
				break;
		 }
		 
	 };
	 
	 $.zabbix.setVarTrafficNetwork = function(json) {
		 try {
		 	jQuery.each(json.traffic_network, function(key, value) {
		 			aTrafficNetwork[key] = value;
             });
	 	} catch (e) {
			// Handle exception
		}
	 };
	 
	 $.zabbix.setVarDiscovery = function(json) {
		 try {
		 		jQuery.each(json.discovery, function(key, value) {
	                //alert(key + ': ' + value);
		 			aDiscovery[key] = value;
             });
	 	} catch (e) {
	 		// Handle exception
		}
	 };
	 
	 $.zabbix.setVarMedia = function(json) {
		 try {
		 	jQuery.each(json.media, function(key, value) {
		 			aMedia[key] = value;
             });
	 	} catch (e) {
			// Handle exception
		}
	 };

	 $.zabbix.setCssTrafficNetwork = function() {
		 
		 	setTimeout(function() {
			 
				 var cache_fix = "?cache_fix=" + new Date().getTime()
				 var urlImage = "<img id='traffic-bandwidth-history-image' src='" + system_url + aTrafficNetwork["traffic_banwidth_img"] + cache_fix + "' />";
				 
				 var width = $("#traffic-bandwidth-history-image").width();
				 var height = $("#traffic-bandwidth-history-image").height();
				 
				 if (width == null || width < 866) {
					 width = 866;
				 }
				 
				 if (height == null || height < 326) {
					 height = 326;
				 }
				 
				 $('#traffic-bandwidth-display-graph').css({
					 	'width' : width +  "px",
				    	'height' : height + "px"
				 });
			 	
			 	$("#traffic-bandwidth-display-graph").html(urlImage);
			 
			 }, 1000);
			 

		 	//if (action == "view") {
		 		
		 		//var hostId = null;
		 		
		 		
				 	// Set Select Host
				 	var i = 0;
				 	var select = ($("#traffic-bandwidth-select-host").val() == null) ? true : false; 
				 	
				 	//$('#traffic-bandwidth-select-host').html("");
				 	//TODO aTrafficNetwork.traffic_banwidth_select_host_and_graph is undefined
				 	
				 	/*if (aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["hostId"] != undefined 
				 		&& aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["hostId"] != null) {*/
				 	
				 	if (aTrafficNetwork.traffic_banwidth_select_host_and_graph.hostId != undefined 
					 		&& aTrafficNetwork.traffic_banwidth_select_host_and_graph.hostId != null) {
				 	
					 	jQuery.each(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["hostId"], function(key, values) {
					 		
					 		 if (select == true) {
					 			 
					 			if (i == 0) {
					 				//$('#traffic-bandwidth-select-host').append($('<option>', { value : values }).text(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["hostName"][key]).attr("selected","selected"));
					 				$('#traffic-bandwidth-select-host').append($('<option>', { value : values }).text(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["hostName"][key]));
					 				$("#traffic-bandwidth-select-host option[value='" + values + "']").attr("selected","selected");
						 			//hostId = values;
					 			} else {
					 				$('#traffic-bandwidth-select-host').append($('<option>', { value : values }).text(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["hostName"][key]));
					 			} 
					 			
					 		 }
					 		
					 	     
					 		 i++;
					 	});
				 	
				 	}
				 	
				 	if (i>0) {
				 		$("#traffic-bandwidth-select-host-display").show();
				 	}
				 	
			 	
				
		 		// Set Select Graph
			 	i=0;
			 	//$("#traffic-bandwidth-select-graph").html("");
			 	/*hostId = ($("#traffic-bandwidth-select-host").val() != null) 
			 						? $("#traffic-bandwidth-select-host").val()
			 						: hostId;*/
			 	var hostId = $("#traffic-bandwidth-select-host").val();
			 	
			 	/*if (aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["GraphId"][hostId] != undefined
			 		&& aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["GraphId"][hostId] != null) {*/
			 	
			 	if (aTrafficNetwork.traffic_banwidth_select_host_and_graph.GraphId != undefined
				 		&& aTrafficNetwork.traffic_banwidth_select_host_and_graph.GraphId != null) {
			 	
				 	jQuery.each(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["GraphId"][hostId], function(key, values) {
				 		
				 		
				 		 if (select == true) {
				 			if (i == 0) {
					 			//$('#traffic-bandwidth-select-graph').append($('<option>', { value : values }).text(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["GraphName"][hostId][key]).attr("selected","selected"));
					 			$('#traffic-bandwidth-select-graph').append($('<option>', { value : values }).text(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["GraphName"][hostId][key]));
					 			$("#traffic-bandwidth-select-graph option[value='" + values + "']").attr("selected","selected");
					 		 } else {
					 			$('#traffic-bandwidth-select-graph').append($('<option>', { value : values }).text(aTrafficNetwork["traffic_banwidth_select_host_and_graph"]["GraphName"][hostId][key])); 
					 		 }
				 		 }
				 		 
				 	     
				 		 i++;
				 	});
			 	
			 	}
			 	
			 	
			 	if (i>0) {
			 		$("#traffic-bandwidth-select-graph-display").show();
			 	}
		 		
		 	//}
			
		 	
		 	
		 	
		 
	 };
	 
	 $.zabbix.setCssMedia = function() {
		 
	 };
	 
	 $.zabbix.setCssDiscoveryUpDown = function() {
		 
		 $("#zabbix-discovery-up-down-value").val(aDiscovery["up_down"]["delay"]);
		 
		 if (aDiscovery["up_down"]["status"] == "0") {
			 //$("#zabbix-switch-discovery-up-down").attr("checked", true);
			 $("#zabbix-switch-discovery-up-down").prop({
				  "checked": true
			 });
			 $("#zabbix-discovery-up-down-value").attr("disabled", false);
		 } else {
			 //$("#zabbix-switch-discovery-up-down").attr("checked", false);
			 $("#zabbix-switch-discovery-up-down").prop({
				  "checked": false
			 });
			 $("#zabbix-discovery-up-down-value").attr("disabled", true);
		 }
		 
		$.zabbix.makeUiSwitchDiscoveryUpDown();
		
	 };
	 
	 $.zabbix.setCssDiscoveryDown = function() {
		 
		 $("#zabbix-discovery-down-delay-value").val(aDiscovery["down"]["delay"]);
		 
		 if (aDiscovery["down"]["status"] == "0") {
			 //$("#zabbix-switch-discovery-down-delay").attr("checked", true);
			 $("#zabbix-switch-discovery-down-delay").prop({
				  "checked": true
			 });
			 $("#zabbix-discovery-down-delay-value").attr("disabled", false);
		 } else {
			 //$("#zabbix-switch-discovery-down-delay").attr("checked", false);
			 $("#zabbix-switch-discovery-down-delay").prop({
				  "checked": false
			 });
			 $("#zabbix-discovery-down-delay-value").attr("disabled", true);
		 }
		 
		 $.zabbix.makeUiSwitchDiscoveryDownDelay();
		 
	 };
	 
	 
	 $.zabbix.setCssDiscoveryUp = function() {
		 
		 $("#zabbix-discovery-up-delay-value").val(aDiscovery["up"]["delay"]);
		 
		 if (aDiscovery["up"]["status"] == "0") {
			 //$("#zabbix-switch-discovery-up-delay").attr("checked", true);
			 $("#zabbix-switch-discovery-up-delay").prop({
				  "checked": true
			 });
			 $("#zabbix-discovery-up-delay-value").attr("disabled", false);
		 } else {
			 //$("#zabbix-switch-discovery-up-delay").attr("checked", false);
			 $("#zabbix-switch-discovery-up-delay").prop({
				  "checked": false
			 });
			 $("#zabbix-discovery-up-delay-value").attr("disabled", true);
		 }
		 
		 $.zabbix.makeUiSwitchDiscoveryUpDelay();
		 
	 };
	 
	 
	 $.zabbix.setCssDiscovery = function() {

		 if (action == "view" || action == "viewDiscovery") {
			 
			 try {
				 	
				 htmlDiscoveryIp = "<table cellpadding=\"0\" cellspacing=\"0\" width=\"866\" class=\"tbl-status\">";
				 htmlDiscoveryIp += "	<tr>";
				 htmlDiscoveryIp += "		<th align=\"left\" valign=\"top\" width=\"30%\">";
				 htmlDiscoveryIp += "			device";
				 htmlDiscoveryIp += "		</th>";
				 htmlDiscoveryIp += "		<th align=\"center\" valign=\"top\" width=\"30%\">";
				 htmlDiscoveryIp += "			up/down";
				 htmlDiscoveryIp += "		</th>";
				 htmlDiscoveryIp += "		<th align=\"center\" valign=\"top\" width=\"30%\">";
				 htmlDiscoveryIp += "			ICMP PING";
				 htmlDiscoveryIp += "		</th>";
				 htmlDiscoveryIp += "	</tr>";
				 
			 	jQuery.each(aDiscovery, function(key, value) {
			 		
			 		classTxt = (aDiscovery[key]["isup"] == "1") ? "txt-on" : "txt-off";
			 		classTxtUpDown = (aDiscovery[key]["isup"] == "1") ? "txtupdown-on" : "txtupdown-off";
			 		status = (aDiscovery[key]["isup"] == "1") ? "status-on" : "status-off";
			 		
			 		htmlDiscoveryIp += "	<tr>";
			 		htmlDiscoveryIp += "		<td align=\"left\" valign=\"top\">";
			 		htmlDiscoveryIp += "			<a href='javascript:void(0);' id='discovery-'" + aDiscovery[key]["ip"] + "'  class=\"" + classTxt + "\" onclick='$.zabbix.makeEventDoViewDiscoveryIp(\"" + aDiscovery[key]["ip"] + "\");'>" + aDiscovery[key]["ip"] + "</a>";
			 		htmlDiscoveryIp += "		</td>";
			 		htmlDiscoveryIp += "		<td class=\"" + classTxtUpDown + "\"  align=\"center\" valign=\"top\">";
			 		htmlDiscoveryIp += aDiscovery[key]["nextcheck"] + " (hh:mm:ss)";
			 		htmlDiscoveryIp += "		</td>";
			 		htmlDiscoveryIp += "		<td align=\"center\" valign=\"top\">";
			 		htmlDiscoveryIp += "			<div class=\"" + status + "\">";
			 		htmlDiscoveryIp += "		&nbsp;";
			 		htmlDiscoveryIp += "			</div>";
			 		htmlDiscoveryIp += "		</td>";
			 		htmlDiscoveryIp += "	</tr>";
			 		
			 	});
			 	
			 	htmlDiscoveryIp += "</table>";
		 	} catch (e) {
		 		// Handle exception
			}
			 
		 	$("#zabbix-discovery-ip-display").html(htmlDiscoveryIp);
			 
		 }	 
		 
		 
		 
		 
		 
		 if (action == "doViewDiscoveryIp") {
			 
			 $.zabbix.setCssDiscoveryUpDown();
			 $.zabbix.setCssDiscoveryDown();
			 $.zabbix.setCssDiscoveryUp();
			 			 
			 
			 $("#container-zabbix-switch-discovery").show();
			 
			 
		 }
		 
		 
		 /*
		 if (aDiscovery["target"] == "all") {
			 $.zabbix.setCssDiscoveryUpDown();
			 $.zabbix.setCssDiscoveryDown();
			 $.zabbix.setCssDiscoveryUp();
		 } else if (aDiscovery["target"] == "up_down") {
			 $.zabbix.setCssDiscoveryUpDown();
		 } else if (aDiscovery["target"] == "down") {
			 $.zabbix.setCssDiscoveryDown();
		 } else if (aDiscovery["target"] == "up") {
			 $.zabbix.setCssDiscoveryUp();
		 }
		 */
		 		 
	 };
	 
	 $.zabbix.makeEventInputDiscoveryUpDown = function() {
		 $("#zabbix-discovery-up-down-value").change(function () {
			 
			 $("#zabbix-discovery-up-down-value").attr("disabled", false);
			 
			// TODO validate delay integer
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doDiscoveryRule",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 target: "up_down",
					 druleid: aDiscovery["up_down"]["druleid"],
					 delay: $("#zabbix-discovery-up-down-value").val(),
					 status: "0",
					 iprange: aDiscovery["up_down"]["iprange"],
					 nextcheck: aDiscovery["up_down"]["nextcheck"]
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
			          }
			       }
			});

			 
		 });
	 };
	 
	 
	 $.zabbix.makeEventSwitchDiscoveryUpDown = function() {
		 $("#zabbix-switch-discovery-up-down").change(function () {
			 
			 status = "0";
			 
			 if ($(this).is(':checked') == true) {
				 $("#zabbix-discovery-up-down-value").attr("disabled", false);
				 status = "0";
			 } else {
				 $("#zabbix-discovery-up-down-value").attr("disabled", true);
				 status = "1";
			 }
			 
			 // TODO validate delay integer
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doDiscoveryRule",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 target: "up_down",
					 druleid: aDiscovery["up_down"]["druleid"],
					 delay: $("#zabbix-discovery-up-down-value").val(),
					 status: status,
					 iprange: aDiscovery["up_down"]["iprange"],
					 nextcheck: aDiscovery["up_down"]["nextcheck"]
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
			          }
			       }
			});

			 
		 });
	 };

	 $.zabbix.makeEventInputDiscoveryDownDelay = function() {
		 $("#zabbix-discovery-down-delay-value").change(function () {

			 $("#zabbix-discovery-down-delay-value").attr("disabled", false);
			 			 
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doDiscoveryRule",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 target: "down",
					 druleid: aDiscovery["down"]["druleid"],
					 delay: $("#zabbix-discovery-down-delay-value").val(),
					 status: "0",
					 iprange: aDiscovery["down"]["iprange"],
					 nextcheck: aDiscovery["down"]["nextcheck"]
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
			          }
			       }
			});
			 
			 
			 
		 });
	 };
	 
	 $.zabbix.makeEventSwitchDiscoveryDownDelay = function() {
		 $("#zabbix-switch-discovery-down-delay").change(function () {

			 status = "0";
			 if ($(this).is(':checked') == true) {
				 $("#zabbix-discovery-down-delay-value").attr("disabled", false);
				 status = "0";
			 } else {
				 $("#zabbix-discovery-down-delay-value").attr("disabled", true);
				 status = "1";
			 }
			 			 
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doDiscoveryRule",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 target: "down",
					 druleid: aDiscovery["down"]["druleid"],
					 delay: $("#zabbix-discovery-down-delay-value").val(),
					 status: status,
					 iprange: aDiscovery["down"]["iprange"],
					 nextcheck: aDiscovery["down"]["nextcheck"]	
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
			          }
			       }
			});
			 
			 
			 
		 });
	 };
	 
	 
	 $.zabbix.makeEventInputDiscoveryUpDelay = function() {
		 $("#zabbix-discovery-up-delay-value").change(function () {
			 
			 $("#zabbix-discovery-up-delay-value").attr("disabled", false);
			 			 			 
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doDiscoveryRule",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 target: "up",
					 druleid: aDiscovery["up"]["druleid"],
					 delay: $("#zabbix-discovery-up-delay-value").val(),
					 status: "0",
					 iprange: aDiscovery["up"]["iprange"],
					 nextcheck: aDiscovery["up"]["nextcheck"]
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
			          }
			       }
			});
			 
			 
		 });
	 };
	 
	 $.zabbix.makeEventSwitchDiscoveryUpDelay = function() {
		 $("#zabbix-switch-discovery-up-delay").change(function () {
			 
			 status = "0";
			 if ($(this).is(':checked') == true) {
				 $("#zabbix-discovery-up-delay-value").attr("disabled", false);
				 status = "0";
			 } else {
				 $("#zabbix-discovery-up-delay-value").attr("disabled", true);
				 status = "1";
			 }
			 
			 
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doDiscoveryRule",
					 
					 accountId: $("#account-id").val(),
					 serverId: $("#server-id").val(),
					 target: "up",
					 druleid: aDiscovery["up"]["druleid"],
					 delay: $("#zabbix-discovery-up-delay-value").val(),
					 status: status,
					 iprange: aDiscovery["up"]["iprange"],
					 nextcheck: aDiscovery["up"]["nextcheck"]
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(data) {
			          }
			       }
			});
			 			 
			 
		 });
	 };
	 
	 
	 
	 $.zabbix.makeEventInlineEdit = function($$, callBack) {
		 
		 var replaceWith = $('<input name="inline-edit-temp" type="text" />');
		 var connectWith = $('input[name="inline-edit-hidden"]');
		 
		 var elem = $$;
		 var oldValue = elem.html();
		 
		 elem.hide();
	     elem.after(replaceWith);
	     replaceWith.val(oldValue);
	     replaceWith.focus();
	     
	     replaceWith.blur(function() {

		  	if ($(this).val() != "") {
		  		
		  		if ($.zabbix.isEmail($(this).val()) == true) {
		  			
		  			connectWith.val($(this).val()).change();
			       	elem.text($(this).val());
			       	status = elem.attr("attrStatus");
			       	
			       	switch (callBack) {
		                case "makeEventAddDiscoverMedia": 
		                	// TODO Old value
		                	$.zabbix.makeEventAddDiscoverMedia($$);
		                	break;
		                case "makeEventAddNetworkTrafficMediaAdmin":
		                	$.zabbix.makeEventAddNetworkTrafficMediaAdmin($$);
		                	break;
		                default: break;
		            };
		  			
		  		} else {
		  			$.zabbix.raiseError("require pattern email !!");
		  		}
		  		
		  		
		    }
	
		 	$(this).remove();
		    elem.show();
		    
	    });

	 };
	 
	 
	 $.zabbix.isEmail = function(email) {
			var pattern = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			return (pattern.test(email)) ? true : false;
	 };
	 
	 $.zabbix.raiseError = function(errorMsg) {
		 $.ZB.Ajax.doError({}, {}, {}, {"errorMsg" : errorMsg});
	 };
	 
	 $.zabbix.isNumber = function(data) {
		 return data.match(/\d/i) ? true : false;
	 };
	 
})(jQuery);