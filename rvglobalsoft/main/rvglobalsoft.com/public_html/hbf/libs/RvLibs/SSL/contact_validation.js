$('document').ready(function(){
	$('.edit_contact_save').click(function(){
		var organize = {
			name : $("[name^='edit_organize']").map(function(){return $(this).attr('name');}).get()
			, value : $("[name^='edit_organize']").map(function(){return ($(this).val()).trim();}).get()
			, id : $("[name^='edit_organize']").map(function(){return $(this).attr('id');}).get()
			, role : 'organize'
			, key : $("[name^='edit_organize']").map(function(){ var $data = $(this); var name = $data.attr('name'); var sName = name.substring(name.search('_')+1); sName = sName.split('['); key = sName[1].substring(0, (sName[1].length)-1); return key; }).get()
		};
		
		var admin = {
				name : $("[name^='edit_admin']").map(function(){return $(this).attr('name');}).get()
				, value : $("[name^='edit_admin']").map(function(){return ($(this).val()).trim();}).get()
				, id : $("[name^='edit_admin']").map(function(){return $(this).attr('id');}).get()
				, role : 'admin'
				, key : $("[name^='edit_admin']").map(function(){ var $data = $(this); var name = $data.attr('name'); var sName = name.substring(name.search('_')+1); sName = sName.split('['); key = sName[1].substring(0, (sName[1].length)-1); return key; }).get()
			};
		
		var tech = {
				name : $("[name^='edit_tech']").map(function(){return $(this).attr('name');}).get()
				, value : $("[name^='edit_tech']").map(function(){return ($(this).val()).trim();}).get()
				, id : $("[name^='edit_tech']").map(function(){return $(this).attr('id');}).get()
				, role : 'tech'
				, key : $("[name^='edit_tech']").map(function(){ var $data = $(this); var name = $data.attr('name'); var sName = name.substring(name.search('_')+1); sName = sName.split('['); key = sName[1].substring(0, (sName[1].length)-1); return key; }).get()
		};
		
		var output = {};
		var chk = {Organization : organize, Administrative : admin, Technical: tech};
		var ctype = {Organization : 'organize', Administrative : 'admin', Technical : 'tech'};
		var pass = false;
		
		for(cKey in chk){
			eachData = chk[cKey];
			eachType = ctype[cKey];
			if(validate(eachData, cKey)){
				output[eachType] = {};
				for(d in chk[cKey]['key']){
					if(typeof output[eachType][eachData['key'][d]] == 'undefined') output[eachType][eachData['key'][d]] = {};
					output[eachType][eachData['key'][d]] = eachData['value'][d];
				}
				if(typeof output[eachType]['Phone_Number'] != 'undefined'){
					output[eachType]['Phone_Number'] = output[eachType]['Phone_Number'].replace(/[^\+0-9\.]/g, '');
				}
				pass = true;
			} else {
				pass = false;
				break;
			}
		}
		
		if(pass){
			$('.form_edit_contact').addLoader();
		    $.ajax({
		    	url: $('#RV_BASEURL').val()
		    	, type: 'POST'
		    	, data: {
		    		cmd: 'module'
	                , module: 'ssl'
	                , action: 'ajax_update_edit_contact'
		    		, order_id: $('#order_id').val()
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
		}
	});
	
	function validate(variable, header)
	{
		var vaName = /^[a-zA-Z0-9\,\.\\\/\_\-\s]*$/;
        var vaGeneral = /^[a-zA-Z0-9\s]*$/;
        var vaEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
        var vaPost = /^(([A-Z]{2}) )?([0-9]{4,5})$/;
        var vaAddress = /^[\w\(\)\-\+\/\_\s\@\.\#]*$/;
        
        // NAME : ALPHABET , . \ / _ - blank
        // GENERAL : ALPHABET NUMBER blank
        // POSTCODE : {[A-Z]*2 [0-9]*4or5}
        // ADDRESS : ALPHABET NUMBER ( ) - + / _ blank @ . #
        // PHONE : REPLACE TO + . NUMBER
        
        for(i in variable['id']){
        	key = variable['id'][i].substring(variable['id'][i].search('_')+1);
        	keyText = key.replace('_', ' ').replace('Ext', 'Ext.').replace('State ', 'State/');
        	value = variable['value'][i];
        	id = variable['id'][i];
        	
        	if(value == '' && key != 'Ext_Number'){
        		makeAlert(id, header, key, 'Cannot be null.');
        		return false;
        	} else {
        		if(key == 'Postal_Code' && !vaPost.test(value)){
        			makeAlert(id, header, key, 'is in wrong format.');
        			return false;
        		} else if(key == 'Address' && !vaAddress.test(value)){
        			makeAlert(id, header, key);
        			return false;
        		}else if(!vaName.test(value) && (key == 'First_Name' || key == 'Last_Name')){
                	makeAlert(id, header, key);
                	return false;
                } else if(key == 'Country' && value == 'JP'){
                    makeAlert(id, header, key, 'We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.');
                    return false;
                } else if(key == 'Email_Address' && !vaEmail.test(value)){
                	makeAlert(id, header, key);
                	return false;
                } else if(key == 'Phone_Number' && value.replace(/[^\+0-9\.]/g,'').trim() == ''){
                    makeAlert(id, header, key);
                    return false;
                } else if(key == 'Phone_Number' && value.replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
                    makeAlert(id, header, key, 'have no numeric character.');
                    return false;
                } else if((key == 'Job_Title' || key == 'City' || key == 'State_Province' || key == 'Organization_Name') && !vaGeneral.test(value)){
                	makeAlert(id, header, key);
                	return false;
                }
        	}
        }
        
        return true;
	}
	
	function makeAlert(mkey, head, key, text)
    {
    	text = typeof text != 'undefined' ? text : 'invalid characters.';
    	alert(head + ' Contact [' + key + '] : ' + text);
    	$('#' + mkey).focus();
    }
});