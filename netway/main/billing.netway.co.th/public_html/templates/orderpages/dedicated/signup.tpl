
{if $logged!="1"}
<ul class="u2">
    <li class="d-label"><label>{$lang.firstname}</label></li><li class="input"><input type="text" value="{$submit.firstname}"  name="firstname" /> </li>
    <li class="d-label"><label>{$lang.lastname}</label></li><li class="input"><input type="text" value="{$submit.lastname}"  name="lastname" /> </li>
    <li class="d-label"><label>{$lang.phone}</label></li><li class="input"><input type="text" value="{$submit.phonenumber}"  name="phonenumber" /> </li>
    <li class="d-label"><label>{$lang.email}</label></li><li class="input"><input type="text" value="{$submit.email}"  name="email" /> </li>
    <li class="d-label"><label>{$lang.password}</label></li><li class="input"><input type="password" size="20" name="password" /> </li>
    <li class="d-label"><label>{$lang.confirmpassword}</label></li><li class="input"><input type="password" size="20" name="password2" /> </li>
    <li class="d-label"><label>{$lang.clacctype}</label></li><li class="input">
        <select  name="type"  onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
            <option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
            <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
        </select> </li>
    <li class="d-label"><label>{$lang.address}</label></li><li class="input"><input type="text" value="{$submit.address1}"  name="address1" /> </li>
    <li class="d-label"><label>{$lang.address2}</label></li><li class="input"><input type="text" value="{$submit.address2}"  name="address2" /> </li>
    <li class="d-label"><label>{$lang.city}</label></li><li class="input"><input type="text" value="{$submit.city}"  name="city" /> </li>
    <li class="d-label"><label>{$lang.state}</label></li><li class="input"><input type="text" value="{$submit.state}"  name="state" /> </li>
    <li class="d-label"><label>{$lang.postcode}</label></li><li class="input"><input type="text" value="{$submit.postcode}" size="15" name="postcode" /> </li>

    <li class="d-label"><label>{$lang.country}</label></li><li class="input">
        <select name="country">
	{foreach from=$countries key=k item=v}
            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>

	{/foreach}
        </select> </li>

    <li class="d-label iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"><label>{$lang.company}</label></li><li class="input iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"><input type="text" value="{$submit.companyname}"  name="companyname" />
{if $extrafields}
				 {foreach from=$extrafields item=field name=f}

    <li {if $field.type=='Company'}class="iscomp d-label" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
						{elseif $field.type=='Private'}class="ispr d-label" style="{if $submit.type=='Company'}display:none{/if}"{else}class="d-label"  {/if}><label>
						{$field.name} {if $field.required=='1'}*{/if}</label></li>
    <li {if $field.type=='Company'}class="iscomp input" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
						{elseif $field.type=='Private'}class="ispr input" style="{if $submit.type=='Company'}display:none{/if}" {else}class="input"{/if}>


						{if $field.field_type=='Input' || $field.field_type=='Encrypted' }
        <input  value="{$submit[$field.code]}" name="{$field.code}"   />
						{elseif $field.field_type=='Check'}
							{foreach from=$field.default_value item=fa}
        <input type="checkbox" name="{$field.code}[{$fa}]" value="1" />{$fa}<br />
							{/foreach}
						{else}
        <select name="{$field.code}" >
							{foreach from=$field.default_value item=fa}
            <option {if $submit[$field.code]==$fa}selected="selected"{/if}>{$fa}</option>
							{/foreach}
        </select>
						{/if}
    </li>

				 {/foreach}
				 {/if}

</ul>
{else}
<div class="reg">
<ul>


                <li class="d-label"><label>{$lang.firstname}</label></li><li class="text">{$client.firstname}</li>
		<li class="d-label"><label>{$lang.address}</label></li><li class="text">{$client.address1}</li>



                <li class="d-label"><label>{$lang.lastname}</label></li><li class="text">{$client.lastname}</li>
		<li class="d-label"><label>{$lang.address2}</label></li><li class="text">{$client.address2}</li>


                <li class="d-label"><label>{$lang.phone}</label></li><li class="text">{$client.phonenumber}</li>
				 <li class="d-label"><label>{$lang.city}</label></li><li class="text">{$client.city}</li>


                <li class="d-label"><label>{$lang.postcode}</label></li><li class="text">{$client.postcode}</li>
			 <li class="d-label"><label>{$lang.state}</label></li><li class="text">{$client.state}</li>



                <li class="d-label"><label>{$lang.email}</label></li><li class="text">{$client.email}</li>
				 <li class="d-label"><label>{$lang.country}</label></li><li class="text">{$countries[$client.country]}</li>



		   {if $client.company=='1'}

                <li class="d-label"><label>{$lang.company}</label></li><li class="text">{$client.companyname}</li>


			  {/if}

		  {if $extrafields}
		   {foreach from=$extrafields item=field name=f}
				 	{if ($field.type=='Company' && $client.company=='1') || ($field.type=='Private' && $client.company!='1')}




					<li class="d-label"><label>{$field.name}</label></li><li class="text">
						{if $field.field_type=='Input' || $field.field_type=='Encrypted' }
						{$client[$field.code]}
						{elseif $field.field_type=='Check'}
							{foreach from=$field.default_value item=fa}
								{if in_array($fa,$client[$field.code])}{$fa} {/if}
							{/foreach}
						{else}

							{foreach from=$field.default_value item=fa}
								{if $client[$field.code]==$fa}{$fa} {/if}
							{/foreach}

						{/if}


                                                </li>


						{/if}

				 {/foreach}
		  {/if}


</ul></div>
{/if}

 