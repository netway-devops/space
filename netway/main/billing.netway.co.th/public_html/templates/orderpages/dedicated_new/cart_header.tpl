<!DOCTYPE html>
<!--[if IEMobile 7]><html class="no-js iem7 oldie"><![endif]-->
<!--[if (IE 7)&!(IEMobile)]><html class="no-js ie7 oldie" lang="en"><![endif]-->
<!--[if (IE 8)&!(IEMobile)]><html class="no-js ie8 oldie" lang="en"><![endif]-->
<!--[if (IE 9)&!(IEMobile)]><html class="no-js ie9" lang="en"><![endif]-->
<!--[if (gt IE 9)|(gt IEMobile 7)]><!--><html lang="en"><!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <base href="{$system_url}" />
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name}</title>
        <link media="all" type="text/css" rel="stylesheet" href="templates/nextgen/css/bootstrap.css" />
        <link media="all" type="text/css" rel="stylesheet" href="templates/nextgen/css/main.css" />
		
		<link media="all" type="text/css" rel="stylesheet" href="templates/netwaybysidepad/css/bootstrap.min.css" />
        <link media="all" type="text/css" rel="stylesheet" href="templates/netwaybysidepad/css/clientarea.css" />
        <link media="all" type="text/css" rel="stylesheet" href="templates/netwaybysidepad/css/smoothness/jquery-ui-1.9.2.custom.min.css" />
		<link media="all" type="text/css" rel="stylesheet" href="templates/netwaybysidepad/css/bootstrap-responsive.css" />
		<link media="all" type="text/css" rel="stylesheet" href="templates/netwaybysidepad/css/style.css" />
		<link media="all" type="text/css" rel="stylesheet" href="templates/netwaybysidepad/css/font-awesome/css/style.css" />
		
		<link media="all" type="text/css" rel="stylesheet" href="templates/netwaybysidepad/share/css/top-style.css" />
		<link media="all" type="text/css" rel="stylesheet" href="templates/netwaybysidepad/share/css/footer-style.css" />
			
		<link media="all" type="text/css" rel="stylesheet" href="templates/nextgen/css/style.css" />
        <!--[if lt IE 9]>
        <link media="all" type="text/css" rel="stylesheet" href="templates/nextgen/css/ie8.css" />
        <script type="text/javascript" src="templates/nextgen/js/ie8.js"></script>
        <![endif]-->
        <script type="text/javascript" src="templates/nextgen/js/jquery.js"></script>
        <script type="text/javascript" src="templates/nextgen/js/bootstrap.js"></script>
        <script type="text/javascript" src="templates/nextgen/js/common.js"></script>
        <script type="text/javascript" src="templates/nextgen/js/jquery-ui-1.8.2.custom.min.js"></script>
        {if $enableFeatures.chat!='off'}
        <script type="text/javascript" src="{$system_url}?cmd=hbchat&amp;action=embed"></script>
        {/if}
        {userheader}
    </head>

    <body class="{$language|capitalize} tpl_nextgen" >
        <div id="wrapper">		
		<!-- *************** Start Top Bar *******************-->
		{include file="header-corporate.tpl" template_dir="templates/netwaybysidepad/share/"}
		<!-- *************** End Top Bar *******************-->
              
		
		<!-- *************** Start NAavigation Bar *******************-->
		{include file="mainnavigation.tpl" template_dir="templates/netwaybysidepad/menus/"}
		
		<!-- *************** End  NAavigation Bar *******************-->
 <div class="container"> 		
	<h3 class="title-b">{$lang.browseprod}</h3>
	<ul class="menu-prod">
		<li class="first active">
			{foreach from=$categories item=i name=categories}
				{if $i.id == $current_cat} <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a>{/if}
			{/foreach}
		</li>
		{foreach from=$categories item=i name=categories name=cats}
			{if $i.id != $current_cat}
			<li class="{if $smarty.foreach.cats.last && !$logged}last{/if}"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></li>
			{/if}
		{/foreach}
		{if $logged=='1'} <li class="last"><a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a></li>{/if}
	</ul>	
	<div class="nw-host-border"></div>

		
        <div id="errors" {if $error}style="display:block"{/if}>
            <div class="alert alert-error">
                <a class="close" >&times;</a>
                {if $error}
                {foreach from=$error item=blad}{$blad}<br/>{/foreach}
            {/if}             
        </div>
    </div>

    <div id="infos"  {if $info}style="display:block"{/if}>

        <div class="alert alert-info">
            <a class="close" >&times;</a>
            {if $info}
                {foreach from=$info item=infos}{$infos}<br/>{/foreach}
            {/if}
        </div>
    </div>

    <section id="{$cmd}">
        <div id="cont" {if $cmd=='cart' && $step>0 && $step<4}class="left"{/if}>
{literal}
    <script type="text/javascript">

        $(document).bind('fieldLogicLoaded', function(event, fl){
            $.fieldLogic.getContainer = function(cond){
                return $(cond.target).parents('.cart-option').eq(0);
            };
        });
        function applyCoupon() {
                var f = $('#promoform, #config_form').serialize();
                $('#cartSummary').addLoader();
                ajax_update('?cmd=cart&addcoupon=true&step='+{/literal}{$step}{literal}+'&'+f,{},'#cartSummary');
                return false;
        }
        function changeCycle(forms) {
                $(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
                return true;
        }
        function removeCoupon() {
                $('#cartSummary').addLoader();
                ajax_update('?cmd=cart&removecoupon=true&step='+{/literal}{$step}{literal},{},'#cartSummary');
                return false;
        }

        function _slide(){
            var t=$(window).scrollTop()-$('#right').offset().top+parseInt($('#right').css('margin-top'));
            var maxi  = $('#cont > div.left').height()-$('.cart-summary').outerHeight(true) - 180;
            if(t>maxi)
                t=maxi;
            if(t<0)
                t=0;

            $('#right').animate({'margin-top':t+"px" },{queue: false, duration: 300});
        }
        var img_src_part = [];
        function createCookie(e,t,n){if(n){var r=new Date;r.setTime(r.getTime()+n*24*60*60*1e3);var i="; expires="+r.toGMTString()}else var i="";document.cookie=e+"="+t+i+"; path=/"}function readCookie(e){var t=e+"=",n=document.cookie.split(";");for(var r=0;r<n.length;r++){var i=n[r];while(i.charAt(0)==" ")i=i.substring(1,i.length);if(i.indexOf(t)==0)return i.substring(t.length,i.length)}return null}function eraseCookie(e){createCookie(e,"",-1)}
        $(function(){
            $('.cart-switch span').click(function(){
                if($(this).hasClass('active'))
                    return false;
                var act = $('.cart-switch span.active');
                $('.switch-content > div:visible').fadeOut('fast', function(){ $('.switch-content > div').eq(act.index()).fadeIn('fast', function(){if($('.server-blocks:visible').length) fixBlocks();})});
                $('.cart-switch div').show().animate({left:act.removeClass('active').siblings('span').addClass('pre-active').position().left}, 'fast','swing', function(){
                    act.siblings('span').addClass('active').removeClass('pre-active');
                    $('.cart-switch div').hide()
                });
            });
            function fixBlocks(){
                var max = 0; 
                $('.server-blocks > div > div:first-child').each(function(){
                    if(max < $(this).height())
                        max = $(this).height();
                });
                $('.server-blocks > div > div:first-child').height(max);
            }
            function getBGPos(){
                var str = $('.clicktrough').css('background-position');
                return {x:parseInt(str.substring(0, str.indexOf(' '))), y:parseInt(str.substring(str.indexOf(' ')+1))};
            }
            
            $('.server-list a.btn').each(function(i){
                if($('#imgsrc li:eq('+i+')').length){
                    img_src_part[i] = [$(this).attr('rel'),$('#imgsrc li:eq('+i+')').html()];
                }else
                    img_src_part[i] = [$(this).attr('rel'),'default.png'];
                createCookie('img_src_part',img_src_part,1);
            });
  
            $('.server-blocks > div img, #cartSummary > div > h4').each(function(i){
                if($(this).is('img')){
                    var list = readCookie('img_src_part').split(',');
                    var src = list[i*2+1];
                    if(src.length){
                        $(this).attr('src',$('#imgsrc').attr('rel')+src);
                    }
                }else if(parseInt($(this).attr('rel')) > 0){
                    var list = readCookie('img_src_part').split(',');
                    for(var n = 0; n < list.length; n+=2){
                        if(parseInt($(this).attr('rel')) == parseInt(list[n])){
                            $(this).prepend('<img src="{/literal}{$orderpage_dir}dedicated_new/img/{literal}'+list[n+1]+'" alt="CPU" />');
                            $('#right').height($('.cart-summary').outerHeight(true));
                        }
                    }
                }
            });
            $('.pconfig_').click(function(){
                var it= $(this).parent('li').find('.s1 span').text();
                var b = $(this).parents('.cart-option');
                    if(!$(this).is(':checked')) {
                        b.find('.picked_option').text(none);
                    } else {
                        b.find('.picked_option').text(it);
                    }
                b.find('.cProductS a').click();
                simulateCart();
            });
            function bendBorder(){
                $('.order-step .content-arrow').hide();
                $('.order-step:visible:last .content-arrow').show();
                $('.order-step:visible').each(function(i){$(this).find('.circle-header div').text(i+1)});
            }
            $('input[name="gateway"]').click(function(){
                
                $.post('?cmd=cart&action=getgatewayhtml&gateway_id='+$(this).val(), '', function(data){
                    data = parse_response(data);
                    if(data.length){
                        $('#gatewayform div.circle-header h5').html($('.wbox_header strong', data).html());
                        $('#gatewayform div.cart-option').html($('.wbox_content', data).html()).append($(data).filter('script, style'));
                        $('#gatewayform').slideDown('normal');
                        bendBorder();
                    }else
                        $('#gatewayform').slideUp('fast', bendBorder);
                });
            });
            $('#server-blocks > div > div > h4').each();
            $('input[name="gateway"]:checked').click();
            $('#errors, #infos').wrap('<div class="cart-infos" />');
            bendBorder();
        });
        function simulateCart(){
            $('#cartSummary').addLoader();
            var s=$('#config_form').serialize();
            ajax_update('?cmd=cart&'+s,{'simulate':'1'},'#cartSummary');
        }
        var excol=function(id,el) {
            $(".s1",$(el)).toggleClass("s3");
            $("#excol_"+id).slideToggle('normal', _slide);
            $(".s2",$(el)).toggle();
            $(".s5",$(el)).toggle();
            return false;
        };
        
    </script>
{/literal}
<div class="break-out">
<div class="cart-header">
    <h1>
        {foreach from=$categories item=i name=categories name=cats}
            {if $i.id == $current_cat}{$i.name|regex_replace:"/^([^\s]+)/":"<strong>\$1</strong>"}{/if}
        {/foreach}
    </h1>
    {if $opconfig.subheader}<span class="sub-header">{$opconfig.subheader}</span>
    {/if}
    {if $step==0}
    <div class="cpus">
        <img src="{$orderpage_dir}dedicated_new/img/xenon-big.png" alt="xenon" />
        <img src="{$orderpage_dir}dedicated_new/img/opteron-big.png" alt="AMD"/>
        <img src="{$orderpage_dir}dedicated_new/img/intel-big.png" alt="Intel" />
    </div>
    {if $opconfig.subheader_text}
    <p>
        {$opconfig.subheader_text}
    </p>
    {/if}

    {/if}
</div>
</div>

