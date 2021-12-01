<script type="text/javascript">
    {literal}
    // $('.row-c').html(base64_decode('{/literal}{$step1}{literal}'));
    
    $('document').ready(function(){
    	var base_url = '{/literal}{$system_url}{literal}index.php';
    	var price_summary = JSON.parse('{/literal}{$price_summary_json}{literal}');
    	
		var nowValidity = $("input[name='validity_period']").map(function(){
			if($(this).attr('checked') == 'checked'){
				return $(this).val();
			}
    	}).get();
		
		if(nowValidity > 12){
			$('#hashing').val('SHA2-256');
        	$("#hashing option[value*='SHA1']").prop('disabled', true);
		} else {
			$("#hashing option[value*='SHA1']").prop('disabled', false);
		}
		
		function numberWithCommas(x) {
			x = x.toString();
		    //x = x.replace('.00', '');
		    return x.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
    	
        $('.priceClass').change(function(){
            var id = $(this).val();
            var price_summary_now_validity = '';
            var discountInfo = $('#discount').val();
            if(discountInfo){
            	var find = '\'';
            	var re = new RegExp(find, 'g');
            	discountInfo = JSON.parse(discountInfo.replace(re, '"'));
            }
            $('.priceBox').css('border', '4px solid grey');
            $('.priceHead').css('background-color', 'black');
            $('.priceSave').attr('color', 'black');
            $('#priceBox' + id).css('border', '4px solid #73c90e');
            $('#priceHead' + id).css('background-color', '#7ed320');
            $('#priceSave' + id).attr('color', '#7ed320');
            if(id > 12){
            	$('#hashing').val('SHA2-256');
            	$("#hashing option[value*='SHA1']").prop('disabled', true);
            } else {
            	$("#hashing option[value*='SHA1']").prop('disabled', false);
            }
            switch(id){
            	case '12' : price_summary_now_validity = 'a'; break;
            	case '24' : price_summary_now_validity = 'b'; break;
            	case '36' : price_summary_now_validity = 't'; break;
            }
            
            var yearText = (id/12 > 1) ? 's' : '';
            $('#price_summary_num_year').text(id/12);
            $('#price_summary_year_text').text(yearText);
            $('#price_summary_product_price').text(numberWithCommas(parseFloat(price_summary[price_summary_now_validity]['product_price']).toFixed(2)));
            if(typeof price_summary[price_summary_now_validity]['san_price'] != 'undefined'){
            	$('#price_summary_san_price').text(numberWithCommas(parseFloat(price_summary[price_summary_now_validity]['san_price']).toFixed(2)));
            }
            if(typeof price_summary[price_summary_now_validity]['server_price'] != 'undefined'){
            	$('#price_summary_server_price').text(numberWithCommas(parseFloat(price_summary[price_summary_now_validity]['server_price']).toFixed(2)));
            }
            var total = parseFloat(price_summary[price_summary_now_validity]['total']);
			
			if(price_summary_now_validity == discountInfo.cyc){
				$('#renew_discount').show();
				total -= discountInfo.discount; 
			} else {
				$('#renew_discount').hide();
			}
			$('#totalShow').text(numberWithCommas(parseFloat(total).toFixed(2)));
        });
        
        $('#submitCSROption0').click(function(){
            $('.format_textarea').hide();
            $('#addtocart').show();
            $('#progressBar').hide();
            $('.information_textarea').hide();
        });
        
        $('#submitCSROption1').click(function(){
            $('.format_textarea').show();
            $('#addtocart').hide();
            $('#progressBar').hide();
            $('.information_textarea').hide();
        });
        
        $("#upload_csr").live( 'change', function () {
            $("#submit_upload_csr").click();
            $('#form_upload_csr').trigger("reset");
            $('#upload_csr').attr('disabled', true);
            $('#csr_data').attr('disabled', true);
            $('#validate_button').attr('disabled', true);
            $('#hashing').attr('disabled', true);
            $('#servertype').attr('disabled', true);
        });
        
        $("#form_upload_csr").submit(function(){
            var formObj = $(this);
            var formURL = formObj.attr("action");
            var formData = new FormData(this);
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
                    $('#upload_csr').attr('disabled', false);
                    $('#csr_data').attr('disabled', false);
                    $('#validate_button').attr('disabled', false);
                    $('#hashing').attr('disabled', false);
                    $('#servertype').attr('disabled', false);
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
                       $("#csr_data").val(aResponse.message);
                    } else {
                        alert('ERROR: Cannot process !!');
                        return false;
                    }
                }   
            });
        });
        
        $('#addtocart').click(function(){
        	
        	var editInfo = $('#submitCSROption1').attr('checked');
        	var sum_find = ',';
        	var sum_re = new RegExp(sum_find, 'g');
        	var credit = '{/literal}{$client_credit}{literal}';
        	if(editInfo){
        		var techType = $('#techInfoType').val();
        		if(techType == 'sameAdmin'){
        			$('#txt_name_1').val($('#txt_name').val());
                    $('#txt_lastname_1').val($('#txt_lastname').val());
                    $('#txt_email_1').val($('#txt_email').val());
                    $('#txt_job_1').val($('#txt_job').val());
                    $('#txt_tel_1').val($('#txt_tel').val());
                    $('#txt_ext_1').val($('#txt_ext').val());	
        		}
        	}
        	
        	if(editInfo && (validateContact() || validateOrganize())){
        		return false;
        	}
        	
        	var orderInfo = { main: {}};
        	
    		var priceList = JSON.parse('{/literal}{$priceListJSON}{literal}');
    		var validity_text = '';
    		orderInfo['main']['product_name'] = '{/literal}{$service.ssl_name}{literal}';
    		orderInfo['main']['validity_period'] = $("input:radio.priceClass:checked").val();
    		switch(orderInfo['main']['validity_period']){
    			case '12': validity_text = 'a'; validity_full_text = 'Annually'; break;
    			case '24': validity_text = 'b'; validity_full_text = 'Biennially'; break;
    			case '36': validity_text = 't'; validity_full_text = 'Triennially'; break;
    		}
    		orderInfo['main']['price'] = priceList[validity_text]['price'];
        	var summary_price = parseFloat(priceList[validity_text]['price'].replace(sum_re, ''));
        	if($('#supportSAN').val()){
        		if(priceList.san_amount > 0 && typeof priceList[validity_text]['sanSum'] != 'undefined'){
	        		$('#summarySANAmount').text(priceList['san_amount']);
	        		$('#summarySAN').text(priceList[validity_text]['sanSum']);
	        		summary_price += parseFloat(priceList[validity_text]['sanSum'].replace(sum_re, ''));
        		}
        		
        		if(editInfo && validateSAN()){
        			return false;
        		}
        	}
        	
        	if(priceList.server_amount > 0 && priceList[validity_text]['server'] != 'undefined'){
        		$('#summaryServAmount').text((priceList['server_amount']-1));
        		$('#summaryServer').text(priceList[validity_text]['server']);
        		summary_price += parseFloat(priceList[validity_text]['server'].replace(sum_re, ''));
    		}

        	var total = parseFloat(summary_price.toFixed(2));
        	var discountInfo = $('#discount').val();
            if(discountInfo){
            	var find = '\'';
            	var re = new RegExp(find, 'g');
            	discountInfo = JSON.parse(discountInfo.replace(re, '"'));
            	if(validity_text == discountInfo.cyc){
            		$('#summaryDiscount').show();
            		$('#summaryDiscount_Text').text(numberWithCommas(discountInfo.discount));
            		total -= parseFloat(discountInfo.discount);
            	}
            }
            var totalRecurring = numberWithCommas(total.toFixed(2));
            if(credit){
            	if(credit >= total){
            		credit = total;
            		total = 0.00;
            	} else {
            		total -= parseFloat(credit);
            	}
            	$('#summaryCredit').show();
            	$('#summaryCredit_Text').text(numberWithCommas(parseFloat(credit).toFixed(2)));
            }
            
            total = numberWithCommas(total.toFixed(2));
            
        	$('#orderSummary').val(JSON.stringify(orderInfo));
        	$('#summarySSLName').text('{/literal}{$service.ssl_name}{literal}');
        	$('#summarySSLPrice').text(numberWithCommas(priceList[validity_text]['price']));
        	$('#summaryCycle').text(validity_full_text);
        	$('.summarySubtotal').text(numberWithCommas(summary_price.toFixed(2)));
        	$('.summaryTotal').text(numberWithCommas(total));
        	$('.summaryTotalRecurring').text(numberWithCommas(totalRecurring));
        	$('#step1').hide();
        	$('#step2').show();
        	
        	function validateContact()
        	{
        		var contactCheck = {txt_name: 'First name', txt_lastname: 'Last name', txt_email: 'Email Address', txt_organize: 'Organization Name', txt_job: 'Job Title', txt_address: 'Address', txt_city: 'City', txt_state: 'State/Region', txt_country: 'Country', txt_post_code: 'Postal Code', txt_tel: 'Phone number'};
        		var validate = /^[a-zA-Z0-9\.\\\/\_\-\s]*$/;
//        		var validateLo = /^[a-zA-Z0-9\.\\\/\_\-\s\,]*$/;
        		var validateLo = /^[a-zA-Z0-9\,\.\\\/\_\-\s@()\']*$/;
            	
            	for(key in contactCheck){
            		if($('#' + key).val() == ''){
            			alert('Field \'' + contactCheck[key] + '\' required.');
            			$('#' + key).focus();
            			return true;
            		} else if ((key == 'txt_name' || key == 'txt_lastname' || key == 'txt_job' || key == 'txt_city' || key == 'txt_state' || key == 'txt_post_code') && (validate.test($('#' + key).val()) == false)){
            			alert('Field \'' + contactCheck[key] + '\' invalid characters.');
            			$('#' + key).focus();
            			return true;
            		} else if ((key == 'txt_organize' || key == 'txt_address') && validateLo.test($('#' + key).val()) == false){
			        	alert('Field \'' + contactCheck[key] + '\' invalid characters.');
						$('#' + key).focus();
						return true;
            		} else if(key == 'txt_tel' && $('#' + key).val().replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
	                    alert('Field \'' + contactCheck[key] + '\' have no numeric character.');
	                    $('#' + key).focus();
	                    return true;
            		} else if ($('#' + key + '_1').val() == ''){
            			alert('Field \'' + contactCheck[key] + '\' required.');
            			$('#' + key + '_1').focus();
            			return true;
            		} else if ((key == 'txt_name' || key == 'txt_lastname' || key == 'txt_job' || key == 'txt_city' || key == 'txt_state' || key == 'txt_post_code') && (validate.test($('#' + key + '_1').val()) == false)){
            			alert('Field \'' + contactCheck[key] + '\' invalid characters.');
            			$('#' + key + '_1').focus();
            			return true;
            		}  else if ((key == 'txt_organize' || key == 'txt_address') && validateLo.test($('#' + key + '_1').val()) == false){
			        	alert('Field \'' + contactCheck[key] + '\' invalid characters.');
						$('#' + key + '_1').focus();
						return true;
            		} else if(key == 'txt_tel' && $('#' + key + '_1').val().replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
                        alert('Field \'' + contactCheck[key] + '\' have no numeric character.');
                        $('#' + key).focus();
                        return true;
                    }
            	}
            	$('#txt_tel').val($('#txt_tel').val().replace(/[^\+0-9\.]/g, ''));
                $('#txt_tel_1').val($('#txt_tel_1').val().replace(/[^\+0-9\.]/g, ''));
        	}
        	
        	function validateOrganize()
        	{
        		var organizeCheck = {o_name: 'Organize Name', o_phone: 'Phone Number', o_address: 'Address', o_city: 'City', o_state: 'State/Province', o_country: 'Country', o_postcode: 'Postal Code'};
//        		var validate = /^[a-zA-Z0-9\.\\\/\_\-\s]*$/;
        		var validate = /^[a-zA-Z0-9\,\.\\\/\_\-\s@&!()\']*$/;
        		
        		for(key in organizeCheck){
        			if(typeof $('#' + key).val() != 'undefined' && $('#' + key).val() == ''){
        				alert('Field \'' + organizeCheck[key] + '\' required.');
        				$('#' + key).focus();
        				return true;
        			} else if(key == 'o_country' && $('#' + key).val() == 'JP'){
        				alert('We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.');
        				$('#' + key).focus();
        				return true;
        			} else if((key == 'o_name' || key == 'o_address' || key == 'o_city' || key == 'o_state') && (validate.test($('#' + key).val()) == false)){
        				alert('Field \'' + organizeCheck[key] + '\' invalid characters.');
        				$('#' + key).focus();
        				return true;
	        		} else if(typeof $('#' + key).val() != 'undefined' && key == 'o_phone' && $('#' + key).val().replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
	        			alert('Field \'' + contactCheck[key] + '\' have no numeric character.');
	        			$('#' + key).focus();
	        			return true;
	        		}
        		}
        		if(typeof $('#o_phone').val() != 'undefined'){
                    $('#o_phone').val($('#o_phone').val().replace(/[^\+0-9\.]/g, ''));
                }
        	}
        	
        	function validateSAN()
        	{
        		var priceList = JSON.parse('{/literal}{$priceListJSON}{literal}');
        		var sanAdd = (typeof priceList.san_amount != 'undefined' && priceList.san_amount > 0) ? parseInt(priceList.san_amount) : 0;
        		var support_san = parseInt($('#supportSAN').val());
        		var sanIncluded = parseInt({/literal}{if isset($sanIncluded)}{$sanIncluded}{else}0{/if}{literal});
        		var sanChk = 0;
        		var commonName = $('#csr_common_name').text();
      		    var dnsChk = [];
      		    //var validate = /^(www.)*([a-zA-Z0-9]{1,})[\.](([a-zA-Z0-9\-]{2,})|([a-zA-Z0-9\-]{2,}[\.]{1,}[a-zA-Z0-9\-]{2,})){1,}$/;
      		    var validate = /^([a-zA-Z0-9\-]*\.){0,}[a-zA-Z0-9\-]*(\.[a-zA-Z\-]{2,5})?\.[a-zA-Z]{2,3}$/;
      		    var pCode = '{/literal}{$service.ssl_productcode}{literal}';
      		    if(pCode == 'QuickSSLPremium'){
      		    	validate = /^(www.)*([a-zA-Z0-9\.]{1,})([a-zA-Z0-9]){1,}$/;
      		    }
      		    
      		    var countSAN = 0;
      		    var sumSAN = sanAdd;
      		    if(sanIncluded > 0){
      		    	sumSAN = sumSAN + (sanIncluded-1);
      		    }
      		    
        		var sanDomain = $("input[name='sanDomain[]']").map(function(){
        			if($(this).val().trim() != ""){
        				countSAN++;
        			}
            		return $(this).val();
            	}).get();
        		
        		var sanId = $("input[name='sanDomain[]']").map(function(){
                	return $(this).attr('id');
                }).get();
        		
        		var sanCheck = {};
        		var haveSAN = false;
        		for(i = 0; i < sanDomain.length; i++){
        			if(sanDomain[i].trim() != ''){
        				haveSAN = true;
        			}
        			if(pCode == 'QuickSSLPremium' && sanDomain[i] != ''){
          		    	sanDomain[i] = sanDomain[i].trim() + '.' + commonName;
          		    }
        			sanCheck[sanId[i]] = sanDomain[i].trim();
        		}
        		
        		if(haveSAN){
	        		for(key in sanCheck){
	        			if(sanCheck[key] == '' && sanAdd > 0){
	        				alert("Please complete each domain name field before submitting form.");
	        				$('#' + key).focus();
	        				return true;
	        			}
	        			if(sanCheck[key] != ''){
		        			if(dnsChk.indexOf(sanCheck[key]) >= 0 || sanCheck[key] == commonName){
		        				alert('You cannot order the duplicated domain name.');
		        				$('#' + key).focus();
		        				return true;
		        			} else if(validate.test(sanCheck[key]) == false){
		        				alert('Invalid domain name.');
		        				$('#' + key).focus();
		        				return true;
		        			} else if(sanCheck[key].toLowerCase().substring(sanCheck[key].lastIndexOf('.'), sanCheck[key].length) == '.jp'){
		        				alert('Sorry, any domain names registered with .jp extension as sample "' + sanCheck[key] + '", will not be able to order SSL Certificate here.');
		        				$('#' + key).focus();
		        				return true;
		        			} else {
		      		            dnsChk.push(sanCheck[key]);
		        			}
	        			}
	        			sanChk++;
	        		}
        		} else if(support_san && sanAdd == 0 && sanIncluded > 0){
        			alert('SAN package requires at least 1 domain name. Please insert the domain name in the field before submitting the order.');
        			$('#sanDomain1').focus();
        			return true;
        		} else if(support_san && sanAdd > 0 && countSAN < sumSAN){
                    alert("Please complete each domain name field before submitting form.");
                    $('#sanDomain1').focus();
                    return true;
                }
        	}
        	
        });
        
        $('#ClearCart').click(function(){
        	// $('#step1').show();
        	// $('#step2').hide();
        	location.reload();
        });
        
        $('#CheckOut').click(function(){
        	if($('#tos').attr('checked')){
        		$('#renewForm').submit();
        	} else {
        		$('#er').show();
        		alert("Please check accepted Term of Service.");
        	}
        })
        
        $('#validate_button').click(function(){
        	elementPerspective(false);
        	$('#err').hide();
    		$('#errMessage').text('');
        	
// $('#progressBar').show();
// progress(1, $('#progressBar'));
        	
        	var orderId = $('#orderId').val();
        	if(($('#csr_data').val()).trim() != ''){
	        	$.ajax({
	    			url: base_url,
	                type: 'POST',
	                data: {
	                	cmd: 'module'
	                    , module: 'ssl'
	                    , action: 'ajax_parse_csr'
	                    , csr: $('#csr_data').val()
	                    , ssl_id: $('#ssl_id').val()
	                },
	                success: function(data){
// progress(10, $('#progressBar'));
	                	csrData = data.aResponse;
	                	if(typeof csrData != 'undefined' && typeof csrData.Status != 'undefined' && csrData.Status && $('#domainName').val() == csrData.CommonName){
	                		$.ajax({
	                			url: base_url,
	                            type: 'POST',
	                            data: {
	                            	cmd: 'module'
	                                , module: 'ssl'
	                                , action: 'ajax_get_whois_by_domain'
	                                , domain: csrData.CommonName
	                            },
	                            success: function(data){
// progress(20, $('#progressBar'));
	                            	whoisData = data.aResponse;
	                            	if(whoisData.status){
	                            		$.ajax({
	                            			url: base_url,
	                                        type: 'POST',
	                                        data: {
	                                        	cmd: 'module'
	                                            , module: 'ssl'
	                                            , action: 'ajax_get_contact_info'
	                                            , orderId: orderId
	                                        },
	                                        success: function(data){
// progress(30, $('#progressBar'));
	                                        	contactInfo = data.aResponse;
	                                        	
	                                        	var countryList = getCountry();
	                                        	var contact = JSON.parse('{/literal}{$contactDetailJSON}{literal}');
	                                        	var billingcontact = JSON.parse('{/literal}{$clientDetailJSON}{literal}');
	                                        	elementPerspective(true);
	                                        	
	                                        	$('.format_textarea').hide();
	                                        	$('.information_textarea').show();
	                                        	
	                                        	if(csrData.CommonName.substring(0, 4) == 'www.'){
	                                        		$('.dvSpecial').text('.' + csrData.CommonName.substring(4));
	                                        	} else {
	                                        		$('.dvSpecial').text('.' + csrData.CommonName);
	                                        	}
	                                        	$('#csr_common_name').text(csrData.CommonName);
	                                        	$('#csr_organization').text(csrData.Organization);
	                                        	$('#csr_organization_unit').text(csrData.OrganizationUnit);
	                                        	$('#csr_locality').text(csrData.Locality);
	                                        	$('#csr_state').text(csrData.State);
	                                        	$('#csr_country').text(csrData.Country);
	                                        	$('#csr_email').text(csrData.Email);
	                                        	$('#csr_key_algorithm').text(csrData.KeyAlgorithm);
	                                        	$('#csr_signature_algorithm').text(csrData.SignatureAlgorithm);

	                                        	var emailApproval = '';
	                                        	var st = 0;
	                                        	var nd = 0;
	                                        	var rd = 0;
	                                        	var th = 0;
	                                        	var eC = 0;
	                                        	var p = 0;
	                                        	var selected = 0;
	                                        	for(key in whoisData['emailApproval']){
	                                        		if(whoisData['emailApproval'][key].length > 0 && whoisData['emailApproval'][key].length <= 2 && st == 0){
	                                        			emailApproval += '<b>Registered Domain Contacts</b><br>';
	                                        			st = 1;
	                                        			p = 1;
	                                        		} else if(key.split('.').length == 2 && nd == 0){
	                                        			emailApproval += '<b>Level 2 Domain Addresses</b><br>';
	                                        			nd = 1;
	                                        			p = 1;
	                                        		} else if(key.split('.').length == 3 && rd == 0){
	                                        			emailApproval += '<b>Level 3 Domain Addresses</b><br>';
	                                        			rd = 1;
	                                        			p = 1
	                                        		} else if(key.split('.').length == 4 && th == 0){
	                                        			emailApproval += '<b>Level 4 Domain Addresses</b><br>';
	                                        			th = 1;
	                                        			p = 1;
	                                        		}
	                                        		for(i = 0;i < whoisData['emailApproval'][key].length; i++){
	                                        			emailApproval += '<input type="radio" name="email_approval" id="email_approval_' + eC + '"';
	                                        			if(whoisData['emailApproval'][key][i] == '{/literal}{$email_approval}{literal}' && selected == 0){
	                                        				emailApproval += ' checked';
	                                        				selected = 1;
	                                        			}
	                                        			emailApproval += ' value="' + whoisData['emailApproval'][key][i] + '"';
	                                        			emailApproval += '/><label for="email_approval_' + eC++ + '">' + whoisData['emailApproval'][key][i] + '</label><br>';
	                                        		}
	                                        		if(p == 1){
	                                        			emailApproval += '<br>';
	                                        			p = 0;
	                                        		}
	                                        	}
	                                        	
	                                        	$('#whois_emailinfo').html(emailApproval);
	                                        	if(selected == 0){
// emailApproval = emailApproval.replace('email_approval_0"', 'email_approval_0"
// checked');
	                                        		$('#email_approval_0').attr('checked', true);
	                                        	}
	                                        	
	                                        	
	                                        	$('#addtocart').show();
	                                        	
	                                        	$('#techInfoType').change(function(){
                                                    var techType = $('#techInfoType').val();
                                                    var firstname = '';
                                                    var lastname = '';
                                                    var email = '';
                                                    var job = '';
                                                    var phone = '';
                                                    var ext= '';
                                                        
                                                    switch(techType){
                                                    	case 'sameBefore' :
                                                    		$(".not_same_address").show();
                                                            $('#techContactDiv').css('padding-bottom', '');
                                                    		firstname = contact.tech.firstname;
                                                    		lastname = contact.tech.lastname;
                                                    		email = contact.tech.email;
                                                    		job = contact.tech.job
                                                    		phone = contact.tech.phone;
                                                    		ext = contact.tech.ext;
                                                    		break;
                                                        case 'sameAdmin' :
                                                            $(".not_same_address").hide();
                                                            $('#techContactDiv').css('padding-bottom', '0px');
                                                            break;
                                                        case 'sameBilling' :
                                                            $(".not_same_address").show();
                                                            $('#techContactDiv').css('padding-bottom', '');
                                                            firstname = billingcontact.firstname;
                                                    		lastname = billingcontact.lastname;
                                                    		email = billingcontact.email;
                                                    		job = '';
                                                    		phone = billingcontact.phonenumber;
                                                    		ext = '';
                                                            break;
                                                        case 'sameTech' :
                                                            $(".not_same_address").show();
                                                            $('#techContactDiv').css('padding-bottom', '');
                                                            firstname = whoisData.tech.firstName;
                                                            lastname = whoisData.tech.lastName;
                                                    		email = whoisData.tech.email;
                                                    		job = '';
                                                    		phone = whoisData.tech.phone;
                                                    		ext = '';
                                                            break;
                                                    }
                                                    $('#txt_name_1').val(firstname);
                                                    $('#txt_lastname_1').val(lastname);
                                                    $('#txt_email_1').val(email);
                                                    $('#txt_job_1').val(job);
                                                    $('#txt_tel_1').val(phone);
                                                    $('#txt_ext_1').val(ext);
                                                });
	                                        }
	                            		});
	                            	} else {
	                            		elementPerspective(true);
	                            	}
	                            }
	                		});
	                	} else {
	                		if(typeof csrData == 'undefined' || typeof csrData.Status == 'undefined'){
	                			showError('Cannot connect to API.');
	                		} else if($('#domainName').val() != csrData.CommonName){
	                			showError('Please use the same Common Name as the current name to renew.');
	                		} else {
	                			showError(csrData.Error[0].ErrorMessage);
	                		}
	                		elementPerspective(true);
	                	}
	                }
	        	});
        	} else {
        		showError('Please insert CSR.');
        		elementPerspective(true);
        	}
        	
        	function progress(percent, element) {
                var progressBarWidth = percent * element.width() / 100;
                element.find('div').animate({ width: progressBarWidth }, 500).html(percent + "%&nbsp;");
            }
        	
        	function showError(message){
        		$('#err').show();
        		$('#errMessage').html(message);
        	}
        	
        	function elementPerspective(set){
        		$('#csr_data').attr('readonly', !set);
            	$('#upload_csr').attr('disabled', !set);
            	$('#hashing').attr('disabled', !set);
                $('#servertype').attr('disabled', !set);
            	if(set){
            		$('#preloader').remove();
            		$('#validate_button').show();
            		$('#csrInformation').show();
            	} else {
            		$('.bgvalidate_CSR').addLoader();
            		$('#validate_button').hide();
            		$('#csrInformation').hide();
            	}
        	}
        	
        	function getCountry(){
        		var country = {
	        		AF: 'Afghanistan', AL: 'Albania', DZ: 'Algeria', AS: 'American Samoa'
	                , AD: 'Andorra', AG: 'Angola', AI: 'Anguilla', AG: 'Antigua & Barbuda'
	                , AR: 'Argentina', AA: 'Armenia', AW: 'Aruba', AU: 'Australia'
	                , AT: 'Austria', AZ: 'Azerbaijan', BS: 'Bahamas', BH: 'Bahrain'
	                , BD: 'Bangladesh', BB: 'Barbados', BY: 'Belarus', BE: 'Belgium'
	                , BZ: 'Belize', BJ: 'Benin', BM: 'Bermuda', BT: 'Bhutan'
	                , BO: 'Bolivia', BL: 'Bonaire', BA: 'Bosnia & Herzegovina', BW: 'Botswana'
	                , BR: 'Brazil', BC: 'British Indian Ocean Ter', BN: 'Brunei', BG: 'Bulgaria'
	                , BF: 'Burkina Faso', BI: 'Burundi', KH: 'Cambodia', CM: 'Cameroon'
	                , CA: 'Canada', IC: 'Canary Islands', CV: 'Cape Verde', KY: 'Cayman Islands'
	                , CF: 'Central African Republic', TD: 'Chad', CD: 'Channel Islands'
	                , CL: 'Chile', CN: 'China', CI: 'Christmas Island', CS: 'Cocos Island'
	                , CO: 'Colombia', CC: 'Comoros', CG: 'Congo', CK: 'Cook Islands'
	                , CR: 'Costa Rica', CT: 'Cote D\'Ivoire', HR: 'Croatia', CU: 'Cuba'
	                , CB: 'Curacao', CY: 'Cyprus', CZ: 'Czech Republic', DK: 'Denmark'
	                , DJ: 'Djibouti', DM: 'Dominica', DO: 'Dominican Republic', TM: 'East Timor'
	                , EC: 'Ecuador', EG: 'Egypt', SV: 'El Salvador', GQ: 'Equatorial Guinea'
	                , ER: 'Eritrea', EE: 'Estonia', ET: 'Ethiopia', FA: 'Falkland Islands'
	                , FO: 'Faroe Islands', FJ: 'Fiji', FI: 'Finland', FR: 'France'
	                , GF: 'French Guiana', PF: 'French Polynesia', FS: 'French Southern Ter'
	                , GA: 'Gabon', GM: 'Gambia', GE: 'Georgia', DE: 'Germany'
	                , GH: 'Ghana', GI: 'Gibraltar', GB: 'Great Britain', GR: 'Greece'
	                , GL: 'Greenland', GD: 'Grenada', GP: 'Guadeloupe', GU: 'Guam'
	                , GT: 'Guatemala', GN: 'Guinea', GY: 'Guyana', HT: 'Haiti'
	                , HW: 'Hawaii', HN: 'Honduras', HK: 'Hong Kong', HU: 'Hungary'
	                , IS: 'Iceland', IN: 'India', ID: 'Indonesia', IA: 'Iran'
	                , IQ: 'Iraq', IR: 'Ireland', IM: 'Isle of Man', IL: 'Israel'
	                , IT: 'Italy', JM: 'Jamaica', JP: 'Japan', JO: 'Jordan', KZ: 'Kazakhstan'
	                , KE: 'Kenya', KI: 'Kiribati', NK: 'Korea North', KS: 'Korea South'
	                , KW: 'Kuwait', KG: 'Kyrgyzstan', LA: 'Laos', LV: 'Latvia'
	                , LB: 'Lebanon', LS: 'Lesotho', LR: 'Liberia', LY: 'Libya'
	                , LI: 'Liechtenstein', LT: 'Lithuania', LU: 'Luxembourg', MO: 'Macau'
	                , MK: 'Macedonia', MG: 'Madagascar', MY: 'Malaysia', MW: 'Malawi'
	                , MV: 'Maldives', ML: 'Mali', MT: 'Malta', MH: 'Marshall Islands'
	                , MQ: 'Martinique', MR: 'Mauritania', MU: 'Mauritius', ME: 'Mayotte'
	                , MX: 'Mexico', MI: 'Midway Islands', MD: 'Moldova', MC: 'Monaco'
	                , MN: 'Mongolia', MS: 'Montserrat', MA: 'Morocco', MZ: 'Mozambique'
	                , MM: 'Myanmar', NA: 'Nambia', NU: 'Nauru', NP: 'Nepal'
	                , AN: 'Netherland Antilles', NL: 'Netherlands (Holland, Europe)', NV: 'Nevis', NC: 'New Caledonia'
	                , NZ: 'New Zealand', NI: 'Nicaragua', NE: 'Niger', NG: 'Nigeria'
	                , NW: 'Niue', NF: 'Norfolk Island', NO: 'Norway', OM: 'Oman'
	                , PK: 'Pakistan', PW: 'Palau Island', PS: 'Palestine', PA: 'Panama'
	                , PG: 'Papua New Guinea', PY: 'Paraguay', PE: 'Peru', PH: 'Philippines'
	                , PO: 'Pitcairn Island', PL: 'Poland', PT: 'Portugal', PR: 'Puerto Rico'
	                , QA: 'Qatar', ME: 'Republic of Montenegro', RS: 'Republic of Serbia', RE: 'Reunion'
	                , RO: 'Romania', RU: 'Russia', RW: 'Rwanda', NT: 'St Barthelemy'
	                , EU: 'St Eustatius', HE: 'St Helena', KN: 'St Kitts-Nevis', LC: 'St Lucia'
	                , MB: 'St Maarten', PM: 'St Pierre & Miquelon', VC: 'St Vincent & Grenadines', SP: 'Saipan'
	                , SO: 'Samoa', AS: 'Samoa American', SM: 'San Marino', ST: 'Sao Tome & Principe'
	                , SA: 'Saudi Arabia', SN: 'Senegal', RS: 'Serbia', SC: 'Seychelles'
	                , SL: 'Sierra Leone', SG: 'Singapore', SK: 'Slovakia', SI: 'Slovenia'
	                , SB: 'Solomon Islands', OI: 'Somalia', ZA: 'South Africa', ES: 'Spain'
	                , LK: 'Sri Lanka', SD: 'Sudan', SR: 'Suriname', SZ: 'Swaziland'
	                , SE: 'Sweden', CH: 'Switzerland', SY: 'Syria', TA: 'Tahiti'
	                , TW: 'Taiwan', TJ: 'Tajikistan', TZ: 'Tanzania', TH: 'Thailand'
	                , TG: 'Togo', TK: 'Tokelau', TO: 'Tonga', TT: 'Trinidad & Tobago'
	                , TN: 'Tunisia', TR: 'Turkey', TU: 'Turkmenistan', TC: 'Turks & Caicos Is'
	                , TV: 'Tuvalu', UG: 'Uganda', UA: 'Ukraine', AE: 'United Arab Emirates'
	                , GB: 'United Kingdom', US: 'United States of America', UY: 'Uruguay', UZ: 'Uzbekistan'
	                , VU: 'Vanuatu', VS: 'Vatican City State', VE: 'Venezuela', VN: 'Vietnam'
	                , VB: 'Virgin Islands (Brit)', VA: 'Virgin Islands (USA)', WK: 'Wake Island', WF: 'Wallis & Futana Is'
	                , YE: 'Yemen', ZR: 'Zaire', ZM: 'Zambia', ZW: 'Zimbabwe' 
        		};
        		return country;
        	}
        });
    });
    {/literal}
</script>