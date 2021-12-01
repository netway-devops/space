<div id="load-img" style="display:none;" ><center><img src="{$template_dir}img/ajax-loading.gif" /></center></div>


<div class="left mright20" style="width:520px;">
{if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
<div class="newbox1header">
<h3 class="modern">{$lang.mydomains}</h3>
<ul class="wbox_menu tabbme">
	{if $allowregister}<li class="t1 {if $contents[2].action=='register' || !$contents[2]}on{/if}" onclick="tabbme(this);">{$lang.register}</li>{/if}
	{if $allowtransfer}<li class="t2 {if $contents[2].action=='transfer'}on{/if}" onclick="tabbme(this);">{$lang.transfer}</li>{/if}
	{if $allowown}<li class="t3 {if $contents[2].action=='own' && !$subdomain}on{/if}" onclick="tabbme(this);">{$lang.alreadyhave}</li>{/if}
	{if $subdomain}<li class="t4 {if $contents[2].action=='own' && $subdomain}on{/if}" onclick="tabbme(this);">{$lang.subdomain}</li>{/if}

</ul>
</div>
<div class="newbox1">
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
<input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id"/>
<input type="hidden" name="make" value="checkdomain" />

 
  <div id="options">

	{if $allowregister}
    <div align="center" id="illregister" class="t1 slidme">
	<input type="radio" name="domain" value="illregister" style="display: none;" checked="checked"/>
	<div id="multisearch" class="left">
		<textarea name="sld_register" id="sld_register"></textarea>
	</div>
        <div style="margin-left:10px;width:310px;float:left">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" style="" class="fs11">
		{foreach from=$tld_reg item=tldname name=ttld}
			{if $smarty.foreach.ttld.index % 3 =='0'}<tr>{/if}
			<td width="33%"><input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register"/> {$tldname}</td>
			{if $smarty.foreach.ttld.index % 3 =='5'}</tr>{/if}

        {/foreach}
		<tr>
		
		</tr>
		
	</table>
            </div>
    <div class="clear"></div>
	<p align="right"><input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/></p>
    </div>
	{/if}
	{if $allowtransfer}
    <div align="center" id="illtransfer" style="{if $allowregister}display: none;{/if}"  class="t2 slidme form-inline">
	 <input type="radio" style="display: none;" value="illtransfer" name="domain" {if !$allowregister}checked="checked"{/if}/>
	www.
      <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="styled span3"/>
      <select name="tld_transfer" id="tld_transfer" class="span2">
         {foreach from=$tld_tran item=tldname}
            <option>{$tldname}</option> 	
        {/foreach}
      </select>  <input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/>
    </div>
	{/if}
	{if $allowown}
    <div align="center" id="illupdate" style="{if $allowregister || $allowtransfer}display: none;{/if}"  class="t3 slidme form-inline">
	 <input type="radio" style="display: none;" value="illupdate" name="domain" {if !$allowregister && !$allowtransfer}checked="checked"{/if}/>
	www.
      <input type="text" value="" size="40" name="sld_update" id="sld_update" class="styled span3"/>
      .
      <input type="text" value="" size="7" name="tld_update" id="tld_update" class="styled span2"/>  <input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/>
    </div>
	{/if}
        {if $subdomain}
		
    <div align="center" id="illsub" style="{if $allowregister || $allowtransfer || $allowown}display: none;{/if}"  class="t4 slidme form-inline">
	  <input type="radio" style="display: none;" value="illsub" name="domain"  {if !($allowregister || $allowtransfer || $allowown)}checked="checked"{/if}/>
	www.
      <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="styled"/>  
      {$subdomain} <input type="submit" value="{$lang.check}" style="font-size:12px;font-weight:bold" class="padded btn"/>
    </div>
	{/if}
  </div></center>

</form>
<form method="post" action="" onsubmit="return onsubmit_2();" id="domainform2">
<div id="updater2">{include file="ajax.checkdomain.tpl"} </div>
</form>
</div></div>
{/if}







<h3 class="modern">{$lang.config_options}</h3>
<div class="newbox1" style="width:510px;">

<form id="cart2" action="" method="post">
<input type="hidden" name="cat_id" value="{$current_cat}" />
	{if $product.paytype=='Free'}
<input type="hidden" name="cycle" value="Free" />
{$lang.price} <strong>{$lang.free}</strong>

			{elseif $product.paytype=='Once'}
<input type="hidden" name="cycle" value="Once" />
{$lang.price}  <strong>{$product.m|price:$currency}</strong> {$lang.once} / {$product.m_setup|price:$currency} {$lang.setupfee}
		{else}
		{$lang.pickcycle}
<select name="cycle"   onchange="simulateCart('#cart2');"  id="product_cycle">
  {if $product.h!=0}<option value="h" {if $cycle=='h'} selected="selected"{/if}>{$product.h|price:$currency} {$lang.h}{if $product.h_setup!=0} + {$product.h_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Hourly} {$lang.freedomain}{/if}</option>{/if}
    {if $product.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$product.d|price:$currency} {$lang.d}{if $product.d_setup!=0} + {$product.d_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Daily} {$lang.freedomain}{/if}</option>{/if}
    {if $product.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$product.w|price:$currency} {$lang.w}{if $product.w_setup!=0} + {$product.w_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Weekly} {$lang.freedomain}{/if}</option>{/if}
    {if $product.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$product.m|price:$currency} {$lang.m}{if $product.m_setup!=0} + {$product.m_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Monthly} {$lang.freedomain}{/if}</option>{/if}
    {if $product.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$product.q|price:$currency} {$lang.q}{if $product.q_setup!=0} + {$product.q_setup|price:$currency} {$lang.setupfee}{/if}{if $product.free_tlds.cycles.Quarterly} {$lang.freedomain}{/if}</option>{/if}
    {if $product.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$product.s|price:$currency} {$lang.s}{if $product.s_setup!=0} + {$product.s_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.SemiAnnually}{$lang.freedomain}{/if}</option>{/if}
    {if $product.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$product.a|price:$currency} {$lang.a}{if $product.a_setup!=0} + {$product.a_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Annually}{$lang.freedomain}{/if}</option>{/if}
    {if $product.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$product.b|price:$currency} {$lang.b}{if $product.b_setup!=0} + {$product.b_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Biennially}{$lang.freedomain}{/if}</option>{/if}
    {if $product.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$product.t|price:$currency} {$lang.t}{if $product.t_setup!=0} + {$product.t_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Triennially}{$lang.freedomain}{/if}</option>{/if}
	{if $product.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$product.p4|price:$currency} {$lang.p4}{if $product.p4_setup!=0} + {$product.p4_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Quadrennially}{$lang.freedomain}{/if}</option>{/if}
	{if $product.p5!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$product.p5|price:$currency} {$lang.p5}{if $product.p5_setup!=0} + {$product.p5_setup|price:$currency} {$lang.setupfee}{/if} {if $product.free_tlds.cycles.Quinquennially}{$lang.freedomain}{/if}</option>{/if}

            

</select>

		{/if}
	</form>	
<form id="cart3" action="" method="post">
<input type="hidden" name="cat_id" value="{$current_cat}" />
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
<colgroup class="firstcol"></colgroup>
<colgroup class="alternatecol"></colgroup>
{if ($product.hostname) && !($cart_contents[0].domainoptions.register=='1' ||  $allowown || $subdomain)}
<tr>
	<td><strong>{$lang.hostname}</strong> *</td>
	<td><input name="domain" value="{$item.domain}" class="styled" size="50"  onchange="simulateCart('#cart3', true);"/></td>
	
</tr>
{if $product.extra.enableos=='1' && !empty($product.extra.os)}
<tr>
	<td><strong>{$lang.ostemplate}</strong> *</td>
	<td><select name="ostemplate" class="styled"   onchange="simulateCart('#cart3');">
		{foreach from=$product.extra.os item=os}
		<option value="{$os.id}"  {if $item.ostemplate==$os.id}selected="selected"{/if}>{$os.name}</option>
		{/foreach}
	</select></td>
	
</tr>
{/if}
{/if}

	</table>
	

 {if $custom} <input type="hidden" name="custom[-1]" value="dummy" /><table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">

	{foreach from=$custom item=cf} 
	{if $cf.items}
	<tr>
		<td colspan="2" class="{$cf.key} cf_option">
		
			<label for="custom[{$cf.id}]" class="styled">{$cf.name} {if $cf.options &1}*{/if}</label><br/>
			{if $cf.description!=''}<div class="fs11 descr" >{$cf.description}</div>{/if}
			
                                                 {include file=$cf.configtemplates.cart}
		</td>
	</tr>
	{/if}
	{/foreach}
</table>
{/if}
{if $subproducts}
<input type="hidden" name="subproducts[0]" value="0" />
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">

    {foreach from=$subproducts item=a key=k}
    <tr><td width="20"><input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}  onclick="simulateCart('#cart3');"/></td>
        <td>
             <strong>{$a.category_name} - {$a.name}</strong>
        </td>
        <td  align="right">
            {if $a.paytype=='Free'}
            {$lang.free}
            <input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>
            {elseif $a.paytype=='Once'}
            <input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>
            {$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}
            {else}
            <select name="subproducts_cycles[{$k}]"   onchange="if($('input[name=\'subproducts[{$k}]\']').is(':checked'))simulateCart('#cart3');">
	 {if $a.h!=0}<option value="h" {if (!$contents[4][$k] && $cycle=='h') || $contents[4][$k].recurring=='h'} selected="selected"{/if}>{$a.h|price:$currency} {$lang.h}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.d!=0}<option value="d" {if (!$contents[4][$k] && $cycle=='d') || $contents[4][$k].recurring=='d'} selected="selected"{/if}>{$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.w!=0}<option value="w" {if (!$contents[4][$k] && $cycle=='w') || $contents[4][$k].recurring=='w'}  selected="selected"{/if}>{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.m!=0}<option value="m" {if (!$contents[4][$k] && $cycle=='m') || $contents[4][$k].recurring=='m'}  selected="selected"{/if}>{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.q!=0}<option value="q" {if (!$contents[4][$k] && $cycle=='q') || $contents[4][$k].recurring=='q'} selected="selected"{/if}>{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.s!=0}<option value="s" {if (!$contents[4][$k] && $cycle=='s') || $contents[4][$k].recurring=='s'} selected="selected"{/if}>{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.a!=0}<option value="a" {if (!$contents[4][$k] && $cycle=='a') || $contents[4][$k].recurring=='a'} selected="selected"{/if}>{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.b!=0}<option value="b" {if (!$contents[4][$k] && $cycle=='b') || $contents[4][$k].recurring=='b'} selected="selected"{/if}>{$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.t!=0}<option value="t" {if (!$contents[4][$k] && $cycle=='t') || $contents[4][$k].recurring=='t'} selected="selected"{/if}>{$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
				{if $a.p4!=0}<option value="p4" {if (!$contents[4][$k] && $cycle=='p4') || $contents[4][$k].recurring=='p4'} selected="selected"{/if}>{$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
				{if $a.p5!=0}<option value="p5" {if (!$contents[4][$k] && $cycle=='p5') || $contents[4][$k].recurring=='p5'} selected="selected"{/if}>{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
            
            </select>
            {/if}
        </td>
    </tr>
    {/foreach}
</table>
{/if}
{if $addons}
<input type="hidden" name="addon[0]" value="0" />
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">

    {foreach from=$addons item=a key=k}
    <tr><td width="20"><input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onclick="simulateCart('#cart3');"/></td>
        <td>
            <strong>{$a.name}</strong>{if $a.description!=''} - {$a.description}{/if}
        </td>
        <td  align="right">
            {if $a.paytype=='Free'}
            {$lang.free}
            <input type="hidden" name="addon_cycles[{$k}]" value="free"/>
            {elseif $a.paytype=='Once'}
            <input type="hidden" name="addon_cycles[{$k}]" value="once"/>
            {$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}
            {else}
            <select name="addon_cycles[{$k}]"   onchange="if($('input[name=\'addon[{$k}]\']').is(':checked'))simulateCart('#cart3');">
	 {if $a.h!=0}<option value="h" {if (!$contents[3][$k] && $cycle=='h') || $contents[3][$k].recurring=='h'} selected="selected"{/if}>{$a.h|price:$currency} {$lang.h}{if $a.h_setup!=0} + {$a.h_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.d!=0}<option value="d" {if (!$contents[3][$k] && $cycle=='d') || $contents[3][$k].recurring=='d'} selected="selected"{/if}>{$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.w!=0}<option value="w" {if (!$contents[3][$k] && $cycle=='w') || $contents[3][$k].recurring=='w'}  selected="selected"{/if}>{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.m!=0}<option value="m" {if (!$contents[3][$k] && $cycle=='m') || $contents[3][$k].recurring=='m'}  selected="selected"{/if}>{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.q!=0}<option value="q" {if (!$contents[3][$k] && $cycle=='q') || $contents[3][$k].recurring=='q'} selected="selected"{/if}>{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.s!=0}<option value="s" {if (!$contents[3][$k] && $cycle=='s') || $contents[3][$k].recurring=='s'} selected="selected"{/if}>{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.a!=0}<option value="a" {if (!$contents[3][$k] && $cycle=='a') || $contents[3][$k].recurring=='a'} selected="selected"{/if}>{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.b!=0}<option value="b" {if (!$contents[3][$k] && $cycle=='b') || $contents[3][$k].recurring=='b'} selected="selected"{/if}>{$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                {if $a.t!=0}<option value="t" {if (!$contents[3][$k] && $cycle=='t') || $contents[3][$k].recurring=='t'} selected="selected"{/if}>{$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
				{if $a.p4!=0}<option value="p4" {if (!$contents[3][$k] && $cycle=='p4') || $contents[3][$k].recurring=='p4'} selected="selected"{/if}>{$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
				{if $a.p5!=0}<option value="p5" {if (!$contents[3][$k] && $cycle=='p5') || $contents[3][$k].recurring=='p5'} selected="selected"{/if}>{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
            </select>
            {/if}
        </td>
    </tr>
    {/foreach}
</table>
{/if}


  <small>{$lang.field_marked_required}</small>
 </div>

</form>

</div>


<div style="width:320px;font-size:14px;" class="right">
<h3 class="modern">{$lang.ordersummary}</h3>
<div class="newbox1" >
<table cellspacing="0" cellpadding="3" border="0"  width="100%" class="ttable">
  <tbody>
    <tr>
      <th width="55%">{$lang.Description}</th>
      <th width="45%">{$lang.price}</th>
    </tr>
	{if $product}
    <tr >
      <td>{$contents[0].category_name} - <strong>{$contents[0].name}</strong> {if $contents[0].domain}({$contents[0].domain}){/if}<br/>
      </td>
      <td align="center">{if $contents[0].price==0}<strong>{$lang.Free}</strong>
	  {elseif $contents[0].prorata_amount}
	 <strong> {$contents[0].prorata_amount|price:$currency}</strong>
	   ({$lang.prorata} {$contents[0].prorata_date|dateformat:$date_format})
	  {else}<strong>{$contents[0].price|price:$currency}</strong>{/if}{if $contents[0].setup!=0} + {$contents[0].setup|price:$currency} {$lang.setupfee}{/if}</td>
    </tr>
	 {/if}
	{if $cart_contents[1]}
			{foreach from=$cart_contents[1] item=cstom2}
                        {foreach from=$cstom2 item=cstom}
			{if $cstom.total>0}
			<tr >
      <td valign="top" class="blighter fs11" style="padding-left:15px">{$cstom.fullname}  {if $cstom.qty>=1}x {$cstom.qty}{/if}<br/>
      </td>	 
      <td align="center" class="blighter fs11"><strong>{if $cstom.price==0}{$lang.Free}{elseif $cstom.prorata_amount}{$cstom.prorata_amount|price:$currency}{else}{$cstom.price|price:$currency}{/if} 
	  {if $cstom.setup!=0} + {$cstom.setup|price:$currency} {$lang.setupfee}{/if}</strong></td>
    </tr>
			
				
			{/if}
			{/foreach}{/foreach}
			
		{/if}

    
  {if $contents[3]}
  
  {foreach from=$contents[3] item=addon}
  <tr >
    <td>{$lang.addon} <strong>{$addon.name}</strong></td>
    <td align="center">{if $addon.price==0}<strong>{$lang.Free}</strong>{elseif $addon.prorata_amount}<strong>{$addon.prorata_amount|price:$currency}</strong> ({$lang.prorata} {$addon.prorata_date|dateformat:$date_format}){else}<strong>{$addon.price|price:$currency}</strong>{/if}{if $addon.setup!=0} + {$addon.setup|price:$currency} {$lang.setupfee}{/if}</td>
  </tr>
  {/foreach}
  {/if}	{if $product}
 
  {/if}
 {if $contents[2] && $contents[2][0].action!='own'}
  {foreach from=$contents[2] item=domenka key=kk}
 
  <tr >
    <td><strong>{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{/if}</strong> - {$domenka.name} - {$domenka.period} {$lang.years}
	<br/>
      {if $domenka.dns}&raquo; {$lang.dnsmanage} (+ {$domenka.dns|price:$currency})<br/>{/if}
	  {if $domenka.idp}&raquo; {$lang.idprotect}(+ {$domenka.idp|price:$currency})<br/>{/if}
		{if $domenka.email}&raquo; {$lang.emailfwd} (+ {$domenka.email|price:$currency})<br/>{/if}
    </td>
    <td align="center"><strong>{$domenka.price|price:$currency}</strong></td>
  </tr>
  
  
  {/foreach}
  {/if}
  {if $contents[4]}{foreach from=$contents[4] item=subprod}
    <tr >
      <td>{$subprod.category_name} - <strong>{$subprod.name}</strong></td>
      <td align="center">{if $subprod.price==0}<strong>{$lang.Free}</strong>
	  {elseif $subprod.prorata_amount}
	 <strong> {$subprod.prorata_amount|price:$currency}</strong>
	   ({$lang.prorata} {$subprod.prorata_date|dateformat:$date_format})
	  {else}<strong>{$subprod.price|price:$currency}</strong>{/if}{if $subprod.setup!=0} + {$subprod.setup|price:$currency} {$lang.setupfee}{/if}</td>
    </tr>
    {/foreach}{/if}

  
  {if $tax}
 
  
  {if $subtotal.coupon}  
   <tr >
    <td align="right">{$lang.discount}</td>
    <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
  </tr>  
  {/if}
  
  {if $tax.tax1 && $tax.taxed1!=0}
  <tr >
    <td align="right">{$tax.tax1name} @ {$tax.tax1}%  </td>
    <td align="center">{$tax.taxed1|price:$currency}</td>
  </tr>
  {/if}
  
  {if $tax.tax2  && $tax.taxed2!=0}
  <tr >
    <td align="right">{$tax.tax2name} @ {$tax.tax2}%  </td>
    <td align="center">{$tax.taxed2|price:$currency}</td>
  </tr>
  {/if}
  
  {if $tax.credit!=0}
  <tr>
    <td align="right"><strong>{$lang.credit}</strong> </td>
    <td align="center"><strong>{$tax.credit|price:$currency}</strong></td>
  </tr>
  {/if}

  {elseif $credit}
  {if  $credit.credit!=0}
   <tr>
    <td align="right"><strong>{$lang.credit}</strong> </td>
    <td align="center"><strong>{$credit.credit|price:$currency}</strong></td>
  </tr>
  {/if}
   
  {if $subtotal.coupon}  
   <tr >
    <td align="right">{$lang.discount}</td>
    <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
  </tr>  
  {/if}
  
  
  
  
  
  
  {else}
  
   
  {if $subtotal.coupon}  
   <tr >
    <td align="right">{$lang.discount}</td>
    <td align="center"><strong>- {$subtotal.discount|price:$currency}</strong></td>
  </tr>  
  {/if}
  
  
 
  
 
  {/if}
  
  {if !empty($tax.recurring)}
  <tr >
    <td align="right">{$lang.total_recurring}</td>
    <td align="center"> {foreach from=$tax.recurring item=rec key=k}
      {$rec|price:$currency} {$lang.$k}<br/>
      {/foreach} </td>
  </tr>
 
  {elseif !empty($subtotal.recurring)}
  <tr >
    <td align="right">{$lang.total_recurring}</td>
    <td align="center"> {foreach from=$subtotal.recurring item=rec key=k}
      {$rec|price:$currency} {$lang.$k}<br/>
      {/foreach} </td>
  </tr>
  {/if}
  
 <tr >
    <td align="right">{$lang.total_today}</td>
    <td align="center"> <strong>
	{if $tax}
			{$tax.total|price:$currency}
		{elseif $credit}
			{$credit.total|price:$currency}
		{else}
			{$subtotal.total|price:$currency}
		{/if}</strong></td> </tr>
		 

		
  <tr>
  	<td colspan="2" align="right">
	{if $subtotal.coupon}
		
		{else}
		<div style="text-align:right"><a href="#" onclick="$(this).hide();$('#promocode').show();return false;"><strong>{$lang.usecoupon}</strong></a></div>
		<div id="promocode" style="display:none;text-align:right">
			<form action="" method="post" id="promoform" onsubmit="{if $step!=4}return applyCoupon();{else}{/if}">
			
			<input type="hidden" name="addcoupon" value="true" />
			{$lang.code}: <input type="text" class="styled" name="promocode"/> <input type="submit" value="&raquo;" style="font-weight:bold" class="padded btn"/></form>
 		</div>
		
		{/if}
	</td>
	
  </tr>
		
  
  
  
  </tbody>
</table>
</div>
<div {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
<h3 class="modern">{$lang.choose_payment}</h3>
 <div class="newbox1">
  	
	
	

  
  {if $gateways}
<form action="" method="post" id="gatewaylist" onchange="simulateCart('#gatewaylist');">
{foreach from=$gateways item=module key=mid name=payloop}
  	<div class="left" style="padding:2px"><input type="radio" name="gateway"  onclick="$('#gatewayform').show();ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id='+$(this).val(), '', '#gatewayform',true)" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module} </div>
  {/foreach}</form>
  <div class="clear"></div>
 {/if}
</div></div>
</div>
<div class="clear"></div>






