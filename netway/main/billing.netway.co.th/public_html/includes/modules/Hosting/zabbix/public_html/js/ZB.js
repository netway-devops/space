var LOG_PRIORITY = {
        ALERT: 0,
        CRIT: 1,
        ERR: 2,
        WARNING: 3,
        NOTICE: 4,
        INFO: 5,
        DEBUG: 6
};

(function(jQuery) {
	 $.ZB = {};
	 
     $.ZB.Log = {
             logMessage: function(message, level) {
                 if (window.console) {
                     if (!document.all) {
                    	 console.debug($.ZB.Log.getLogLevelMsg(level) + ': ' + message);
                     }
                 }
                 return this;
             },
             getLogLevelMsg: function(level) {
                 switch (level) {
                     case LOG_PRIORITY.ALERT: return 'Alert';
                     case LOG_PRIORITY.CRIT: return 'Crit';
                     case LOG_PRIORITY.ERR: return 'Error';
                     case LOG_PRIORITY.WARNING: return 'Warning';
                     case LOG_PRIORITY.NOTICE: return 'Notice';
                     case LOG_PRIORITY.INFO: return 'Info';
                     case LOG_PRIORITY.DEBUG: 
                     default: return 'Debug';
                 };
             }
     };
     
     $.ZB.Ajax = {
    		 connect: function(param) {
    	 
    	 		 $('body').css({'cursor':'wait'});
    	 		 
		    	 defaultSetting = {
		     			type: "POST",
		     			cache : false
		     	 };
		    	 
		    	 settings = defaultSetting;
		    	 if (arguments.length === 2) {
		             for (k in arguments[1]) {
		             	settings[k] = arguments[1][k];
		             }
		         }
		    	 
		    	 if (settings.waitDialog != undefined && typeof settings.waitDialog == "function") {
	                	waitDialog = $("<div/>");
	                	waitDialog.bind(
	                            "ajaxSend", function(){
	                            		$('body').css({'cursor':'wait'});
	                            		if (settings.waitDialog == undefined) {
		                            		if (typeof settings.waitDialog !== 'function') {
		                                        $('select,object,embed').displayTagProblemIE67('hidden'); 
		                                       waitDialog.dialog('open');
		                                   }
		                            	} else {
		                            		try{
		                            			settings.waitDialog("ajaxSend");
		                            		} catch (e) {
		                            			settings.waitDialog();
		                            		}
	                            	}
	                            }
	                        ).bind(
	                        	"ajaxComplete", function() {
	                            	if (settings.waitDialog == undefined) {
	                            		$('select,object,embed').displayTagProblemIE67('visible'); 
	                                    waitDialog.dialog('close');
	                                    waitDialog.dialog('destory');
	                                    waitDialog.remove();
	                            	} else {
	                            		try{
	                            			settings.waitDialog("ajaxComplete");
	                            			 waitDialog.remove();
	                            		} catch (e) {
	                            			settings.waitDialog();
	                            		}
	                            	}
	                            }
	                        );
	                } else {
	                	msgPleaseWait = 'Please wait...'
	                    waitDialog = $("<div/>").dialog({
						                        modal: true,
						                        title: msgPleaseWait,
						                        resizable: 'auto',
						                        autoOpen: false
						                    }).parent().find(".ui-dialog-titlebar-close").hide().end().end();
	                    indicator = $("<div/>").addClass("ui-progressbar-indicator").text(msgPleaseWait).appendTo(waitDialog);
	                    
	                    waitDialog.bind(
	                        "ajaxSend", function(){
	                        	jQuery('body').css({'cursor':'wait'});
	                            if (typeof settings.waitDialog != 'function') {
	                                 $('select,object,embed').displayTagProblemIE67('hidden'); 
	                                waitDialog.dialog('open');
	                            } 
	                        }
	                    ).bind(
	                        "ajaxComplete", function(event, XMLHttpRequest, ajaxOptions){ 
	                            if (typeof settings.waitDialog !== 'function') {
	                                 $('select,object,embed').displayTagProblemIE67('visible'); 
	                                 waitDialog.dialog('close');
	                                 waitDialog.dialog('destory');
	                                 waitDialog.remove();
	                            }
	                        }
	                    );
	                }
		    	 
		    	 
	             $.ajaxSetup(settings);
                 
	             option = {
	                     success: function (data) {
	            	 
	                 			$('body').css({'cursor':'default'});
	                 			
	                 			//decode = $.rvskin.json.parse(data);
	                 			data = data.aResponse;
	                 			
	                 			if (data.raiseError != undefined
	                 					&& (data.raiseError == '1' || data.raiseError == 1 || data.raiseError == 'true' || data.raiseError == true)) {
	                 			} else {
	                 				xhr = {};
	 			                    xhr.status = '500';
	 			                    xhr.statusText = 'text/json';
	 			                    xhr.responseText = data;
	 			                    ajaxOptions = {};
	 			                    thrownError = {};
	 			                    this.error(xhr, ajaxOptions, thrownError);
	 			                    return;
	                 			}
	                 			
	                 			
	 			        		$.ZB.Log.logMessage('AJAX returns: '+ data, LOG_PRIORITY.DEBUG);
	 			        		
	 			        		if (typeof settings.waitDialog === 'function') {
	                         
	 			        		} else {
	 			        			$('select,object,embed').displayTagProblemIE67('visible');
	 			        			waitDialog.dialog('close');
	                                waitDialog.dialog('destory');
	                                waitDialog.remove();
	                            }
	                             
	 			        		//CALL BACK
	 			        		if (typeof data == 'object') {
	 			        			//CASE DATA OBJECT
		                 			if (typeof settings.callback.doSuccess == 'function') {
		                                 settings.callback.doSuccess(data);
		                             } else {
		                            	 $.ZB.Ajax.doSuccess(data);
		                             }
	 			        		} else {
	 			        			// TODO on hostbill
	 			        			//CASE DATA NOT OBJECT
	 			        			if (data.match(/cpanel_internal_error_1/gi)) {
		                                 ///CPANEL INTERNAL ERROR
		                                 ErrDialog = $("<div/>").dialog({
		                                     modal: true,
		                                     title: 'CPANEL ERROR',
		                                     width: 'auto',
		                                     height: 'auto',
		                                     resizable: 'auto',
		                                     autoOpen: false/*,
		                                     buttons:{
		                                         "Close": function() { ErrDialog.dialog('close'); }
		                                     }*/
		                                 }),
		                                 indicator = $("<div/>").addClass("ui-progressbar-indicator").html(data).appendTo(ErrDialog);
		                                 ErrDialog.dialog('open');
	 			        			} else if (typeof settings.callback.doSuccess == 'function') {
	 			        				settings.callback.doSuccess(data);
	 			        			} else {
	 			        				$.ZB.Ajax.doSuccess(data);
	 			        			}
	 			        		}
	                         },
	                         
	                   error: function (xhr, ajaxOptions, thrownError) {
	                        	 
	                         	$('body').css({'cursor':'default'});
	                            $.ZB.Log.logMessage('AJAX connect error '+ xhr.status +': '+ xhr.statusText, LOG_PRIORITY.ERR);
	                             
	                             if (typeof settings.waitDialog === 'function') {
	                             
	                             } else {
	                                 waitDialog.dialog('close');
	                                 waitDialog.dialog('destory');
	                                 waitDialog.remove();
	                             }

	                             var defXHR = {};
	                             if (xhr.status == 500 || xhr.status == '500') {
	                            	 $.ZB.Log.logMessage('AJAX connect response text: ' + xhr.responseText, LOG_PRIORITY.ERR);
	                            	 //decode = $.rvskin.json.parse(xhr.responseText);
	                            	 defXHR.errorMsg = (xhr.responseText.raiseError != undefined) 
	                            	 									? xhr.responseText.raiseError 
	                            	 									: 'Error. Please try again.';	                               
	                             } else {
	                                 defXHR.errorMsg = 'Network connection Error(' + xhr.status + ': '+ xhr.statusText +'), please try again.';
	                             }
	                                 
	                             if (typeof settings.callback.doError === 'function') {
	                                 settings.callback.doError(xhr, ajaxOptions, thrownError, defXHR);
	                             } else {
	                            	 $.ZB.Ajax.doError(xhr, ajaxOptions, thrownError, defXHR);
	                             }
	                         }
	                 };
	             

		             //option.data = '';
		             //$.ajax(option);
		             
		             if (param.match(/^[#|\.]/)) {
			            	$.ZB.Log.logMessage('Usage ajaxSubmit (jQuery form)', LOG_PRIORITY.DEBUG);
			                $(param).ajaxSubmit(option);
		             } else {
			               	$.ZB.Log.logMessage('Usage ajax (jQuery default)', LOG_PRIORITY.DEBUG);
			                option.data = param;
			                $.ajax(option);
		             }
	             
	             /*if (data.match(/^[#|\.]/)) {
		            	$.ZB.Log.logMessage('Usage ajaxSubmit (jQuery form)', LOG_PRIORITY.DEBUG);
		                $(data).ajaxSubmit(option);
	             } else {
		               	$.ZB.Log.logMessage('Usage ajax (jQuery default)', LOG_PRIORITY.DEBUG);
		                option.data = data;
		                $.ajax(option);
	             }*/
	             
     		 },
             doSuccess: function(data) {
                 /**
                  * Default process on event success.
                  * If want over write this function, you can setting callback in settings.doSuccess
                  */
     		 },
            doError: function(xhr, ajaxOptions, thrownError, defXHR) {
                 /**
                 * Default process on event error.
                 * If want over write this function, you can setting callback in settings.doError
                 */
     			 
     			//decode = $.rvskin.json.parse(xhr.responseText);
     			errorText = (defXHR.errorMsg != undefined) 
										? defXHR.errorMsg
										: 'Oops...';	
										
                ErrDialog = $("<div/>").dialog({
                    modal: true,
                    title: "System",
                    width: 400,
                    height: 'auto',
                    autoOpen: false/*,
                    buttons:{
                        "Close": function() { ErrDialog.dialog('close'); }
                    }*/
                });
                //indicator = $("<div/>").addClass("ui-progressbar-indicator").html(errorText).appendTo(ErrDialog);
                
                warning = '<div class="ui-widget">';
                warning += '<div class="ui-state-error ui-corner-all" style="padding: 0pt 0.7em;">';
                warning += '<br /><p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: 0.3em;"></span>';
                warning += '<strong>Warnnig:</strong></p><br />';
                warning += '<div class="rvdialogwarning">' + errorText + '</div><br />&nbsp;';
                warning += '</div>';
                warning += '</div>';                
                indicator = $("<div/>").html(warning).appendTo(ErrDialog);        
                
                ErrDialog.dialog('open');
            }
     };
     
     $.fn.displayTagProblemIE67 = function(val) {  
         if (jQuery.browser.msie && jQuery.browser.version < 7) {
            $(this).css({'visibility' : val}); 
          }
      };
      
      $.ZB.urls = {
     		 api: function(api2_call) {
     	 			//return CPANEL.urls.json_api(api2_call);
 		    	 	var params = "";
 		    		for(var post in api2_call){
 		    			if (api2_call.hasOwnProperty(post)) {
 		    				params += encodeURIComponent(post)+"="+encodeURIComponent(api2_call[post])+"&"
 		    			}
 		    		}
 		    		return params += "cache_fix=" + new Date().getTime();
              }
      };
     
})(jQuery);