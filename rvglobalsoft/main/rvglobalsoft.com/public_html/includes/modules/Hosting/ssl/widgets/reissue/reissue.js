$(document).ready(function(){
	var system_url = $('#system_url').val();
    var base_url = system_url + 'index.php';
    var account_location = base_url + '/clientarea/services/ssl/{/literal}{$service.id}{literal}/';
    var order_id = $('#order_id').val();
    
    $("#upload_csr").live( 'change', function () {
        $("#submit_upload_csr").click();
        $('#form_upload_csr').trigger("reset");
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
            success: function(data){
                console.log(data);
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
    
    $('.reissue_button').click(function(e){
        var csr = $('#csr_data').val();
        var email = $('#reissue-mail').val();
        var errorText = '';
        var error = false;
        var chkDup = {};
        $('#reissue-error-text').text('');
        $('#reissue-error-tr').hide();
        $('#reissue-table').addLoader();
        
        var dnsInp = $('input[name^="dns"]').map(function(){return $(this).val().trim();}).get();
        var dnsId = $('input[name^="dns"]').map(function(){return $(this).attr('id');}).get();
        
        for(i in dnsId){
        	if(dnsInp[i] == ''){
                showError('Please insert SAN', 'SAN', dnsId[i]);
                error = true;
                break;
        	}
        	
        	if(typeof chkDup[dnsInp[i]] == 'undefined'){
        		chkDup[dnsInp[i]] = 1;
        	} else {
                showError('You cannot order the duplicated domain name', 'SAN', dnsId[i]);
                error = true;
                break;
        	}
        }
        
        e.preventDefault();
        if(!error){
	        if(csr == ''){
	            showError('Please insert CSR', 'CSR');
	        } else if(!error){
	        	$('#reissue_form').submit();
	        }
        }
    });
    
    $('.dns').change(function(){
    	var value = $(this).attr('name');
    	var id = 'reset' + $(this).attr('id').replace('dns', '');
    	$('#' + id).show();
    });
    
    function showError(msg, key, focus)
    {
    	focus = typeof focus !== 'undefined' ? focus : false;
    	$('#reissue-error-tr').show();
    	$('#reissue-error-text').html(key + ' Error: ' + msg + '.');
    	if(focus){
    		$('#' + focus).focus();
    	}
    	$('#preloader').remove();
    }
});

function resetSAN(that)
{
	var value = $(that).attr('name');
	var id = 'dns' + $(that).attr('id').replace('reset', '');
	$('#' + id).val(value);
	$(that).hide();
	
}