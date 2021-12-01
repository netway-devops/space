$(document).ready(function(){
    var value;
    var currentWidth;
    var num;
    var id;
	
    jQuery('#plan-slider').jcarousel({
        start: 1
    });
    $('.plan-top .btn-group').each(function(){
        if($(this).find('li').length < 2)
            $(this).find('a').removeClass('dropdown-toggle').removeAttr('data-toggle').click(function(){
                return false
                }).find('span:last').css('visibility', 'hidden');
    })
    setPlan(1);
    arangeHtml();
})
$(window).load(function(){
    arangeHtml();
});

function arangeHtml(){
    $('.config-option:last').width($('.order-button-up').width());
}

function arangeSlider(){
    var n = $('.slider-circle-pos').length,
    w = $('.slider-circle-pos:first').parent().width(),
    wd = (w-21)/(n-1);
    
    $('.slider-circle-pos:not(.first)').css('width', ((wd/w) * 100) +'%')
    
    $('#slider').slider({
        range: "min",
        value: 1,
        min: 1,
        max: (n-1)*50,
        step: 1,
        slide: slider_event,
        change: slider_event,
        start: slider_event
    })
    
}
function slider_event(){
    var width = $('.ui-slider-range').width(),
    selected = Math.floor( $('#slider').slider('value')/50);
    $('.slider-circle').each(function(i){
        var actv = $(this).hasClass('slider-circle-active') ;
        //console.log(Math.ceil( $('#slider').slider('value')/50));
        
        if(selected>=i && !actv){
            $(this).addClass('slider-circle-active');
        }else if( selected<i ){
            $(this).removeClass('slider-circle-active');
        }
    });
    var rel = $('.slider-circle-active:last').length ? $('.slider-circle-active:last').attr('rel') : 1;
    $('.props_').hide().filter('.props_'+rel).show();
    setPlan(selected+1, true);
    arangeHtml();
}

function setPlan(n, noslider){
    if($('[id^=premade_'+n+']').length){
        $('.plan-top .left-column img').attr('src', $('[id^=premade_'+n+'] .premade-plan').css('background-image').replace(/.*"(.*)".*/,'$1')); 
        $('.plan-top .left-column span').text( $('[id^=premade_'+n+'] span').text());
    }
    if(noslider == undefined)
        $('#slider').slider('value',(n-1)*50);
    $('#plan-slider li').removeClass('active-plan');
    $('.selected-plan').removeClass('selected-plan');
    $('[id^=premade_'+n+']:first').addClass('active-plan').children('.plan-tail').addClass('selected-plan');
}

function changeCycle(that){
    $('.props_:visible input[name=cycle]').val($(that).attr('rel'))
    $('.total-price p:visible').text($(that).text());
    $(that).parent().prev().children('span:first').text($(that).find('span:last').text());
    arangeHtml();
}