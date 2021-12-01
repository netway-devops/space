<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}flexislider/style.css" />
<script type="text/javascript">
{literal}

function simulateCart(forms) {
	$('#cart_summary').addLoader();
	ajax_update('?cmd=cart&do=2&'+$(forms).serialize(),{'simulate':'1'},'#cart_summary');
}
    function applyCoupon() {
        $('#promoform input[name=step]').remove();
	var f = $('#promoform').serialize();
	$('#cart_summary').addLoader();
	ajax_update('?cmd=cart&do=2&addcoupon=true&'+f,{},'#cart_summary');
	return false;
}
function removeCoupon() {

$('#cart_summary').addLoader();
	ajax_update('?cmd=cart&do=2&removecoupon=true',{},'#cart_summary');
	return false;
}
    function changeCycle(forms) {
	$(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
	return true;
}
{/literal}
 </script>

<div class="zone-all step-n">


	<div>
		<div class="zone2" >
                 



			<div class="zone-left">
<form action="" method="post" id="cart3">
                    <input name='action' value='addconfig' type='hidden' />
                    <div class="kol1" style="padding-right:20px;">
			

                       <h3 class="slider-title">{$cart_contents[0].category_name} -{$cart_contents[0].name}</h3>
                      
{if $config ||  $product.hostname || $product.extra.enableos=='1' || $custom}



                                <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled" style="margin-bottom:20px;">
<colgroup class="firstcol"></colgroup>
<colgroup class="alternatecol"></colgroup>
  {if $cart_contents[0].customdata}  {foreach from=$cart_contents[0].customdata item=slider}
<tr>
	<td class="pb10" width="175"><strong>{$slider.name}:</strong> </td>
	<td class="pb10">{$slider.value} {$slider.unit}</td>
</tr>

                  
                       {/foreach}
                       {/if}


{if $product.hostname}
<tr>
	<td class="pb10" width="175"><strong>{$lang.hostname}</strong> *</td>
	<td class="pb10"><input name="domain" value="{$item.domain}" class="styled" size="50" style="width:96%"/></td>
</tr>


{if $product.extra.enableos=='1' && !empty($product.extra.os)}
<tr>
	<td class="pb10"><strong>{$lang.ostemplate}</strong> *</td>
	<td class="pb10"><div class="input"><div><select name="ostemplate" class="styled" style="width:99%" >
		{foreach from=$product.extra.os item=os}
		<option value="{$os.id}"  {if $item.ostemplate==$os.id}selected="selected"{/if}>{$os.name}</option>
		{/foreach}
	</select></div></div></td>

</tr>
{/if}
{/if}

{if $custom} <input type="hidden" name="custom[-1]" value="dummy" />
	{foreach from=$custom item=cf}
	{if $cf.items}
	<tr>
		<td  class="">
			<label for="custom[{$cf.id}]" class="styled">{$cf.name} </label>
                        </td><td>
			{if $cf.type=='select'}
				<select name="custom[{$cf.id}]" style="width:99%"  onchange="simulateCart('#cart3');">
					{foreach from=$cf.items item=cit}
						<option value="{$cit.id}">{$cit.name} {if $cit.price!=0}+ {$cit.price|price:$currency}{/if}</option>
					{/foreach}
				</select>




			{elseif $cf.type=='qty'}

				<input name="custom[{$cf.id}]" class="styled" size="2" onkeyup="simulateCart('#cart3');" value="0"/>
				  {foreach from=$cf.items item=cit} x {$cit.name}  {if $cit.price!=0}({$cit.price|price:$currency}){/if}{/foreach}
			{elseif $cf.type=='check'}


			 {foreach from=$cf.items item=cit} <input name="custom[{$cf.id}]"  value="{$cit.id}" type="checkbox" onchange="simulateCart('#cart3');" /> {$cit.name}  {if $cit.price!=0}({$cit.price|price:$currency}){/if}{/foreach}

			{/if}
		</td>
	</tr>
	{/if}
	{/foreach}

{/if}

{if $config}
{foreach from=$config item=c}
        {'styled'|draw_config:$c}
    {/foreach}
	{/if}
	</table>


{/if}


{if $addons}

<table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
<colgroup class="firstcol"></colgroup>
<colgroup class="alternatecol"></colgroup>
<colgroup class="firstcol"></colgroup>

{foreach from=$addons item=a key=k}
<tr {if $selected_addons.$k}style="display:none"{/if} id="tr_{$k}"><td colspan="3" class="green-link" ><a href="#" onclick="$('#tr_{$k}').hide();$('#trr_{$k}').show().find('input[type=checkbox]').click();return false;">{$lang.add} {$a.name}</a></td></tr>
<tr {if $selected_addons.$k}{else}style="display:none"{/if} id="trr_{$k}"><td width="20" style="padding-left:0px"><input name="addon[{$k}]" type="checkbox" value="1" {if $selected_addons.$k}checked="checked"{/if}  onchange="simulateCart('#cart3');"/></td>
<td>
<strong>{$a.name}</strong>
</td>
<td>
{if $a.paytype=='Free'}
{$lang.free}
<input type="hidden" name="addon_cycles[{$k}]" value="free"/>
{elseif $a.paytype=='Once'}
<input type="hidden" name="addon_cycles[{$k}]" value="once"/>
{$a.m|price:$currency} {$lang.once} {if $a.m_setup!=0}/ {$a.m_setup|price:$currency} {$lang.setupfee}{/if}
{else}
<select name="addon_cycles[{$k}]"   onchange="if($('input[name=\'addon[{$k}]\']').is(':checked'))simulateCart('#cart3');">
	 {if $a.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$a.d|price:$currency} {$lang.d}{if $a.d_setup!=0} + {$a.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $a.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$a.w|price:$currency} {$lang.w}{if $a.w_setup!=0} + {$a.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $a.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$a.m|price:$currency} {$lang.m}{if $a.m_setup!=0} + {$a.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $a.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$a.q|price:$currency} {$lang.q}{if $a.q_setup!=0} + {$a.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $a.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$a.s|price:$currency} {$lang.s}{if $a.s_setup!=0} + {$a.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $a.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$a.a|price:$currency} {$lang.a}{if $a.a_setup!=0} + {$a.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $a.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$a.b|price:$currency} {$lang.b}{if $a.b_setup!=0} + {$a.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
     {if $a.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$a.t|price:$currency} {$lang.t}{if $a.t_setup!=0} + {$a.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
	 {if $a.p4!=0}<option value="p4" {if $cycle=='p4'} selected="selected"{/if}>{$a.p4|price:$currency} {$lang.p4}{if $a.p4_setup!=0} + {$a.p4_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
	 {if $a.p4!=0}<option value="p5" {if $cycle=='p5'} selected="selected"{/if}>{$a.p5|price:$currency} {$lang.p5}{if $a.p5_setup!=0} + {$a.p5_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
</select>
{/if}
</td>
</tr>
{/foreach}
</table>



{/if}



		</div>
                    </form>
			</div>
			<div class="zone-right">
                            <h3 class="slider-title">{$lang.ordersummary}</h3>
                        <div id="cart_summary">
                        {include file='ajax.cart.summary.tpl'}
                            </div>
                        
                        <a href="#"  onclick="$('#cart3').submit();return false" class="green-button"><span>{$lang.continue}</span></a>
                          <div class="clear"></div>
			</div>

		</div>
	  </div>
</div>


