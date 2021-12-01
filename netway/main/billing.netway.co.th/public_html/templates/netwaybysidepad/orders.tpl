<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
    {include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
{literal}
<style>
      section.hero {
           
            height: 415px;
            text-align: center;
            width: 100%;
            background : url('https://netway.co.th/templates/netwaybysidepad/images/bg-orders2018-2.png');
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
            background-position: bottom;
          
        }
     
        .order-txt-banner {
            font-size: 36px;
            font-family: 'Prompt', sans-serif;
            font-style: normal;
            line-height: 40px;
            font-weight: 500;
            color: #fff;
            margin-top: 117px;
            text-shadow: 1px 1px 6px #000;

        }
      .fancybox-opened {
        z-index: 8030;
      } 
      .fancybox-close {
        position: absolute;
        top: -18px;
        right: -18px;
        width: 36px;
        height: 36px;
        cursor: pointer;
        z-index: 8040;
     }
      .order .bg {
        padding: 5px;
        margin: 25px 0;
      }
     .order .bg .list-menu{
        clear: both;
	    padding: 60px 80px 60px 46px;
	    border: 2px solid #00b8d8;
	    border-radius: 21px;
	    background-color: #fff;
	    color: #717171;
     }   
    .order .bg .list-menu ul li {
        width: 250px;
        height: 46px;
        float: left;
    }
    .order .bg .list-menu ul li a, .order .bg .list-menu ul li a:visited, .order .bg .list-menu ul li a:active{ 
        color:black; 
        line-height: 1.8em; 
    }
    
    .order .bg .list-menu ul li a:hover, .order .bg .list-menu ul li a:active{ 
        text-decoration: none; 
        color :#0000FF;
    }
    .left {
         float: left;
    }
    
    .btnorder, .btnorder:visited, .btnorder:hover, .btnorder:active  {
      background: #189efe;
    color: #FFFFFF;
    font-size: 18px;
    -webkit-border-radius: 20px;
    padding: 10px 10px 10px 10px;
    text-decoration: none;
    margin-right: 15px;
    margin-left: 10px;
    font-family: 'prompt', Tahoma, Verdana, sans-serif;
    }   
    .btnorder:hover, .btnorder:active { 
        background:#5faadf; 
        text-decoration:none; 
    }
    .line-word{
        background: #C9D6FF;
        background: -webkit-linear-gradient(to right, #E2E2E2, #C9D6FF); 
        background: linear-gradient(to right, #E2E2E2, #C9D6FF); 

    }
</style>
{/literal}
 <section class="section hero">
        <div class="container" >
            <div class="row" >
        
                <div class="hero-inner hidden-phone">
                        <h2 class="order-txt-banner">เลือกซื้อสินค้า และบริการสั่งซื้อ<br>และชำระเงินผ่านระบบออนไลน์ได้ทุกวันตลอด 24 ชั่วโมง</h2> 
                        <br/>
                        <a href="/orders#special"><button class="btn-check" style="margin-top:-20px">&nbsp;<i class="fa fa-cart-plus" aria-hidden="true" style="font-size: 20px"></i>&nbsp;&nbsp; สั่งซื้อสินค้า  </button></a>            
                </div>
                
                <div class="hero-inner  visible-phone">
                        <h2 class="order-txt-banner" style="font-size: 24px;">เลือกซื้อสินค้า และบริการสั่งซื้อ<br>และชำระเงินผ่านระบบออนไลน์ได้ทุกวันตลอด 24 ชั่วโมง</h2>  
                        <a href="/orders#special"><button class="btn-check" style="margin-top:-20px">&nbsp;<i class="fa fa-cart-plus" aria-hidden="true" style="font-size: 20px"></i>&nbsp;&nbsp; สั่งซื้อสินค้า  </button></a>        
                </div>
                
                
            </div>
        </div>
    </section>
<div class="row-fluid white-kb-2018" id="special"  style="background:#f5f5f8;"> 
  <div class="container" >         
        <div class="order">
            <div class="row">
                <div class="span12" style="margin-top: 20px;">
                    <div class="bg">
                        <div class="list-menu">
                            <ul>
                            {foreach from=$orderpages item=op}
                              <li>
                                  <a href="{$ca_url}cart/{$op.slug}/">{$op.name}</a>
                              </li>
                            {/foreach}
                            </ul>
                        <div class="clearit"></div>
                        </div>
                    </div>
                    <div class="clearit"></div><div class="clearit"></div>
                </div>
           </div> 
           <div class="row">
                <div class="span12 hidden-phone">
               <div cass="left" style="margin-bottom:30px;"><a href="{$smarty.const.CMS_URL}/payment" class="btnorder">&nbsp;&nbsp;<i class="fa fa-money"></i>&nbsp;&nbsp;ช่องทางการชำระเงิน</a>
               <a  class="btnorder" style="top:80px;" href="{$smarty.const.CMS_URL}/contact">&nbsp;&nbsp;<i class="fa fa-comments-o" style="font-size: 20px"></i>&nbsp;&nbsp;ติดต่อเรา</a></div>
               </div>
           </div>
           <div class="row  visible-phone" style="margin-bottom:30px;" >
               <div class="span6">
                 <a href="{$smarty.const.CMS_URL}/payment" class="btnorder span12"><center>&nbsp;&nbsp;<i class="fa fa-money"></i>&nbsp;&nbsp;ช่องทางการชำระเงิน </center></a>
               </div>
               <div class="span6"  style>
                 <br/>
                <a  class=" btnorder span12" style="top:80px;" href="{$smarty.const.CMS_URL}/contact"><center>&nbsp;&nbsp;<i class="fa fa-comments-o" style="font-size: 20px"></i>&nbsp;&nbsp;ติดต่อเรา</center></a>
               </div>
           </div>
       </div>
  </div>
</div>



{include file="notifications.tpl"}

<div id="infos"  {if $info}style="display:block"{/if}>
        <!-- <div class="alert alert-info">
            <a class="close" >&times;</a>
            {if $info}
                {foreach from=$info item=infos}{$infos}<br/>{/foreach}
            {/if}
        </div> -->
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

            $('#right').animate({'margin-top':t+"px" },{queue: false, duration: 30  background: url('https://netway.co.th/templates/netwaybysidepad/images/order-cir.png') left 10px no-repeat;0});
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
    <div class="cpus" style="display:none;">
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

<div class="cart-switch clearfix" style="display:none;">
    <span><b>{$lang.bestselling}</b></span>
    <span class="active"><b>{$lang.allservers}</b></span>
    <div></div>
</div>
<h2 style="display:none;">{$lang.configure} <strong>{$lang.dedicatedserver}</strong></h2>
<div class="switch-content">
    <div class="server-list">
        <table cellpadding="0" cellspacing="0" class="server-table table-striped">
            <thead>
                <tr>
                    <th>
                        <strong>{$lang.server}</strong>
                    </th>
                    {foreach from=$products item=i name=ploop key=k}
                        {specs var="awords_top" string=$i.description}
                        {if $awords_top[0].specs} 
                            {foreach from=$awords_top[0].specs item=feat name=feat key=ka}
                                {if $smarty.foreach.feat.index > 2}{break}
                                {/if}
                                <th>
                                    <strong>{$feat[0]}</strong>
                                </th>
                            {/foreach}
                        {/if}

                        {break}
                    {/foreach}
                    <th>
                        <strong>{$lang.startingat}</strong>
                    </th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                {foreach from=$products item=i name=ploop key=k}
                    <tr {if $smarty.foreach.ploop.iteration%2==0}class="odd"{/if}>
                        <td>
                            <span>{$i.name}</span>
                        </td>
                        {specs var="awords" string=$i.description}
                        <td>{$awords[$k].specs[0][1]}</td>
                        <td>{$awords[$k].specs[1][1]}</td>
                        <td>{$awords[$k].specs[2][1]}</td>
                        <td>
                            {if $i.paytype=='Free'}{$lang.Free}
                            {elseif $i.paytype=='Once'}{$i.m|price:$currency}
                            {else}<!--
                                {if $i.d!=0}
                                    -->{$i.d|price:$currency}<!--
                                {elseif $i.w!=0}
                                    -->{$i.w|price:$currency}<!--
                                {elseif $i.m!=0}
                                    -->{$i.m|price:$currency}<!--
                                {elseif $i.q!=0}
                                    -->{$i.q|price:$currency}<!--
                                {elseif $i.s!=0}
                                    -->{$i.s|price:$currency}<!--
                                {elseif $i.a!=0}
                                    -->{$i.a|price:$currency}<!--
                                {elseif $i.b!=0}
                                    -->{$i.b|price:$currency}<!--
                                {elseif $i.t!=0}
                                    -->{$i.t|price:$currency}<!--
                                {elseif $i.p4!=0}
                                    -->{$i.p4|price:$currency:false}<!--
                                {elseif $i.p5!=0}
                                    -->{$i.p5|price:$currency:false}<!--
                                {/if}
                                -->
                            {/if}
                            {if $i.paytype=='Free'}
                            {elseif $i.paytype=='Once'}/{$lang.once}
                            {else}/
                                {if $i.d!=0}{$lang.d} 
                                {elseif $i.w!=0}{$lang.w} 
                                {elseif $i.m!=0}{$lang.m}
                                {elseif $i.q!=0}{$lang.q}
                                {elseif $i.s!=0}{$lang.s}
                                {elseif $i.a!=0}{$lang.a}
                                {elseif $i.b!=0}{$lang.b}
                                {elseif $i.t!=0}{$lang.t}
                                {elseif $i.p4!=0}{$lang.p4}
                                {elseif $i.p5!=0}{$lang.p5}
                                {/if}
                            {/if}
                            
                        </td>
                        <td>
                            <a class="btn btn-success btn-order" rel="{$i.id}" href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}">{$lang.order}</a>
                        </td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
    <div class="server-blocks">
        <ul id="imgsrc" style="display:none" rel="{$orderpage_dir}dedicated_new/img/">{$opconfig.server_img}</ul>
        {foreach from=$products item=i name=ploop key=k}
            {if $smarty.foreach.ploop.index > 3}{break}{/if}
            <div {if $smarty.foreach.ploop.first}class="first-block"{elseif $smarty.foreach.ploop.last || $smarty.foreach.ploop.index == 3}class="last-block"{/if}>
                <div>
                    <img class="left" src="{$orderpage_dir}dedicated_new/img/default.png" alt="cpu" />
                    <h4>
                        <span>{$i.name}</span>
                    </h4>
                    <ul class="clear">
                        {specs var="awords" string=$i.description}
                        {foreach from=$awords[$k].specs item=feat name=feat key=ka}
                            <li {if $smarty.foreach.feat.last}class="last-child"{/if}><strong>{$feat[0]}:</strong> <span>{$feat[1]}</span></li>
                        {/foreach}
                    </ul>
                    
                </div>
                <div class="separator"></div>
                <div class="last">
                    <a class="btn btn-success btn-order" href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}">{$lang.configure}</a>
                    <span class="product-price">{include file="common/price.tpl" product=$i hidecode=true decimal=0}</span>
                    {include file="common/cycle.tpl" product=$i wrap=true}
                    <div class="clear"></div>
                </div>
            </div>
        {/foreach}
    </div>
</div>



