<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}metered/style.css" />
{*<script type="text/javascript" src="{$orderpage_dir}metered/jquery-1.6.2.js"></script>*}
<script type="text/javascript" src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js"></script>
<script type="text/javascript" src="{$orderpage_dir}metered/jquery.ui.selectmenu.js"></script>
<link type="text/css" href="{$orderpage_dir}metered/jquery.ui.selectmenu.css" rel="stylesheet" />
<link type="text/css" href="{$orderpage_dir}metered/jquery.ui.theme.css" rel="stylesheet" />
<script src="{$orderpage_dir}metered/scripts_metered.js" type="text/javascript"></script>
<div class="zone-all">
<h3 class="title-b">{$lang.browseprod}</h3>

	<ul class="menu-tabs">
		{foreach from=$categories item=i name=categories}
			{if $i.id == $current_cat} 
			<li class="first">
				<a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a>
			</li>
			{/if}
		{/foreach}
		{foreach from=$categories item=i name=categories name=cats}
			{if $i.id != $current_cat}
			<li class="{if $smarty.foreach.cats.last && $logged!='1'}last{/if}"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></li>
			{/if}
		{/foreach}
		{if $logged=='1' && $current_cat!='addons'}
			<li class="last"><a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a></li>
		{/if}
	</ul>
	<div class="con-inner-middle">		
	{* DISABLED CART DESCRIPTION 
	{foreach from=$categories item=i name=categories name=cats}
		{if $i.id == $current_cat && $i.description!=''}
			<div style="text-align:left;margin-top:10px;">{$i.description}</div>
		{/if}
	{/foreach}*}
	{if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}
	<br />
	{if $products}				
		<table cellpadding="0" cellspacing="0" class="met">
			<tr class="first-row-top">
				<td colspan="4"><div><div></div></div></td>
			</tr>								
			<tr class="first-row">
				<td class="col1" width="600">{$lang.service}</td>
				<td width="115">{$lang.setupfee}</td>
				<td width="94">{$lang.price}</td>
				<td class="col4"  width="287">{$lang.Description}</td>
			</tr>								
			<tr class="first-row-bottom">
				<td colspan="4"><div><div></div></div></td>
			</tr>
			<tr >
				<td colspan="3">
					<ul class="pr">
						{foreach from=$products item=i key=k}
<!-- -->
						<li id="id-{$i.id}" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}class="active"{/if}>
							<label>
							<div class="bel-top"><div></div></div>
							<div class="bel-middle">
								<table cellpadding="0" cellspacing="0" >
									<colgroup>
									<col width="5" />
									<col width="361" />
									<col width="61"/>
									<col width="83"/>
									</colgroup>						
									<tr>
										<td class="vmid"><div><input type="radio" name="box" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}checked="checked"{/if} value="{$i.id}" /></div></td>
										<td>
											<div class="pr-title">
											{$i.name}
											</div>
											<div class="pr-desc">
												{if $i.description!=''}
												<div class="pr-desc-top"><div></div></div>
												<div class="pr-desc-middle">												
												{$i.description}
                                                <div style="height:1px"></div>
												</div>
												<div class="pr-desc-bottom"><div></div></div>													
												{/if}
											</div>
										</td>
										<td class="font-n" align="center" >
											{if $i.paytype=='Free'}<input type="hidden" name="cycle" value="Free" />
											{elseif $i.paytype=='Once'}<input type="hidden" name="cycle" value="Once" />{if $i.m_setup>0}{$i.m_setup|price:$currency} {else}{$lang.Free}{/if}
											{else}
												{if $i.m_setup!='0.00'}{$i.m_setup|price:$currency}
												{elseif $i.q_setup!='0.00'}{$i.q_setup|price:$currency}
												{elseif $i.s_setup!='0.00'}{$i.s_setup|price:$currency}
												{elseif $i.a_setup!='0.00'}{$i.a_setup|price:$currency}
												{elseif $i.b_setup!='0.00'}{$i.b_setup|price:$currency}
												{elseif $i.t_setup!='0.00'}{$i.t_setup|price:$currency}
												{elseif $i.p4_setup!='0.00'}{$i.p4_setup|price:$currency}
												{elseif $i.p5_setup!='0.00'}{$i.p5_setup|price:$currency}
												{else}{$lang.Free}{/if}
											{/if}
											
										</td>
										<td class="font-n" align="center" >
											{if $i.paytype=='Free'}{$lang.Free}
											{elseif $i.paytype=='Once'}
												{if $i.m>0}{$i.m|price:$currency}
												{else}{$lang.Free}
												{/if}
											{else} 
												{if $i.d!=0}{$lang.d} 
												{elseif $i.w!=0}{$i.w|price:$currency} 
												{elseif $i.m!=0}{$i.m|price:$currency}
												{elseif $i.q!=0}{$i.q|price:$currency}
												{elseif $i.s!=0}{$i.s|price:$currency}
												{elseif $i.a!=0}{$i.a|price:$currency}
												{elseif $i.b!=0}{$i.b|price:$currency}
												{elseif $i.t!=0}{$i.t|price:$currency}
												{elseif $i.p4!=0}{$i.p4|price:$currency}
												{elseif $i.p5!=0}{$i.p5|price:$currency}
												{/if}
											{/if}												
										</td>
									</tr>
								</table>
							</div>			
							<div class="bel-bottom"><div></div></div>
							</label>
						</li>
