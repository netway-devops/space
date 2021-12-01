{literal}
<script type="text/javascript">
//WF_DOMAIN_APPROVAL
$( document ).ready(function() {
	var base_url = $('#hid_base_url').val();
	var order_id = $('#hid_order_id').val();
	var client_id = $('#hid_client_id').val();
	
	$('#csr-submit').hide();	// 	submit csr
	$('#submit-info').hide();	// 	submit info
	$('#submit-order').hide();	//	submit order [buy]
	$('#change-email').hide();	//	change email
	$('#verify-call').hide();	//	verification call
	$('#change-csr').hide();	// 	change csr
	$('#check-status').hide();	// 	check status
	$('#edit-contact').hide();	//	edit contact
	$('#button-reissue').hide();	//	reissue1
	$('#button-reissue-step2').hide();	//	reissue2
	$('#update-submit').hide();
	$('#button-revoke').hide();
	$('#button-revoke-step2').hide();
	$('#button-revoke-step2-back').hide();
	$('.td-emailapproval').hide();
	$('.td-contact-table').hide();
	$('.td-domaininfo').hide();
	$('#csrShow').hide();
	$('#csrHide').hide();
	$('#detailShow').hide();
	$('#detailHide').hide();
	$('#tr-billingcontact').hide();
	$('#gmt').hide();
	$('#statusOutput').html(generateStatus($('#hid_symantecStatus').val()));
	$("#fix_status").val($('#hid_symantecStatus').val());


	$('.tr-completed').hide();
	$('.tr-symantec-info').hide();
	$('#require-field').hide();
	$('.date-pick').datePicker();
	$('.tr-revoke').hide();

	switch($('#hid_symantecStatus').val()){
		case 'WAITING_SUBMIT_ORDER':
			$('#change-csr').show();
			$('#update-submit').show();
			$('#submit-order').hide();
    		$('#emailapproval-select').html($("#hid_email_approval").val());
    		$('#edit-contact').hide();
    		createContactTable();
    		hideContactWithShowButton();
    		hideCSRWithShowButton();
    		showDomain();
    		showEmail();
			break;
		case 'WAITING_SUBMIT_CSR':
			$('#csr-submit').show();
			$('#csr-area').show();
			$('#require-field').show();
			break;
		case 'AUTHORIZATION_FAILED':
			$('#verify-call').show();
			$('#button-revoke').show();
			showDomain();
			showEmail();
			createContactTable();
			hideCSRWithShowButton();
			break;
		case 'COMPLETED':
			hideCSRWithShowButton();
			hideContactWithShowButton();
			showDomain();
			showEmail();
			$('#statusOutput').html(generateStatus($('#hid_symantecStatus').val()));
			$('.tr-completed').show();
			$('.tr-symantec-info').show();
			$('#button-reissue').show();
//			$('.tr-action').hide();
			$('#check-status').show();
			$('#button-revoke').show();
			createContactTable();
			$('#update-submit').show();
			$("#caCertFocus").attr('readonly', false).css('background-color','#fff');
			$("#servCertFocus").attr('readonly', false).css('background-color','#fff');
			$("#pkcs7Focus").attr('readonly', false).css('background-color','#fff');
			
			break;
		default:
			$('#update-submit').show();
			$('#check-status').show();
			$('.tr-symantec-info').show();
			$('#button-revoke').show();
			showEmail();
			showDomain();
			createContactTable();
			hideCSRWithShowButton();
			hideContactWithShowButton();
	}
	

	switch($('#fix_status').val()){
		case 'WAITING_SUBMIT_ORDER':
			$('#change-csr').show();
			$('#update-submit').show();
			$('#submit-order').hide();
    		$('#emailapproval-select').html($("#hid_email_approval").val());
    		$('#edit-contact').hide();
    		createContactTable();
    		hideContactWithShowButton();
    		hideCSRWithShowButton();
    		showDomain();
    		showEmail();
			break;
		case 'WAITING_SUBMIT_CSR':
			$('#csr-submit').show();
			$('#csr-area').show();
			$('#require-field').show();
			break;
		case 'AUTHORIZATION_FAILED':
			$('#verify-call').show();
			$('#button-revoke').show();
			showDomain();
			showEmail();
			createContactTable();
			hideCSRWithShowButton();
			break;
		case 'COMPLETED':
			hideCSRWithShowButton();
			hideContactWithShowButton();
			showDomain();
			showEmail();
			$('.tr-completed').show();
			$('.tr-symantec-info').show();
			$('#button-reissue').hide();
//			$('.tr-action').hide();
			$('#check-status').show();
			$('#button-revoke').show();
			$('#update-submit').show();
			createContactTable();
			break;
		default:
			$('#check-status').show();
			$('#update-submit').show();
			$('.tr-symantec-info').show();
			$('#button-revoke').show();
			showEmail();
			showDomain();
			createContactTable();
			hideCSRWithShowButton();
			hideContactWithShowButton();
	}
 
	if($('#firstApp').val() == ''){
    	$('#start').hide();
    	$('#to').hide();
    	$('#end').hide();
    	$('#gmt').hide();
    }
	
    if($('#secondApp').val() == ''){
    	$('#start2').hide();
    	$('#to2').hide();
    	$('#end2').hide();
    	$('#gmt2').hide();
    }

    if($('#firstApp').text() != '' && $('#secondApp').val() == ''){
        $( "#date_pick2" ).datepicker('disabled');
    }
    
    $('#refreshpage').click(function(){
    	location.reload();
    });
    
	
	$('#csr-submit').click(function(){
		//var csr_data = encodeURIComponent($('#csr-area').val());
		$('.all-button').attr('disabled', true);
		$('#csrError').html('');
		$('body').css('cursor', 'progress');
		$('#main-data').hide();
		$('#csrProcess').html('Processing : Parse CSR');
		$.ajax({
			url: base_url,
            type: 'POST',
            data: {
            	cmd: 'module'
                , module: 'ssl'
                , action: 'ajax_parsecsr'
				, csr: $('#csr-area').val()
            },
            success: function(data){
				var csrinfo = data.aResponse;
				//var result = csrinfo.substring(0,csrinfo.indexOf('DOCTYPE')-2);
                //var obj = JSON.parse(csrinfo);
				console.log(csrinfo);
				
            	if(csrinfo.error != undefined){
            		$('body').css('cursor', 'default');
            		$('#csrError').html(csrinfo.error[0].message);
            		$('#csrProcess').html('');
            		$('.all-button').attr('disabled', false);
            	} else if(csrinfo['CN'].toLowerCase().search('.jp') != -1){
            		$('body').css('cursor', 'default');
            		$('#csrError').html('.jp extension not support now : "' + csrinfo['CN'] + '"');
            		$('#csrProcess').html('');
            		$('.all-button').attr('disabled', false);
            	} else {
            		$('#csrProcess').html('Processing : Get Whois data');
            		$.ajax({
            			url: base_url,
                        type: 'POST',
                        data: {
                        	cmd: 'module'
                            , module: 'ssl'
                            , action: 'ajax_getwhois'
                            , domain: csrinfo.CN
                        },
                        success: function(data){
                        	var whoisinfo = data.aResponse;
                        	$.ajax({
                    			url: base_url,
                                type: 'POST',
                                data: {
                                	cmd: 'module'
                                    , module: 'ssl'
                                    , action: 'ajax_get_email_approval'
                                    , domain: csrinfo.CN
                                },
                                success: function(data){
                                	emailApprovalList = data.aResponse;
                                	$('#csrProcess').html('');
                                	$('#main-data').show();
                                	$('body').css('cursor', 'default');
                                	console.log(whoisinfo);
                                	$('#csrError').html('');
                            		$('#csr-area').attr('readonly', true);
                            		$('#csr-area').css('background-color', '#ebebe4');
                            		$('#csr-submit').hide();
                            		$('#submit-info').show();
                            		$('#change-csr').hide();
                            		$('#csrShow').show();
                            		$('#csr-area').hide();
                            		$('#domainName').text(csrinfo.CN);
                            		$('.td-domaininfo').show();
                            		($('#hid_ssl_type').val() == 'DV') ? $('.td-emailapproval').show() : '';
                            		$('.td-contact-table').show();
                            		$('#detailShow').hide();
                            		$('#detailHide').hide();
                            		$('#td-contact-table-content').show();
                            		$('#tr-billingcontact').show();
                            		$('.organizationContact').attr('readonly', false).css('border', '1px solid grey');
                            		$('.adminContact').attr('readonly', false).css('border', '1px solid grey');
                            		$('.techContact').attr('readonly', false).css('border', '1px solid grey');
                            		$('#require-field').show();
                            		$('.all-button').attr('disabled', false);
                            		createServerTypeList();
                            		createEmailApprovalList(emailApprovalList);
                            		createContactTableOnSubmit(whoisinfo); 	
                                }
                        	});
                        }
            		});
            	}
			}

		});
	});
	
	$('#change-csr').click(function(){
		$('#csrError').html('');
		$('#csr-area').val();
	    $('#csr-area').show();
		$('#csr-area').attr('readonly', false);
	    $('#csr-area').css('background-color', 'white');
	    $('#submit-info').hide();
	    $('#csrShow').hide();
	    $('#csrHide').hide();
	    $('#statusOutput').html('Waiting submit CSR');
	    $('#submit-order').hide();
	    $('#change-csr').hide();
	    $('#csr-submit').show();
	    $('#tr-billingcontact').hide();
	    $('#hid_symantecStatus').val('WAITING_SUBMIT_CSR');
	    $('#edit-contact').hide();
	    $('#server_type').attr('disabled', false);
	    hidealldetail();
	});	
	
	$('#submit-info').click(function(){
		var organization = {};
		var admin = {};
		var tech = {};
		var chk = 0;
		$(".organizationContact").each(function() {
			organization[$(this).attr("name")] = $(this).val();
		})
		chk = validateContactData(organization, 'Organization');
		
		if(chk == 0){
			$(".adminContact").each(function() {
				admin[$(this).attr("name")] = $(this).val();
			})
			chk = validateContactData(admin, 'Admin');
			if(chk == 0){
				$(".techContact").each(function() {
					tech[$(this).attr("name")] = $(this).val();
				})
				chk = validateContactData(tech, 'Technical');				
			}
		}
		
		if(chk == 0){
			$('body').css('cursor', 'progress');
			$('.all-button').attr('disabled', true);
			$('#csrProcess').html('Processing : Inserting contact data');
			$.ajax({
    			url: base_url,
                type: 'POST',
                data: {
                	cmd: 'module'
                    , module: 'ssl'
                    , action: 'ajax_updatesslorder'
                    , csr: $('#csr-area').val()
                    , email: ($('#hid_ssl_type').val() == 'DV') ? $('#email_approval').val() : ''
                    , servertype: $('#server_type').val()
                    , domain: $('#domainName').text()
                    , orderid: order_id
                },
                success: function(data){
                	$.ajax({
            			url: base_url,
                        type: 'POST',
                        data: {
                        	cmd: 'module'
                            , module: 'ssl'
                            , action: 'ajax_updatesslcontact'
                            , organization: JSON.stringify(organization)
                            , admin: JSON.stringify(admin)
                            , tech: JSON.stringify(tech)
                            , csr: $('#csr-area').val()
                            , domain: $('#domainName').text()
                            , clientid: client_id
                            , orderid: order_id
                        },
                        success: function(data){
                        	$('#csrProcess').html('Processing : Refreshing');
                        	location.reload();
                        }
            		});
                }
    		});
		}
	});
	

	$("select#fix_status").change(function(){
		var state = $(this).children("option:selected").val();
		if(state == 'COMPLETED'){
			$(".tr-completed").show();
			   $("#caType").attr('readonly', false).css('background-color','#fff').val('INTERMEDIATE');
			   $("#caCertFocus").attr('readonly', false).css('background-color','#fff');
			   $("#servCertFocus").attr('readonly', false).css('background-color','#fff');
			   $("#pkcs7Focus").attr('readonly', false).css('background-color','#fff');
			   
			}	
		else{
				$(".tr-completed").hide();
		}	
	 });
	$('#update-submit').click(function(){
		if($('#hid_symantecStatus').val() != 'REJECTED'){
			$('body').css('cursor', 'progress');
			$('#csrProcess').html('Processing : Ordering to Symantec');
			$('.all-button').attr('disabled', true);
			$.ajax({
				url: base_url,
				type: 'POST',
				data: {
					cmd: 'module'
					, module: 'ssl'
					, action: 'ajax_updateData'
					, orderid: order_id
					, date_created	   :$('#date_created').val()
					, status: $("#fix_status").val()
					, invoiceStatus : $('#hid_invoice_status').val()
					, authorityOrderid :$('#authority_orderid').val()
					, partnerOrderId   :$('#partnerOrderId').val()
					, caCertFocus      :$('#caCertFocus').val()
					, servCertFocus    :$('#servCertFocus').val()
					, pkcs7Focus       :$('#pkcs7Focus').val()
					, invoiceStatus    :$('#hid_invoice_status').val()
					, caType	       :$('#caType').val()
					, date_expire	   :$('#date_expire').val()
					
				},
				success: function(data){
					$('#csrProcess').html('Processing : Refreshing');
					location.reload();
					
				}
			});
		} 
	});
	$('#edit-contact').click(function(){
		$('body').css('cursor', 'progress');
		$('#csrProcess').html('Processing : Generating edit page');
		$('#csrError').html('');
   	 	$('.all-button').attr('disabled', true);
		$.ajax({
			url: base_url,
            type: 'POST',
            data: {
            	cmd: 'module'
                , module: 'ssl'
                , action: 'ajax_getwhois'
                , domain: $('#domainName').text()
            },
            success: function(data){
            	var whoisinfo = data.aResponse;
            	$('body').css('cursor', 'default');
            	if(whoisinfo.error != undefined && whoisinfo.error != ''){
            		$('#csrProcess').html('');
            		$('#csrError').html('Cannot edit contact by whois: ' + whoisinfo.error);	
               	 	$('.all-button').attr('disabled', false);
            	} else {
            		$.ajax({
            			url: base_url,
                        type: 'POST',
                        data: {
                        	cmd: 'module'
                            , module: 'ssl'
                            , action: 'ajax_get_email_approval'
                            , domain: $('#domainName').text()
                        },
                        success: function(data){
                        	emailApprovalList = data.aResponse;
		            		createServerTypeList();
			            	$('#detailShow').hide();
			        		$('#detailHide').hide();
			        		$('#td-contact-table-content').show();
			        		$('#tr-billingcontact').show();
			        		
			        		$('#edit-contact').hide();
			        		$('#submit-order').hide();
			        		$('#change-csr').hide();
			        		$('#submit-info').show();
			        		
			        		$('.organizationContact').attr('readonly', false).css('border', '1px solid grey');
			        		$('.adminContact').attr('readonly', false).css('border', '1px solid grey');
			        		$('.techContact').attr('readonly', false).css('border', '1px solid grey');
			        		$('#server_type').attr('disabled', false);
			        		$('#csrProcess').html('');
			           	 	$('.all-button').attr('disabled', false);
			        		createEmailApprovalList(emailApprovalList);
                        }
            		});
            	}
            }
		});
	});
	
	$('#submit-order').click(function() {
		if($('#hid_invoice_status').val() == 'Paid'){
			$('body').css('cursor', 'progress');
			$('#csrProcess').html('Processing : Ordering to Symantec');
			$('.all-button').attr('disabled', true);
			$.ajax({
				url: base_url,
	            type: 'POST',
	            data: {
	            	cmd: 'module'
	                , module: 'ssl'
	                , action: 'ajax_submitorder'
	                , orderid: order_id
	            },
	            success: function(data){
	            	aResponse = data.aResponse;
	            	console.log(aResponse);
	            	if(aResponse === null){
		            	$('body').css('cursor', 'default');
		            	$('#csrProcess').html('');
		            	$('#csrError').html('Cannot Order : response null value.');
		            	$('.all-button').attr('disabled', false);
	            	} else if(typeof aResponse.error != 'undefined' && aResponse.error[0].message != ''){
	            		$('body').css('cursor', 'default');
	            		$('#csrProcess').html('');
	            		$('#csrError').html('Cannot Order : ' + aResponse.error[0].message);
	            		$('.all-button').attr('disabled', false);
	            	} else {
	            		$('#csrProcess').html('Processing : Completed, Refreshing');
	            		location.reload();
	            	}
	            }
			});
		} else {
			alert('Please add payment for this order.');
		}
	});
	
	$('#button-reissue').click(function(){
		$('#csrProcess').html('');
		$('.all-button').attr('disabled', false);
    	$('#csr-area').attr('readonly', false);
		$('#csr-area').css('background-color', '#fff');
		$('#csr-area').show();
		$('#csrShow').hide();
		$('#csrHide').hide();
		
		hideDomain();
		$('.tr-completed').hide();
		$('.tr-symantec-info').hide();
		$('.td-contact-table').hide();
//		createEmailApprovalList(emailApprovalList);
		$('#button-reissue').hide();
    	$('#button-reissue-step2').show();
    	$('#button-reissue-step2-back').show();
    	$('#check-status').hide();
//		$('body').css('cursor', 'progress');
//		$('#csrProcess').html('Processing : Create email approval list');
//		$('.all-button').attr('disabled', true);
//		$.ajax({
//			url: base_url,
//            type: 'POST',
//            data: {
//            	cmd: 'module'
//                , module: 'ssl'
//                , action: 'ajax_getwhois'
//                , domain: $('#domainName').text()
//            },
//            success: function(data){
//            	var whoisinfo = data.aResponse;
//            	$.ajax({
//        			url: base_url,
//                    type: 'POST',
//                    data: {
//                    	cmd: 'module'
//                        , module: 'ssl'
//                        , action: 'ajax_get_email_approval'
//                        , domain: $('#domainName').text()
//                    },
//                    success: function(data){
//                    	var emailApprovalList = data.aResponse;
//		            	$('body').css('cursor', 'default');
//		        		$('#csrProcess').html('');
//		        		$('.all-button').attr('disabled', false);
//		            	$('#csr-area').attr('readonly', false);
//		        		$('#csr-area').css('background-color', '#fff');
//		        		$('#csr-area').show();
//		        		$('#csrShow').hide();
//		        		$('#csrHide').hide();
//		        		hideDomain();
//		        		$('.tr-completed').hide();
//		        		$('.tr-symantec-info').hide();
//		        		$('.td-contact-table').hide();
//		        		createEmailApprovalList(emailApprovalList);
//		        		$('#button-reissue').hide();
//		            	$('#button-reissue-step2').show();
//                    }
//            	});
//            }
//		});
	});
	
	$('#button-reissue-step2').click(function(){
		$('body').css('cursor', 'progress');
		$('#csrProcess').html('Processing : Reissue');
		$('.all-button').attr('disabled', true);
		$('#csr-area').attr('readonly', true);
		$('#csr-area').css('background-color', '#ebebe4');
		$('#csrError').html('');
		
		email_approval = ($('#hid_ssl_type').val() == 'DV') ? $('#hid_email_approval').val() : '';
		
		$.ajax({
			url: base_url,
            type: 'POST',
            data: {
            	cmd: 'module'
                , module: 'ssl'
                , action: 'ajax_reissue'
                , order_id: order_id
                , csr: $('#csr-area').val()
                , email: email_approval
            },
            success: function(data){
            	var aResponse = data.aResponse;
            	console.log(aResponse);
            	
            	if(aResponse.status){
            		$('#csrProcess').html('Processing : Successful');
            		location.reload();
            	} else {
            		$('#csrProcess').html('');
            		$('#csr-area').attr('readonly', false);
            		$('#csr-area').css('background-color', '#fff');
            		$('#csrError').html('Reissue Error[' + aResponse.error[0].ErrorCode + '] : ' + aResponse.error[0].ErrorMessage);
            	}
            	$('body').css('cursor', 'default');
            	$('.all-button').attr('disabled', false);
            }
		});
	});
	
	$('#verify-call').click(function(){
		var haveError = 0;
		var d1 = $('#date_pick1').val();
		var d2 = $('#date_pick2').val();
		var f1 = $('#start').val();
		var t1 = $('#end').val();
		var f2 = $('#start2').val();
		var t2 = $('#end2').val();
		var g = $('#gmt').val();
		
		if(d1 == 'No Detail'){
			haveError = 1;
			alert('Verification Call 1 : Please select your date and time appointment.');
		}
		if(haveError == 0){
			$.ajax({
				url: base_url,
			    type: 'POST',
			    data: {
			    	cmd: 'module'
		            , module: 'ssl'
			    	, action : 'ajax_checktime'
			    	, date : d1
			    	, from : 'now'
			    	, to : f1
			    	, gmt : g
			    	, state : 1
			    },
			    success: function(data){
			    	var response = data.aResponse; 
			    	if(response != ''){
			    		haveError = 1;
			    		alert(response);
			    	} else {
				    	$.ajax({
		    	 			url: base_url,
		    			    type: 'POST',
		    			    data: {
		    			    	cmd: 'module'
	    			            , module: 'ssl'
	    				    	, action : 'ajax_checktime'
		    			    	, date : d1
		    			    	, from : f1
		    			    	, to : t1
		    			    	, gmt : g
		    			    	, state : 1
		    			    },
		    			    success: function(data){
		    			    	response = data.aResponse; 
		    			    	if(response != ''){
		    			    		haveError = 1;
		    			    		alert(response);
		    			    	} else if(d2 != 'No Detail'){
		    			    		if(d1 == 'No Detail'){
			    			    		haveError = 1;
			    			    		alert('Verification Call 1 : Please select your date and time appointment.');
			    			    	} else {
			    			    		$.ajax({
						    	 			url: base_url,
						    			    type: 'POST',
						    			    data: {
						    			    	cmd: 'module'
					    			            , module: 'ssl'
					    				    	, action : 'ajax_checktime'
						    			    	, date : d2
						    			    	, from : 'now'
						    			    	, to : f2
						    			    	, gmt : g
						    			    	, state : 2
						    			    },
						    			    success: function(data){
						    			    	response = data.aResponse; 
						    			    	if(response != ''){
						    			    		haveError = 1;
						    			    		alert(response);
						    			    	} else {
							    			    	$.ajax({
									    	 			url: base_url,
									    			    type: 'POST',
									    			    data: {
									    			    	cmd: 'module'
								    			            , module: 'ssl'
								    				    	, action : 'ajax_checktime'
									    			    	, date : d2
									    			    	, from : f2
									    			    	, to : t2
									    			    	, gmt : g
									    			    	, state : 2
									    			    },
									    			    success: function(data){
									    			    	response = data.aResponse; 
									    			    	if(response != ''){
									    			    		haveError = 1;
									    			    		alert(response);
									    			    	} else {
										    			    	$.ajax({
												    	 			url: base_url,
												    			    type: 'POST',
												    			    data: {
												    			    	cmd: 'module'
											    			            , module: 'ssl'
											    				    	, action : 'ajax_checktime'
												    			    	, date : d1 + 'AND' + d2
												    			    	, from : t1
												    			    	, to : f2
												    			    	, gmt : g
												    			    	, state : 3
												    			    },
												    			    success: function(data){
												    			    	response = data.aResponse; 
												    			    	if(response != ''){
												    			    		haveError = 1;
												    			    		alert(response);
												    			    	} else {
													    			    	if(haveError == 0){
													    			    		$.ajax({
														    			    		url: base_url,
																    			    type: 'POST',
																    			    data: {
																    			    	cmd: 'module'
															    			            , module: 'ssl'
															    				    	, action : 'ajax_updatetime'
																    			    	, date : d1
																    			    	, date2 : d2
																    			    	, from : f1
																    			    	, from2 : f2
																    			    	, to : t1
																    			    	, to2 : t2
																    			    	, gmt : g
																    			    	, orderid: order_id
																    			    },
																    			    success: function(data){
																    			    	location.reload();
																    			    }
													    			    		});
												  							}
												    			    	}
												    			    }
												     			});
									    			    	}
									    			    }
									     			});
						    			    	}
						    			    }
					     				});
		    			    		}
		    			    	} else {
			    			    	if(haveError == 0){
			    			    		$.ajax({
				    			    		url: base_url,
						    			    type: 'POST',
						    			    data: {
						    			    	cmd: 'module'
					    			            , module: 'ssl'
					    				    	, action : 'ajax_updatetime'
						    			    	, date : d1
						    			    	, date2 : d2
						    			    	, from : f1
						    			    	, from2 : f2
						    			    	, to : t1
						    			    	, to2 : t2
						    			    	, gmt : g
						    			    	, orderid: order_id
						    			    },
						    			    success: function(data){
						    			    	location.reload();
						    			    }
			    			    		});
		  							}
		    			    	}
		    			    }
		     			});
			    	}
			    }
			});
		}
	});
	
     $("#upload_csr").change(function () {
         $("#submit_upload_csr").click();
     });
     
     $("#form_upload_csr").submit(function(){
         var formObj = $(this);
         var formURL = "{/literal}{$system_url}{literal}" + '7944web/index.php';
         var formData = new FormData(this);
         formData.append('cmd', 'module');
         formData.append('module', 'ssl');
         formData.append('action', 'ajax_upload_csr');
         $.ajax({
             url: formURL,
             type: 'POST',
             data:  formData,
             mimeType:"multipart/form-data",
             contentType: false,
             cache: false,
             processData:false,
             dataType: 'json',
         success: function(data)
         {
             $('#csr-area').val(data.aResponse.message);
         }
         , error: function(xhr,error) {
                         respError = $.parseJSON(xhr.responseText);
                         alert(respError);
                         return false;
                     }
         });
     });
     
     $('#adminQ').mouseenter(function(){
         $('#adminEVOVInfo').show(); 
     });
     $('#adminQ').mouseleave(function(){
         $('#adminEVOVInfo').hide();
     });
     $('#techQ').mouseenter(function(){
         $('#techEVOVInfo').show(); 
     });
     $('#techQ').mouseleave(function(){
         $('#techEVOVInfo').hide();
     });
     
     $('#detailShow').click(function(){
         $('#detailShow').hide();
         $('#detailHide').css('display', 'inline');
         $('#td-contact-table-content').show();
     });

     $('#detailHide').click(function(){
        $('#detailShow').css('display', 'inline');
        $('#detailHide').hide();
        $('#td-contact-table-content').hide();
 	 });
     
     $('#billingContact').click(function(){
    	 $.ajax({
 			url: base_url,
             type: 'POST',
             data: {
             	cmd: 'module'
                 , module: 'ssl'
                 , action: 'ajax_getbillingcontact'
                 , clientid: client_id
             },
             success: function(data){
            	 var billingdata = data.aResponse;
             	
	           	 $('#tfirstname').val(billingdata.firstname);
	           	 $('#tlastname').val(billingdata.lastname);
	           	 $('#temail').val(billingdata.email);
	           	 $('#torganization').val(billingdata.organization);
	           	 $('#tjob').val(billingdata.job);
	           	 $('#taddress').val(billingdata.address);
	           	 $('#tcity').val(billingdata.city);
	           	 $('#tstate').val(billingdata.state);
	           	 $('#tcountry').val(billingdata.country);
	           	 $('#tpostcode').val(billingdata.postcode);
	           	 $('#tphone').val(billingdata.phone);
	           	 $('#text').val(billingdata.ext);
             }
 		});
     });
     
     $('#check-status').click(function(){
    	 $('body').css('cursor', 'progress');
    	 $('.all-button').attr('disabled', true);
    	 $('#csrProcess').html('Processing : Checking');
    	 $.ajax({
  			url: base_url,
              type: 'POST',
              data: {
              	cmd: 'module'
                  , module: 'ssl'
                  , action: 'ajax_checkstatus'
                  , orderid: order_id
              },
              success: function(data){
            	  $('#csrProcess').html('Processing : Refreshing');
            	  location.reload();
              }
  		});
     });
     
     $('#modifyOrder').click(function(){
    	 $('body').css('cursor', 'progress');
    	 $('.all-button').attr('disabled', true);
    	 $('#csrProcess').html('Processing : Checking');
    	 $.ajax({
  			url: base_url,
              type: 'POST',
              data: {
              	cmd: 'module'
                  , module: 'ssl'
                  , action: 'ajax_modifyorder'
                  , orderid: order_id
                  , modifyaction: $('#devOpt').val()
                  , partnerorderid: $('#partnerOrderId').val()
              },
              success: function(data){
            	  $('#check-status').click();
//            	  $('#csrProcess').html('Processing : Refreshing');
//            	  location.reload();
              }
  		});
     });
     
     $('#button-cancel').click(function(){
    	 var isRefund = '{/literal}{$thirty_day_refund}{literal}';
    	 var alertMessage = '';
    	 if(isRefund){
    		 alertMessage = 'This account this action will cancel the Symantec order too [30-day-refund], Are you sure you want to terminate?'; 
    	 } else {
    		 alertMessage = 'This account this action will cancel the Symantec order too, Are you sure you want to terminate?';
    	 }
    	 var confirmBox = confirm(alertMessage);
    	 if(confirmBox){
    		 $('#csrProcess').html('');
  			 $('#csrError').html('');
	    	 $('body').css('cursor', 'progress');
	    	 $('.all-button').attr('disabled', true);
	    	 $('#csrProcess').html('Processing : Checking');
	    	 $.ajax({
	  			url: base_url,
	              type: 'POST',
	              data: {
	              	cmd: 'module'
	                  , module: 'ssl'
	                  , action: 'ajax_cancel_order'
	                  , orderid: order_id
	                  , partnerorderid: $('#partnerOrderId').val()
	              },
	              success: function(data){
	            	  var aResponse = data.aResponse;
	            	  if(aResponse == true){
		            	  $('#csrProcess').html('Processing : Refreshing');
		            	  location.reload();
	            	  } else {
	            		  console.log(aResponse);
	            		  $('#csrProcess').html('');
	           			  $('#csrError').html('Cancel Error : ' + aResponse.error[0].errorMessage);
	            	      $('body').css('cursor', 'default');
	            	      $('.all-button').attr('disabled', false);
	            	  }
	              }
	    	 });
     	}
     });
     
     $('#button-revoke').click(function(){
    	 alert('For SSL order, To terminate this account you have to submit revocation request below.');
    	 $('#button-revoke').hide();
    	 $('#button-reissue').hide();
    	 $('#check-status').hide();
    	 $('.tr-completed').hide();
    	 $('.td-contact-table').hide();
    	 $('.tr-symantec-info').hide();
    	 $('.td-emailapproval').hide();
    	 $('.td-domaininfo').hide();
    	 $('.td-csr').hide();
    	 $('.td-order-id').hide();
    	 $('.td-state-process').hide();
    	 $('.tr-revoke').show();
    	 $('.tr-manual-set-status').hide();
    	 $('.modify-order').hide();
    	 $('#button-revoke-step2').show();
    	 $('#button-revoke-step2-back').show();
     });
     
     $('#button-revoke-step2').click(function(){
    	 if($('#revoke-type').val() == ''){
    		  $('#csrProcess').html('');
  			  $('#csrError').html('Error : Please select revoke type.');
	   	      $('body').css('cursor', 'default');
	   	      $('.all-button').attr('disabled', false);
	   	      $('#revoke-reason').attr('readonly', false);
	   	 	  $('#revoke-reason').css('background-color', '#fff');
    	 } else {
    		 var confirmBox = confirm('Are you sure you want to terminate?');
        	 if(confirmBox){
		    	 $('#csrError').html('');
		    	 $('#csrProcess').html('Processing : Revoking');  
		    	 $('body').css('cursor', 'progress');
		    	 $('.all-button').attr('disabled', true);
		    	 $('#revoke-reason').attr('readonly', true);
		 		 $('#revoke-reason').css('background-color', '#ebebe4');
		 		 
		    	 $.ajax({
		  			url: base_url,
		              type: 'POST',
		              data: {
		              	cmd: 'module'
		                  , module: 'ssl'
		                  , action: 'ajax_revoke'
		                  , orderid: order_id
		                  , reason: $('#revoke-reason').val()
		                  , type: $('#revoke-type').val()
		              },
		              success: function(data){
		            	  aResponse = data.aResponse;
		            	  console.log(aResponse);
		            	  if(aResponse != true){
		            		  $('#csrProcess').html('');
		           			  $('#csrError').html(aResponse);
		            	      $('body').css('cursor', 'default');
		            	      $('.all-button').attr('disabled', false);
		            	      $('#revoke-reason').attr('readonly', false);
		            	 	  $('#revoke-reason').css('background-color', '#fff');
		            	  } else {
		            		  $('#csrProcess').html('Processing : Refreshing');
		            		  location.reload();
		            	  }
		            	  console.log(data);
		              }
		  		});
        	}
    	 }
     });
     
     $('#button-revoke-step2-back').click(function(){
    	 $('#button-revoke').show();
    	 $('#button-reissue').show();
    	 $('#check-status').show();
    	 $('.td-contact-table').show();
    	 $('.tr-symantec-info').show();
    	 $('.td-emailapproval').show();
    	 $('.td-domaininfo').show();
    	 $('.td-csr').show();
    	 $('.td-order-id').show();
    	 $('.td-state-process').show();
    	 $('.tr-revoke').hide();
    	 $('#button-revoke-step2').hide();
    	 $('#button-revoke-step2-back').hide();
    	 $('#csrProcess').html('');
		 $('#csrError').html('');
		 $('.modify-order').show();
		 $('.tr-completed').show();
		 $('.tr-manual-set-status').show();
		 
		 $('#button-reissue-step2').hide();
		 $('#button-reissue').show();
     });
     
     $('#csrShow').click(function(){
    	 $('#csrShow').hide();
    	 $('#csrHide').css('display', 'inline');
    	 $('#csr-area').css('display', 'inline');
     });
     
     $('#csrHide').click(function(){
    	 $('#csrHide').hide();
    	 $('#csrShow').css('display', 'inline');
    	 $('#csr-area').hide();
     });
     
	$("#caCertFocus").focus(function() {
		var $this = $(this);
		$this.select();

		$this.mouseup(function() {
			$this.unbind("mouseup");
			return false;
		});
	});

	$("#servCertFocus").focus(function() {
		var $this = $(this);
		$this.select();

		$this.mouseup(function() {
			$this.unbind("mouseup");
			return false;
		});
	});

	$("#pkcs7Focus").focus(function() {
    	 var $this = $(this);
    	 $this.select();

    	 $this.mouseup(function() {
    		 $this.unbind("mouseup");
    		 return false;
    	 });
	});

	$("#pkcs12Focus").focus(function() {
		var $this = $(this);
		$this.select();

		$this.mouseup(function() {
			$this.unbind("mouseup");
			return false;
		});
	});

	$("#pkcs12PassFocus").focus(function() {
		var $this = $(this);
		$this.select();

		$this.mouseup(function() {
			$this.unbind("mouseup");
			return false;
		});
	});
     
     
     function hidealldetail(){
    	$('.td-emailapproval').hide();
 		$('.td-contact-table').hide();
 		$('.td-domaininfo').hide();
     }
     
     function hideCSRWithShowButton(){
    	$('#csr-area').attr('readonly', true);
		$('#csr-area').css('background-color', '#ebebe4');
		$('#csr-area').hide();
		$('#csrShow').show();
		$('#csrHide').hide();
     }
     
     function hideContactWithShowButton(){
    	$('#detailShow').show();
    	$('#td-contact-table-content').hide();
    	$('.require-field').hide();
     }
     
     function showDomain(){
    	$('#domainName').text($('#hid_domain_name').val());
		$('.td-domaininfo').show();
		$('#server-type-span').text($('#hid_server_type').val());
     }
     
     function hideDomain(){
     	$('.td-domaininfo').hide();
      }
     
     function showEmail(){
    	$('.td-emailapproval').show();
    	if($('#hid_ssl_type').val() == 'DV'){
    		$('#emailapproval-select').html($("#hid_email_approval").val());
    	} else {
    		$('.td-emailapproval').hide();
    	}
     }
     
     function hideEmail(){
    	 $('.td-emailapproval').hide();
     }
     
     function createEmailApprovalList(emailList){
    	 var output = '';
    	 var checker = 0;
    	 var nowMail = $('#hid_email_approval').val();

    	 output += '<select id="email_approval">';
    	 
    	 for(i = 0;i < emailList.length; i++){
    		 output += '<option value="' + emailList[i] + '"';
    		 if(nowMail == emailList[i]){
    			 output+= ' selected';
    		 }
    		 output += '>' + emailList[i] + '</option>';
    	 }
    	 
    	 output += '</select>';
    	 $('#emailapproval-select').html(output);
     }
     
     function createServerTypeList(){
    	 var nowType = $('#hid_server_type').val();
    	 var output = '';
    	 var typeList = ['Other', 'IIS'];
    	 
    	 output += '<select id="server_type" name="server_type" >';
    	 for(i in typeList){
    		 output += '<option value="' + typeList[i] + '"';
     	 	if(nowType == typeList[i]){
     		 	output += ' selected';
     	 	}
     	 	output += '>' + typeList[i] + '</option>';
    	 }
    	 $('#server-type-span').html(output);
     }
     
     function createContactTable(){
    	 $('#csrProcess').html('Processing : Generate Contact Table');
    	 $('.all-button').attr('disabled', true);
    	 $.ajax({
 			url: base_url,
             type: 'POST',
             data: {
             	cmd: 'module'
                 , module: 'ssl'
                 , action: 'ajax_getcontactinfo'
                 , orderid: order_id
             },
             success: function(data){
            	 var aResponse = data.aResponse;
            	 console.log(aResponse);
            	 var title = 'o';
            	 for(i in aResponse){
            		 if(aResponse[i].address_type == '1'){
            			 title = 'a';
            		 } else if(aResponse[i].address_type == '2'){
            			 title = 't';
            		 }
            		 $('#' + title + 'firstname').val(aResponse[i].firstname);
            		 $('#' + title + 'lastname').val(aResponse[i].lastname);
            		 $('#' + title + 'email').val(aResponse[i].email_approval);
            		 $('#' + title + 'organization').val(aResponse[i].organization_name);
            		 $('#' + title + 'job').val(aResponse[i].job);
            		 $('#' + title + 'address').val(aResponse[i].address);
            		 $('#' + title + 'city').val(aResponse[i].city);
            		 $('#' + title + 'state').val(aResponse[i].state);
            		 $('#' + title + 'country').val(aResponse[i].country);
            		 $('#' + title + 'postcode').val(aResponse[i].postal_code);
            		 $('#' + title + 'phone').val(aResponse[i].phone);
            		 $('#' + title + 'ext').val(aResponse[i].ext_number);
            		 
            		 $('.organizationContact').attr('readonly', true).css('border', '0');
            		 $('.adminContact').attr('readonly', true).css('border', '0');
            		 $('.techContact').attr('readonly', true).css('border', '0');
            	 }
            	 $('#csrProcess').html('');
            	 $('.all-button').attr('disabled', false);
            	 $('.td-contact-table').show();
     			 $('#td-contact-table-content').hide();
     			 $('#detailShow').show();
             }
 		});	 
     }
     
     function createContactTableOnSubmit(whoisdata){
    	 $('#ofirstname').val(whoisdata.owner.firstName);
    	 $('#afirstname').val(whoisdata.admin.firstName);
    	 $('#tfirstname').val(whoisdata.tech.firstName);
    	 
    	 $('#olastname').val(whoisdata.owner.lastName);
    	 $('#alastname').val(whoisdata.admin.lastName);
    	 $('#tlastname').val(whoisdata.tech.lastName);
    	 
    	 $('#oemail').val(whoisdata.owner.email);
    	 $('#email').val(whoisdata.admin.email);
    	 $('#temail').val(whoisdata.tech.email);
    	 
    	 $('#oorganization').val(whoisdata.owner.organization);
    	 $('#aorganization').val(whoisdata.admin.organization);
    	 $('#torganization').val(whoisdata.tech.organization);
    	 
    	 $('#ojob').val('');
    	 $('#ajob').val('');
    	 $('#tjob').val('');

    	 $('#oaddress').val(whoisdata.owner.address);
    	 $('#aaddress').val(whoisdata.admin.address);
    	 $('#taddress').val(whoisdata.tech.address);
    	 
    	 $('#ocity').val(whoisdata.owner.city);
    	 $('#acity').val(whoisdata.admin.city);
    	 $('#tcity').val(whoisdata.tech.city);
    	 
    	 $('#ostate').val(whoisdata.owner.state);
    	 $('#astate').val(whoisdata.admin.state);
    	 $('#tstate').val(whoisdata.tech.state);
    	 
    	 $('#ocountry').val(whoisdata.owner.country);
    	 $('#acountry').val(whoisdata.admin.country);
    	 $('#tcountry').val(whoisdata.tech.country);
    	 
    	 $('#opostcode').val(whoisdata.owner.postal);
    	 $('#apostcode').val(whoisdata.admin.postal);
    	 $('#tpostcode').val(whoisdata.tech.postal);
    	 
    	 $('#ophone').val(whoisdata.owner.phone);
    	 $('#aphone').val(whoisdata.admin.phone);
    	 $('#tphone').val(whoisdata.tech.phone);
    	 
    	 $('#oext').val('');
    	 $('#aext').val('');
    	 $('#text').val('');
     }
     
     function validateContactData(input, title){
    	 var head = 'o';
    	 if(title == 'Admin'){
    		 head = 'a';
    	 } else if(title == 'Technical'){
    		 head = 't'
    	 }
    	 for(i in input){
    		 if(input[i] == '' && i != 'ext'){
    			 if(i == 'state_and_region'){
    				 i = 'state/region';
    			 }
    			 alert(title + ' [' + i + '] : cannot be null');
    			 if(i == 'state/region'){
    				 i = 'state';
    			 }
    			 $('#' + head + i).focus();
    			 return 1;
    		 } else if(i == 'country' && input[i].toLowerCase() == 'jp'){
    			 alert(title + ' [' + i + '] : cannot be located in Japan.');
    			 $('#' + head + i).focus();
    			 return 1;
    		 }
    	 }
    	 return 0;
     }
     
     function generateStatus(status){
    	 switch(status){
	    	 case 'WF_AUTHORIZATION' :
	         case 'RV_WF_AUTHORIZATION' :
	        	 return 'Waiting for verification call';
	         case 'AUTHORIZATION_FAILED' :
	        	 return 'Failed verification call';
	         case 'WF_ACK_EMAIL' :
	        	 return 'Waiting for sending of acknowledgement email';
	         case 'WF_DOMAIN_APPROVAL_ADDRESS' :
	        	 return 'Waiting for change of Whois approval address';
	         case 'WF_DOMAIN_APPROVAL_EMAIL' :
	        	 return 'Waiting for sending of Whois approval email';
	         case 'DOMAIN_APPROVAL_EMAIL_FAILED' :
	        	 return 'Failed sending Whois approval email';
	         case 'WF_DOMAIN_APPROVAL' :
	        	 return 'Waiting for approval';
	         case 'WF_EXTERNAL_APPROVALS' :
	        	 return 'Waiting for GeoCenter approval';
	         case 'DOMAIN_NOT_PREVETTED' :
	        	 return 'Domain not pre-vetted';
	         case 'WF_SECURITY_REVIEW' :
	        	 return 'Waiting for security review';
	         case 'SECURITY_REVIEW_FAILED' :
	        	 return 'Failed Security Review';
	         case 'WF_MANUAL_VETTING' :
	        	 return 'Waiting for manual vetting';
	         case 'WF_VETTING_REVIEW' :
	        	 return 'Waiting for vetting review';
	         case 'WF_PAYMENT' :
	        	 return 'Waiting for payment processinig';
	         case 'PAYMENT_FAILED' :
	        	 return 'Failed payment processing';
	         case 'WF_CERTGEN' :
	        	 return 'Waiting for certificate generation';
	         case 'CERTGEN_FAILED' :
	        	 return 'Failed certificate generation';
	         case 'WF_FINALIZATION' :
	        	 return 'Waiting for finalization';
	         case 'WF_RESELLER_APPROVAL_POSTVETTING' :
	        	 return 'Waiting for reseller approval';
	         case 'WF_RESELLER_APPROVAL_PRECERTGEN' :
	        	 return 'Waiting for reseller approval';
	         case 'WF_RESELLER_APPROVAL_PREVETTING' :
	        	 return 'Waiting for reseller approval';
	         case 'WF_TRIAL_EXPIRATION' :
	        	 return 'Waiting for the trial period to expire';
	         case 'CONVERTED' :
	        	 return 'Trial order has been converted';
	         case 'COMPLETED' :
	        	 return 'Completed';
	         case 'REJECTED' :
	        	 return '<font color="red">Order has rejected by symantec.</font>';
	         case 'WF_CONSUMER_AUTH' :
	        	 return 'Waiting for consumer authentication';
	         case 'WF_Malware_Scan' :
	        	 return 'Waiting for malware scan';
	         case 'WF_FILE_AUTH' :
	        	 return 'Waiting for file authentication';
	         case 'WAITING_SUBMIT_CSR' :
	        	 return 'Waiting for submit CSR';
	         case 'WAITING_SUBMIT_ORDER' :
	        	 return 'Waiting for submit order';
	         case 'WAITING_SUBMIT_PHONECALL' :
	        	 return 'Waiting for submit phone call';
	         case 'WAITING_SUBMIT_DOCUMENT' :
	        	 return 'Waiting for organization documents';
	         case 'ORDER_WAITING_FOR_APPROVAL' :
	        	 return 'Waiting for approval.';
	         default :
	        	 return status;
    	 }
     }
});

