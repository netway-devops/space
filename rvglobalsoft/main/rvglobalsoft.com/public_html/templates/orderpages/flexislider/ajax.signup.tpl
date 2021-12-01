<table border="0" cellpadding="0" cellspacing="3" width="100%" class="dosignuptable">

<tbody>

<tr>
<td  >{$lang.firstname}</td><td><div class="input" style="width:295px"><div><input class="styled" type="text" value="{$submit.firstname}" style="width: 95%;" name="firstname" /></div></div></td>

</tr>

<tr class="even">
<td >{$lang.lastname}</td><td><div class="input" style="width:295px"><div><input class="styled" type="text" value="{$submit.lastname}" style="width: 95%;" name="lastname" /></div></div></td>

</tr>
<tr>
<td >{$lang.phone}</td><td><div class="input" style="width:295px"><div><input class="styled" type="text" value="{$submit.phonenumber}" style="width: 95%;" name="phonenumber" /></div></div></td></tr>

<tr>

<td  >{$lang.address}</td><td><div class="input" style="width:295px"><div><input class="styled" type="text" value="{$submit.address1}" style="width: 95%;" name="address1" /></div></div>
<input type="hidden" name="address2" value=""/></td>
</tr>



<tr>

<td >{$lang.city}</td><td><div class="input" style="width:295px"><div><input class="styled" type="text" value="{$submit.city}" style="width: 95%;" name="city" /></div></div></td>
</tr>

<tr class="even">
<td >{$lang.state}</td><td><div class="input" style="width:295px"><div><input class="styled" type="text" value="{$submit.state}" style="width: 95%;" name="state" /></div></div></td>
</tr>

<tr>

<td >{$lang.postcode}</td><td><div class="input" style="width:295px"><div><input class="styled" type="text" value="{$submit.postcode}" size="15" name="postcode" /></div></div></td>
</tr>

<tr class="even">

<td >{$lang.country}</td><td><div class="input" style="width:295px"><div>
<select name="country" style="width: 95%;">
	{foreach from=$countries key=k item=v}
		<option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>

	{/foreach}
</select></div></div></td>
</tr>


<tr class="even">
<td >{$lang.email}</td><td><div class="input" style="width:295px"><div><input class="styled" type="text" value="{$submit.email}" style="width: 95%;" name="email" /></div></div></td>

</tr>

<tr >
<td >{$lang.password}</td><td><div class="input" ><div><input type="password" class="styled" size="20" name="password" /></div></div></td>

</tr>

<tr class="even"><td >{$lang.confirmpassword}</td><td><div class="input"><div><input type="password" class="styled" size="20" name="password2" /></div></div></td>
</tr>

<tr><td style="border:none;">{$lang.clacctype}</td><td  style="border:none;"><div class="input" style="width:295px"><div>
				<select  name="type" style="width: 95%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
					<option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
					<option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
				</select></div></div>
				</td></tr>
				
			



<tr style="{if !$submit.type || $submit.type=='Private'}display:none{/if}" class="iscomp">
<td style="border:none;">{$lang.company}</td><td  style="border:none;"><div class="input" style="width:295px"><div><input class="styled" type="text" value="{$submit.companyname}" style="width: 95%;" name="companyname" /></div></div></td>

{if $extrafields}
				 {foreach from=$extrafields item=field name=f}
				 	
						<tr {if $field.type=='Company'}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
						{elseif $field.type=='Private'}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" {/if}>
						<td  style="border:none;">{$field.name} {if $field.required=='1'}*{/if}</td>
						
						<td  style="border:none;">
						{if $field.field_type=='Input'}
						<div class="input" style="width:295px"><div><input  value="{$submit[$field.code]}" name="{$field.code}" style="width: 95%;" class="styled" /></div></div>
						{elseif $field.field_type=='Check'}
							{foreach from=$field.default_value item=fa}
								<input type="checkbox" name="{$field.code}[{$fa}]" value="1" />{$fa}<br />
							{/foreach}
						{else}
							<div class="input" style="width:295px"><div><select name="{$field.code}" style="width: 95%;">
							{foreach from=$field.default_value item=fa}
								<option {if $submit[$field.code]==$fa}selected="selected"{/if}>{$fa}</option>
							{/foreach}
							</select></div></div>
						{/if}
						</td></tr>
					
				 {/foreach}
				 {/if}




</table>





