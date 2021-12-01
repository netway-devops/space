
$(function(){
		//add Tooltip
		$('.neotooltip').hover(
			function(){$(this).find('div.jq-checkpointSubhead:hidden').fadeIn(200);},
			function(){$(this).find('div.jq-checkpointSubhead:visible').fadeOut(200);}
		);

		//cta click
		$('.neotooltip p').click(function(){
			$(this).parent().prev().trigger('click');
		});
		
		
});