function showTime(){
    $('#date_pick1').css('border', 'initial');
    $('#date_pick1').css('background-color', 'white');
    $('#start').css('display', 'inline');
    $('#to').css('display', 'inline');
    $('#end').css('display', 'inline');
    $('#gmt').css('display', 'inline');
}

function showTime2(){
    $('#date_pick2').css('border', 'initial');
    $('#date_pick2').css('background-color', 'white');
    $('#start2').css('display', 'inline');
    $('#to2').css('display', 'inline');
    $('#end2').css('display', 'inline');
    $('#gmt').css('display', 'inline');
}

function set_status(order_id){
    if($("#ssl_status").val() != 0){
       if(confirm("Do you want to change status ?")){
           var RVL_BASEURL = "{/literal}{$system_url}{literal}";
           $.ajax({
               type: "POST"
               , url: RVL_BASEURL + '7944web/index.php'
               , data: {
                   cmd: 'module'
                   , module: 'ssl'
                   , action: 'ajax_set_status'
                   , order_id: order_id
                   , ssl_status: $("#ssl_status").val()
                   }
               , dataType: 'json'
               , success: function(data) {
                   if (data.aResponse == undefined) {
                           alert('ERROR: Cannot get response!!');
                           return false;
                   } else {
                           aResponse = data.aResponse;
                       }
                           
                   if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                           alert('ERROR: ' + aResponse.message);
                           return false;
                   } else if (aResponse.status != undefined && aResponse.status == 'success') {
                           alert(aResponse.message);
                           window.location.reload();
                   } else {
                           alert('ERROR: Cannot process !!');
                           return false;
                   }
               }
           });
       }
   }else{
       alert('Please select status');
       return false;
   }
}

</script>
{/literal}