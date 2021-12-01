$(window).load(function(){
    var height = $('.servers').height();
    $('.servers .column').each(function(index){
        if(index % 4 == 0){
            height = $('.servers .column').slice(index,index + 4).height();
        }
            
        var current = $(this).outerHeight();
        if(height-current > 0){
           $(this).css('margin-top', height-current);
        }
    }); 
});
$(document).ready(function(){
	
	$('.column').each(function(i){
        if(i % 4 < 2) $(this).find('ul li dl').addClass('left'); else $(this).find('ul li dl').addClass('right')
    })
	$('.column ul li').hover(function(){
            var h = $(this).find('dl').css({visibility:'hidden', display:'block'}).height(),
            w = $(this).find('dl').outerWidth(true);
            if($(this).parents('.column').offset().left < w && $(this).find('dl').hasClass('left')){
                $(this).find('dl').removeClass('left').addClass('right');
            }else if( ($(this).parents('.column').offset().left + $(this).parents('.column').width() + w) > $(document).width() && $(this).find('dl').hasClass('right')){
                $(this).find('dl').removeClass('right').addClass('left');
            }
            console.log([w, $(this).parents('.column').offset().left,  $(this).parents('.column').width(), $(document).width()]);
			$(this).find('dd').css({'top':(-h/2 + 20)+'px'}).end().find('dl').css({visibility:'visible', display:'none'}).fadeIn();
            
		}, function(){
			$(this).find('dl').hide();
	});

	$('.column-header').click(function(){
		$('.column-header').css({
			'border': 'solid 2px #fff',
			'border-bottom': 'solid 2px #d4d4d4',
			'box-shadow': 'none'
		});
		$(this).css({
			'border': 'solid 2px #91c03d',
			'box-shadow': '0 0 5px 0 #91c03d'
			})
	});

    var lim = 0;
    $('#planfeat li').each(function(li){
        $('.packdescr').eq(li % 4).append($(this).html())
    });
    $('.ribbon').each(function(){
        var hbg = $(this).find('.ribbon-bg').position(),
            ht = $(this).find('.ribbon-t').position();
        $(this).find('.ribbon-bg').height(ht.top - hbg.top - 5);
    });

})