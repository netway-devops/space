<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}fourbox/style.css" />
<div id="cContent">
	<div id="middle">
		<a href="index.php">
			<span class="s1">{$business_name}</span>
		</a>
		{if $opconfig.bestline}<p class="p1">{$opconfig.bestline}</p>{/if}
		{if $opconfig.phoneline}<p class="p2">
			<span class="s2">{$opconfig.phoneline}</span>
		</p>{/if}
	</div>
	<div style="padding:0px;text-align:center;">
	{foreach from=$categories item=i name=categories name=cats}
	{if $i.id == $current_cat} 
	{else} <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
	{/if}
	{/foreach}
	{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}
	
	
	{foreach from=$categories item=i name=categories name=cats}
	{if $i.id == $current_cat && $i.description!=''}
	<div style="text-align:left;margin-top:10px;">{$i.description}</div>
	{/if}
	{/foreach}
	</div>
	
	{if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}
	
	{if $products}
	
	{if count($currencies)>1}
	<form action="" method="post" id="currform"><p align="right">
	<input name="action" type="hidden" value="changecurr">
	{$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
	{foreach from=$currencies item=crx}
	<option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
	{/foreach}
	</select>
	</p></form>
	{/if}
	
	{$j++}
		<ul id="deals">
			{foreach from=$products item=i name=ploop}
			<li class="i{$j++}">
				<form name="form" action="" method="post">
				<input name="action" type="hidden" value="add">
				<input name="id" type="hidden" value="{$i.id}">
					<h1>
						<span class="s1">{$i.name}</span>
					</h1>
					<div class="cDeals">
						<div class="line1">{if $i.description!=''}
							{$i.description}
						{/if}</div>
						<p class="line3">
						{if $i.paytype=='Free'}
					     <h3>{$lang.Free}</h3>
					      
						{elseif $i.paytype=='Once'}
							{$i.m|price:$currency} {$lang.once} {if $i.m_setup>0} + {$i.m_setup|price:$currency} {$lang.setupfee}{/if}
							{if $i.free_tlds.Once}<span class="freedomain">{$lang.freedomain}</span>{/if}
						{else}
							<select name="cycle" style="margin:4px 0px;" class="cycle">
								{if $i.h!=0}
								<option value="h">{$i.h|price:$currency} {$lang.h}{if $i.h_setup!=0} + {$i.h_setup|price:$currency} {$lang.setupfee}{/if}{if $i.free_tlds.Hourly} {$lang.freedomain}{/if}</option>
								{/if}
								{if $i.d!=0}
								<option value="d">{$i.d|price:$currency} {$lang.d}{if $i.d_setup!=0} + {$i.d_setup|price:$currency} {$lang.setupfee}{/if}{if $i.free_tlds.Daily} {$lang.freedomain}{/if}</option>
								{/if}
								{if $i.w!=0}
								<option value="w">{$i.w|price:$currency} {$lang.w}{if $i.w_setup!=0} + {$i.w_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Weekly}{$lang.freedomain}{/if}</option>
								{/if}
								  {if $i.m!=0}
								<option value="m">{$i.m|price:$currency} {$lang.m}{if $i.m_setup!=0} + {$i.m_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Monthly}{$lang.freedomain}{/if}</option>
								{/if}
								  {if $i.q!=0}
								<option value="q">{$i.q|price:$currency} {$lang.q}{if $i.q_setup!=0} + {$i.q_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Quarterly}{$lang.freedomain}{/if}</option>
								{/if}
								  {if $i.s!=0}
								<option value="s">{$i.s|price:$currency} {$lang.s}{if $i.s_setup!=0} + {$i.s_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.SemiAnnually}{$lang.freedomain}{/if}</option>
								{/if}
								  {if $i.a!=0}
								<option value="a">{$i.a|price:$currency} {$lang.a}{if $i.a_setup!=0} + {$i.a_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Annually}{$lang.freedomain}{/if}</option>
								{/if}
								  {if $i.b!=0}
								<option value="b">{$i.b|price:$currency} {$lang.b}{if $i.b_setup!=0} + {$i.b_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Biennially}{$lang.freedomain}{/if}</option>
								{/if}
								{if $i.t!=0}
								<option value="t">{$i.t|price:$currency} {$lang.t}{if $i.t_setup!=0} + {$i.t_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Triennially}{$lang.freedomain}{/if}</option>
								{/if}
								{if $i.p4!=0}
								<option value="p4">{$i.p4|price:$currency} {$lang.p4}{if $i.p4_setup!=0} + {$i.p4_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Quadrennially}{$lang.freedomain}{/if}</option>
								{/if}
								{if $i.p5!=0}
								<option value="p5">{$i.p5|price:$currency} {$lang.p5}{if $i.p5_setup!=0} + {$i.p5_setup|price:$currency} {$lang.setupfee}{/if} {if $i.free_tlds.Quinquennially}{$lang.freedomain}{/if}</option>
								{/if}
							</select>
					
						{/if}					
							<span class="s1"></span>
							<span class="s2"></span>
						</p>						
						
						<p class="line2">							
							<a href="javascript:void(0)" onclick="{literal}$(this).submit(){/literal}">
								<span class="l"></span>
								<span class="c"><input type="submit" value="{$lang.order}" style="font-weight:bold;" class="padded btn"/></span>
								<span class="r"></span>
							</a>							
						</p>
					</div>
					<span class="bDeals"></span>
				</form>
			</li>
                        {if $smarty.foreach.ploop.iteration%4==0}
                        {assign var="j" value="1"}
                        <li style="height:15px;clear:both;display: block;float:none;"></li>
                        {/if}
			{/foreach}
			</ul>
				{if $opconfig.footertext}<p class="enterprise">{$opconfig.footertext}</p>{/if}
				{if $opconfig.whyourplan}<div id="about">
					<span class="tAbout"></span>
					<div class="cAbout">
						{if $opconfig.whyourplantext}<h1>{$opconfig.whyourplantext}</h1>{/if}
						{$opconfig.whyourplan}
					</div>
					<span class="bAbout"></span>
				</div>{/if}
							
	{else}
	<center>{$lang.nothing}</center>
	{/if}
	
	
	{/if}
	</div>
		<div id="footer">
				<div id="cFooter">
					<div class="info">
                                            {$opconfig.aboutus}
					</div>
					<div class="links">
						<h1>{$lang.quicklinks}</h1>
						<ul>
                                                    <li ><a href="index.php">{$lang.homepage}</a></li>
                                                    <li><a href="{$ca_url}clientarea/">{$lang.clientarea}</a></li>
                                                    <li ><a href="{if $logged=='1'}{$ca_url}support/{elseif $enableFeatures.kb!='off'}{$ca_url}knowledgebase/{else}{$ca_url}tickets/new/{/if}"  >{$lang.support}</a></li>
                                                    {if $enableFeatures.affiliates!='off'}<li><a href="{$ca_url}affiliates/" >{$lang.affiliates}</a></li>{/if}
                                                    {if $enableFeatures.chat!='off'}<li><a href="{$ca_url}chat/" {if $cmd=='cart'}target="_blank"{/if}>{$lang.chat}</a></li>{/if}
                                                </ul>
					</div>
					<div class="contact">
						{if $opconfig.bestline}<p class="p1" style="border-left:0px;margin-left:0px;padding-left:0px;">{$opconfig.bestline}</p>{/if}
						{if $opconfig.phoneline}<p class="p2">{$opconfig.phoneline}</p>{/if}
					</div>			
				</div>
			</div>
{literal}
<script type="text/javascript">
function fix4boxHeights() {
    var h =0; var hh =0;
    $('.cDeals').each(function(){
        if($(this).height()>hh) {
            hh=$(this).height();
        }
        if($(this).find('.line1').height()>h) {
            h=$(this).find('.line1').height();
        }
    });
    $('.cDeals  .line1').height(h);
    $('.cDeals ').height(hh);
}
appendLoader('fix4boxHeights');
</script>
{/literal}