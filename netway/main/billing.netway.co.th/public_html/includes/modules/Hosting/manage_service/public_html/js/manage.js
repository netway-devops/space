var aCpu = {};
var aMemory = {};
var aDisk = {};
var aApache = {};
var aMysql = {};
var aMyIsam = {};
var aInnodb = {};
var aExim = {};
var aNginx = {};
var aUserMedia = {};
var aActions = {};
var aNamed = {};

(function(jQuery) {
    
     $.manage = {};
     
     $.manage.init = function() {
         $.manage.makeUi();
         $.manage.makeEvent();
     };
     
     $.manage.makeUi = function() {
         /*
         // CPU
         $.manage.makeUiCpu();
         
         // Memory
         $.manage.makeUiMemory();
         
         // Apahce
         $.manage.makeUiApache();
         
         // MySql
         $.manage.makeUiMysql();
         
         // NginX
         $.manage.makeUiNginx();
         
         // Exim
         $.manage.makeUiExim();
         
         // Named
         $.manage.makeUiNamed();

        // User Media
        $.manage.makeUiUserMedia();
        */
       
        // Actions
        // $.manage.makeUiActions();
       
     };
     
     $.manage.makeEvent = function() {
         
         // User Media
         // $.manage.makeEventAddRowUserMedia(); // On Click
         // $.manage.makeEventInlineEdit(); // On Click
         // $.manage.makeEventAddUserMedia(); On Click
         // $.manage.makeEventDeleteUserMedia() On Click
         
         // Actions
         $.manage.makeEventOnOffActions();
         $.manage.makeEventEscPeriodActions();
         
         // Provision Re-Create
         // $.manage.makeEventReCreate(); On CLick
     };

     $.manage.makeEventReCreate = function() {
         
        $('body').css({'cursor':'wait'});
                
        $.post('?cmd=manage_service&action=doRecreate',{
            "account_id": $("#account-id").val(),
            "server_id": $("#server-id").val(),                   
            "client_id": $("#client-id").val()
        }, function(data) {
            parse_response(data);
            $('body').css({'cursor':'default'});
        });
        
     };
     
     $.manage.makeEventOnOffActions = function() {
         
         $(".manage-service-switch-actions").change(function () {
             $.manage.makeEventActions($(this), 'switch');
         });
         
     };
     
     $.manage.makeEventEscPeriodActions = function() {
         
         $(".manage-service-actions-esc-period").change(function () {
             $.manage.makeEventActions($(this), 'period');
         });
         
     };
     
     $.manage.makeEventActions = function($$, callBack) {
         
         var elem = $$;
         var key = elem.attr('attrKey');
         
         if (callBack == 'switch') {
             var period = elem.attr('attrPeriod');         
             var status = (elem.is(':checked') == true) ? 0 : 1;
         } else if (callBack == 'period') {
             var period = elem.attr('id');
             var status = ($('#' + elem.attr('attrSwitch')).is(':checked') == true) ? 0 : 1;
         }
         
         
         
         var api_call = {
                 cmd    : "manage_service",
                 action: "doActions",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 action_id: aActions[aActions[key]]['actionid'],
                 status: status,
                 esc_period: $('#' + period).val()
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      //doError: function(data) {
                      //},
                      doSuccess: function(json) {
                            
                            /*
                            if (status == 0 || status == "0") {
                                $("#zabbix-action-ping-esc-period").prop({ "disabled": false });
                            } else {
                                $("#zabbix-action-ping-esc-period").prop({ "disabled": true });
                            }
                            */
                      
                            //$.zabbix.makeUiPing();
                      }
               }
        });
         
         
     };
     
     $.manage.makeUiActions = function() {
         // Return Onclick Once Tabs
         //if ($("#tabs-once-mn-notification").val() == "1") {
         //   return true; 
         //}
         
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewActions",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val()
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                         
                         // Onclick Once Tabs
                         //$("#tabs-once-mn-notification").val("1");
                      }
               }
        });
        
     };
     
     $.manage.makeUiNginx = function() {
         // Nginx Connection
         $.manage.makeUiNginxConnectSlider();
         $.manage.makeUiNginxConnect();
         
         // Nginx Thread
         $.manage.makeUiNginxThreadSlider();
         $.manage.makeUiNginxThread();
     };
     
     $.manage.makeUiExim = function() {
         // Exim Status
         $.manage.makeUiEximStatisticSlider();
         $.manage.makeUiEximStatistic();
         
         // Exim Traffic
         $.manage.makeUiEximTrafficSlider();
         $.manage.makeUiEximTraffic();
     };
     
     $.manage.makeUiNamed = function() {
         // Named Session
         $.manage.makeUiNamedSessionSlider();
         $.manage.makeUiNamedSession();
     };
     
     $.manage.makeUiMysqls = function() {
         // Mysql Connect
         // $.manage.makeUiMysqlConnectSlider();
         // $.manage.makeUiMysqlConnect();
         
         // Mysql Threads
         // $.manage.makeUiMysqlThreadSlider();
         // $.manage.makeUiMysqlThread();
         
         // Mysql
         $.manage.makeUiMysqlSlider();
         $.manage.makeUiMysql();
         
         // MyIsam
         $.manage.makeUiMyIsamSlider();
         $.manage.makeUiMyIsam();
         
         // InnoDb
         $.manage.makeUiInnodbSlider();
         $.manage.makeUiInnodb();
         
     };
     
     $.manage.makeUiMemory = function() {
         // Memory Usage
         $.manage.makeUiMemoryUsageSlider();
         $.manage.makeUiMemoryUsage();
         
         // Swap Usage
         $.manage.makeUiSwapUsageSlider();
         $.manage.makeUiSwapUsage();
     };
     
     $.manage.makeUiDisk = function() {
         // Free Disk Space
         $.manage.makeUiFreeDiskSpaceSlider();
         $.manage.makeUiFreeDiskSpace();  
     };
     
     $.manage.makeUiCpu = function() {
         // CPU Load
         $.manage.makeUiCpuLoadSlider();
         $.manage.makeUiCpuLoad();
         
         // CPU Jump
         $.manage.makeUiCpuJumpSlider();
         $.manage.makeUiCpuJump();
     };
     
     $.manage.makeUiApache = function() {
         // Apache Stat
         $.manage.makeUiApacheStatSlider();
         $.manage.makeUiApacheStat();
     };
     
     $.manage.makeUiNamedSessionSlider = function() {
         
         var label = "History Named Session: ";
         
         $("#named-session-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#named-session-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiNamedSession();
              }
           });
         
          $("#named-session-display-value-slider").html(label + $("#named-session-slider").slider("value") + " days");
           
     };
     
     $.manage.makeUiNamedSession = function() {
         
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewNamedSession",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#named-session-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
         
     };
     
     $.manage.makeUiInnodbSlider = function() {
         
         var label = "History InnoDB: ";
         
         for (i=0;i<myInnodbCount;i++) {

             $("#innodb-slider-" + i).slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                //$("#free-disk-space-display-value-slider-" + i).html(label +ui.value + " days");
                $('#' + $(this).attr('attrTargetDisplaySlide')).html(label + ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  
                  var attrKey = $(this).attr('attrKey');
                  var attrGraphId = $(this).attr('attrGraphId');
                  var attrTargetDisplayGraph = $(this).attr('attrTargetDisplayGraph');
                  var attrType = $(this).attr('attrType');
                  $.manage.makeUiMySqlByType(ui.value, attrKey, attrGraphId, attrTargetDisplayGraph, attrType);
                  
              }
           });
         
           $("#innodb-display-value-slider-" + i).html(label + $("#innodb-slider-" + i).slider("value") + " days");
             
         }
         
     };
     
     $.manage.makeUiInnodb = function() {
         
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewInnodb",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val()/*,
                 period : $("#swap-usage-slider").slider("value")*/
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
         
     };
     
     $.manage.makeUiMyIsamSlider = function() {
         var label = "History MyISAM: ";
         
         for (i=0;i<myIsamCount;i++) {

             $("#myisam-slider-" + i).slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                //$("#free-disk-space-display-value-slider-" + i).html(label +ui.value + " days");
                $('#' + $(this).attr('attrTargetDisplaySlide')).html(label + ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  
                  var attrKey = $(this).attr('attrKey');
                  var attrGraphId = $(this).attr('attrGraphId');
                  var attrTargetDisplayGraph = $(this).attr('attrTargetDisplayGraph');
                  var attrType = $(this).attr('attrType');
                  $.manage.makeUiMySqlByType(ui.value, attrKey, attrGraphId, attrTargetDisplayGraph, attrType);
                  
              }
           });
         
           $("#myisam-display-value-slider-" + i).html(label + $("#myisam-slider-" + i).slider("value") + " days");
             
         }
         
     };
     
     $.manage.makeUiMyIsam = function() {

         var api_call = {
                 cmd    : "manage_service",
                 action: "viewMyIsam",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val()/*,
                 period : $("#swap-usage-slider").slider("value")*/
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
        
     };
     
     $.manage.makeUiMysqlSlider = function() {
         
         var label = "History MySQL: ";
         
         for (i=0;i<mySqlCount;i++) {

             $("#mysql-slider-" + i).slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                //$("#free-disk-space-display-value-slider-" + i).html(label +ui.value + " days");
                $('#' + $(this).attr('attrTargetDisplaySlide')).html(label + ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  
                  var attrKey = $(this).attr('attrKey');
                  var attrGraphId = $(this).attr('attrGraphId');
                  var attrTargetDisplayGraph = $(this).attr('attrTargetDisplayGraph');
                  var attrType = $(this).attr('attrType');
                  $.manage.makeUiMySqlByType(ui.value, attrKey, attrGraphId, attrTargetDisplayGraph, attrType);
                  
              }
           });
         
           $("#mysql-display-value-slider-" + i).html(label + $("#mysql-slider-" + i).slider("value") + " days");
             
         }
         
     };
     
     $.manage.makeUiMySqlByType = function(period, attrKey, attrGraphId, attrTargetDisplayGraph, attrType) {
        //alert(index + " " + period);
        
        var api_call = {
                 cmd    : "manage_service",
                 action: "viewMySqlByType",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 graph_id: attrGraphId,
                 period: period,
                 type: attrType
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                         
                         setTimeout(function() {
                             
                             var cache_fix = "?cache_fix=" + new Date().getTime();
                             
                             if (attrType == 'mysql') {
                                 
                                var urlImage = "<img id='mysql-history-image-'" + attrKey + " src='" + system_url + json.raiseData['mysql_by_type_graph'] + cache_fix + "' />";
                                $("#mysql-display-graph-" + attrKey).html(urlImage);
                             
                                $('#mysql-display-graph-' + attrKey).css({
                                    'width' : "740px",
                                    'height': 'auto'
                                });
                                $('#mysql-history-image-' + attrKey).css({
                                     'width' : "740px",
                                     'height': "260px"
                                });
                             
                             } else if (attrType == 'myisam') {
                                 
                                var urlImage = "<img id='myisam-history-image-'" + attrKey + " src='" + system_url + json.raiseData['mysql_by_type_graph'] + cache_fix + "' />";
                                $("#myisam-display-graph-" + attrKey).html(urlImage);
                             
                                $('#myisam-display-graph-' + attrKey).css({
                                    'width' : "740px",
                                    'height': 'auto'
                                });
                                $('#myisam-history-image-' + attrKey).css({
                                     'width' : "740px",
                                     'height': "260px"
                                });
                                
                             } else if (attrType == 'innodb') {
                                 
                                var urlImage = "<img id='innodb-history-image-'" + attrKey + " src='" + system_url + json.raiseData['mysql_by_type_graph'] + cache_fix + "' />";
                                $("#innodb-display-graph-" + attrKey).html(urlImage);
                             
                                $('#innodb-display-graph-' + attrKey).css({
                                    'width' : "740px",
                                    'height': 'auto'
                                });
                                $('#innodb-history-image-' + attrKey).css({
                                     'width' : "740px",
                                     'height': "260px"
                                });
                                 
                             }
                             
                             $('.ui-slider-horizontal').css({
                                 'width' : "730px"
                             });
                             
                         }, 1000);
                         
                         
                         /*
                         setTimeout(function() {
             
                             var cache_fix = "?cache_fix=" + new Date().getTime();
                             
                             var urlImage = "<img id='free-disk-space-history-image-'" + attrKey + " src='" + system_url + json.raiseData['mysql_by_type_graph'] + cache_fix + "' />";
                             $("#free-disk-space-display-graph-" + attrKey).html(urlImage);
                             
                             
                             $('.ui-slider-horizontal').css({
                                 'width' : "730px"
                             });
                             $('#free-disk-space-display-graph-' + attrKey).css({
                                 'width' : "740px",
                                 'height': 'auto'
                             });
                             $('#free-disk-space-history-image-' + attrKey).css({
                                 'width' : "740px",
                                 'height': "260px"
                             });
                                
                         }, 1000);
                         */
                         
                         
                         
                      }
               }
        });
        
     };
     
     $.manage.makeUiMysql = function() {
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewMysql",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val()/*,
                 period : $("#swap-usage-slider").slider("value")*/
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
     };
     
     
     $.manage.makeUiFreeDiskSpaceSlider = function() {

         var label = "History Free Disk Space: ";
         
         for (i=0;i<diskCount;i++) {

             $("#free-disk-space-slider-" + i).slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                //$("#free-disk-space-display-value-slider-" + i).html(label +ui.value + " days");
                $('#' + $(this).attr('attrTargetDisplaySlide')).html(label + ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  
                  var attrKey = $(this).attr('attrKey');
                  var attrGraphId = $(this).attr('attrGraphId');
                  var attrTargetDisplayGraph = $(this).attr('attrTargetDisplayGraph');
                  $.manage.makeUiFreeDiskSpaceByDisk(ui.value, attrKey, attrGraphId, attrTargetDisplayGraph);
                  
              }
           });
         
           $("#free-disk-space-display-value-slider-" + i).html(label + $("#free-disk-space-slider-" + i).slider("value") + " days");
             
         }
         
     };
     
     $.manage.makeUiFreeDiskSpaceByDisk = function(period, attrKey, attrGraphId, attrTargetDisplayGraph) {
        //alert(index + " " + period);
        
        var api_call = {
                 cmd    : "manage_service",
                 action: "viewFreeDiskSpaceByDisk",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 graph_id: attrGraphId,
                 period: period
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                          
                         // TODO $.manage.preViewAs(json); // key free_disk_space_by_disk_graph
                         setTimeout(function() {
             
                             var cache_fix = "?cache_fix=" + new Date().getTime();
                             
                             var urlImage = "<img id='free-disk-space-history-image-'" + attrKey + " src='" + system_url + json.raiseData['free_disk_space_by_disk_graph'] + cache_fix + "' />";
                             $("#free-disk-space-display-graph-" + attrKey).html(urlImage);
                             
                             
                             $('.ui-slider-horizontal').css({
                                 'width' : "730px"
                             });
                             $('#free-disk-space-display-graph-' + attrKey).css({
                                 'width' : "740px",
                                 'height': 'auto'
                             });
                             $('#free-disk-space-history-image-' + attrKey).css({
                                 'width' : "740px",
                                 'height': "260px"
                             });
                                
                         }, 1000);
                         
                         
                         
                         
                      }
               }
        });
        
     };
     
     $.manage.makeUiFreeDiskSpace = function() {
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewFreeDiskSpace",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val()/*,
                 period : $("#swap-usage-slider").slider("value")*/
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
     };
     
     $.manage.makeUiSwapUsageSlider = function() {
         
         var label = "History Swap Usage: ";
         
         $("#swap-usage-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#swap-usage-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiSwapUsage();
              }
           });
         
           $("#swap-usage-display-value-slider").html(label + $("#swap-usage-slider").slider("value") + " days");
          
     };
   
     $.manage.makeUiSwapUsage = function() {
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewSwapUsage",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#swap-usage-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
     };
     
     $.manage.makeEventDeleteUserMedia = function($$) {

             if ($('#user-media-table tr').length <= 2) {
                 // 1 Row Disable Delete.
                $.manage.raiseError("Require 1 Email Address.");
                 return false;
             }
         
             attrNum = $$.attr("attrNum");
             attrMediaId = $("#inline-edit-user-media-" + attrNum).attr("attrMediaId");
             emailName = $("#inline-edit-user-media-" + attrNum).text();
             
             if (attrMediaId == "") {
                 $("table#user-media-table tr#tr-user-media-" + attrNum).remove();
             } else {
                 
                 if (!confirm('Are you sure?')) {
                     return false;
                }
                 
                 var api_call = {
                         cmd    : "manage_service",
                         action: "doDeleteUserMedia",
                         
                         account_id: $("#account-id").val(),
                         server_id: $("#server-id").val(),
                         media_id: attrMediaId
                 };
                 
                 $.MN.Ajax.connect($.MN.urls.api(api_call), {
                      waitDialog: function() {},
                      callback: {
                          /*doError: function(data) {
                          },*/
                          doSuccess: function(data) {
                                $("table#user-media-table tr#tr-user-media-" + attrNum).remove();
                          }
                       }
                });
                 
                 
             }
             
     };
     
     $.manage.makeEventAddUserMedia = function($$) {
         
         attrStatus = $$.attr("attrStatus");
         emailName = $$.text();
         
         if (attrStatus == "add") {
             
             var api_call = {
                     cmd    : "manage_service",
                     action: "doAddUserMedia",
                     
                     client_id: $("#client-id").val(),
                     server_id: $("#server-id").val(),
                     emailName: emailName
             };
             
             $.MN.Ajax.connect($.MN.urls.api(api_call), {
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
     
     $.manage.makeEventInlineEdit = function($$, callBack) {
         
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
                
                if ($.manage.isEmail($(this).val()) == true) {
                    
                    connectWith.val($(this).val()).change();
                    elem.text($(this).val());
                    
                    switch (callBack) {
                        case "add":
                            $.manage.makeEventAddUserMedia($$);
                            break;
                        default: break;
                    };
                    
                } else {
                    $.manage.raiseError("Require pattern email !!");
                }
                
                
            }
    
            $(this).remove();
            elem.show();
            
        });

     };
     
     $.manage.makeEventAddRowUserMedia = function() {

         countRow = 0;
         $('#user-media-table tr').each(function() {
             countRow++;
         });
             
        output = '  <tr id="tr-user-media-' + countRow + '">';
        output += '     <td align="left" valign="top" class="bg">';
        output += '          <p id="inline-edit-user-media-' + countRow + '" attrMediaId="" class="inline-edit-user-media-class edit" attrStatus="add" onclick="$.manage.makeEventInlineEdit($(this), \'add\');\">Edit here..</p>';
        output += '     </td>';
        output += '     <td align="center" valign="top" class="bg">';
        output += '         <img class="user-media-remove-media" id="user-media-remove-media-' + countRow + '" attrNum="' + countRow + '" src="' + system_url + 'includes/modules/Hosting/manage_service/public_html/images/delete.gif" alt="Remove Row" onclick="$.manage.makeEventDeleteUserMedia($(this));"/>';
        output += '     </td>';
        output += '</tr>';
             
        $('#user-media-table tr:last').after(output);
         
     };
     
     $.manage.makeUiUserMedia = function() {
         
         // Return Onclick Once Tabs
         //if ($("#tabs-once-mn-notification").val() == "1") {
         //   return true; 
         //}
         
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewUserMedia",
                 
                 client_id: $("#client-id").val(),
                 server_id: $("#server-id").val()
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                      },*/
                      doSuccess: function(json) {
                            $.manage.preViewAs(json);
                            
                            // Onclick Once Tabs
                            //$("#tabs-once-mn-notification").val("1");
                      }
               }
        });
         
     };
     
     $.manage.makeUiNginxThreadSlider = function() {
         var label = "History Nginx Thread Status Usage: ";
         
         $("#nginx-thread-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#nginx-thread-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiNginxThread();
              }
           });
         
           $("#nginx-thread-display-value-slider").html(label + $("#nginx-thread-slider").slider("value") + " days");
     };
     
     $.manage.makeUiNginxThread = function() {
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewNginxThread",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#nginx-thread-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
     };
       
     $.manage.makeUiNginxConnectSlider = function() {
         var label = "History Nginx Connect Usage: ";
         
         $("#nginx-connect-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#nginx-connect-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiNginxConnect();
              }
           });
         
           $("#nginx-connect-display-value-slider").html(label + $("#nginx-connect-slider").slider("value") + " days");
     };
     
     $.manage.makeUiNginxConnect = function() {
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewNginxConnect",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#nginx-connect-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
     };
     
     $.manage.makeUiEximTrafficSlider = function() {
         var label = "History Exim Traffic Usage: ";
         
         $("#exim-traffic-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#exim-traffic-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiEximTraffic();
              }
           });
         
           $("#exim-traffic-display-value-slider").html(label + $("#exim-traffic-slider").slider("value") + " days");
     };
         
     $.manage.makeUiEximTraffic = function() {
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewEximTraffic",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#exim-traffic-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      doError: function(data) {
                          $("#exim-traffic-slider").hide();
                          $("#exim-traffic-display-value-slider").hide();
                      },
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
        
     };
     
     $.manage.makeUiEximStatisticSlider = function() {
          var label = "History Exim Statistic Usage: ";
         
         $("#exim-statistic-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#exim-statistic-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiEximStatistic();
              }
           });
         
           $("#exim-statistic-display-value-slider").html(label + $("#exim-statistic-slider").slider("value") + " days");
     };
     
     $.manage.makeUiEximStatistic = function() {
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewEximStatistic",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#exim-statistic-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
     };
     
     $.manage.makeUiMysqlThreadSlider = function() {
         var label = "History MySQL Thread Usage: ";
         
         $("#mysql-thread-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#mysql-thread-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiMysqlThread();
              }
           });
         
           $("#mysql-thread-display-value-slider").html(label + $("#mysql-thread-slider").slider("value") + " days");
     };
     
     $.manage.makeUiMysqlThread = function() {
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewMysqlThread",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#mysql-thread-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
     };
     
     $.manage.makeUiMysqlConnectSlider = function() {
         var label = "History MySQL Connect Usage: ";
         
         $("#mysql-connect-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#mysql-connect-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiMysqlConnect();
              }
           });
         
        $("#mysql-connect-display-value-slider").html(label + $("#mysql-connect-slider").slider("value") + " days");
     };
     
     $.manage.makeUiMysqlConnect = function() {
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewMysqlConnect",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#mysql-connect-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
     };
     
     $.manage.makeUiApacheStatSlider = function() {
         var label = "History Apache Stat Usage: ";
         
         $("#apache-stat-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#apache-stat-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiApacheStat();
              }
           });
         
        $("#apache-stat-display-value-slider").html(label + $("#apache-stat-slider").slider("value") + " days");
     };
     
     $.manage.makeUiApacheStat = function() {
         /*
         // Return Onclick Once Tabs
         if ($("#tabs-once-bandwidth").val() == "1") {
            return true; 
         }
         */
         
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewApacheStat",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#apache-stat-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
     };
     
     $.manage.makeUiMemoryUsageSlider = function() {
         
         var label = "History Memory Usage: ";
         
         $("#memory-usage-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#memory-usage-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-bandwidth").val("0");
                  $.manage.makeUiMemoryUsage();
              }
           });
         
           $("#memory-usage-display-value-slider").html(label + $("#memory-usage-slider").slider("value") + " days");
           
    };
    
    $.manage.makeUiMemoryUsage = function() {
                  
         /*
         // Return Onclick Once Tabs
         if ($("#tabs-once-bandwidth").val() == "1") {
            return true; 
         }
         */
         
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewMemoryUsage",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#memory-usage-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      /*doError: function(data) {
                      },*/
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                      }
               }
        });
         
    };
     
     $.manage.makeUiCpuJumpSlider = function() {
         
         var label = "History CPU Jumps: ";
         
         $("#cpu-jump-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#cpu-jump-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-mn-cpu-jump").val("0");
                  $.manage.makeUiCpuJump();
              }
           });
         
           $("#cpu-jump-display-value-slider").html(label + $("#cpu-jump-slider").slider("value") + " days");
           
    };
    
    $.manage.makeUiCpuJump = function() {
           
         // Return Onclick Once Tabs
         //if ($("#tabs-once-mn-cpu-jump").val() == "1") {
         //   return true; 
         //}
         
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewCpuJump",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#cpu-jump-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      //doError: function(data) {
                      //},
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                         
                         // Onclick Once Tabs
                         //$("#tabs-once-mn-cpu-jump").val("1");
                      }
               }
        });
         
    };
     
     $.manage.makeUiCpuLoadSlider = function() {
         
         var label = "History CPU Load: ";
         
         $("#cpu-load-slider").slider({
              value: 1,
              min: 1,
              max: 90,
              step: 1,
              slide: function( event, ui ) {
                $("#cpu-load-display-value-slider").html(label +ui.value + " days");
              },
              change: function(event, ui) { 
                  //alert("value = " + ui.value);
                  
                  // Onclick Once Tabs
                  // $("#tabs-once-mn-cpu-load").val("0");
                  $.manage.makeUiCpuLoad();
              }
           });
         
           $("#cpu-load-display-value-slider").html(label + $("#cpu-load-slider").slider("value") + " days");
           
    };
    
    $.manage.makeUiCpuLoad = function() {
         
         // Return Onclick Once Tabs
         // if ($("#tabs-once-mn-cpu-load").val() == "1") {
         //   return true; 
         // }
         
         var api_call = {
                 cmd    : "manage_service",
                 action: "viewCpuLoad",
                 
                 account_id: $("#account-id").val(),
                 server_id: $("#server-id").val(),
                 period : $("#cpu-load-slider").slider("value")
         };
         
         $.MN.Ajax.connect($.MN.urls.api(api_call), {
                  waitDialog: function() {},
                  callback: {
                      //doError: function(data) {
                      //},
                      doSuccess: function(json) {
                         $.manage.preViewAs(json);
                         
                         // Onclick Once Tabs
                         // $("#tabs-once-mn-cpu-load").val("1");alert('xx');
                      }
               }
        });
         
    };
    
    $.manage.setVarCpuLoad = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aCpu[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };
    
    $.manage.setCssCpuLoad = function() {
         
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='cpu-load-history-image' src='" + system_url + aCpu["cpu_load_graph"] + cache_fix + "' />";
             $("#cpu-load-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#cpu-load-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#cpu-load-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
                
         }, 1000);
         
     };
     
     $.manage.setVarCpuJump = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aCpu[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };
    
    $.manage.setCssCpuJump = function() {
         
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='cpu-jump-history-image' src='" + system_url + aCpu["cpu_jump_graph"] + cache_fix + "' />";
             $("#cpu-jump-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#cpu-jump-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#cpu-jump-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
                
         }, 1000);
         
     };
     
     $.manage.setVarMemoryUsage = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aCpu[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };
    
    $.manage.setCssMemoryUsage = function() {
         
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='memory-usage-history-image' src='" + system_url + aCpu["memory_usage_graph"] + cache_fix + "' />";
             $("#memory-usage-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#memory-usage-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#memory-usage-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
                
         }, 1000);
         
     };
    
    
    $.manage.setVarApacheStat = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aApache[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };
    
    $.manage.setCssApacheStat = function() {
         
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='apache-stat-history-image' src='" + system_url + aApache["apache_stat_graph"] + cache_fix + "' />";
             $("#apache-stat-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#apache-stat-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#apache-stat-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
             
         }, 1000);
         
     };
     
     $.manage.setVarMysqlConnect = function (json) {
        try {
             jQuery.each(json.raiseData, function(key, value) {
                 aMysql[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
     };
     
     $.manage.setCssMysqlConnect = function() {
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='mysql-connect-history-image' src='" + system_url + aMysql["mysql_connect_graph"] + cache_fix + "' />";
             $("#mysql-connect-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#mysql-connect-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#mysql-connect-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
                
         }, 1000);
     };
     
     $.manage.setVarMysqlThread = function (json) {
        try {
             jQuery.each(json.raiseData, function(key, value) {
                 aMysql[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
     };
     
     $.manage.setCssMysqlThread = function() {
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='mysql-thread-history-image' src='" + system_url + aMysql["mysql_thread_graph"] + cache_fix + "' />";
             $("#mysql-thread-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#mysql-thread-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#mysql-thread-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
             
         }, 1000);
     };
     
     $.manage.setVarEximStatistic = function (json) {
        try {
             jQuery.each(json.raiseData, function(key, value) {
                 aExim[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
     };
     
     $.manage.setCssEximStatistic = function() {
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='exim-statistic-history-image' src='" + system_url + aExim["exim_statistic_graph"] + cache_fix + "' />";
             $("#exim-statistic-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#exim-statistic-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#exim-statistic-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
             
         }, 1000);
     };
     
    $.manage.setVarEximTraffic = function (json) {
        try {
             jQuery.each(json.raiseData, function(key, value) {
                 aExim[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
     };
     
     $.manage.setCssEximTraffic = function() {
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='exim-traffic-history-image' src='" + system_url + aExim["exim_traffic_graph"] + cache_fix + "' />";
             $("#exim-traffic-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#exim-traffic-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#exim-traffic-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
             
         }, 1000);
     };
    
    $.manage.setVarNginxConnect = function (json) {
        try {
             jQuery.each(json.raiseData, function(key, value) {
                 aNginx[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
     };
     
     $.manage.setCssNginxConnect = function() {
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='nginx-connect-history-image' src='" + system_url + aNginx["nginx_connect_graph"] + cache_fix + "' />";
             $("#nginx-connect-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#nginx-connect-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#nginx-connect-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
                     
         }, 1000);
     };
     
    $.manage.setVarNginxThread = function (json) {
        try {
             jQuery.each(json.raiseData, function(key, value) {
                 aNginx[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
     };
     
     $.manage.setCssNginxThread = function() {
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='nginx-thread-history-image' src='" + system_url + aNginx["nginx_thread_graph"] + cache_fix + "' />";
             $("#nginx-thread-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#nginx-thread-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#nginx-thread-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
                         
         }, 1000);
     };
     
    $.manage.setVarUserMedia = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aUserMedia[key] = value;
             });
        } catch (e) {
            // Handle exception
        }
     };
     
     $.manage.setCssUserMedia = function() {
         
         try {
             
             var output = '<table id="user-media-table" width="100%" cellpadding="0" cellspacing="0" class="tbl-status">';
             output +=      '<tbody>';
             output +=          '<tr>';
             output +=              '<th align="left" valign="top" width="90%">Email</th>';
             output +=              '<th align="center" valign="top">Delete</th>';
             output +=          '</tr>';
            
             
             jQuery.each(aUserMedia.aMedia, function(key, value) {

                 output += '        <tr id="tr-user-media-' + key + '">';
                 output += '            <td align="left" valign="top" class="bg">';
                 output += '                <p id="inline-edit-user-media-' + key + '" class="inline-edit-user-media-class" attrStatus="edit" attrMediaId="' + aUserMedia.aMedia[key].mediaid + '" attrUserId="' + aUserMedia.aMedia[key].userid + '" onclick="$.zabbix.manage($(this), \'edit\');">' + aUserMedia.aMedia[key].sendto + '</p>';
                 output += '            </td>';
                 output += '            <td align="center" valign="top" class="bg">';
                 output += '                <img class="user-media-remove-media" id="user-media-remove-media-' + key + '" attrNum="' + key + '" src="'+  system_url + 'includes/modules/Hosting/manage_service/public_html/images/delete.gif" alt="Remove Row" onclick="$.manage.makeEventDeleteUserMedia($(this));"/>';
                 output += '            </td>';
                 output += '        </tr>';
                 
             });
             
             
             output +=  '</tbody>';
             output += '</table>';
             output += '<div class="position"><a id="add-row-user-media" href="javascript:void(0);" class="btn" onclick="$.manage.makeEventAddRowUserMedia();">Add Email Address</a></div>';
                
             $("#manage-service-user-media-display").html(output);  
             
        } catch (e) {
            // Handle exception
        }
        
     };
     
     $.manage.setCssCpuProcessorLoad = function() {
         
         // Show Box
         $('#box-cpu').show();
         
         if (aActions[aActions['action-cpu-processor-load-high']]['status'] == "0" 
            || aActions[aActions['action-cpu-processor-load-high']]['status'] == 0) {
             // ON
             $("#manage-service-switch-cpu-processor-load").prop({ "checked": true });
             
             $("#manage-service-action-cpu-processor-load-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#manage-service-switch-cpu-processor-load").prop({ "checked": false });
             
             $("#manage-service-action-cpu-processor-load-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#manage-service-action-cpu-processor-load-esc-period").val(aActions[aActions['action-cpu-processor-load-high']]['esc_period']);
         
         // Set ON/OFF
         $("#manage-service-switch-cpu-processor-load").iButton("destroy");
         $("#manage-service-switch-cpu-processor-load").iButton();
         
         
         if (aActions['trigger']['trigger-cpu-processor-load-high']['description2'] != undefined 
            && aActions['trigger']['trigger-cpu-processor-load-high']['description2'] != null) {
             $('#cpu-processor-load-high-des2').html(aActions['trigger']['trigger-cpu-processor-load-high']['description2']);
         }
         
         
     };
     
     $.manage.setCssPing = function() {
         
         // Show Box
         $('#box-ping').show();
         
         if (aActions[aActions['action-key-ping']]['status'] == "0" || aActions[aActions['action-key-ping']]['status'] == 0) {
             // ON
             $("#manage-service-switch-action-ping").prop({ "checked": true });
             
             $("#manage-service-action-ping-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#manage-service-switch-action-ping").prop({ "checked": false });
             
             $("#manage-service-action-ping-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#manage-service-action-ping-esc-period").val(aActions[aActions['action-key-ping']]['esc_period']);
         
         // Set ON/OFF
         $("#manage-service-switch-action-ping").iButton("destroy");
         $("#manage-service-switch-action-ping").iButton();
         
     };
     
     $.manage.setCssPingSms = function() {
         
         // Show Box
         $('#box-ping-sms').show();
         
         if (aActions[aActions['action-key-ping-sms']]['status'] == "0" || aActions[aActions['action-key-ping-sms']]['status'] == 0) {
             // ON
             $("#manage-service-switch-action-ping-sms").prop({ "checked": true });
             
             $("#manage-service-action-ping-sms-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#manage-service-switch-action-ping-sms").prop({ "checked": false });
             
             $("#manage-service-action-ping-sms-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#manage-service-action-ping-sms-esc-period").val(aActions[aActions['action-key-ping-sms']]['esc_period']);
         
         // Set ON/OFF
         $("#manage-service-switch-action-ping-sms").iButton("destroy");
         $("#manage-service-switch-action-ping-sms").iButton();
         
     };
     
     $.manage.setCssMemoryLackFreeSwap = function() {
         
         // Show Box
         $('#box-memory').show();
         
         if (aActions[aActions['action-memory-lack-free-swap']]['status'] == "0" 
            || aActions[aActions['action-memory-lack-free-swap']]['status'] == 0) {
             // ON
             $("#manage-service-switch-memory-lack-free-swap").prop({ "checked": true });
             
             $("#manage-service-action-memory-lack-free-swap-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#manage-service-switch-memory-lack-free-swap").prop({ "checked": false });
             
             $("#manage-service-action-memory-lack-free-swap-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#manage-service-action-memory-lack-free-swap-esc-period").val(aActions[aActions['action-memory-lack-free-swap']]['esc_period']);
         
         // Set ON/OFF
         $("#manage-service-switch-memory-lack-free-swap").iButton("destroy");
         $("#manage-service-switch-memory-lack-free-swap").iButton();
         
         
         if (aActions['trigger']['trigger-memory-lack-free-swap']['description2'] != undefined 
            && aActions['trigger']['trigger-memory-lack-free-swap']['description2'] != null) {
            
            $('#memory-lack-free-swap-des2').html(aActions['trigger']['trigger-memory-lack-free-swap']['description2']);
         }
         
         
     };
     
     $.manage.setCssMemoryLackAvailable = function() {
         
         // Show Box
         $('#box-memory').show();
         
         if (aActions[aActions['action-memory-lack-available-memory']]['status'] == "0" 
            || aActions[aActions['action-memory-lack-available-memory']]['status'] == 0) {
             // ON
             $("#mn-switch-memory-lack-available-memory").prop({ "checked": true });
             
             $("#mn-action-memory-lack-available-memory-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-memory-lack-available-memory").prop({ "checked": false });
             
             $("#mn-action-memory-lack-available-memory-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#mn-action-memory-lack-available-memory-esc-period").val(aActions[aActions['action-memory-lack-available-memory']]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-memory-lack-available-memory").iButton("destroy");
         $("#mn-switch-memory-lack-available-memory").iButton();
         
         
         if (aActions['trigger']['trigger-memory-lack-available']['description2'] != undefined 
            && aActions['trigger']['trigger-memory-lack-available']['description2'] != null) {
          
            $('#memory-lack-available-memory-des2').html(aActions['trigger']['trigger-memory-lack-available']['description2']);
         }
                  
     };
     
     
     $.manage.setCssDiskIoOverLoad = function() {
         
         // Show Box
         $('#box-disk').show();
         
         if (aActions[aActions['action-disk-io-overload']]['status'] == "0" 
            || aActions[aActions['action-disk-io-overload']]['status'] == 0) {
             // ON
             $("#mn-switch-disk-io-overload").prop({ "checked": true });
             
             $("#mn-action-disk-io-overload-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-disk-io-overload").prop({ "checked": false });
             
             $("#mn-action-disk-io-overload-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#mn-action-disk-io-overload-esc-period").val(aActions[aActions['action-memory-lack-available-memory']]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-disk-io-overload").iButton("destroy");
         $("#mn-switch-disk-io-overload").iButton();
         
         if (aActions['trigger']['trigger-disk-io-overload']['description2'] != undefined 
            && aActions['trigger']['trigger-disk-io-overload']['description2'] != null) {
         
            $('#disk-io-overload-des2').html(aActions['trigger']['trigger-disk-io-overload']['description2']);       
         }
         
         
     };
     
     $.manage.setCssMysqlThreadMoreThan100 = function() {
         
         // Show Box
         $('#box-mysql').show();
         
         if (aActions[aActions['action-mysql-thread-more-than-100']]['status'] == "0" 
            || aActions[aActions['action-mysql-thread-more-than-100']]['status'] == 0) {
             // ON
             $("#mn-switch-mysql-thread-more-than-100").prop({ "checked": true });
             
             $("#mn-action-mysql-thread-more-than-100-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-mysql-thread-more-than-100").prop({ "checked": false });
             
             $("#mn-action-mysql-thread-more-than-100-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#mn-action-mysql-thread-more-than-100-esc-period").val(aActions[aActions['action-mysql-thread-more-than-100']]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-mysql-thread-more-than-100").iButton("destroy");
         $("#mn-switch-mysql-thread-more-than-100").iButton();
         
         if (aActions['trigger']['trigger-mysql-thread-more-than-100']['description2'] != undefined 
            && aActions['trigger']['trigger-mysql-thread-more-than-100']['description2'] != null) {
                
            $('#mysql-thread-more-than-100-des2').html(aActions['trigger']['trigger-mysql-thread-more-than-100']['description2']);
         }
         
     };  
     
     $.manage.setCssMysqlUtilizationMoreThan95 = function() {
         
         // Show Box
         $('#box-mysql').show();
         
         if (aActions[aActions['action-mysql-connection-utilization-more-than-95']]['status'] == "0" 
            || aActions[aActions['action-mysql-connection-utilization-more-than-95']]['status'] == 0) {
             // ON
             $("#mn-switch-mysql-connection-utilization-more-than-95").prop({ "checked": true });
             
             $("#mn-action-mysql-connection-utilization-more-than-95-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-mysql-connection-utilization-more-than-95").prop({ "checked": false });
             
             $("#mn-action-mysql-connection-utilization-more-than-95-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#mn-action-mysql-connection-utilization-more-than-95-esc-period").val(aActions[aActions['action-mysql-connection-utilization-more-than-95']]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-mysql-connection-utilization-more-than-95").iButton("destroy");
         $("#mn-switch-mysql-connection-utilization-more-than-95").iButton();
         
         if (aActions['trigger']['trigger-mysql-connection-utilization-more-than-95']['description2'] != undefined 
            && aActions['trigger']['trigger-mysql-connection-utilization-more-than-95']['description2'] != null) {
         
            $('#mysql-connection-utilization-more-than-95-des2').html(aActions['trigger']['trigger-mysql-connection-utilization-more-than-95']['description2']);       
         }
         
     };
     
     $.manage.setCssMysqlDown = function() {
         
         // Show Box
         $('#box-mysql').show();
         
         if (aActions[aActions['action-mysql-down']]['status'] == "0" 
            || aActions[aActions['action-mysql-down']]['status'] == 0) {
             // ON
             $("#mn-switch-mysql-down").prop({ "checked": true });
             
             $("#mn-action-mysql-down-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-mysql-down").prop({ "checked": false });
             
             $("#mn-action-mysql-down-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#mn-action-mysql-down-esc-period").val(aActions[aActions['action-mysql-down']]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-mysql-down").iButton("destroy");
         $("#mn-switch-mysql-down").iButton();
         
         if (aActions['trigger']['trigger-mysql-down']['description2'] != undefined 
            && aActions['trigger']['trigger-mysql-down']['description2'] != null) {
                
            $('#mysql-down-des2').html(aActions['trigger']['trigger-mysql-down']['description2']);
         }
         
     };
     
     $.manage.setCssEximQueueMore1000 = function() {
         
         // Show Box
         $('#box-exim').show();
         
         if (aActions[aActions['action-exim-queue-more-than-1000']]['status'] == "0" 
            || aActions[aActions['action-exim-queue-more-than-1000']]['status'] == 0) {
             // ON
             $("#mn-switch-exim-queue-more-than-1000").prop({ "checked": true });
             
             $("#mn-action-exim-queue-more-than-1000-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-exim-queue-more-than-1000").prop({ "checked": false });
             
             $("#mn-action-exim-queue-more-than-1000-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#mn-action-exim-queue-more-than-1000-esc-period").val(aActions[aActions['action-exim-queue-more-than-1000']]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-exim-queue-more-than-1000").iButton("destroy");
         $("#mn-switch-exim-queue-more-than-1000").iButton();
         
         
         if (aActions['trigger']['trigger-exim-queue-more-than-1000']['description2'] != undefined 
            && aActions['trigger']['trigger-exim-queue-more-than-1000']['description2'] != null) {
         
            $('#exim-queue-more-than-1000-des2').html(aActions['trigger']['trigger-exim-queue-more-than-1000']['description2']);       
         }
         
         
     };
     
     $.manage.setCssNginxDown = function() {
         
         // Show Box
         $('#box-nginx').show();
         
         if (aActions[aActions['action-nginx-down']]['status'] == "0" 
            || aActions[aActions['action-nginx-down']]['status'] == 0) {
             // ON
             $("#mn-switch-nginx-down").prop({ "checked": true });
             
             $("#mn-action-nginx-down-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-nginx-down").prop({ "checked": false });
             
             $("#mn-action-nginx-down-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#mn-action-nginx-down-esc-period").val(aActions[aActions['action-nginx-down']]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-nginx-down").iButton("destroy");
         $("#mn-switch-nginx-down").iButton();
         
         if (aActions['trigger']['trigger-nginx-down']['description2'] != undefined 
            && aActions['trigger']['trigger-nginx-down']['description2'] != null) {
                
            $('#nginx-down-des2').html(aActions['trigger']['trigger-nginx-down']['description2']);
         }
         
         
     };
     
     
     $.manage.setCssNamedDown = function() {
         
         // Show Box
         $('#box-named').show();
         
         if (aActions[aActions['action-named-down']]['status'] == "0" 
            || aActions[aActions['action-named-down']]['status'] == 0) {
             // ON
             $("#mn-switch-named-down").prop({ "checked": true });
             
             $("#mn-action-named-down-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-named-down").prop({ "checked": false });
             
             $("#mn-action-named-down-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#mn-action-named-down-esc-period").val(aActions[aActions['action-named-down']]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-named-down").iButton("destroy");
         $("#mn-switch-named-down").iButton();
         
         if (aActions['trigger']['trigger-named-down']['description2'] != undefined 
            && aActions['trigger']['trigger-named-down']['description2'] != null) {
                
            $('#named-down-des2').html(aActions['trigger']['trigger-named-down']['description2']);
         }
         
         
     };
     
     $.manage.setCssApacheDown = function() {
         
         // Show Box
         $('#box-apache').show();
         
         if (aActions[aActions['action-apache-down']]['status'] == "0" 
            || aActions[aActions['action-apache-down']]['status'] == 0) {
             // ON
             $("#mn-switch-apache-down").prop({ "checked": true });
             
             $("#mn-action-apache-down-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-apache-down").prop({ "checked": false });
             
             $("#mn-action-apache-down-esc-period").prop({ "disabled": true });
         }
         
         // Set Period
         $("#mn-action-apache-down-esc-period").val(aActions[aActions['action-apache-down']]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-apache-down").iButton("destroy");
         $("#mn-switch-apache-down").iButton();

         if (aActions['trigger']['trigger-apache-down']['description2'] != undefined 
            && aActions['trigger']['trigger-apache-down']['description2'] != null) {
          
            $('#apache-down-des2').html(aActions['trigger']['trigger-apache-down']['description2']);         
         }
         
         
     };

     $.manage.setCssFreeDiskSpaceVolume = function(indexVolume) {
         
         // Show Box
         $('#box-free-disk-space').show();
         
         if (aActions[aActions['action-free-disk-space-volume-' + indexVolume]]['status'] == "0" 
            || aActions[aActions['action-free-disk-space-volume-' + indexVolume]]['status'] == 0) {
             // ON
             $("#mn-switch-free-disk-space-volume-" + indexVolume).prop({ "checked": true });
             
             $("#mn-action-free-disk-space-volume-" + indexVolume + "-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-free-disk-space-volume-" + indexVolume).prop({ "checked": false });
             
             $("#mn-action-free-disk-space-volume-" + indexVolume + "-esc-period").prop({ "disabled": true });
         }
         
         
         // Set Period
         $("#mn-action-free-disk-space-volume-" + indexVolume + "-esc-period").val(aActions[aActions['action-free-disk-space-volume-' + indexVolume]]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-free-disk-space-volume-" + indexVolume).iButton("destroy");
         $("#mn-switch-free-disk-space-volume-" + indexVolume).iButton();
     };
     
     $.manage.setCssRaidStatus = function(indexVolume) {
         
         // Show Box
         $('#box-raid').show();
         
         if (aActions[aActions['action-raid-status-' + indexVolume]]['status'] == "0" 
            || aActions[aActions['action-raid-status-' + indexVolume]]['status'] == 0) {
             // ON
             $("#mn-switch-raid-status-" + indexVolume).prop({ "checked": true });
             
             $("#mn-action-raid-status-" + indexVolume + "-esc-period").prop({ "disabled": false });
         } else {
             // OFF
             $("#mn-switch-raid-status-" + indexVolume).prop({ "checked": false });
             
             $("#mn-action-raid-status-" + indexVolume + "-esc-period").prop({ "disabled": true });
         }
         
         
         // Set Period
         $("#mn-action-raid-status-" + indexVolume + "-esc-period").val(aActions[aActions['action-raid-status-' + indexVolume]]['esc_period']);
         
         // Set ON/OFF
         $("#mn-switch-raid-status-" + indexVolume).iButton("destroy");
         $("#mn-switch-raid-status-" + indexVolume).iButton();
     };
     
     $.manage.setVarSwapUsage = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aMemory[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };
    
    $.manage.setCssSwapUsage = function() {
         
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='swap-usage-history-image' src='" + system_url + aMemory["swap_usage_graph"] + cache_fix + "' />";
             $("#swap-usage-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#swap-usage-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#swap-usage-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
                
         }, 1000);
         
     };
     
     $.manage.setVarNamedSession = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aNamed[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };
    
    $.manage.setCssNamedSession = function() {
         
         // SET IMAGE GRAPH
         setTimeout(function() {
             
             var cache_fix = "?cache_fix=" + new Date().getTime();
             
             var urlImage = "<img id='named-session-history-image' src='" + system_url + aNamed["named_session_graph"] + cache_fix + "' />";
             $("#named-session-display-graph").html(urlImage);
             
             $('.ui-slider-horizontal').css({
                 'width' : "730px"
             });
             $('#named-session-display-graph').css({
                 'width' : "740px",
                 'height': "270px"
             });
             $('#named-session-history-image').css({
                 'width' : "740px",
                 'height': "260px"
             });
                
         }, 1000);
         
     };

     $.manage.setVarFreeDiskSpace = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aDisk[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };
   
    $.manage.setCssFreeDiskSpace = function() {
        
        jQuery.each(aDisk, function(key, value) {

            setTimeout(function() {
             
                 var cache_fix = "?cache_fix=" + new Date().getTime();
                 
                 var urlImage = "<img id='free-disk-space-history-image-'" + key + " src='" + system_url + aDisk[key]['imageName'] + cache_fix + "' />";
                 $("#free-disk-space-display-graph-" + key).html(urlImage);
                 
                 
                 $('.ui-slider-horizontal').css({
                     'width' : "730px"
                 });
                 $('#free-disk-space-display-graph-' + key).css({
                     'width' : "740px",
                     'height': 'auto'
                 });
                 $('#free-disk-space-history-image-' + key).css({
                     'width' : "740px",
                     'height': "260px"
                 });
                    
             }, 1000);
                 
        });
        
    };
    
    $.manage.setVarMysql = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aMysql[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };

    $.manage.setCssMysql = function() {
        
        jQuery.each(aMysql, function(key, value) {

            setTimeout(function() {
             
                 var cache_fix = "?cache_fix=" + new Date().getTime();
                 
                 var urlImage = "<img id='mysql-history-image-'" + key + " src='" + system_url + aMysql[key]['imageName'] + cache_fix + "' />";
                 $("#mysql-display-graph-" + key).html(urlImage);
                 
                 
                 $('.ui-slider-horizontal').css({
                     'width' : "730px"
                 });
                 $('#mysql-display-graph-' + key).css({
                     'width' : "740px",
                     'height': 'auto'
                 });
                 $('#mysql-history-image-' + key).css({
                     'width' : "740px",
                     'height': "260px"
                 });
                    
             }, 1000);
                 
        });
        
    };
    
    $.manage.setVarMyIsam = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aMyIsam[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };

    $.manage.setCssMyIsam = function() {
        
        jQuery.each(aMyIsam, function(key, value) {

            setTimeout(function() {
             
                 var cache_fix = "?cache_fix=" + new Date().getTime();
                 
                 var urlImage = "<img id='myisam-history-image-'" + key + " src='" + system_url + aMyIsam[key]['imageName'] + cache_fix + "' />";
                 $("#myisam-display-graph-" + key).html(urlImage);
                 
                 
                 $('.ui-slider-horizontal').css({
                     'width' : "730px"
                 });
                 $('#myisam-display-graph-' + key).css({
                     'width' : "740px",
                     'height': 'auto'
                 });
                 $('#myisam-history-image-' + key).css({
                     'width' : "740px",
                     'height': "260px"
                 });
                    
             }, 1000);
                 
        });
        
    };

    $.manage.setVarInnodb = function(json) {
         try {
             jQuery.each(json.raiseData, function(key, value) {
                 aInnodb[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
    };

    $.manage.setCssInnodb = function() {
        
        jQuery.each(aInnodb, function(key, value) {

            setTimeout(function() {
             
                 var cache_fix = "?cache_fix=" + new Date().getTime();
                 
                 var urlImage = "<img id='innodb-history-image-'" + key + " src='" + system_url + aInnodb[key]['imageName'] + cache_fix + "' />";
                 $("#innodb-display-graph-" + key).html(urlImage);
                 
                 
                 $('.ui-slider-horizontal').css({
                     'width' : "730px"
                 });
                 $('#innodb-display-graph-' + key).css({
                     'width' : "740px",
                     'height': 'auto'
                 });
                 $('#innodb-history-image-' + key).css({
                     'width' : "740px",
                     'height': "260px"
                 });
                    
             }, 1000);
                 
        });
        
    };

    $.manage.setVarActions = function (json) {
        try {
             jQuery.each(json.raiseData, function(key, value) {
                 aActions[key] = value;
            });
        } catch (e) {
            // Handle exception
        }
     };
     
     $.manage.setCssActions = function() {
         setTimeout(function() {
             
             accountId = $("#account-id").val();
             
             jQuery.each(aActions, function(key, value) {
                 
                 actionName = aActions[key]['name'];
                 
                 switch(actionName) {
                     case 'a-' + accountId + '-ping':
                         aActions['action-key-ping'] = key;
                         $.manage.setCssPing();
                       break;
                     case 'a-' + accountId + '-ping-sms':
                         aActions['action-key-ping-sms'] = key;
                         $.manage.setCssPingSms();
                       break; 
                     case 'a-' + accountId + '-cpu-processor-load-high':
                         aActions['action-cpu-processor-load-high'] = key;
                         $.manage.setCssCpuProcessorLoad();
                       break;
                     case 'a-' + accountId + '-memory-lack-free-swap':
                         aActions['action-memory-lack-free-swap'] = key;
                         $.manage.setCssMemoryLackFreeSwap();
                       break;
                     case 'a-' + accountId + '-memory-lack-available':
                         aActions['action-memory-lack-available-memory'] = key;
                         $.manage.setCssMemoryLackAvailable();
                       break;
                     case 'a-' + accountId + '-apache-down':
                         aActions['action-apache-down'] = key;
                         $.manage.setCssApacheDown();
                       break;  
                     case 'a-' + accountId + '-disk-io-overload':
                         aActions['action-disk-io-overload'] = key;
                         $.manage.setCssDiskIoOverLoad();
                       break;
                     case 'a-' + accountId + '-mysql-thread-more-than-100':
                         aActions['action-mysql-thread-more-than-100'] = key;
                         $.manage.setCssMysqlThreadMoreThan100();
                       break;
                     case 'a-' + accountId + '-mysql-connection-utilization-more-than-95':
                         aActions['action-mysql-connection-utilization-more-than-95'] = key;
                         $.manage.setCssMysqlUtilizationMoreThan95();
                       break;
                     case 'a-' + accountId + '-mysql-down':
                         aActions['action-mysql-down'] = key;
                         $.manage.setCssMysqlDown();
                       break;
                     case 'a-' + accountId + '-exim-queue-more-than-1000':
                         aActions['action-exim-queue-more-than-1000'] = key;
                         $.manage.setCssEximQueueMore1000();
                       break;
                     case 'a-' + accountId + '-nginx-down':
                         aActions['action-nginx-down'] = key;
                         $.manage.setCssNginxDown();
                       break;
                     case 'a-' + accountId + '-named-down':
                         aActions['action-named-down'] = key;
                         $.manage.setCssNamedDown();
                       break;  
                     default:
                        
                        var pattern = /-free-disk-space-volume-/;
                        if (pattern.test(actionName)) {
                            var aMatch = actionName.match(/\d+/g);
                            aActions['action-free-disk-space-volume-' + aMatch[aMatch.length-1]] = key;
                            $.manage.setCssFreeDiskSpaceVolume(aMatch[aMatch.length-1]);
                        }
                        
                        var pattern = /-raid-divice-status-/;
                        if (pattern.test(actionName)) {
                            var aMatch = actionName.match(/\d+/g);
                            aActions['action-raid-status-' + aMatch[aMatch.length-1]] = key;
                            $.manage.setCssRaidStatus(aMatch[aMatch.length-1]);
                        }
                         
                        break;
                 }
                 
            });
            
         }, 1000);
     };
    
    $.manage.preViewAs = function(json) {
         
         preViewAs = json.preViewAs;
         
         switch(preViewAs) {
             case 'cpu_load':
                 $.manage.setVarCpuLoad(json);
                 $.manage.setCssCpuLoad();
               break;
             case 'cpu_jump':
                 $.manage.setVarCpuJump(json);
                 $.manage.setCssCpuJump();
               break;
             case 'memory_usage':
                 $.manage.setVarMemoryUsage(json);
                 $.manage.setCssMemoryUsage();
               break;
             case 'apache_stat':
                 $.manage.setVarApacheStat(json);
                 $.manage.setCssApacheStat();
               break;
             case 'mysql_connect':
                 $.manage.setVarMysqlConnect(json);
                 $.manage.setCssMysqlConnect();
               break;
             case 'mysql_thread':
                 $.manage.setVarMysqlThread(json);
                 $.manage.setCssMysqlThread();
               break;
             case 'exim_statistic':
                 $.manage.setVarEximStatistic(json);
                 $.manage.setCssEximStatistic();
               break;
             case 'exim_traffic':
                 $.manage.setVarEximTraffic(json);
                 $.manage.setCssEximTraffic();
               break;
             case 'nginx_connect':
                 $.manage.setVarNginxConnect(json);
                 $.manage.setCssNginxConnect();
               break;
             case 'nginx_thread':
                 $.manage.setVarNginxThread(json);
                 $.manage.setCssNginxThread();
               break;
             case 'user_media':
                 $.manage.setVarUserMedia(json);
                 $.manage.setCssUserMedia();
               break;
             case 'actions':
                 $.manage.setVarActions(json);
                 $.manage.setCssActions();
               break;
             case 'swap_usage':
                 $.manage.setVarSwapUsage(json);
                 $.manage.setCssSwapUsage();
               break;
             case 'free_disk_space':
                 $.manage.setVarFreeDiskSpace(json);
                 $.manage.setCssFreeDiskSpace();
               break;
             case 'mysql':
                 $.manage.setVarMysql(json);
                 $.manage.setCssMysql();
               break;
             case 'myisam':
                 $.manage.setVarMyIsam(json);
                 $.manage.setCssMyIsam();
               break;
             case 'innodb':
                 $.manage.setVarInnodb(json);
                 $.manage.setCssInnodb();
               break;
             case 'named_session':
                 $.manage.setVarNamedSession(json);
                 $.manage.setCssNamedSession();
               break;
             case 'media':
             default: 
                break;
         }
         
  };
  
  $.manage.isEmail = function(email) {
        var pattern = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return (pattern.test(email)) ? true : false;
  };
     
  $.manage.raiseError = function(errorMsg) {
         $.MN.Ajax.doError({}, {}, {}, {"errorMsg" : errorMsg});
  };
    
  $.manage.validateTabNotification = function() {
      
      if ($('#tabs-once-mn-notification').val() == '1') {
      } else {
        $.manage.makeUiUserMedia();
        $.manage.makeUiActions();
        
        $("#tabs-once-mn-notification").val("1");
      }
      
  };
  
  $.manage.validateTabGraph = function() {
      
      if ($('#tabs-once-mn-graph').val() == '1') {
      } else {
          if (isAgentd == 'true') {
              
              /*
              setTimeout(function() {
                  var cache_fix = "?cache_fix=" + new Date().getTime();
                  $('.dvLoading').html("<img src='" + system_url + "includes/modules/Hosting/manage_service/public_html/images/loading.gif" + cache_fix + "' style='display: block;margin-left: auto;margin-right: auto;margin-top: 100px;' />"); 
              }, 500);
              */
             
              // var cache_fix = "?cache_fix=" + new Date().getTime();
              // $('.dvLoading').html("<img src='" + system_url + "includes/modules/Hosting/manage_service/public_html/images/loading.gif" + cache_fix + "' style='display: block;margin-left: auto;margin-right: auto;margin-top: 100px;' />");
              
              if (isCpu == '1' || isCpu == 1) {
                  $.manage.makeUiCpu();
              }
              if (isMemory == '1' || isMemory == 1) {
                  $.manage.makeUiMemory();
              }
              if (isDisk == '1' || isDisk == 1) {
                  $.manage.makeUiDisk();
              }
              if (isApahce == '1' || isApahce == 1) {
                  $.manage.makeUiApache();
              }
              if (isMysql == '1' || isMysql == 1) {
                  $.manage.makeUiMysqls();
              }
              if (isNginx == '1' || isNginx == 1) {
                  $.manage.makeUiNginx();
              }
              if (isExim == '1' || isExim == 1) {
                  $.manage.makeUiExim();
              }
              if (isNamed == '1' || isNamed == 1) {
                  $.manage.makeUiNamed();
              }
              
          }
          
          $("#tabs-once-mn-graph").val("1");
      }
  };
  
  $.manage.onclickTabCpu = function() {
      
      if (aOnclick['cpu'] == 0 && (isCpu == '1' || isCpu == 1) && isAgentd == 'true') {
          aOnclick['cpu'] = 1;
          $.manage.makeUiCpu();
      }
      
  };
  
  $.manage.onclickTabMemory = function() {
      
      if (aOnclick['memory'] == 0 && (isMemory == '1' || isMemory == 1) && isAgentd == 'true') {
          aOnclick['memory'] = 1;
          $.manage.makeUiMemory();
      }
      
  };
  
  $.manage.onclickTabDisk = function() {
      
      if (aOnclick['disk'] == 0 && (isDisk == '1' || isDisk == 1) && isAgentd == 'true') {
          aOnclick['disk'] = 1;
          $.manage.makeUiDisk();
      }
      
  };
  
  $.manage.onclickTabApache = function() {
      
      if (aOnclick['apache'] == 0 && (isApahce == '1' || isApahce == 1) && isAgentd == 'true') {
          aOnclick['apache'] = 1;
          $.manage.makeUiApache();
      }
      
  };
  
  $.manage.onclickTabMysql = function() {
      
      if (aOnclick['mysql'] == 0 && (isMysql == '1' || isMysql == 1) && isAgentd == 'true') {
          aOnclick['mysql'] = 1;
          $.manage.makeUiMysqls();
      }
      
  };
  
  $.manage.onclickTabNginx = function() {
      
      if (aOnclick['nginx'] == 0 && (isNginx == '1' || isNginx == 1) && isAgentd == 'true') {
          aOnclick['nginx'] = 1;
          $.manage.makeUiNginx();
      }
      
  };
  
  $.manage.onclickTabExim = function() {
      
      if (aOnclick['exim'] == 0 && (isExim == '1' || isExim == 1) && isAgentd == 'true') {
          aOnclick['exim'] = 1;
          $.manage.makeUiExim();
      }
      
  };
  
  $.manage.onclickTabNamed = function() {
      
      if (aOnclick['named'] == 0 && (isNamed == '1' || isNamed == 1) && isAgentd == 'true') {
          aOnclick['named'] = 1;
          $.manage.makeUiNamed();
      }
      
  };
  
})(jQuery);