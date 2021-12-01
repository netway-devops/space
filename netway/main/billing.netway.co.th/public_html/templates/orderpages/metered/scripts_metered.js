$(document).ready(function(){
	
	$('.bil-opt select').each(function(){
		var wdh = ($(this).width()+12)+'px';
		$(this).selectmenu({style:'dropdown',transferClasses:false, width:'100%',menuWidth:wdh});//$('#currform').submit()
	});	
	$('.bil-opt-sel label').width($('.bil-opt-sel label:visible').eq(0).width());
	$('.pr-desc').each(function(){
    if($('.pr-desc-middle',this).height() == 0)
    $(this).hide();
	});

 	$('.pr li:last label').css('border-bottom', '1px dotted #ffffff');
	$('.pr > li').click(function(){
		$('.pr li').removeClass('active');
		$(this).addClass('active');
		var id = $(this).attr('id');
		$(this).find('input').attr('checked',true);
		$('.hideable').hide();
		$('.'+ id).show();
		
		$('.maincycle').val( $('#cycle_'+id).val() );

		$('#cycle_'+id+'-menu').width($('#cycle_'+id).width()+12);
		$('#curr_'+id+'-menu').width($('#curr_'+id).width()+12);
	});
	$('.maincycle').val( $('.bil-opt:visible [name="cycle"]').val() );

});

