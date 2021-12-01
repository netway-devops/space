


	<div id="cart_contents" style="">

		<table border="0" cellpadding="0" cellspacing="1" width="100%">
		{if $cart_contents[0]}
		<tr>
			<td colspan="2" class="midtext">
			{$cart_contents[0].category_name} - <strong>{$cart_contents[0].name}</strong>
			</td>
		</tr>

		<tr>
			<td class="smalltext">
			{$lang.setupfee}
			</td>
			<td align="right" class="smalltext">
			{$cart_contents[0].setup|price:$currency}
			</td>
		</tr>

		<tr>
			<td class="smalltext">
			{if $cart_contents[0].price!=0}
			{assign var=tit value=$cart_contents[0].recurring}
			{$lang[$tit]}
			{/if}

			</td>
			<td align="right" class="smalltext">
			{if $cart_contents[0].price!=0}
				{$cart_contents[0].price|price:$currency}
			{else}
				{$lang.Free}
			{/if}

			</td>
		</tr>
		{/if}
		<tr><td class="smalltext" colspan="2">&nbsp;</td></tr>

		{if $cart_contents[1]}
			{foreach from=$cart_contents[1] item=cstom2}
                        {foreach from=$cstom2 item=cstom}
			{if $cstom.total>0}
				<tr><td class="smalltext">{$cstom.sname} {if $cstom.qty>1}x {$cstom.qty}{/if}</td>
				<td align="right" class="smalltext">{$cstom.total|price:$currency}</td></tr>
			{/if}
			{/foreach}{/foreach}
			<tr><td class="smalltext" colspan="2">&nbsp;</td></tr>
		{/if}


		{foreach from=$cart_contents[3] item=addon}
  <tr >
    <td colspan="2"  class="midtext">{$lang.addon} <strong>{$addon.name}</strong></td>
	  </tr>

	 <tr>
			<td class="smalltext">
			{$lang.setupfee}
			</td>
			<td align="right" class="smalltext">
			{$addon.setup|price:$currency}
			</td>
		</tr>

 <tr >
    <td  class="smalltext">
	{if $addon.price!=0}
			{assign var=tit value=$addon.recurring}
			{$lang[$tit]}
			{/if}

	</td>
	<td  align="right" class="smalltext">
	{if $addon.price!=0}
				{$addon.price|price:$currency}
			{else}
				{$lang.Free}
			{/if}
	</td>
  </tr>
  <tr><td class="smalltext" colspan="2">&nbsp;</td></tr>

  {/foreach}


		  {if $cart_contents[2] && $cart_contents[2][0].action!='own' && $cart_contents[2][0].name!='yep'}
		    {foreach from=$cart_contents[2] item=domenka key=kk}
  <tr >
    <td colspan="2"  class="midtext">
	{$lang.domain} <strong>{$domenka.name}</strong>
	</td>
 </tr>
 <tr>

 	<td class="smalltext">{if $domenka.action=='register'}{$lang.domainregister}{elseif $domenka.action=='transfer'}{$lang.domaintransfer}{/if} {$domenka.period} {$lang.years}
	</td>
	<td class="smalltext" align="right">{$domenka.price|price:$currency}
	</td>
	</tr>

	{if $domenka.dns} <tr> <td class="smalltext">{$lang.dnsmanage} </td><td class="smalltext" align="right">{$domenka.dns|price:$currency}</td></tr>{/if}
	  {if $domenka.idp} <tr><td class="smalltext">{$lang.idprotect}</td><td class="smalltext" align="right"> {$domenka.idp|price:$currency}</td></tr>{/if}
		{if $domenka.email} <tr> <td class="smalltext">{$lang.emailfwd} </td><td class="smalltext" align="right">{$domenka.email|price:$currency}</td></tr>{/if}

		{/foreach}
		{/if}
