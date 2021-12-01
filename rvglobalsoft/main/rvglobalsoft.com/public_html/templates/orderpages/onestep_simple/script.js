function mainsubmit(formel) {
	var v=$('input[name="gateway"]:checked');
	if(v.length>0) {
		$(formel).append("<input type='hidden' name='gateway' value='"+v.val()+"' />");	
	}
	if($('input[name=domain]').length > 0 && $('input[name=domain]').attr('type') != 'radio')
		$(formel).append("<input type='hidden' name='domain' value='"+$('input[name=domain]').val()+"' />");

	return true;
}

function onsubmit_2() {
	$('.load-img').show();
	ajax_update('index.php?cmd=cart&'+$('#domainform2').serialize(),{
		layer:'ajax'
	},'#configer');
	return false;
}

function tabbme(el) {
	$(el).parent().find('li').removeClass('on');
	$('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
	$('#options div.'+$(el).attr('class')).show().find('input[type=radio]').attr('checked','checked');
	$(el).addClass('on');
}

function on_submit() {
	if($("input[value='illregister']").is(':checked')) {
		//own
		ajax_update('index.php?cmd=checkdomain&action=checkdomain&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val()+'&'+$('.tld_register').serialize(),{
			layer:'ajax',
			sld:$('#sld_register').val()
			},'#updater2',true);
	} else if ($("input[value='illtransfer']").is(':checked')) {
		//transfer
		ajax_update('index.php?cmd=checkdomain&action=checkdomain&transfer=true&sld='+$('#sld_transfer').val()+'&tld='+$('#tld_transfer').val()+'&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val(),{
			layer:'ajax'
		},'#updater2',true);
	} else if ($("input[value='illupdate']").is(':checked')) {
		ajax_update('index.php?cmd=cart&domain=illupdate&sld_update='+$('#sld_update').val()+'&tld_update='+$('#tld_update').val(),{
			layer:'ajax'
		},'#configer');
		$('.load-img').show();
	} else if ($("input[value='illsub']").is(':checked')) {
		ajax_update('index.php?cmd=cart&domain=illsub&sld_subdomain='+$('#sld_subdomain').val(),{
			layer:'ajax'
		},'#configer');
		$('.load-img').show();
	}

	return false;
}

function applyCoupon() {
	ajax_update('?cmd=cart&addcoupon=true',$('#promoform').serializeArray(),'#configer');
	return false;
}

function simulateCart(forms, domaincheck) {
	$('.load-img').show();
	var urx = '?cmd=cart';
	if(domaincheck) urx += '_domainupdate=1';
	ajax_update(urx,$(forms).serializeArray(),'#configer');
}

function removeCoupon() {
	
	ajax_update('?cmd=cart',{
		removecoupon:'true'
	},'#configer');
	return false;
}

function changeProduct(pid) {
	if(pid==$('#pidi').val())
		return;
	$('#products tr').removeClass('active').filter('#pr'+pid).addClass('active');
	
	$('#errors').slideUp('fast',function(){
		$(this).find('span').remove();
	});
	$('.load-img').show();
	$.post('?cmd=cart',{
		id: pid
	},function(data){
		var r = parse_response(data);

		$('#configer').html(r);
	});
}

function submitTheForm() {
	$('form#cart3').find('input,select').each(function() {
		if(($(this).attr('type') != 'radio' && $(this).attr('type') != 'checkbox') || $(this).is(':checked') )
			$('#orderform').append('<input type="hidden" value="'+$(this).val()+'" name="'+$(this).attr('name')+'" />');

	});
	$('#orderform').submit();
}
function flyingSidemenu() {
	$('#summary').height($('#floter').height());
	$(window).scroll(function(){
		var t=$(window).scrollTop()-$('#summary').offset().top;
		var maxi  =$('#contener').height()-($('#floter').height()*1.5)-15;
		if(t>maxi)
			t=maxi;
		if(t<0)
			t=0;

  		$('#floter').animate({top:t+"px" },{queue: false, duration: 300});
	});

}
appendLoader('flyingSidemenu');
$(function(){
	$('#summary .summaryupdate').ajaxSuccess(function(){
		$(this).html($('#configer .summaryupdate').html());
		$('.load-img').hide();
	});
})