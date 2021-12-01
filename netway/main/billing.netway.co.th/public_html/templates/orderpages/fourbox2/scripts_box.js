	function max_height()
	{
		var i = 1;
		var max_h = 0;
		$('.box-product').removeClass('active').removeClass('noactive').addClass('noactive');
		$('.box-product.noactive .box-describe').css('height', 'auto');
		$('.box-product.noactive .box-describe').each(function(){
			if(max_h == 0)
				max_h = $(this).height();
			else if($(this).height() > max_h)
				max_h = $(this).height(); 					
		});
		
		$('.box-product.noactive .box-describe').css('height', max_h + 'px');

		return max_h;
	}
		$(document).ready(function(){
			
			$('.box-describe li ul li:last').addClass('last');		
			$('.box-product').click(function(){
				$(this).css('height', 'auto');
			    var box_height = max_height();
				$('.box-product').removeClass('active');
				$('.box-product').addClass('noactive');
				$(this).removeClass('noactive').addClass('active');
				if($(this).find('.box-describe').height() >= box_height + 10)
				{
					$(this).find('.box-describe').css('height', (box_height + 10) + 'px');
				}
				else
				{
					$(this).css('height', 'auto');
				}
				
			});
			
			$('.box-describe ul li').each(function(x){
				$(this).mouseover(function(){

				if(!$(this).parents('.box-product').hasClass('active'))
					return false;
				if(!$(this).find('dl dd').length || $(this).find('dl dd').html()=='')
					return false;

				var htm = $(this).find('dl dd').html();
				var pos = $(this).parents('.box-product').offset();
				
				if(($(this).parents('.box-product').index()+1) % 4){
					var left_pos = $(this).width();
					$('.cloud-title').removeClass('right');
				}else 
					var left_pos = (- $('.cloud-title').addClass('right').width());

				var pos_li = $(this).position();
				  $('.chmury').css('top', pos.top + pos_li.top - 30 + 'px');
				  $('.chmury').css('left', pos.left + left_pos + 'px');
				  $('.chmury .cloud-desc li').html(htm);
				  $('.chmury .cloud-title').fadeIn('fast');
				  $(document).unbind('mouseover', cloud_fadeout);
				  $(document).bind('mouseover', cloud_fadeout);
				 }
				);
			});
			function cloud_fadeout(event){
				if($('.chmury .cloud-title:visible').length && ( !$(event.target).parents('.chmury').length && !$(event.target).parents('.box-describe').length )) {
					$('.chmury .cloud-title').fadeOut('fast');
					$(document).unbind('mouseover', cloud_fadeout);
				}
			}
		//	$('.box-describe ul li').mouseout(function(){
		//	  $('.chmury .cloud-title').fadeOut('fast');
		//	 });
			
			
		});