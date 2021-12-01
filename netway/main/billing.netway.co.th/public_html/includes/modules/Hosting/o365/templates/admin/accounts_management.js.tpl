{literal}
<script type="text/javascript">

	$('#addTxt').click(function(){
		if($('#txtData').val() == ''){
			$('#txtData').focus();
			return false;
		}
		
		$('#o365-setting').addLoader();
		$.post('?cmd=o365&action=checkTxtRecordForVerifyDomain', {
											'domainName'    : $('#domainName').val(),
											'txtdata'		: $('#txtData').val()
											
		}, function (data) {
			console.log(data);
		    //parse_response(data.aResponse.data);
		    if(data.aResponse.data == true){
		    	
		    	$.post('?cmd=o365&action=addTxtRecord', {
											'domainName'    : $('#domainName').val(),
											'txtdata'		: $('#txtData').val()
											
				}, function (data) {
					
					if(data.aResponse.data == true && data.aResponse.msg.metadata.result == 1){
						$('#step-1-status').html('<font color=green>ทำรายการสำเร็จ : เพิ่ม TXT Record เรียบร้อย</font>');	
					}else if(data.aResponse.data == true && data.aResponse.msg.metadata.result == 0){
						$('#step-1-status').html('<font color=red>ทำรายการไม่สำเร็จ : '+ data.aResponse.msg.metadata.reason +'</font>');	
					}else if(data.aResponse.data == false){
						$('#step-1-status').html('<font color=red>ทำรายการไม่สำเร็จ : '+ data.aResponse.msg +'</font>');
					}
					$('#preloader').remove();																
				});
		    	
		    }else{
		    	
		    	$('#step-1-status').html('<font color=red>ทำรายการไม่สำเร็จ : '+ data.aResponse.msg + '</font>');
		    	$('#step-2-status').html('');
		    	$('#preloader').remove();
		    }
		    
		});
		
	});
	
	
	$('#addAllDns').click(function(){
		if($('#exMxPta').val() == ''){
			$('#exMxPta').focus();
			return false;
		}
		$('#o365-setting').addLoader();
		$.post('?cmd=o365&action=editO365Dns', {
											'domainName'    : $('#domainName').val(),
											'hostname'		: $('#hostname').val(),
											'exMxPta'		: $('#exMxPta').val()
											
					}, function (data) {
						
						console.log(data);
						
						if(data.aResponse.status == 1){
							var i = 1;
							$.each(data.aResponse.data , function(key,value){
								if(i == 1){
									$('#step-2-status').html('');
								}
								if(value.result == 1){
									$('#step-2-status').append('<font color=green>Record '+ i + ' status: สำเร็จ</font><br>');	
								}else{
									$('#step-2-status').append('<font color=red>Record '+ i + ' status: '+ value.reason +'</font><br>');
								}
								i++;
							});
							
						}else if(data.aResponse.status == 0){
							$('#step-2-status').html('<font color=red>ทำรายการไม่สำเร็จ : '+ data.aResponse.msg +'</font>');	
						}
						
						$('#preloader').remove();
						
					});
		
	});

	function getAzureSubscriptionFromPartnerCenter(module_id, account_id)
	{
		let divContainer = document.getElementById("result_azure_subscription");
		divContainer.innerHTML = "Please wait, processing...";
		let btGetSubscription = document.getElementById("bt_get_subscription");
		btGetSubscription.disabled = true;
		btGetSubscription.style = 'display: none;';
		
		$.get(`?cmd=module&module=${module_id}&action=getCustomerInfoFromPartnerCenterWithDomain&account_id=${account_id}`, function(response, status) {
			btGetSubscription.disabled = false;
			btGetSubscription.style = 'display: block;';
			divContainer.innerHTML = response;
		});
	}
	
	function sync_ms_id_to_hb_account(module_id, account_id) {
		let _bt  = document.getElementById("bt_sync_ms_id_to_hb_account");
		_bt.style = 'display: none;';
		let _txt  = document.getElementById("txt_sync_ms_id_to_hb_account");
		_txt.innerHTML = 'Please wait, processing...';
		$.get(`?cmd=module&module=${module_id}&action=doSyncMicrosiftID2HBAccount&account_id=${account_id}`, function(response, status) {
			if (response.errors != undefined) {
				alert(`Sync Microsoft ID to Hostbill account ID "${account_id}" have problem. ${response.errors.message}`);
				_bt.style = 'display: block;'
				_txt.innerHTML = ''
			} else {
				_txt.innerHTML = ''
				alert(`Updated Microsoft ID to Hostbill account ID has been successfully.`);
				for (let index in response.data.configs) {
					let _config =response.data.configs[index];
					let _inputMsidField  = document.getElementsByName(`custom[${_config.config_cat}][${_config.config_id}]`);
					for (let i=0; i < _inputMsidField.length; i++) {
						_inputMsidField[i].value = `${_config.value}`;
					}
				}
			}
		});
	}
</script>
{/literal}