<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}slidersquaretab/style.css" />
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}slidersquaretab/jquery-ui-1.8.16.custom.css" />
<script src="{$orderpage_dir}slidersquaretab/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>

<script type="text/javascript">
{literal}
//<![CDATA[
ind = null;
function toolTip(ind) 
{
	if(ind == null)
	{
		var ind = $('.product-select').val();
	}	
	krok = $('.krok').val(); 
	ind = Math.floor((ind + krok/2)/krok);
	$('.tool-tip ul').children('li').hide().eq(ind).show();
	$('ul.plan-list').children('li').hide().eq(ind).show();
	$('.button-sub').children('span').hide().eq(ind).show();
	$('.sum-list').children('li').hide().eq(ind).show();
	$('.prod-sum-top-name').children('li').hide().eq(ind).show();
	$('.prod-sum-z').hide().eq(ind).show();
	var range = Math.floor($('.ui-slider-horizontal .ui-slider-range-min').width());
	var heigh = 30;//wysokość slidera
	var b = Math.floor($('#slider_pak').width());
	var margin = 35;
	var calib = 3;
	var vcalib = 6;
	var poin = Math.floor($('.ui-slider-handle.ui-state-default').width());
	var strzala = Math.floor($('.cloud-p3').width()); 
	var cloudPos = Math.floor(range - $('.cloud').width()/2);
	var top = Math.floor(heigh * range/b);

	if(cloudPos < -margin )
	{
		cloudPos = -margin;			
	}
	else if(cloudPos + $('.cloud').width() > b + margin)
	{
		cloudPos = b + margin - $('.cloud').width();			
	}

	
	top = top + 5;
	var topStrz = top + vcalib;
	 $('.cloud').css('left', cloudPos + 'px');
	 $('.cloud').css('bottom', topStrz + 'px');
	 $('.cloud-p3').css('left', (range - poin/2  + strzala/2) + 'px');
	 $('.cloud-p3').css('bottom', top + 'px');
}
$(function() {
	$('.sum-list li > ul > li:first-child').css('padding-right','20px');
});
$(document).ready(function(){
if(-1 != navigator.userAgent.indexOf("MSIE")) 
{
	// MSIE
	$('.tab-or').find('div').each(function(){$(this).hide();});
}
var il =$('.prod-sum-z').length-1;
if(il >0)
var krok = 500/il;
else var krok = 1001;
$('.krok').val(krok);
	$( "#slider_pak" ).slider({
		range: "min",
		value:0,
		min: 0,
		max: 500,
		stop: function(event, ui) {
		    $('.product-select').val(ui.value);
			toolTip(ui.value);
		},
		change: function(event, ui) {
		    $('.product-select').val(ui.value);
			toolTip(ui.value);
		},
		slide: function(event, ui) {
		    $('.product-select').val(ui.value);
			toolTip(ui.value);
		}
	});
	
	toolTip();
	$('.sum-list li ol').prepend('<li class="first">{/literal}{$lang.additional_features}{literal}');
});

