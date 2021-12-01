<script type="text/javascript">
                   var none = "{$lang.none}";
    {literal}
    $("head").append("<link>");
    css = $("head").children(":last");
    css.attr({
      rel:  "stylesheet",
      type: "text/css",
      href: "{/literal}{$orderpage_dir}{literal}dedicated/style.css"
    });
var applyCoupon=function() {
        var f = $('#promocodev').val();
	sidebar_preload();
	 ajax_update('?cmd=cart&do={/literal}{$progress}{literal}&addcoupon=true&promocode='+f,{},'#cart_sum');
             fixHeightsDelay();
             return false;
    
};
     var changeCycleC=function() {
         var f=$('#cycleform select').val();
         $('#ccf2_c').val(f);
        $('#ccf2').submit();
             return false;
    };
    var changeCurrencyC=function() {
         var f=$('#currform select').val();
         $('#ccf_c').val(f);
        $('#ccf').submit();
             return false;
    };
        var excol=function(id,el) {
            $(".s1",$(el)).toggleClass("s3");
            $("#excol_"+id).slideToggle();
            $(".s2",$(el)).toggle();
            $(".s5",$(el)).toggle();
            return false;
    };
        var excol2=function(id,el) {
            $("#excol2_"+id).slideToggle();
            return false;
    };
        var sidebar_preload=function() {
            $('#pre_indicator').addClass('pre_indicator');
        return false;
};

var ff=function(){
 $("#content").after($("#footer"));
     $('.content').prepend($('#errors')).prepend($('#infos'));
     $('.pconfig2_').click(function(){
        var it= $(this).parent('li').find('.s1 span').text();
        var b= $(this).parents('li.paddon_');
        b.find('.picked_option').text(it);
        b.find('.cProductS a').click();
        if($(this).val()=="-1") {
            b.find('.cProductS .s10').removeClass('s11');
            b.find('.cProductS .ss1').show();
            b.find('.cProductS .ss2').hide();
        } else {
            b.find('.cProductS .s10').addClass('s11');
                b.find('.cProductS .ss1').hide();
            b.find('.cProductS .ss2').show();
        }
        var s=$('#step2form').serialize();
        sidebar_preload();
        ajax_update('?cmd=cart&'+s,{},'#cart_sum');
        fixHeightsDelay();
    });
        $(document).delegate('.pinput_','blur keyup',function(){
             var b = $(this).parents('li.poption_');
            if(parseInt($(this).val())>0) {
                 var it= $(this).parent('li').find('.s1 span').text();
                 b.find('.picked_option').text(it+" x "+$(this).val());
            } else {
                b.find('.picked_option').text(none);
            }
            var s=$('#step2form').serialize();
            sidebar_preload();
            ajax_update('?cmd=cart&'+s,{},'#cart_sum');
                fixHeightsDelay();
    });
     $('.pconfig_').click(function(){
        var it= $(this).parent('li').find('.s1 span').text();
            var b = $(this).parents('li.poption_');
                if(!$(this).is(':checked')) {
                            b.find('.picked_option').text(none);
                } else {
                            b.find('.picked_option').text(it);
                }
            b.find('.cProductS a').click();

          var s=$('#step2form').serialize();
              sidebar_preload();
          ajax_update('?cmd=cart&'+s,{},'#cart_sum');
              fixHeightsDelay();
    });

};
    appendLoader('ff');
 {/literal}

</script>
<form id="ccf" style="display:none" method="post" action="">
<input type="hidden" value="{$progress}" name="do"/>
<input type="hidden" value="1" name="ccurrency" id="ccf_c"/>
</form><form id="ccf2" style="display:none" method="post" action="">
<input type="hidden" value="{$progress}" name="do"/>
<input type="hidden" value="1" name="changecycle" id="ccf2_c"/>
</form>
<div id="middle">
			<a href="{$ca_url}cart/&cat_id={$current_cat}"><img src="{$orderpage_dir}dedicated/images/web_logo.png" alt=""/></a>
		</div>
{if $progress>1 && $progress<7}
<ul id="steps">
			<li class="i1">
				<span>{if $progress>2}<a href="?cmd=cart&cat_id={$current_cat}">1</a>{else}1{/if}</span>
				<div>
					<h1>{if $progress>2}<a href="?cmd=cart&cat_id={$current_cat}">{$lang.server}</a>{else}{$lang.server}{/if}</h1>
					<p>{$lang.hardwaresettings}</p>
				</div>
			</li>
			<li class="i2 {if $progress<3} notactive{/if}">
				<span>{if $progress>3}<a href="?cmd=cart&do=3">2</a>{else}2{/if}</span>
				<div>
					<h1>{if $progress>3}<a href="?cmd=cart&do=3">{$lang.network}</a>{else}{$lang.network}{/if}</h1>
					<p>{$lang.ipsbandwidth}</p>
				</div>
			</li>
			<li class="i3 {if $progress<4} notactive{/if}">
				<span>{if $progress>4}<a href="?cmd=cart&do=4">3</a>{else}3{/if}</span>
				<div>
					<h1>{if $progress>4}<a href="?cmd=cart&do=4">{$lang.software}</a>{else}{$lang.software}{/if}</h1>
					<p>{$lang.oscontrolpanel}</p>
				</div>
			</li>
			<li class="i4 {if $progress<5} notactive{/if}">
				<span>{if $progress>5}<a href="?cmd=cart&do=5">4</a>{else}4{/if}</span>
				<div>
					<h1>{if $progress>5}<a href="?cmd=cart&do=5">{$lang.services}</a>{else}{$lang.services}{/if}</h1>
					<p>{$lang.serveraddons}</p>
				</div>
			</li>
			<li class="i5 {if $progress<6} notactive{/if}">
				<span>5</span>
				<div>
					<h1>{$lang.checkout}</h1>
					<p>{$lang.finishorder}</p>
				</div>
			</li>
		</ul>
{elseif $progress!=7}
<div class="h">
			
				<span class="s1"></span>
				<span class="s2">{foreach from=$categories item=i name=categories name=cats}
{if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
{else} <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
{/if}
{/foreach}
{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}
</span>
			
		</div>

{/if}