<!-- -->								
						{/foreach}
					</ul>
				</td>
				<td colspan="3">
				{foreach from=$products item=i key=k}
				<div class="right hideable id-{$i.id}" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}style="display:block;"{else}style="display:none;"{/if}>
					<div class="desc">
						<div class="desc-title">
							{$i.name}
						</div>
						<div class="desc-cont" {if $i.description=='' ||  $i.description=='<ul></ul>'}style="visibility: hidden"{/if}>
							<div class="top">&nbsp;</div>
							<div class="middle">
								{$i.description}														
							</div>
							<div class="bottom">&nbsp;</div>
						</div>
						
					</div>
				</div>						
				{/foreach}
				</td>
			</tr>
			<tr>
				<td colspan="3">
					{foreach from=$products item=i key=k}
	
					<div class="bil-opt hideable id-{$i.id}" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}style="display:block;"{else}style="display:none;"{/if}>
						<div class="bil-opt-top"><div></div></div>
						<div class="bil-opt-middle">
							<div class="bil-opt-title">
								{if  $i.paytype=='Free'}
									{$lang.price} {$lang.Free}
								{elseif $i.paytype=='Once'}
									{$lang.price} {if $i.m>0}{$i.m|price:$currency}{else}{$lang.Free}{/if}
								{else}
								{$lang.pselectbilling}:
								{/if}
							</div>
							{if  $i.paytype!='Free' &&  $i.paytype!='Once'}
							<div class="bil-opt-sel">
								<label for="cycle{$k.id}">
									{$lang.pickcycle}						
								</label>
								<div class="select-cont">
								<div>
									{if  $i.paytype!='Free' &&  $i.paytype!='Once'}
										  <select name="cycle"  id="cycle_id-{$i.id}" onclick="setselectw('cycle_id-{$i.id}');" onchange="$('.maincycle').val($(this).val());">
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
								</div>
								</div>
								
							</div>
							{/if}
							{if count($currencies)>1}
							<form action="" method="post" id="currform{$k}">
							<div class="bil-opt-sel">
								<input name="action" type="hidden" value="changecurr">
								<label for="cycleCurrency{$k.id}">
									{$lang.Currency} 				
								</label>
								<div class="select-cont">
								<div>
									<select id="curr_id-{$i.id}" name="currency" class="styled span2" onchange="$('#currform{$k}').submit(); return false;">
										{foreach from=$currencies item=crx}
										<option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
										{/foreach}
									</select>		
								</div>
								</div>
							</div>									
							</form>
							{/if}
						</div>
						<div class="bil-opt-bottom"><div></div></div>
					</div>	
					{/foreach}
				</td>
				<td style="vertical-align:middle">
				{foreach from=$products item=i key=k}
				<div class="hideable id-{$i.id}" {if $opconfig.defaultselect == ($k+1) || ((!$opconfig.defaultselect || $opconfig.defaultselect < 1) && $k==0)}style="display:block;"{else}style="display:none;"{/if}>
					<form name="" action="" method="post">
					<input name="action" type="hidden" value="add">
					<input name="id" type="hidden" value="{$i.id}">
					{if $i.paytype=='Free'}<input type="hidden" name="cycle" value="Free" />
					{elseif $i.paytype=='Once'}<input type="hidden" name="cycle" value="Once" />
					{else}<input type="hidden" name="cycle" class="maincycle" value="" />
					{/if}												
					
					<div class="center" >
						<span class="button01" >
							<span>
								<input type="submit" value="{$lang.ordernow}" style="font-weight:bold;" class="padded btn"/>
							</span>
						</span>
					</div>
					</form>
				</div>						
				{/foreach}
				</td>
			</tr>								
				</table>
				{else}
				<center>{$lang.nothing}</center>
				{/if}
				
				
				{/if}

</div>