$('document').ready(function(){
	$('.edit_contact_save').click(function(){
	    var output = {};
	    var result = true;
	    var mainVar = {edit_organize: 'Organization', edit_admin: 'Administrator', edit_tech: 'Technical'};
	    
	    for(eName in mainVar){
	    	$('[name^="' + eName + '"]').each(function(){
		    	value = ($(this).val()).trim();
		        key = $(this).attr('id');
		        result = validateContact(key, value, mainVar[eName]);
		        if(!result) return false;
		        if(typeof output[eName.substring(eName.search('_')+1)] == 'undefined') output[eName.substring(eName.search('_')+1)] = {} 
		        output[eName.substring(eName.search('_')+1)][key.substring(key.search('_')+1)] = value;
		    });
	    	
	    	if(!result) return false;
	    }
	    
	    $('.form_edit_contact').addLoader();
	    $.ajax({
	    	url: $('#RV_BASEURL').val()
	    	, type: 'POST'
	    	, data: {
	    		cmd: 'module'
                , module: 'ssl'
                , action: 'ajax_update_edit_contact'
	    		, order_id: $('#orderId').val()
	    		, edit_data: output
	    	}, success: function(data){
	    		aResponse = data.aResponse;
	    		if(aResponse.status){
	    			alert('Update Successful.');
	    			location.reload();
	    		} else {
	    			alert('Error occured, Please tell Staff.');
	    			console.log(aResponse);
	    		}
	    		$('#preloader').remove();
	    	}
	    });
	    
	    
	    function validateContact(key, value, type)
	    {
	        var vaName = /^[a-zA-Z0-9\,\.\\\/\_\-\s]*$/;
	        var vaGeneral = /^a-zA-Z$/;
	        var vaEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	        keySplit = key.substring(key.search('_')+1);
	        keyText = keySplit.replace('_', ' ').replace('Ext', 'Ext.').replace('State ', 'State/');
	        if(value == '' && keySplit != 'Ext_Number'){
	            makeAlert(key, type, keyText, 'Cannot be null.');
	            return false;
	        } else {
	            if(!vaName.test(value) && (keySplit == 'First_Name' || keySplit == 'Last_Name')){
	            	makeAlert(key, type, keyText);
	            } else if(keySplit == 'Country' && value == 'JP'){
	                makeAlert(key, type, keyText, 'We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.');
	                return false;
	            } else if(keySplit == 'Email_Address' && !vaEmail.test(value)){
	            	makeAlert(key, type, keyText);
	            	return false;
	            } else if(keySplit == 'Phone_Number' && value.replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
	                makeAlert(key, type, keyText);
	                return false;
	            }
	        }
	        return true;
	    }
	    
	    function makeAlert(mkey, head, key, text)
	    {
	    	text = typeof text != 'undefined' ? text : 'invalid characters';
	    	alert(head + ' Contact [' + key + '] : ' + text);
	    	$('#' + mkey).focus();
	    }
	});
});