<tr><td class="smalltext" colspan="2">&nbsp;</td></tr>
{if $tax}
  <tr >
    <td align="right" class="smalltext">{$lang.subtotal}</td>
    <td  align="right"  >{$tax.subtotal|price:$currency}</td>
  </tr>

  {if $subtotal.coupon}
   <tr >
    <td align="right" class="smalltext">{$lang.discount}</td>
    <td  align="right" ><strong>- {$subtotal.discount|price:$currency}</strong></td>
  </tr>
  {/if}

  {if $tax.tax1 && $tax.taxed1!=0}
  <tr >
    <td align="right" class="smalltext">{$tax.tax1name} @ {$tax.tax1}%  </td>
    <td  align="right" >{$tax.taxed1|price:$currency}</td>
  </tr>
  {/if}

  {if $tax.tax2  && $tax.taxed2!=0}
  <tr >
    <td align="right" class="smalltext">{$tax.tax2name} @ {$tax.tax2}%  </td>
    <td  align="right" >{$tax.taxed2|price:$currency}</td>
  </tr>
  {/if}

  {if $tax.credit!=0}
  <tr>
    <td align="right" class="smalltext"><strong>{$lang.credit}</strong> </td>
    <td  align="right" ><strong>{$tax.credit|price:$currency}</strong></td>
  </tr>
  {/if}

  {elseif $credit}
  {if  $credit.credit!=0}
   <tr>
    <td align="right" class="smalltext"><strong>{$lang.credit}</strong> </td>
    <td  align="right" ><strong>{$credit.credit|price:$currency}</strong></td>
  </tr>
  {/if}

  {if $subtotal.coupon}
   <tr >
    <td align="right" class="smalltext">{$lang.discount}</td>
    <td  align="right" ><strong>- {$subtotal.discount|price:$currency}</strong></td>
  </tr>
  {/if}





  <tr>
    <td align="right" class="smalltext">{$lang.subtotal}</td>
    <td  align="right" >{$subtotal.total|price:$currency}</td>
  </tr>
  {else}


  {if $subtotal.coupon}
   <tr >
    <td align="right" class="smalltext">{$lang.discount}</td>
    <td  align="right" ><strong>- {$subtotal.discount|price:$currency}</strong></td>
  </tr>
  {/if}



  <tr>
    <td align="right" class="smalltext">{$lang.subtotal}</td>
    <td  align="right" >{$subtotal.total|price:$currency}</td>
  </tr>

  {/if}

  {if !empty($tax.recurring)}
  <tr >
    <td align="right" class="smalltext">{$lang.total_recurring}</td>
    <td  align="right" > {foreach from=$tax.recurring item=rec key=k}
      {$rec|price:$currency} {$lang.$k}<br/>
      {/foreach} </td>
  </tr>

  {elseif !empty($subtotal.recurring)}
  <tr >
    <td align="right" class="smalltext">{$lang.total_recurring}</td>
    <td  align="right" > {foreach from=$subtotal.recurring item=rec key=k}
      {$rec|price:$currency} {$lang.$k}<br/>
      {/foreach} </td>
  </tr>
  {/if}



                <tr><td class="smalltext" colspan="2">&nbsp;</td></tr>
		 {if $subtotal.coupon}
	<tr>
 	<td class="smalltext">{$lang.promotionalcode}: <strong>{$subtotal.coupon}</strong>
	</td>
	<td class="smalltext" align="right">- {$subtotal.discount|price:$currency}
	</td>
	</tr>
	 <tr><td class="smalltext" colspan="2" align="right">
	 <form id="remove" method="post">
<input type="hidden" name="step" value="{$step}" />
<input type="hidden" name="removecoupon" value="true" />
	 </form>
	 <a href="#" onclick="$('#remove').submit();">{$lang.removecoupon}</a></td></tr>
	
		{/if}
         <tr><td class="smalltext" colspan="2" >
             <b>{$lang.choose_payment}</b>
                        <div class="input"><div>
                        <select name="gateway" id="gateway" size="1">
                            {foreach from=$gateways item=module key=mid name=payloop}
  	<option value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}selected="selected"{elseif $smarty.foreach.payloop.first}selected="selected"{/if}>{$module}</option>
  {/foreach}
                        </select>
                    </div></div>
             </td></tr>
		</table>

		{if $subtotal.coupon}

		{else}
		

		{/if}
	</div>


 
    <div style="text-align:right"><strong>{$lang.total_today}</strong></div>
	<div class="cart_total">


	<span style="vertical-align: top; font-size: 20px;">{$currency.sign}</span>
	
		{if $tax}
			<span style="vertical-align: top;line-height:43px">{$tax.total|price:$currency:false}</span>
		{elseif $credit}
			<span style="vertical-align: top;line-height:43px">{$credit.total|price:$currency:false}</span>
		{else}
			<span style="vertical-align: top;line-height:43px">{$subtotal.total|price:$currency:false}</span>
		{/if}
	
	</div>

