 {if $product.id=='new'}
<center>
    <strong>{$lang.save_product_first}</strong>
</center>
{else}
<table width="100%" {if !$dns_management_enable}style="display:none"{/if} id="dns_management_box" cellspacing="0" cellpadding="6">
	<tr>
		<td style="width:165px; text-align: right; font-weight: bold">DNS Management options</td>
		<td>
			<input id="dns_management_enable" type="checkbox" value="1" {if $dns_management_enable}checked="checked"{/if} onclick="{literal}if(!this.checked){$('#mettered_blank_state').show();$('#mettered_container').hide();}{/literal}" name="dns_management_enable" value="0" />
			<label for="dns_management_enable">Enable</label>
		</td>
	</tr>
	<tr>
		<td></td>
		<td>Offer following DNS Management options:</td>
	</tr>
	<tr>
		<td></td>
		<td id="mett_priceoptions">	
		{if $dns_management_packages}
			<select size="8" class="multiopt" style="width:100%" multiple="multiple" name="dns_management_packages[]">
			{foreach from=$dns_management_packages item=package}
				<option>{$package.category_name} - {$package.name}</option>
			{/foreach}
			</select>
		{else}
			<div style="padding:10px 0px;" class="blank_state_smaller blank_domains">
				<div class="blank_info">
					<h3>You dont have any PowerDNS packages set-up yet.</h3>
					<div class="clear"></div>
					<br>
					<a target="_blank" class="new_control" href="?cmd=services&amp;action=addcategory"><span class="addsth"><strong>Create new PowerDNS orderpage</strong></span></a>
					<div class="clear"></div>
				</div>
			</div>
		{/if}
		</td>
	</tr>
</table>
<div {if $dns_management_enable}style="display:none"{/if} id="dns_management_blank" class="blank_state_smaller blank_domains">
    <div class="blank_info">
        <h3>You can offer DNS Management for free or as paid option</h3>
        <div class="clear"></div>
        <br>
        <a onclick="$('#dns_management_box').show(); $('#dns_management_blank').hide(); $('#dns_management_enable').attr('checked',true); return false" class="new_control" href="#"><span class="addsth"><strong>Enable DNS Management</strong></span></a>
        <div class="clear"></div>
    </div>
</div>
{/if}