<form method="post" action="{$system_url}" enctype="multipart/form-data" name="signupform">
    <input type="hidden" name="cmd" value="signup"/>

    {foreach from=$c.fields item=field name=floop key=k}
        {if  $k=='captcha'}{continue}{/if}

        <div  {if $field.type=='Company' && $c.fields.type}class="iscomp" style="{if !$submit.type}display:none{/if}"
            {elseif $field.type=='Private' && $c.fields.type}class="ispr"  {/if}>
             <label for="field_{$k}" >{if $k=='type'}{$lang.clacctype}
                    {elseif $field.options & 1}{if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                    {else}{$field.name}{/if}
                    {if $field.options & 2}*{/if}
                    {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}</label>
                {if $k=='type'}
                    <select  id="field_{$k}" name="type" style="width: 90%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
                        <option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                        <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
                    </select>
                {elseif $k=='country'}
                    <select name="country" style="width: 90%;" id="field_{$k}" class="chzn-select">
                        {foreach from=$c.countries key=k item=v}
                            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>
                        {/foreach}
                    </select>
                {else}
                    {if $field.field_type=='Input' || $field.field_type=='Encrypted' }

                        <input type="text" placeholder="{$field.placeholder}" value="" style="width: 90%;" name="{$k}" class="" id="field_{$k}" {if $field.options & 2}required{/if}/>
                    {elseif $field.field_type=='Password'}
                        <input type="password" autocomplete="off" value="" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                    {elseif $field.field_type=='Select'}
                        <select name="{$k}" style="width: 90%;" id="field_{$k}" >
                            {foreach from=$field.default_value item=fa}
                                <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                            {/foreach}
                        </select>
                    {elseif $field.field_type=='Check'}
                        {foreach from=$field.default_value item=fa}
                            <input type="checkbox" name="{$k}[{$fa|escape}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" />{$fa}<br />
                        {/foreach}
                    {elseif $field.field_type=='File'}
                        <input type="file" name="{$k}" />
                        <small class="">{$field.expression|string_format:$lang.allowedext}</small>
                    {/if}
                {/if}

        </div>
    {/foreach}

    <input type="submit"  value="Sign Up">

</form>