//]]>
{/literal}
</script>
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
			<script type="text/javascript">
			{literal}
				if($('.menu-prod li.active').position().top != $('.menu-prod li:last').position().top){
					var pt = $('li.active').position().top;
					var lis = $('.menu-prod li');
					for(var i=0;i<lis.length;i++){
						if(lis.eq(i).position().top != pt)
							break
					}
					$('.menu-prod li.active').insertAfter( lis.eq(i) );
				}
			{/literal}
			</script>
			<div class="fix con-inner">
				<div class="con-inner-top"><div>
					{if count($currencies)>1}
					<form action="" method="post" id="currform">
						<p align="right">
							<input name="action" type="hidden" value="changecurr">
							{$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
								{foreach from=$currencies item=crx}
								<option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
								{/foreach}
							</select>
						</p>
					</form>
					{/if}
					</div></div>
					<div class="con-inner-middle">
					<div class="con-inner-middle1 clearfix">
						<div class="c-part1">
							<input class="product-select" type="hidden" value ="0" />
							<input class="krok" type="hidden" value ="0" />

							<h3 class="title01">
								{if $opconfig}{$opconfig.chooseplantext}{else}{$lang.selectyourplan}{/if}
							</h3>
							<div class="slider-content">
								<div id="slider_pak">
									<div class="tool-tip">
										<div class="cloud">
											<div class="p1">
												<div class="pleft"></div> 
												<ul>
													{foreach from=$products item=i name=loop key=k}
														<li style="display:none;">{$i.name}</li>
													{/foreach}
												</ul>
												<div class="pright"></div> 
											</div>
											<div class="p2"><div class="pleft"></div> <div class="pright"></div> </div> 
										</div>
										<div class="fix cloud-p3"></div> 
									</div>
								</div>
							</div>
							{if $opconfig.whyourplan}<div class="line-shadow"></div>
							<div class="plan">
								<h3 class="title-plan">{if $opconfig.whyourplanintro}{$opconfig.whyourplanintro}{else}{$lang.whyus}?{/if}</h3>
								{$opconfig.whyourplan}
							</div>{/if}
						</div>
						<div class="c-part2">
							<div class="prod-sum">
								{if $opconfig.redstriptext}<div class="tab-or">
									<div>{$opconfig.redstriptext}
									</div>
								</div>{/if}
								<div class="prod-sum-top">
									<ul class="prod-sum-top-name">
										{foreach from=$products item=i name=loop key=k}
											<li>{$i.name}</li>
										{/foreach}
									</ul>
								</div>
								<div class="prod-sum-middle">
									<ul class="sum-list">
										{foreach from=$products item=i name=loop key=k}
											<li>{$i.description}</li>
										{/foreach}
									</ul>
										{foreach from=$products item=i name=loop key=k}
										<div class="prod-sum-z" id="price_{$i.id}" {if $k!='0'}style=""{/if}>
											{if $i.paytype=='Free'}
											<span class="z1">{$lang.Free}</span>
											{elseif $i.paytype=='Once'}
												{$currency.sign}<span class="z1">{$i.m|number_format:2}</span>
											{else}
												{$lang.from} {$currency.sign} 
												<span class="z1">
											<!--
												{if $i.d!=0}
													-->{$i.d|price:$currency:false}<!--
												{elseif $i.w!=0}
													-->{$i.w|price:$currency:false}<!--
												{elseif $i.m!=0}
													-->{$i.m|price:$currency:false}<!--
												{elseif $i.q!=0}
													-->{$i.q|price:$currency:false}<!--
												{elseif $i.s!=0}
													-->{$i.s|price:$currency:false}<!--
												{elseif $i.a!=0}
													-->{$i.a|price:$currency:false}<!--
												{elseif $i.b!=0}
													-->{$i.b|price:$currency:false}<!--
												{elseif $i.t!=0}
													-->{$i.t|price:$currency:false}<!--
												{elseif $i.p4!=0}
													-->{$i.p4|price:$currency:false}<!--
												{elseif $i.p5!=0}
													-->{$i.p5|price:$currency:false}<!--
												{/if}
												-->
												</span>/
											{/if}
											{if $i.paytype=='Free'}{elseif $i.paytype=='Once'}{$lang.once}{else}
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
										</div>
										{/foreach}									
									{if $opconfig.promotext}<div class="prom-code">
										<div class="prom-code-top"><div></div></div>
										<div class="prom-code-middle">
											<div>
												{$opconfig.promotext}
											</div>						
										</div>
										<div class="prom-code-bottom"><div></div></div>
									</div>{/if}
									<div class="fix line-shadow2"></div>
									<div class="cen">
										<span class="button-sub">
										{foreach from=$products item=i name=loop key=k}
											<span>
												<a href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}" class="button-order">{$lang.ordernow}</a>
											</span>
										{/foreach}
										</span>
									</div>
								</div>
								<div class="fix prod-sum-bottom"></div>							
							</div>
						</div>
					</div>
					</div>
					<div class="fix con-inner-bottom"><div></div></div>
			</div>
<!-- stare -->

	