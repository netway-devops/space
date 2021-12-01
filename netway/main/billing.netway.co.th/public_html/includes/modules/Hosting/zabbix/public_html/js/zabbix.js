var aTrafficBandwidth = {};
var aPing = {};
var aUserMedia = {};

(function(jQuery) {
	
	 $.zabbix = {};
	 
	 $.zabbix.init = function() {
		 $.zabbix.makeUi();
		 $.zabbix.makeEvent();
	 };
	 
	 $.zabbix.makeUi = function() {
		 // $.zabbix.makeUiTrafficBandwidth(); // Onclick Tabs
		 $.zabbix.makeUiTrafficBandwidthSlider();
		 
		 // $.zabbix.makeUiPing(); // Onclick Tabs
		 // $.zabbix.makeUiUserMedia(); // Onclick Tabs
	 };
	 
	 $.zabbix.makeEvent = function() {
		 // $.zabbix.makeEventDeleteUserMedia(); // Onclick
		 // $.zabbix.makeEventAddRowUserMedia(); // Onclick
		 // $.zabbix.makeEventInlineEdit(); // Onclick
		 // $.zabbix.makeEventAddUserMedia(); // Onclick
		 
		 $.zabbix.makeEventOnOffActionPing();
		 $.zabbix.makeEventEscPeriodActionPing();
	 };
	 
	 $.zabbix.makeEventOnOffActionPing = function() {
		 $("#zabbix-switch-action-ping").change(function () {
			 $.zabbix.makeEventActionPing();
		 });
	 };
	 
	 $.zabbix.makeEventEscPeriodActionPing = function() {
		 $("#zabbix-action-ping-esc-period").change(function () {
			 $.zabbix.makeEventActionPing();
		 });
	 };
	 
	 
	 $.zabbix.makeEventActionPing = function() {
		 
		 status = ($("#zabbix-switch-action-ping").is(':checked') == true) ? 0 : 1;
		 
		 var api_call = {
				 cmd	: "zabbix",
				 action: "doActionPing",
				 
				 account_id: $("#account-id").val(),
				 server_id: $("#server-id").val(),
				 status: status,
				 esc_period: $("#zabbix-action-ping-esc-period").val()
		 };
		 
		 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(json) {
			    	  		
			    	  		if (status == 0 || status == "0") {
			    	  			$("#zabbix-action-ping-esc-period").prop({ "disabled": false });
			    	  		} else {
			    	  			$("#zabbix-action-ping-esc-period").prop({ "disabled": true });
			    	  		}
			    	  
			    	  		//$.zabbix.makeUiPing();
			          }
		       }
		});
		 
	 };
	 
	 $.zabbix.makeUiPing = function() {
		 
		 // Return Onclick Once Tabs
		 if ($("#tabs-once-monitor").val() == "1") {
			return true; 
		 }
		 
		 var api_call = {
				 cmd	: "zabbix",
				 action: "viewPing",
				 
				 account_id: $("#account-id").val(),
				 server_id: $("#server-id").val()
		 };
		 
		 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(json) {
				    	  	$.zabbix.preViewAs(json);
			          }
		       }
		});
		 
	 };
	 
	 $.zabbix.makeEventAddUserMedia = function($$) {
		 
		 attrStatus = $$.attr("attrStatus");
		 emailName = $$.text();
		 
		 if (attrStatus == "add") {
			 
			 var api_call = {
					 cmd	: "zabbix",
					 action: "doAddUserMedia",
					 
					 client_id: $("#client-id").val(),
					 server_id: $("#server-id").val(),
					 emailName: emailName
			 };
			 
			 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(json) {
			    	  		$$.attr("attrStatus", "edit");
							$$.attr("attrMediaId", json.raiseData.aMedia.mediaid);
			          }
			       }
			});
			 
			 
		 } else if (attrStatus== "edit") {
			// Condition Not Edit.
		 }
		 
	 };
	 
	 $.zabbix.makeEventInlineEdit = function($$, callBack) {
		 
		 var replaceWith = $('<input name="inline-edit-temp" type="text" />');
		 var connectWith = $('input[name="inline-edit-hidden"]');
		 
		 var elem = $$;
		 var oldValue = elem.html();
		 
		 status = elem.attr("attrStatus");
		 if (status == 'edit') {
			 // Condition Not Edit.
			 return false;
		 }
		 
		 elem.hide();
	     elem.after(replaceWith);
	     replaceWith.val(oldValue);
	     replaceWith.focus();
	     
	     replaceWith.blur(function() {

		  	if ($(this).val() != "") {
		  		
		  		if ($.zabbix.isEmail($(this).val()) == true) {
		  			
		  			connectWith.val($(this).val()).change();
			       	elem.text($(this).val());
			       	
			       	switch (callBack) {
		                case "add":
		                	$.zabbix.makeEventAddUserMedia($$);
		                	break;
		                default: break;
		            };
		  			
		  		} else {
		  			$.zabbix.raiseError("Require pattern email !!");
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
	 
	 
	 $.zabbix.makeEventAddRowUserMedia = function() {

		 countRow = 0;
		 $('#discovery-media-table tr').each(function() {
			 countRow++;
		 });
			 
		output = '	<tr id="tr-discovery-' + countRow + '">';
		output += '		<td align="left" valign="top" class="bg">';
		output += '			 <p id="inline-edit-discovery-media-' + countRow + '" attrMediaId="" class="inline-edit-discovery-media-class edit" attrStatus="add" onclick="$.zabbix.makeEventInlineEdit($(this), \'add\');\">Edit here..</p>';
		output += '		</td>';
		output += '		<td align="center" valign="top" class="bg">';
		output += '			<img class="discovery-remove-media" id="discovery-remove-media-' + countRow + '" attrNum="' + countRow + '" src="' + system_url + 'includes/modules/Hosting/zabbix/public_html/images/delete.gif" alt="Remove Row" onclick="$.zabbix.makeEventDeleteUserMedia($(this));"/>';
		output += '		</td>';
		output += '</tr>';
			 
		$('#discovery-media-table tr:last').after(output);
		 
	 };
	 
	 
	 $.zabbix.makeEventDeleteUserMedia = function($$) {

		 	 if ($('#discovery-media-table tr').length <= 2) {
		 		 // 1 Row Disable Delete.
		 		$.zabbix.raiseError("Require 1 Email Address.");
		 		 return false;
		 	 }
		 
			 attrNum = $$.attr("attrNum");
			 attrMediaId = $("#inline-edit-discovery-media-" + attrNum).attr("attrMediaId");
			 emailName = $("#inline-edit-discovery-media-" + attrNum).text();
			 
			 if (attrMediaId == "") {
				 $("table#discovery-media-table tr#tr-discovery-" + attrNum).remove();
			 } else {
				 
				 if (!confirm('Are you sure?')) {
					 return false;
				}
				 
				 var api_call = {
						 cmd	: "zabbix",
						 action: "doDeleteUserMedia",
						 
						 account_id: $("#account-id").val(),
						 server_id: $("#server-id").val(),
						 media_id: attrMediaId
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
	 
	 $.zabbix.makeUiUserMedia = function() {
		 
		 // Return Onclick Once Tabs
		 if ($("#tabs-once-monitor").val() == "1") {
			return true; 
		 }
		 
		 var api_call = {
				 cmd	: "zabbix",
				 action: "viewUserMedia",
				 
				 client_id: $("#client-id").val(),
				 server_id: $("#server-id").val()
		 };
		 
		 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(json) {
				    	  	$.zabbix.preViewAs(json);
				    	  	
				    	  	// Onclick Once Tabs
					   		$("#tabs-once-monitor").val("1");
			          }
		       }
		});
		 
	 };
	 
	 $.zabbix.makeUiTrafficBandwidth = function() {
		 
		 // Return Onclick Once Tabs
		 if ($("#tabs-once-bandwidth").val() == "1") {
			return true; 
		 }
		 
		 var api_call = {
				 cmd	: "zabbix",
				 action: "viewTrafficBandwidth",
				 
				 account_id: $("#account-id").val(),
				 server_id: $("#server-id").val(),
				 period : $("#traffic-bandwidth-slider").slider("value")
		 };
		 
		 $.ZB.Ajax.connect($.ZB.urls.api(api_call), {
			      waitDialog: function() {},
			      callback: {
			          /*doError: function(data) {
			          },*/
			          doSuccess: function(json) {
				    	  	$.zabbix.preViewAs(json);
				    	  	
				    	 // Onclick Once Tabs
				   		 $("#tabs-once-bandwidth").val("1");
			          }
		       }
		});

		 
	 };
	 
	 $.zabbix.makeUiTrafficBandwidthSlider = function() {
			
		 label = "History Traffic Bandwidth: ";
		 
		 $("#traffic-bandwidth-slider").slider({
		      value: 1,
		      min: 1,
		      max: 90,
		      step: 1,
		      slide: function( event, ui ) {
		        $("#traffic-bandwidth-display-value-slider").html(label +ui.value + " days");
		      },
		      change: function(event, ui) { 
		    	  //alert("value = " + ui.value);
		    	  
		    	  // Onclick Once Tabs
			      $("#tabs-once-bandwidth").val("0");
		    	  $.zabbix.makeUiTrafficBandwidth();
		      }
		   });
		 
		   $("#traffic-bandwidth-display-value-slider").html(label + $("#traffic-bandwidth-slider").slider("value") + " days");
	 };
	 
	 $.zabbix.preViewAs = function(json) {
		 
		 preViewAs = json.preViewAs;
		 
		 switch(preViewAs) {
			 case 'traffic_bandwidth':
				 $.zabbix.setVarTrafficBandwidth(json);
			 	 $.zabbix.setCssTrafficBandwidth();
			   break;
			 case 'user_media':
				 $.zabbix.setVarUserMedia(json);
			 	 $.zabbix.setCssUserMedia();
			   break;
			 case 'ping':
				 $.zabbix.setVarPing(json);
			 	 $.zabbix.setCssPing();
			   break;
			 case 'media':
			 default: 
				break;
		 }
		 
	 };

	 
	 $.zabbix.setVarPing = function(json) {
		 try {
			 jQuery.each(json.raiseData, function(key, value) {
				 aPing[key] = value;
	      	 });
		} catch (e) {
			// Handle exception
		}
	 };
	 
	 $.zabbix.setCssPing = function() {
		 
		 if (aPing.status == "0" || aPing.status == 0) {
			 // ON
			 $("#zabbix-switch-action-ping").prop({ "checked": true });
			 
			 $("#zabbix-action-ping-esc-period").prop({ "disabled": false });
		 } else {
			 // OFF
			 $("#zabbix-switch-action-ping").prop({ "checked": false });
			 
			 $("#zabbix-action-ping-esc-period").prop({ "disabled": true });
		 }
		 
		 // Set Period Ping
		 $("#zabbix-action-ping-esc-period").val(aPing.esc_period);
		 
		 // Set ON/OFF Ping
		 $("#zabbix-switch-action-ping").iButton("destroy");
		 $("#zabbix-switch-action-ping").iButton();
		 
	 };
	 
	 $.zabbix.setVarUserMedia = function(json) {
		 try {
			 jQuery.each(json.raiseData, function(key, value) {
				 aUserMedia[key] = value;
	      	 });
		} catch (e) {
			// Handle exception
		}
	 };
	 
	 $.zabbix.setCssUserMedia = function() {
		 
		 try {
			 
			 var output = '<table id="discovery-media-table" cellpadding="0" cellspacing="0" width="750" class="tbl-status">';
			 output += 		'<tbody>';
             output += 			'<tr>';
             output += 				'<th align="left" valign="top" width="90%">Email</th>';
             output += 				'<th align="center" valign="top">Delete</th>';
             output += 			'</tr>';
            
			 
			 jQuery.each(aUserMedia.aMedia, function(key, value) {

				 output += '		<tr id="tr-discovery-' + key + '">';
				 output += '			<td align="left" valign="top" class="bg">';
				 output += '				<p id="inline-edit-discovery-media-' + key + '" class="inline-edit-discovery-media-class" attrStatus="edit" attrMediaId="' + aUserMedia.aMedia[key].mediaid + '" attrUserId="' + aUserMedia.aMedia[key].userid + '" onclick="$.zabbix.makeEventInlineEdit($(this), \'edit\');">' + aUserMedia.aMedia[key].sendto + '</p>';
	             output += '			</td>';
	             output += '			<td align="center" valign="top" class="bg">';
	             output += '				<img class="discovery-remove-media" id="discovery-remove-media-' + key + '" attrNum="' + key + '" src="'+  system_url + 'includes/modules/Hosting/zabbix/public_html/images/delete.gif" alt="Remove Row" onclick="$.zabbix.makeEventDeleteUserMedia($(this));"/>';
				 output += '			</td>';
				 output += '		</tr>';
				 
	      	 });
			 
			 
			 output += 	'</tbody>';
			 output += '</table>';
			 output += '<div class="position"><a id="add-row-discovery-media" href="javascript:void(0);" class="btn" onclick="$.zabbix.makeEventAddRowUserMedia();">Add Email Address</a></div>';
		        
		     $("#zabbix-user-media-display").html(output);  
			 
		} catch (e) {
			// Handle exception
		}
		
	 };
	 
	 $.zabbix.setVarTrafficBandwidth = function(json) {
		 try {
			 jQuery.each(json.raiseData, function(key, value) {
				 aTrafficBandwidth[key] = value;
	      	});
		} catch (e) {
			// Handle exception
		}
	 };
	 
	 $.zabbix.setCssTrafficBandwidth = function() {
		 
		 // SET IMAGE GRAPH
		 setTimeout(function() {
			 
			 var cache_fix = "?cache_fix=" + new Date().getTime()
			 var urlImage = "<img id='traffic-bandwidth-history-image' src='" + system_url + aTrafficBandwidth["traffic_bandwidth_url_graph"] + cache_fix + "' />";
			 
			 
			 $("#traffic-bandwidth-display-graph").html(urlImage);
			 $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#traffic-bandwidth-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#traffic-bandwidth-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });

		     var htmlBandwidthDetail = "* incoming traffic to internet ในที่นี้หมายถึง ข้อมูลที่<b>ถูกส่งไป</b>ถึง server ของคุณ<br>";
		     htmlBandwidthDetail += "* outgoing traffic from internet ในที่นี้หมายถึง ข้อมูลที่<b>ถูกเรียกออก</b>จาก server ของคุณ";
		     $('#traffic-bandwidth-detail').html(htmlBandwidthDetail);
		      	
		 }, 1000);
		 
	 };
	 
})(jQuery);