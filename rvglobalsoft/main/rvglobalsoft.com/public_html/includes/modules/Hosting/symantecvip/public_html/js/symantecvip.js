(function(jQuery) {

	 $.symantecvip = {};
	 
	 $.symantecvip.init = function() {
		 $.symantecvip.makeUi();
		 $.symantecvip.makeEvent();
	 };
	 
	 $.symantecvip.makeUi = function() {
	 };
	 
	 $.symantecvip.makeEvent = function() {
		 $.symantecvip.makeEventVipSaveAccount();
		 $.symantecvip.makeEventVipSaveCertificateFile();
		 $.symantecvip.makeEventVipSaveCertificateFilePassword();
		 $.symantecvip.makeEventVipSaveCertificateFilecPanelApps();
		 $.symantecvip.makeEventVipViewCerPem();
		 $.symantecvip.makeEventVipViewCerP12();
		 $.symantecvip.makeEventOpenAddAcctForm();
		 $.symantecvip.makeEventVipAddAccount();
		 $.symantecvip.makeEventVipDeleteAccount();
		 $.symantecvip.makeEventVipCredentialList();
		 $.symantecvip.makeEventVipAddCredentialForm();
		 $.symantecvip.makeEventVipAddCredential();
		 $.symantecvip.makeEventConfirmCodeOtp();
		 $.symantecvip.makeEventVipServerList();
	 };
	 
	 $.symantecvip.makeEventOpenAddAcctForm = function() {
		 
		 	$('#dialog-add-vip-account').dialog({
				autoOpen: false , 
				show: 'blind',
				width: 870 ,
				minHeight: 300,
				height: 'auto',
				modal: true,
				draggable: false
			});
			
			$('#add-vip-account').click(function () {
				$('#dialog-add-vip-account').dialog('open');
				
				var randomnumber      = Math.floor(Math.random()*999);
				var loadUrl           = $(this).attr('href');

				return false;
			
			});
			
			$('#vip-cancel-add-acct').click(function () {
				 $('#dialog-add-vip-account').dialog('close');
			     $("#vip-acct-name").val("");
			     $("#vip-acct-comment").val("");
			 });
		 	
	 };
	 
	 $.symantecvip.makeEventVipViewCerPem = function() {
	 
		/* for whm */
	 	$('#show-dialog-cer-file').click(function(){
			$('#dialog-cer-detail').dialog({ width: 500 });
			
		});
	 	
	 	/* for cpanel */	 	
	 	$('#show-dialog-cer-file-cpanel').click(function(){
				$('#dialog-cer-detail-cpanel').dialog({ width: 500 });
				
		}); 
	 	
	 	/* for apps */	 	
	 	$('#show-dialog-cer-file-apps').click(function(){
			$('#dialog-cer-detail-apps').dialog({ width: 500 });
			
	    }); 
	 	
	 };
		
	 $.symantecvip.makeEventVipViewCerP12 = function() {
		
		 /* for whm */
		 
		 $('#show-dialog-cer-file-p12').click(function(){
				$('#dialog-cer-detail-p12').dialog({ width: 500 });
				
		 }); 
		 
		 /* for cpanel */

		 $('#show-dialog-cer-file-p12-cpanel').click(function(){
				$('#dialog-cer-detail-p12-cpanel').dialog({ width: 500 });
				
		 }); 
		 
		 /* for apps */
		 
		 $('#show-dialog-cer-file-p12-apps').click(function(){
				$('#dialog-cer-detail-p12-apps').dialog({ width: 500 });
				
		 });
	 };
	 
	 $.symantecvip.makeEventVipSaveAccount = function() {
		 
		 $("#vip-save-account").click(function () {
			 
			 $.getJSON("?cmd=symantecvip&action=doSaveAccount", {
				 vipNum: $("#vip-ou-number").val(),
				 vipQuantityAtSymantec: $("#vip-quantity-at-symantec").val(),
				 vipQuantityOrder: $("#vip-quantity").val(),
				 vipInfoId: $("#vip-info-id").val(),
				 vipInfoType: $("#vip-info-type").val(),
				 productId: $("#vip-product-id").val(),
				 productName: $("#vip-product-name").val(),
				 usrId: $("#usr-id").val(),
				 acctId: $("#account-id").val()
		        }, function(data) {
		        	data = data.aResponse;
		        	alert(data.message);
		        	location.reload(); 
		        });
		 });
	 };
	 
	 
	 $.symantecvip.makeEventVipSaveCertificateFile = function() {

		 $("#vip-save-certificate-file").click(function () {
			 var fileInput = document.querySelector('#certificate-file');
			 var fileInputP12 = document.querySelector('#certificate-file-p12');
			 
			 var usrIdFolder = document.querySelector('#usr-id');
			 
			 var dateFileUpload = document.querySelector('#date-file-upload');
			 var dateFileUploadP12 = document.querySelector('#date-file-upload-p12');
			 
			 var vipCerFileName = document.querySelector("#certificate-file-name");
			 var vipCerExpireDate = document.querySelector("#certificate-expire-date");
			 var vipCerFileNameP12 = document.querySelector("#certificate-file-name-p12");
			 var vipCerExpireDateP12 = document.querySelector("#certificate-expire-date-p12");
			 var vipInfoId = document.querySelector("#vip-info-id");
			 
			 var vipCerFilePassword = document.querySelector("#certificate-file-password");
			 var vipCerFilePasswordP12 = document.querySelector("#certificate-file-password-p12");
			 //var vipCerFilePasswordP12 = vipCerFilePassword;

		     var xhr = new XMLHttpRequest();
		     xhr.open('POST', '?cmd=symantecvip&action=doSaveCertificateFile');
		     
		     // subscribe to this event before you send your request.
		     xhr.onreadystatechange=function() {
		      if (xhr.readyState==4) {
		    	  
		    	  var obj = JSON.parse(xhr.responseText);
		    	  alert(obj.aResponse.message);
		    	  location.reload(); 
		    	  
		       //alert the user that a response now exists in the responseTest property.
		      // alert(xhr.responseText);
		       // And to view in firebug
		       //console.log('xhr',xhr)
		      }
		     }
		     
		     
		     var form = new FormData();
		     
		     if (fileInput.files[0]!==undefined)
		     {
		    	 form.append('vipCerFilePath', fileInput.files[0].name);
		    	 form.append('vipCerFileType', fileInput.files[0].type);
		    	 form.append('vipCerFileSize', fileInput.files[0].size);
		    	 form.append('vipCerFileNameArray', fileInput.files[0]);
		     }
		     
		     if (fileInputP12.files[0]!==undefined)
		     {
		    	 form.append('vipCerFilePathP12', fileInputP12.files[0].name);
		    	 form.append('vipCerFileTypeP12', fileInputP12.files[0].type);
		    	 form.append('vipCerFileSizeP12', fileInputP12.files[0].size);
		    	 form.append('vipCerFileNameArrayP12', fileInputP12.files[0]);
		     }
		     
		     form.append('usrIdFolder', usrIdFolder.value);
		     form.append('vipCerFileName', vipCerFileName.value);
		     form.append('vipCerExpireDate', vipCerExpireDate.value);
		     form.append('vipCerFileNameP12', vipCerFileNameP12.value);
		     form.append('vipCerExpireDateP12', vipCerExpireDate.value);
		     form.append('vipInfoId', vipInfoId.value);
		     form.append('dateFileUpload', dateFileUpload.value);
		     form.append('dateFileUploadP12', dateFileUploadP12.value);
		     
		     form.append('vipCerFilePassword', vipCerFilePassword.value);
		     form.append('vipCerFilePasswordP12', vipCerFilePasswordP12.value);
		     
		     xhr.send(form);   
		        
		 });
	 };
	 
	 

	 $.symantecvip.makeEventVipSaveCertificateFilecPanelApps = function() {

		 $("#vip-save-certificate-file-cpanel-app").click(function () {
			 var fileInput = document.querySelector('#certificate-file');
			 var fileInputP12 = document.querySelector('#certificate-file-p12');
			 
			 var usrIdFolder = document.querySelector('#usr-id');
			 
			 var dateFileUpload = document.querySelector('#date-file-upload');
			 var dateFileUploadP12 = document.querySelector('#date-file-upload-p12');
			 
			 var vipCerFileName = document.querySelector("#certificate-file-name");
			 var vipCerExpireDate = document.querySelector("#certificate-expire-date");
			 //var vipCerFileNameP12 = document.querySelector("#certificate-file-name-p12");
			 //var vipCerExpireDateP12 = document.querySelector("#certificate-expire-date-p12");
			 var vipInfoId = document.querySelector("#vip-info-id");
			 
			 var accountId = document.querySelector("#account-id");
			 var cerFileType = document.querySelector("#cer-file-type");
			 
			 var usrId =  document.querySelector("#usr-id");
			 
			 var vipCerFilePassword = document.querySelector("#certificate-file-password");

		     var xhr = new XMLHttpRequest();
		     xhr.open('POST', '?cmd=symantecvip&action=doSaveCertificateFilecPanelApps');
		     
		     // subscribe to this event before you send your request.
		     xhr.onreadystatechange=function() {
		      if (xhr.readyState==4) {
		    	  
		    	  var obj = JSON.parse(xhr.responseText);
		    	  alert(obj.aResponse.message);
		    	  location.reload(); 
		    	  
		       //alert the user that a response now exists in the responseTest property.
		      // alert(xhr.responseText);
		       // And to view in firebug
		       //console.log('xhr',xhr)
		      }
		     }
		     
		     
		     var form = new FormData();
		     
		     if (fileInput.files[0]!==undefined)
		     {
		    	 form.append('vipCerFilePath', fileInput.files[0].name);
		    	 form.append('vipCerFileType', fileInput.files[0].type);
		    	 form.append('vipCerFileSize', fileInput.files[0].size);
		    	 form.append('vipCerFileNameArray', fileInput.files[0]);
		     }
		     
		     if (fileInputP12.files[0]!==undefined)
		     {
		    	 form.append('vipCerFilePathP12', fileInputP12.files[0].name);
		    	 form.append('vipCerFileTypeP12', fileInputP12.files[0].type);
		    	 form.append('vipCerFileSizeP12', fileInputP12.files[0].size);
		    	 form.append('vipCerFileNameArrayP12', fileInputP12.files[0]);
		     }
		     
		     form.append('accountId', accountId.value);
		     form.append('cerFileType', cerFileType.value);
		     form.append('usrIdFolder', usrIdFolder.value);
		     form.append('vipCerFileName', vipCerFileName.value);
		     form.append('vipCerExpireDate', vipCerExpireDate.value);
		     //form.append('vipCerFileNameP12', vipCerFileNameP12.value);
		     //form.append('vipCerExpireDateP12', vipCerExpireDateP12.value);
		     form.append('vipInfoId', vipInfoId.value);
		     form.append('dateFileUpload', dateFileUpload.value);
		     form.append('dateFileUploadP12', dateFileUploadP12.value);
		     form.append('usrId', usrId.value);
		     form.append('vipCerFilePassword', vipCerFilePassword.value);
		     xhr.send(form);   
		        
		 });
	 };
	 
	 
	 $.symantecvip.makeEventConfirmCodeOtp = function() {
		 
		 $("#confirm-code").click(function () {
			 $.getJSON("?cmd=symantecvip&action=doConfirmCodeOtp", {
				 otp: $("#otp").val(),
				 vipAcctIdC: $("#vip-acct-id-c").val(),
				 vipAcctNameC: $("#vip-acct-name-c").val(),
				 vipCredC: $("#vip-cred-c").val()
		      	}, function(data) {
		        	data = data.aResponse;
		        	alert(data.message);
		        	location.reload(); 
		      });
			 //alert("vipNum=" + vipNum);
		 });
		 
		 $("#cancel-validate-cred").click(function () {
			 $.getJSON("?cmd=symantecvip&action=doConfirmCodeOtp", {
				 otp: $("#otp").val(),
				 vipAcctIdC: $("#vip-acct-id-c").val(),
				 vipAcctNameC: $("#vip-acct-name-c").val(),
				 vipCredC: $("#vip-cred-c").val()
		      	}, function(data) {
		        	data = data.aResponse;
		        	//alert(data.message);
		        	//if(data.complete=='0')
		        	//{
		        		alert('Cancelled validate credential id');
		        	//}
		        	
		        	location.reload(); 
		      });
			 //alert("vipNum=" + vipNum);
		 });
	 };
	 
	 
	 
	 /*
	  * 
	  * user manage vip
	  * 
	  */
	 
	 /*
	  * user add vip account
	  */
	 $.symantecvip.makeEventVipAddAccount = function() {

		 $("#add-acct").click(function () {
			 
			 var nameFull = $("#acct-prefix").val() + $("#vip-acct-name").val();
			 
			 var postData = "cmd=symantecvip&action=doAddVIPAccount&acctPrefix=" + $("#acct-prefix").val();
			 postData += "&vipAcctName=" + $("#vip-acct-name").val();
			 postData += "&vipAcctComment=" + $("#vip-acct-comment").val();
			 postData += "&vipAcctNameFull=" + nameFull;
			 $('#dialog-add-vip-account').html('<div id="loader">Loading...Please wait.</div>');
			 $.ajax({
				  type: "POST",
	
				  data: postData ,
				  
				  success: function(msg){
				        alert(msg.aResponse.message);
				        $('#dialog-add-vip-account').dialog('close');
				        $("#vip-acct-name").val("");
				        $("#vip-acct-comment").val("");
				        if (msg.aResponse.complete=='1') {
				        	
				        	//$('#dialog-addvipcredential').dialog('open');
				        	$.getJSON("?cmd=symantecvip&action=doLoadVIPCredAddForm", {
								 vipAcctId: msg.aResponse.vip_acct_id
						      	}, function(data) {
						      		var htmlForm = "";
						        	dataRes = data.aResponse;
						        	htmlForm = dataRes.htmlForm;
						        	
						        	//$('#htmlFormAddCred').empty();
						        	//$('#htmlFormAddCred').append(htmlForm);

						        	$('#htmlFormAddCred').html(htmlForm);
						        	$('#dialog-addvipcredential').dialog('open');
						    });
				        }
				        //location.reload(); 
				        
				  },
				  error: function(XMLHttpRequest, textStatus, errorThrown) {
				     alert("some error");
				  }
				});
		 });
	 };
	 
	 $.symantecvip.makeEventVipDeleteAccount = function() {
		 
		 $(".delete-acct").click(function () {
			 if (confirm("Do you want to delete this vip account?")==true) {
				 $.getJSON("?cmd=symantecvip&action=doDeleteVIPAccount", {
					 vipAcctId: $(this).attr("id")
			      	}, function(data) {
			        	data = data.aResponse;
			        	alert(data.message);
			        	location.reload(); 
			      });
			 }

		 });
		
	 };
	 
	 
	 $.symantecvip.makeEventVipCredentialList = function() {
	 
		 $('#dialog-listvipcredential').dialog({
				autoOpen: false , 
				show: 'blind',
				width: 750 ,
				minHeight: 300,
				height: 'auto',
				modal: true,
				draggable: false
			});
			
			$('.show-dialog').click(function () {
				
				$.getJSON("?cmd=symantecvip&action=doGetVIPCredList", {
					 vipAcctId: $(this).attr("id")
			      	}, function(data) {
			        	dataRes = data.aResponse;
			        	
			        	if (dataRes.vip_cred_num > 0) {
			        		
			        		$('#itemContent').html(dataRes.htmlCredList);
    		        		$('#dialog-listvipcredential').dialog('open');
			        		
			        	}
			        	
			        	//print data;
			        	//alert(data.message);
			        	//location.reload(); 
			      });
				
				return false;
			
			});
			
	 };
	 
	 
	 $.symantecvip.makeEventVipAddCredentialForm = function() {
		 
		 $('#dialog-addvipcredential').dialog({
				autoOpen: false , 
				show: 'blind',
				width: 870 ,
				minHeight: 300,
				height: 'auto',
				modal: true,
				draggable: false,
				closeOnEscape: false ,
				dialogClass: "no-close",
			});
			
			$('.show-dialog-add').click(function () {
				
				$.getJSON("?cmd=symantecvip&action=doLoadVIPCredAddForm", {
					 vipAcctId: $(this).attr("id")
			      	}, function(data) {
			      		var htmlForm = "";
			        	dataRes = data.aResponse;
			        	htmlForm = dataRes.htmlForm;
			        	
			        	//$('#htmlFormAddCred').empty();
			        	//$('#htmlFormAddCred').append(htmlForm);
			        	$("#vip-cred").val("");
					    $("#vip-cred-comment").val("");
			        	$('#htmlFormAddCred').html(htmlForm);
			        	$('#dialog-addvipcredential').dialog('open');
			    });
				
				return false;
			
			});
			
	 };
	 
	 
	 $.symantecvip.makeEventVipAddCredential = function() {
		 
		 $("#vip-save-credential").click(function () {
			 
			 
			 $('#dialog-validatecredential').dialog({autoOpen: false , 
					closeOnEscape: false,
					dialogClass: 'no-close',
					show: 'blind',
					width: 750 ,
					minHeight: 300,
					height: 'auto',
					modal: true,
					draggable: false
			 });
			
			 $.getJSON("?cmd=symantecvip&action=doSaveCredential", {
				 vipCred: $("#vip-cred").val(),
				 vipCredComment: $("#vip-cred-comment").val(),
				 vipAcctId: $("#vip-acct-id").val(),
				 vipAcctNameInput: $("#vip-acct-name-input").val(),
				 vipCredType: $("#vip-cred-type").val()
		        }, function(data) {
		        	// close add cred form
		        	$("#vip-acct-name").val("");
				    $("#vip-acct-comment").val("");
	        		$('#dialog-addvipcredential').dialog('close');
				    
		        	dataRes = data.aResponse;
		        	if(dataRes.complete=='1') {
		        		
		        		// open validate form
		        		$.getJSON("?cmd=symantecvip&action=doValidateCredentialForm", {
		    				 vipCredF: dataRes.vip_cred,
		    				 vipAcctIdF: dataRes.vip_acct_id,
		    				 vipAcctNameF: dataRes.vip_acct_name
		    		        }, function(data) {
		    		        	dataRes = data.aResponse;
		    		        	if (dataRes.htmlFormValidate != '') {
		    		        		$('#htmlFormValidate').html(dataRes.htmlFormValidate);
		    		        		$('#dialog-validatecredential').dialog('open');
		    		        	}
					        	
		    		        	//dataRes = data.aResponse;
		    		        	//alert(dataRes.message);
		    		        	//location.reload();
		    		        });
		        		 
		        	} else {
		        		
		        		//TODO : 
		        		alert(dataRes.message);
		        		location.reload();
		        		
		        	}
		        	 
		        });
			 
			 return false;
		 });
		 
		 
		  $("#vip-cancel-add-cred").click(function () {
		  
		  
		 
			 $.getJSON("?cmd=symantecvip&action=doSaveCredential", {
				 vipCred: $("#vip-cred").val(),
				 vipCredComment: $("#vip-cred-comment").val(),
				 vipAcctId: $("#vip-acct-id").val(),
				 vipAcctNameInput: $("#vip-acct-name-input").val(),
				 vipCredType: $("#vip-cred-type").val()
		        }, function(data) {
		        	// close add cred form
		        	$("#vip-acct-name").val("");
				    $("#vip-acct-comment").val("");
	        		$('#dialog-addvipcredential').dialog('close');
				    
		        	dataRes = data.aResponse;
		        	if(dataRes.complete=='0') {
		        		
		        		//TODO : 
		        		alert('Cancelled add credential id');
		        		location.reload();
		        	}	
		        	
		        	 
		        });
			 
			 return false;
				
			
	        		
	          });
		 
		 
	 };
	 
	 
	 $.symantecvip.makeEventVipSaveCertificateFilePassword = function() {
		 
		 $("#vip-save-certificate-file-pass").click(function () {
			 $.getJSON("?cmd=symantecvip&action=doSaveCertificateFilePassword", {
				 vipCerFilePassword: $("#certificate-file-password").val(),
				 vipCerFilePasswordP12: $("#certificate-file-password-p12").val(),
				 vipInfoId: $("#vip-info-id").val(),
		      	}, function(data) {
		        	data = data.aResponse;
		        	alert(data.message);
		        	location.reload(); 
		      });
			 //alert("vipNum=" + vipNum);
		 });
	 };
	 
	 $.symantecvip.makeEventdoDeleteCredential = function(deleteId) {
			 //alert("del id = " +  deleteId);
		 if (confirm("Do you want to delete this vip credential?")==true) {
			 $.getJSON("?cmd=symantecvip&action=doDeleteCredential", {
				 vipCredIdDel: deleteId
		      	}, function(data) {
		        	data = data.aResponse;
		        	alert(data.message);
		        	location.reload(); 
		      });
		 }
	 };
	 
	 
	 /*
	  * manage server 
	  */
	 
	 $.symantecvip.makeEventVipServerList = function() {
		 
		     $('#dialog-listhost').dialog({
				autoOpen: false , 
				show: 'blind',
				width: 750 ,
				minHeight: 300,
				height: 'auto',
				modal: true,
				draggable: false
			});
			
			$('.show-dialog-manage').click(function () {
				
				$.getJSON("?cmd=symantecvip&action=doGetVIPHostList", {
					 vipAcctId: $(this).attr("id")
			      	}, function(data) {
			        	dataRes = data.aResponse;
			        	//alert(dataRes);
			        	if(dataRes.htmlFormHost != '') {
			        		$('#itemContentHost').html(dataRes.htmlFormHost);
			        		$('#dialog-listhost').dialog('open');
			        	}

			      });
				
				return false;
			
			});
			
	 };
	 
	 $.symantecvip.makeEventdoEnableServer = function(serverId,vipAcctId) {
		 $.getJSON("?cmd=symantecvip&action=doEnableDisableServer", {
			 serverId: serverId , 
			 vipAcctId: vipAcctId
	      	}, function(data) {
	        	data = data.aResponse;
	        	alert(data.message);
	        	//location.reload(); 
	      });
	 };
	 
})(jQuery);