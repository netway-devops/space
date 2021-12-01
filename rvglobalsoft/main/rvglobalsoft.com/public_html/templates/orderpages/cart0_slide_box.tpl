<h3>{$lang.browseprod}</h3>


{if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}

	{if $products}

{foreach from=$products item=i name=loop key=k}
		<div class="bubble" style="display:none;">
	<div class="bubble_l"></div>
	<div class="bubble_c">{$i.name}</div>
	<div class="bubble_r"></div>
</div>		
	{/foreach}

<div class="shead">
	<div class="spicked">
		{foreach from=$categories item=i name=categories}

{if $i.id == $current_cat} <strong>{$i.name}</strong>{/if}{/foreach}

	</div>
	<div class="snpicked">
	{foreach from=$categories item=i name=categories name=cats}

{if $i.id != $current_cat}
<a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
{/if}
{/foreach}

{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}


	</div>
	<div class="clear"></div>

</div>
<div class="slidebg">

	<div class="innerx">
	<ul class="slix">
	{foreach from=$products item=i name=loop key=k}
			<li {if $k=='0'}class="active"{/if}>{$i.name}</li>		
	{/foreach}
	</ul>


	<div class="pricebg">
		{foreach from=$products item=i name=loop key=k}
			<div class="pricetag" id="price_{$i.id}" {if $k!='0'}style="display:none"{/if}>
				<div class="price">
				{if $i.paytype=='Free'}
					{$lang.Free}
				{elseif $i.paytype=='Once'}
				<span style="vertical-align: top; font-size: 20px;">{$currency.sign}</span><span style="vertical-align: top;">{$i.m|number_format:2}</span><span style="vertical-align:  middle; font-size: 20px;color:#606060;">{$currency.code}</span>				
				{else}
				<span style="vertical-align: top; font-size: 20px;">{$currency.sign}</span><!--
					{if $i.d!=0}
						--><span style="vertical-align: top;">{$i.d|price:$currency:false}</span><!--
					{elseif $i.w!=0}
						--><span style="vertical-align: top;">{$i.w|price:$currency:false}</span><!--
					{elseif $i.m!=0}
						--><span style="vertical-align: top;">{$i.m|price:$currency:false}</span><!--
					{elseif $i.q!=0}
						--><span style="vertical-align: top;">{$i.q|price:$currency:false}</span><!--	
					{elseif $i.s!=0}
						--><span style="vertical-align: top;">{$i.s|price:$currency:false}</span><!--	
					{elseif $i.a!=0}
						--><span style="vertical-align: top;">{$i.a|price:$currency:false}</span><!--	
					{elseif $i.b!=0}
						--><span style="vertical-align: top;">{$i.b|price:$currency:false}</span><!--	
					{elseif $i.t!=0}
						--><span style="vertical-align: top;">{$i.t|price:$currency:false}</span><!--
					{elseif $i.p4!=0}
						--><span style="vertical-align: top;">{$i.p4|price:$currency:false}</span><!--
					{elseif $i.p5!=0}
						--><span style="vertical-align: top;">{$i.p5|price:$currency:false}</span><!--
					{/if}
					--><span style="vertical-align: middle; font-size: 20px;color:#606060;">{$currency.code}</span>
				{/if}
				
				</div>
				<div class="period">
				{if $i.paytype=='Free'}{$lang.Free}{elseif $i.paytype=='Once'}{$lang.once}{else}
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
				<div class="order">
					<a href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}">{$lang.ordernow}</a>
				</div>
			
			</div>
				
	{/foreach}
		
		
	</div>
	
	
	
	<div class="slides" id="slider">	
	<div class="sl"></div>
	<div class="sr"></div>
		
	</div>
	<div class="clear"></div>
	</div>
	
	<div class="descbox">
	{foreach from=$products item=i name=loop key=k}
		
		
		 <div class="descriptionx left" id="prodd_{$i.id}" {if $k!='0'}style="display:none"{/if}>
		 {$i.description}
		 </div> 
	{/foreach}
	{if count($currencies)>1}
	<div class="right">
<form action="" method="post" id="currform">
<input name="action" type="hidden" value="changecurr">
{$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
{foreach from=$currencies item=crx}
<option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{$crx.code}</option>
{/foreach}
</select>
</form></div>
{/if}
	<div class="clear"></div>
	</div>
</div>
<script src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>

<script type="text/javascript">
{literal}

function bindSlider() {
	$('.slix li').each(function(n){
		$(this).click(function(){
			scrollToEl(n);
			return false;		
		});
		$(this).hover(function(){	
			$('.bubble').eq(n).show();
		},function(){
		$('.bubble').fadeOut('fast');
		});
	});
	$('.bubble').each(function(n){
		$(this).css('top',$('.slix li').eq(n).offset().top-30);
		$(this).css('left',$('.slix li').eq(n).offset().left);
	});
	$('#slider').width($('.slix').width()-40);
	$('#slider').slider({min: 0, max: ($('.slix li').length-1)+0.4, value: 0,step:0.1,range:"min", animate: true, stop:function(e,ui){		   
			slidCb(true);
			
	},change: function(e, ui){	
			slidCb(false);
	},slide: function(e, ui){	
			slidCb(false);
	}
	});
}
function slidCb(magic) {
var x = Math.floor($('#slider').slider( "value" ));
			$('.slix li').removeClass('active');
			$('.pricetag').hide();
			$('.pricetag').eq(x).show();
			$('.descriptionx').hide();
			$('.descriptionx').eq(x).show();
			for(var a=0;a<x+1;a++) {
				$('.slix li').eq(a).addClass('active');				
			}
			if(magic) {
			$('.bubble').eq(x).fadeIn('fast',function(){
			setTimeout("$('.bubble').eq("+x+").fadeOut('slow');",550);
				
				});
			}
}
function scrollToEl(ele) {
	$('#slider').slider("value", ele);

}
appendLoader('bindSlider');
{/literal}
</script>

	
	{else}
	{foreach from=$categories item=i name=categories name=cats}

{if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
{else} <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id={$i.id}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
{/if}
{/foreach}

{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}


	{/if}
	
{/if}
	