<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}flexboxes/style.css" />
<h3 class="title-b">{$lang.browseprod}</h3>

<div class="menu-prod">
	{foreach from=$categories item=i name=categories name=cats}
		<span {if $i.id == $current_cat}class="active"{/if}><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></span>{if $smarty.foreach.cats.last && !$logged}{else} {/if}
	{/foreach}
	{if $logged=='1'} <span ><a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a></span>{/if}
</div>

<div class="nw-host-border"></div>

{if count($currencies)>1}
<form action="" method="post" id="currform">
	<p align="right" style="margin-right:15px">
		<input name="action" type="hidden" value="changecurr">
		{$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
			{foreach from=$currencies item=crx}
			<option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
			{/foreach}
		</select>
	</p>
</form>
{/if}

<div class="fix con-inner">
	<div class="c-part">
		{foreach from=$products item=i name=loop key=k}
		<div class="prod-sum">
		{if $opconfig.redstriptext}
			<div class="tab-or">
				<div>{$opconfig.redstriptext}
				</div>
			</div>{/if}
			<div class="prod-sum-top">
				<ul class="prod-sum-top-name">
					<li>{$i.name}</li>
				</ul>
			</div>
			<div class="prod-sum-middle">
				<ul class="sum-list">
					<li>{$i.description}</li>
				</ul>
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
						<span>
							<a href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}" class="button-order">{$lang.ordernow}</a>
						</span>
					</span>
				</div>
			</div>
			<div class="fix prod-sum-bottom"></div>							
		</div>
		{/foreach}
	</div>
	<div class="fix "><div></div></div>
</div>
<script type="text/javascript">
	
	$('.sum-list li ol').prepend('<li class="first">{$lang.additional_features}');
	var e = ['.prod-sum-top', '.sum-list ul', '.sum-list', '.prod-sum-middle', '.prod-sum'];
    var h = 0;
	{literal}
	for (i=0;i<e.length;i++){
		h=0;
		$(e[i]).each(function(x){
			if(h  < $(this).height())
			h = $(this).height();
		});
		$(e[i]).height(h);
	}
	$('.sum-list li > ul > li:first-child').css('padding-right','20px');
	{/literal}
</script>
<!-- stare -->

