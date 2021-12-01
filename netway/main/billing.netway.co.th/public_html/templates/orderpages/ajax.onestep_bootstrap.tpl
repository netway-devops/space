<div class="well-cont blueprice">
    <form id="cart0" action="" method="post">
    <table class="tab-cont" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cell-top first">
                {counter name=vsliderc print=false assign=vslider start=0}
                {foreach from=$custom item=cf name=vsliders}
                    {if $cf.type == 'slider'}
                        {if $vslider == 0}
                        {include file="onestep_bootstrap/verticalsliderheader.tpl" slideno=$smarty.foreach.vsliders.index}
                        {/if}
                        {counter name=vsliderc}
                    {/if}
                {/foreach}
            </td>
            <td class="cell-top">
                {counter name=vsliderc print=false assign=vslider start=0}
                {foreach from=$custom item=cf name=vsliders}
                    {if $cf.type == 'slider'}
                        {if $vslider == 1}
                        {include file="onestep_bootstrap/verticalsliderheader.tpl" slideno=$smarty.foreach.vsliders.index}
                        {/if}
                        {counter name=vsliderc}
                    {/if}
                {/foreach}
            </td>
            <td class="cell-top">
                {counter name=vsliderc print=false assign=vslider start=0}
                {foreach from=$custom item=cf name=vsliders}
                    {if $cf.type == 'slider'}
                        {if $vslider == 2}
                        {include file="onestep_bootstrap/verticalsliderheader.tpl" slideno=$smarty.foreach.vsliders.index}
                        {/if}
                        {counter name=vsliderc}
                    {/if}
                {/foreach}
            </td>
            <td class="cell-top last">
                <div class="notable">{$lang.total}</div>
                <div class="loadergif"></div><strong class="price">
                <small style="font-size:60%">{$currency.sign}</small>{if $tax}{$tax.total|price:$currency:false:false}{elseif $credit}{$credit.total|price:$currency:false:false}{else}{$subtotal.total|price:$currency:false:false}{/if}
                </strong>
            </td>
        </tr>
        <td class="cell-botom first">
            {counter name=vsliderc print=false assign=vslider start=0}
            {foreach from=$custom item=cf name=vsliders}
                {if $cf.type == 'slider'}
                    {if $vslider == 0}
                    {include file="onestep_bootstrap/verticalslider.tpl" slideno=$smarty.foreach.vsliders.index}
                    {/if}
                    {counter name=vsliderc}
                {/if}
            {/foreach}
        </td>
        <td class="cell-botom">
            {counter name=vsliderc print=false assign=vslider start=0}
            {foreach from=$custom item=cf name=vsliders}
                {if $cf.type == 'slider'}
                    {if $vslider == 1}
                    {include file="onestep_bootstrap/verticalslider.tpl" slideno=$smarty.foreach.vsliders.index}
                    {/if}
                    {counter name=vsliderc}
                {/if}
            {/foreach}
        </td>
        <td class="cell-botom">
            {counter name=vsliderc print=false assign=vslider start=0}
            {foreach from=$custom item=cf name=vsliders}
                {if $cf.type == 'slider'}
                    {if $vslider == 2}
                    {include file="onestep_bootstrap/verticalslider.tpl" slideno=$smarty.foreach.vsliders.index}
                    {/if}
                    {counter name=vsliderc}
                {/if}
            {/foreach}
        </td>
        <td class="cell-botom last">
            {if $currencies}
            <div class="btn-group">
                <button class="btn dropdown-toggle btn-custom" data-toggle="dropdown" href="#">
                    
                    <span class="notable">{$lang.Currency}:</span>
                    {foreach from=$currencies item=crx}
                        {if !$selcur && $crx.id==0}{if $crx.code}{$crx.code}{else}{$crx.iso}{/if} {if $crx.sign}({$crx.sign}){/if}{elseif $selcur==$crx.id}{if $crx.code}{$crx.code}{else}{$crx.iso}{/if} {if $crx.sign}({$crx.sign}){/if}{/if}
                    {/foreach}
                    
                    <span class="caret"></span>
                </button>
                    
                <ul class="dropdown-menu clear">
                    {foreach from=$currencies item=crx}
                         <li><a href="#" onclick="return changecurrency({$crx.id});">{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</a></li>
                    {/foreach}
                </ul>
            </div>
            <div style="height:5px"></div>
            {/if}
            <div class="btn-group clear">
                <button class="btn dropdown-toggle btn-custom cycles" data-toggle="dropdown" href="#">
                    <span class="notable">{$lang.billing}:</span>
                {if $product.paytype=='Free'}
                    {$lang.price} <strong>{$lang.free}</strong>
                {elseif $product.paytype=='Once'}
                    {$lang.price}  <strong>{$product.m|price:$currency}</strong> {$lang.once} / {$product.m_setup|price:$currency} {$lang.setupfee}
                {else}
                    <span class="btn-value">{$lang[$cycle]}</span>
                    <span class="caret"></span>
                {/if}
                
                </button>
                {if $product.paytype=='Free'}
                    <input type="hidden" name="cycle" value="Free" />
                {elseif $product.paytype=='Once'}
                    <input type="hidden" name="cycle" value="Once" />
                {else}
                    <input type="hidden" name="cycle" value="{$cycle}" />
                {/if}
                
                {if $product.paytype!='Once' && $product.paytype!='Free'}
                <ul class="dropdown-menu" >
                    {price product=$product}
                        <li><a href="#" onclick="return changecycle('@@cycle','@@cyclename')">@@line</a></li>
                    {/price}
                </ul>
                {/if}
            </div>
            <div class="produc-description">
                {$products[0].description}
            </div>
            <div style="height:5px"></div>
            <a class="btn btn-primary btn-large right" href="#" onclick="customize(this);return false;">
            {$lang.customize}
            </a>
        </td>
        <tr>
        </tr>
    </table>
    </form>
</div>
<script type="text/javascript">$(function(){literal}{{/literal}setcustomvisible({if $submit.make}true{else}false{/if}){literal}}{/literal})</script>  
<div class="customizer" style="display:none">
    <h1 style="padding-left:10px">{$lang.productconfig}</h1>
    {counter name=alter start=0 assign=alterval}
    <div class="section1">
        
    {*FORMS*}
    <form id="cart1" action="" method="post">
        <input type="hidden" name="custom[-1]" value="dummy" />
    {counter name=vsliderc print=false assign=vslider start=0}
    {foreach from=$custom item=cf name=sliders}
        {if $cf.type == 'slider'}
            {counter name=vsliderc}
        {/if}
        {if $vslider > 3 && $cf.type == 'slider'}
        <div class="item {if $alterval % 2 == 0}even{/if} {if $alterval == 0}first{/if}">
        {include file="onestep_bootstrap/horizontalslider.tpl"}
        </div>
        {counter name=alter}
        {/if}
    {/foreach}
    {foreach from=$custom item=cf} 
		{if $cf.items && $cf.type && $cf.type != 'slider' }
        <div class="item {if $alterval % 2 == 0}even{/if} {if $alterval == 0}first{/if}"> 
            {include file=$cf.configtemplates.cart}
            <h3>{$cf.name} {if $cf.options &1}*{/if}</h3>
            {if $cf.description!=''}<div class="fs11 descr" >{$cf.description}</div>{/if}
        </div>
        {counter name=alter}
        {/if}
    {/foreach}
    </form>
    {* SUBPRODUCTS *}
    {if $subproducts}
        <form id="cart2" action="" method="post">
		<input type="hidden" name="subproducts[0]" value="0" />
        <input type="hidden" name="addon[0]" value="0" />
			{foreach from=$subproducts item=a key=k}
			<div class="item {if $alterval % 2 == 0}even{/if} {if $alterval == 0}first{/if}"> 
				
					<input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}  onclick="simulateCart('#cart2');"/>
				
					<strong>{$a.category_name} - {$a.name}</strong>
				
				{price product=$a}
				{if $a.paytype=='Free'}
					{$lang.free}
					<input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
				{elseif $a.paytype=='Once'}
					<input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
					@@line
				{else}
					<select name="subproducts_cycles[{$k}]"   
                                                onchange="if($('input[name=\'subproducts[{$k}]\']').is(':checked'))simulateCart('#cart2');">
                                            <option value="@@cycle" @@selected>@@line</option>
                                        </select>
				{/if}
                                {/price}
                </div>
                {counter name=alter}
		{/foreach}
        </form>
	{/if}
    {* ADDONS *}
    <form id="cart3" action="" method="post">
	{if $addons}
            <input type="hidden" name="addon[0]" value="0" />
            {foreach from=$addons item=a key=k}
                <div class="item {if $alterval % 2 == 0}even{/if} {if $alterval == 0}first{/if}"> 
                    <input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onclick="simulateCart('#cart3');"/>
                        
                    <strong>{$a.name}</strong>{if $a.description!=''} - {$a.description}{/if}
                    {price product=$a}
                    {if $a.paytype=='Free'}
                        {$lang.free}
                        <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
                    {elseif $a.paytype=='Once'}
                        <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
                        @@line
                    {else}
                        <select name="addon_cycles[{$k}]"   onchange="if($('input[name=\'addon[{$k}]\']').is(':checked'))simulateCart('#cart3');">
                            <option value="@@cycle" @@selected>@@line</option>
                        </select>
                    {/if}
                    {/price}
                </div>
                {counter name=alter}
            {/foreach}
	{/if}
    {* HOSTNAME *}
    {if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
        <div class="item {if $alterval % 2 == 0}even{/if} {if $alterval == 0}first{/if}"> 
            <h3>{$lang.hostname}*</h3>
            <input name="domain" value="{$item.domain}" class="styled" size="50" onchange="simulateCart();"/>
        </div>
        {counter name=alter}
        {if $product.extra.enableos=='1' && !empty($product.extra.os)}
            <div class="item {if $alterval % 2 == 0}even{/if} {if $alterval == 0}first{/if}"> 
                <h3>{$lang.ostemplate} *</h3>
                <select name="ostemplate" class="styled"   onchange="simulateCart('#cart3');">
                    {foreach from=$product.extra.os item=os}
                        <option value="{$os.id}"  {if $item.ostemplate==$os.id}selected="selected"{/if}>{$os.name}</option>
                    {/foreach}
                </select>      
            </div>
            {counter name=alter}
        {/if}
    {/if}
    </form>
    {*DOMAIN OPTIONS*}
    {if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
    <div class="item {if $alterval % 2 == 0}even{/if} {if $alterval == 0}first{/if}"> 
        <h3>{$lang.mydomains}</h3>
        <div class="btn-group">
        {if $allowregister}<button rel="t1" class="btn {if $contents[2].action=='register' || !$contents[2]}active{/if}" onclick="tabbme(this);">{$lang.register}</button>{/if}
        {if $allowtransfer}<button rel="t2" class="btn {if $contents[2].action=='transfer'}active{/if}" onclick="tabbme(this);">{$lang.transfer}</button>{/if}
        {if $allowown}<button rel="t3" class="btn {if $contents[2].action=='own' && !$subdomain}active{/if}" onclick="tabbme(this);">{$lang.alreadyhave}</button>{/if}
        {if $subdomain}<button rel="t4" class="btn {if $contents[2].action=='own' && $subdomain}active{/if}" onclick="tabbme(this);">{$lang.subdomain}</button>{/if}
        </div>
        <br />

        {if $contents[2]}
            <div id="domoptions22">
                {foreach from=$contents[2] item=domenka key=kk}
                    {if $domenka.action!='own'  && $domenka.action!='hostname'}
                        <strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{/if}</strong> - {$domenka.name} - {$domenka.period} {$lang.years}
                        {$domenka.price|price:$currency}<br />
                    {else}
                        {$domenka.name}<br />
                    {/if}
                    {if $domenka.custom}
                        <form class="cartD" action="" method="post">
                            <table class="styled" width="100%" cellspacing="" cellpadding="6" border="0">
                                {foreach from=$domenka.custom item=cf}
                                    {if $cf.items}
                                        <tr>
                                            <td class="configtd" >
                                                <label for="custom[{$cf.id}]" class="styled">{$cf.name}{if $cf.options & 1}*{/if}</label>
                                                {if $cf.description!=''}<div class="fs11 descr" style="">{$cf.description}</div>{/if}
                                                {include file=$cf.configtemplates.cart cf_opt_formId=".cartD" cf_opt_name="custom_domain"}
                                            </td>
                                        </tr>
                                    {/if}   
                                {/foreach}
                            </table>
                        </form>
                    {/if}
                {/foreach}
                <a href="#" onclick="$('#domoptions22').hide();$('#domoptions11').show();return false;">{$lang.change}</a>
            </div>
        {/if}

        <div {if $contents[2]}style="display:none"{/if} id="domoptions11">
            <form action="" method="post"  name="domainpicker" onsubmit="return on_submit();">
                <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id" />
                <input type="hidden" name="make" value="checkdomain" />
                <div id="options">
                    {if $allowregister}
                        <div id="illregister" class="t1 slidme">
                            <input type="radio" name="domain" value="illregister" style="display: none;" checked="checked"/>
                            <div id="multisearch" class="left">
                                <textarea name="sld_register" id="sld_register" style="resize: none"></textarea>
                            </div>
                            <div style="margin-left:10px;width:310px;float:left">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="" class="fs11">
                                {foreach from=$tld_reg item=tldname name=ttld}
                                    {if $smarty.foreach.ttld.index % 3 =='0'}<tr>{/if}
                                        <td width="33%"><input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register"/> 
                                            {$tldname}
                                        </td>
                                    {if $smarty.foreach.ttld.index % 3 =='5'}</tr>{/if}
                                {/foreach}
                                    <tr></tr>
                                </table>
                            </div>
                            <div class="clear"></div>
                            <p class="align-right">
                                <input type="submit" value="{$lang.check}" class="btn"/>
                            </p>
                        </div>
                    {/if}
                    {if $allowtransfer}
                        <div id="illtransfer" style="{if $allowregister}display: none;{/if}"  class="t2 slidme align-center form-horizontal">
                            <input type="radio" style="display: none;" value="illtransfer" name="domain" {if !$allowregister}checked="checked"{/if}/>
                            www.
                            <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled"/>
                            <select name="tld_transfer" id="tld_transfer" class="span2">
                                {foreach from=$tld_tran item=tldname}
                                    <option>{$tldname}</option> 	
                                {/foreach}
                            </select>  
                            <input type="submit" value="{$lang.check}" class="btn"/>
                        </div>
                    {/if}
                    {if $allowown}
                        <div id="illupdate" style="{if $allowregister || $allowtransfer}display: none;{/if}"  class="t3 slidme align-center form-horizontal">
                            <input type="radio" style="display: none;" value="illupdate" name="domain" {if !$allowregister && !$allowtransfer}checked="checked"{/if}/>
                            www.
                            <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled"/>
                            .
                            <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span2"/>  <input type="submit" value="{$lang.check}" class="btn"/>
                        </div>
                    {/if}
                    {if $subdomain}
                        <div id="illsub" style="{if $allowregister || $allowtransfer || $allowown}display: none;{/if}"  class="t4 slidme align-center form-horizontal">
                            <input type="radio" style="display: none;" value="illsub" name="domain"  {if !($allowregister || $allowtransfer || $allowown)}checked="checked"{/if}/>
                            www.
                            <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled"/>  
                            {$subdomain} <input type="submit" value="{$lang.check}" class="btn"/>
                        </div>
                    {/if}
                </div>
            </form>
            <form method="post" action="" onsubmit="return onsubmit_2();" id="domainform2">
                <div id="updater2">{include file="ajax.checkdomain.tpl"} </div>
            </form>
        </div>
    </div>
{/if}
{if $alterval == 0}
    <div class="item first"> {$lang.nocustomizations} </div>
{/if}
</div>
<script type="text/javascript">conditioncheck()</script>
{*SUMMARY*}
<div class="summarybox well-cont">
    <h3>{$lang.ordersummary}</h3>
	<div style="height:5px"></div>
    
	{* PRODUCT *}
	{if $product}
        <div class="item">
		{$contents[0].category_name} - <strong>{$contents[0].name}</strong> {if $contents[0].domain}({$contents[0].domain}){/if}<br/>
		<span class="price">
		{if $contents[0].price==0}
			<strong>{$lang.Free}</strong>
		{elseif $contents[0].prorata_amount}
			<strong> {$contents[0].prorata_amount|price:$currency}</strong>
			({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
		{else}
			<strong>{$contents[0].price|price:$currency}</strong>
		{/if}
		{if $contents[0].setup!=0} 
			+ {$contents[0].setup|price:$currency} {$lang.setupfee}
		{/if}
		</span>	
		{if $contents[0].recurring && $contents[0].price > 0}
			{assign value=$contents[0].recurring var=recurring}{$lang[$recurring]}
		{elseif $contents[0].price > 0}
			{$lang.once}
		{/if}
        </div>
	{/if}
	{* FORMS *}
	{if $cart_contents[1]}
		
		{foreach from=$cart_contents[1] item=cstom2}
			<div class="item">
			{foreach from=$cstom2 item=cstom}
				{if $cstom.total>0}
					<strong>{$cstom.fullname}</strong>  {if $cstom.qty>=1}x {$cstom.qty}{/if} <br />
                    <span class="price">
					<strong>
					{if $cstom.price==0}
						{$lang.Free}
					{elseif $cstom.prorata_amount}
						{$cstom.prorata_amount|price:$currency}
					{else}
						{$cstom.price|price:$currency}
					{/if} 
                    </strong>
					{if $cstom.recurring}
						{assign value=$cstom.recurring var=recurring}{$lang[$recurring]}
					{elseif $cstom.price > 0}
						{$lang.once}
					{/if}
                    </span>
                    {if $cstom.setup!=0}
                        <br />
                        <span class="price">
						<strong>+ {$cstom.setup|price:$currency}</strong> {$lang.setupfee}
                        </span>
					{/if}
				{/if}
			{/foreach}
            </div>
		{/foreach}
	{/if}
	{* ADDONS *}
	{if $contents[3]}
		{foreach from=$contents[3] item=addon}
            <div class="item">
			{$lang.addon} - <strong>{$addon.name}</strong><br />
			<span class="price">
			{if $addon.price==0}
				<strong>{$lang.Free}</strong>
			{elseif $addon.prorata_amount}
				<strong>{$addon.prorata_amount|price:$currency}</strong> ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format})
			{else}
				<strong>{$addon.price|price:$currency}</strong>
			{/if}
			{if $addon.setup!=0}
				+ {$addon.setup|price:$currency} {$lang.setupfee}
			{/if}
			</span>	
			{if $addon.recurring}
				{assign value=$addon.recurring var=recurring}{$lang[$recurring]}
			{elseif $addon.price > 0}
				{$lang.once}
			{/if}
			</div>
		{/foreach}
	{/if}
	{* DOMAINS *}
	{if $contents[2] && $contents[2][0].action!='own'}
		{foreach from=$contents[2] item=domenka key=kk}
			<div class="item">
			<strong>
			{if $domenka.action=='register'}
				{$lang.domainregister}
			{elseif $domenka.action=='transfer'}
				{$lang.domaintransfer}
			{/if}
			</strong> - {$domenka.name}<br>
			<span class="price">
			{if $domenka.dns}
				&raquo; {$lang.dnsmanage} (+ {$domenka.dns|price:$currency})<br/>
			{/if}
			{if $domenka.idp}
				&raquo; {$lang.idprotect}(+ {$domenka.idp|price:$currency})<br/>
			{/if}
			{if $domenka.email}
				&raquo; {$lang.emailfwd} (+ {$domenka.email|price:$currency})<br/>
			{/if}
			<strong>{$domenka.price|price:$currency}</strong>
			</span>
			{$domenka.period} {$lang.years}
            </div>
		{/foreach}
	{/if}
	{* SUBPRODUCTS *}
	{if $contents[4]}
		
		{foreach from=$contents[4] item=subprod}
			{$subprod.category_name} -  <strong>{$subprod.name}</strong><br />
			<div class="item">
			<span class="price">
			{if $subprod.price==0}
				<strong>{$lang.Free}</strong>
			{elseif $subprod.prorata_amount}
				<strong> {$subprod.prorata_amount|price:$currency}</strong>
				({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
			{else}
				<strong>{$subprod.price|price:$currency}</strong>
			{/if}
			
			{if $subprod.setup!=0}
				+ {$subprod.setup|price:$currency} {$lang.setupfee}
			{/if}
			</span>	
			{if $subprod.recurring}
				{assign value=$subprod.recurring var=recurring}{$lang[$recurring]}
			{elseif $subprod.price > 0}
				{$lang.once}
			{/if}
            </div>
		{/foreach}
	{/if}
    {* TAX *}
	<table id="taxsum" cellpadding="0" cellspacing="0">
	{if $tax}
		{if $subtotal.coupon}  
		<tr >
			<td class="aling-left">{$lang.discount}</td>
			<td><strong>- {$subtotal.discount|price:$currency}</strong></td>
		</tr>  
		{/if}
		{if $tax.tax1 && $tax.taxed1!=0}
		<tr >
			<td class="aling-left">{$tax.tax1name} @ {$tax.tax1}%  </td>
			<td>{$tax.taxed1|price:$currency}</td>
		</tr>
		{/if}
		{if $tax.tax2  && $tax.taxed2!=0}
		<tr >
			<td class="aling-left">{$tax.tax2name} @ {$tax.tax2}%  </td>
			<td>{$tax.taxed2|price:$currency}</td>
		</tr>
		{/if}
		{if $tax.credit!=0}
		<tr>
			<td class="aling-left"><strong>{$lang.credit}</strong> </td>
			<td><strong>{$tax.credit|price:$currency}</strong></td>
		</tr>
		{/if}
	{elseif $credit}
		{if  $credit.credit!=0}
		<tr>
			<td class="aling-left"><strong>{$lang.credit}</strong> </td>
			<td><strong>{$credit.credit|price:$currency}</strong></td>
		</tr>
		{/if}
		{if $subtotal.coupon}  
		<tr >
			<td class="aling-left">{$lang.discount}</td>
			<td><strong>- {$subtotal.discount|price:$currency}</strong></td>
		</tr>  
		{/if}
	{else}
		{if $subtotal.coupon}  
		<tr >
			<td class="aling-left">{$lang.discount}</td>
			<td><strong>- {$subtotal.discount|price:$currency}</strong></td>
		</tr>  
		{/if}
	{/if}
	{* RECURING *}
	{if !empty($tax.recurring)}
		<tr>
			<td class="aling-left">{$lang.total_recurring}</td>
			<td> {foreach from=$tax.recurring item=rec key=k}
			{$rec|price:$currency} {$lang.$k}<br/>
			{/foreach} </td>
		</tr>
	{elseif !empty($subtotal.recurring)}
		<tr >
			<td class="aling-left">{$lang.total_recurring}</td>
			<td> {foreach from=$subtotal.recurring item=rec key=k}
			{$rec|price:$currency} {$lang.$k}<br/>
			{/foreach} </td>
		</tr>
	{/if}
	</table>
    {* CUPON *}
	{if !$subtotal.coupon}
	<div id="promocode" >
		<form action="" method="post" id="promoform" onsubmit="return applyCoupon();" class="form-horizontal" >
			<input type="hidden" name="addcoupon" value="true" />    
            <h3>{$lang.coupon_code}</h3>
            <div class="input-append">
                <input type="text" size="16" name="promocode" class="input2"><button type="button" class="btn" onclick="$('#promoform').submit();">{$lang.Go}!</button>
            </div>
		</form>
	</div>
    {else}
        <button class="btn" onclick="removeCoupon()">{$lang.remove_coupon}</button>
	{/if}
    {* PAYMENT METHOD *}
    {if $gateways}
    <h3>{$lang.choose_payment}</h3>
        <form action="" method="post" id="gatewaylist" onchange="simulateCart('gatewaylist');">
            <select class="payment-method" name="gateway" >
            {foreach from=$gateways item=module key=mid name=payloop}
            <option value="{$mid}"  {if $submit && $submit.gateway==$mid||$mid==$paygateid}selected="selected"{elseif $smarty.foreach.payloop.first}selected="selected"{/if}>{$module}</option>
            {/foreach}
            </select>
        </form>
    <div class="hr"></div>
    {/if}
	
	{* TOTAL TODAY *}
	
	<div class="total">
		{$lang.total_today} <br> 
		<strong>
            <div class="loadergif"></div>
			{if $tax}
				<small>{$currency.sign}</small>{$tax.total|price:$currency:false:false}
			{elseif $credit}
				<small>{$currency.sign}</small>{$credit.total|price:$currency:false:false}
			{else}
				<small>{$currency.sign}</small>{$subtotal.total|price:$currency:false:false}
			{/if}
		</strong>
	</div>
    </div>
</div>
