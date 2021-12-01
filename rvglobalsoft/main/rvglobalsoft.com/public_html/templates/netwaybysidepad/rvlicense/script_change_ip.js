
function action_addlicense() {
     var getcmd = $('#cmd').val();
     $('.sta_no').hide();
     $('.sta_ok ').show().find('#txt_response_yes').html('waiting.....');
     $.post('?cmd=' + getcmd + '&action=addlicense',$('form#frmaddlicense').serialize(),function(data) {
         // CALL BACK
         //data = jQuery.parseJSON(data);
         var datares = data.aResponse;
         //alert('ddd');
         if (datares.res == true) {
             $('.sta_no').hide();
             $('.sta_ok').show();
             $('#txt_response_yes').html('Add License IP has been successfully processed.');
         } else {
             $('.sta_no').show();
             $('.sta_ok').hide();
             $('#main_ip').val('');
             $('#txt_response_no').html(datares.msg);
         }
         
     });
     
}
function action_chageip() {
     var getcmd = $('#cmd').val();
     $('.sta_no').hide();
     $('.sta_ok ').show().find('#txt_response_yes').html('waiting.....');
     $.post('?cmd=' + getcmd + '&action=changeip',$('form#frmchangeip').serialize(),function(data) {
         // CALL BACK
         //data = jQuery.parseJSON(data);
         //console.log(data);
         var data = data.aResponse;
         //alert('ddd');
         if (data.res == true) {
             $('#frm_ip').html($('#to_ip').val());
             $('#to_ip').val('');
             $('#to_pbip').val('');
             $('.sta_no').hide();
             $('.sta_ok').show();
             $('#txt_response_yes').html('Change IP Request has been successfully processed.');
             if (data.countLimit){
                 var countlimit = data.countLimit;
                 countlimit = countlimit*1;
            
                 if (countlimit > 2 || countlimit == 2) {
                   window.location.reload();
                 }
             }
         } else {
             $('.sta_no').show();
             $('.sta_ok').hide();
             $('#to_ip').val('');
             $('#to_pbip').val('');
             $('#txt_response_no').html(data.msg);
         }
         
     });
     
}

$(document).ready( function () {
	
	$('#to_ip').change(function(){
		
		var getcmd = $('#cmd').val();
		
		$.post(caUrl + '?cmd=' + getcmd + '&action=ip_is_private', {
	        ip          : $('#to_ip').val()
	    }, function (data) {
		
			//console.log(data);
			
			if(data.aResponse == true){
				$('#pb_ip').show();
				$('#isNat').val(1);
				$('#bu_changeip').hide();
				$('#pbip_error').hide();
			}else{
				
				$('#pb_ip').hide();
				$('#isNat').val(0);
				$('#to_pbip').val('');
				$('#bu_changeip').show();
			}
		
		});
		
	});
	
	$('#to_pbip').change(function(){
		
		var getcmd = $('#cmd').val();
		
		$.post(caUrl + '?cmd=' + getcmd + '&action=ip_is_private', {
	        ip          : $('#to_pbip').val()
	    }, function (data) {
		
			console.log(data);
			
			if(data.aResponse == true){
				$('#to_pbip').val('');
				$('#bu_changeip').hide();
				$('#pbip_error').show();
			}else{
				$('#pbip_error').hide();
				$('#bu_changeip').show();
			}
		
		});
		
	});

});
