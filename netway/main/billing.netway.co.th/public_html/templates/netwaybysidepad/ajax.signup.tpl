{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.signup.tpl.php');
{/php}

{if isset($isDomainContactForm) && $isDomainContactForm}
    {* แยก domain contact ออกไปอีก form จะได้ไม่มั่ว *}
    {include file="`$template_path`ajax.domaincontact.tpl"}
{elseif $useCustomSignupFrom}
    {* เอาออกมา custom เอง hostbill จัดการยากเกิน *}
    {include file="`$template_path`ajax.signup_custom.tpl"}
{else}

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin:15px 0px">
    <tr>
        <td valign="top" width="50%">
            <table cellpadding="0" cellspacing="0" width="100%" class="newchecker">
                <tbody>
                    {foreach from=$fields item=field name=floop key=k}
                        {if $smarty.foreach.floop.iteration > ($smarty.foreach.floop.total/2)}{break}{/if}
                        
						{if $k=='captcha'}{continue}{/if}
						{if $k=='addresstype'}{continue}{/if}
						
                        <tr height="46"  {if $field.type=='Company' && $fields.type}class="iscomp" style="{if $submit.type=='Private'}display:none{/if}"
                            {elseif $field.type=='Private' && $fields.type}class="ispr" style="{if !$submit.type || $submit.type=='Company'}display:none{/if}" {/if}>
                            <td class="{if $smarty.foreach.floop.iteration>0}bord{/if}"> <label for="field_{$k}" >
                                    {if $k=='type'}
                                        {$lang.clacctype}
                                    {elseif $field.options & 1}
                                        {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                    {else}
                                        {$field.name}
                                    {/if}
                                    {if $field.options & 2}*{/if}
                                    {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
                                </label>
                                {if $k=='type'}
                                    <select  id="field_{$k}" name="type" style="width: 90%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
                                        <option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                                        <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
                                    </select>
                                {elseif $k=='country'}
                                    <select name="country" style="width: 90%;" id="field_{$k}" class="chzn-select">
                                        {foreach from=$countries key=k item=v}
                                            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>
                                        {/foreach}
                                    </select>
                                {else}
                                    {if $field.field_type=='Input'}
                                        {if  $k=='captcha'}
                                            <div style="white-space: nowrap;">
                                                <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" /> 
                                                <span style="display: inline-block; width: 65%; white-space: normal;">
                                                    {$lang.typethecharacters}<br />
                                                    <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                                                </span>
                                            </div>
                                        {/if}
                                        <input type="text" value="{$submit[$k]}" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Password'}
                                        <input type="password" value="" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
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
                                    {/if}
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="50%">
            <table cellpadding="0" cellspacing="0" width="100%" class="newchecker">
                <tbody>
                    {foreach from=$fields item=field name=floop key=k}
                        {if $smarty.foreach.floop.iteration <= ($smarty.foreach.floop.total/2)}{continue}{/if}
                        
						{if $k=='captcha'}{continue}{/if}
						{if $k=='addresstype'}{continue}{/if}
						
                        <tr height="46" {if $field.type=='Company' && $fields.type}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
                            {elseif $field.type=='Private' && $fields.type}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" {/if}>
                            <td class=""> 
                                <label for="field_{$k}" >
                                    {if $k=='type'}
                                        {$lang.clacctype}
                                    {elseif $field.options & 1}
                                        {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                    {else}
                                        {$field.name}
                                    {/if}
                                    {if $field.options & 2}*{/if}
                                    {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
                                </label>
                                {if $k=='type'}
                                    <select  id="field_{$k}"  name="type" style="width: 90%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
                                        <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
										<option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                                    </select>
                                {elseif $k=='country'}
                                    <select name="country" style="width: 90%;" id="field_{$k}"  class="chzn-select">
                                        {foreach from=$countries key=k item=v}
                                            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>

                                        {/foreach}
                                    </select>
                                {else}
                                    {if $field.field_type=='Input'}
                                        {if  $k=='captcha'}
                                            <div style="white-space: nowrap;">
                                                <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" /> 
                                                <span style="display: inline-block; width: 65%; white-space: normal;">
                                                    {$lang.typethecharacters}<br />
                                                    <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                                                </span>
                                            </div>
                                        {/if}
                                        <input type="text" value="{$submit[$k]}" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
                                    {elseif $field.field_type=='Password'}
                                        <input type="password" value="" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
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
                                    {/if}
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </td>
    </tr>
	

    <tr>
        <td valign="top" colspan="2">
            <table cellpadding="0" cellspacing="0" width="100%" class="newchecker">
                <tbody>
                {foreach from=$fields item=field name=floop key=k}
                {if $k=='captcha'}
                <tr height="46">
                    <td class="bord">
                    <label for="field_{$k}" >
                        {if $k=='type'}
                            {$lang.clacctype}
                        {elseif $field.options & 1}
                            {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                        {else}
                            {$field.name}
                        {/if}
                        {if $field.options & 2}*{/if}
                        {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
                    </label>
                    
                    <div style="white-space: nowrap;">
                        <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" /> 
                        <span style="display: inline-block; width: 65%; white-space: normal;">
                            {$lang.typethecharacters}<br />
                            <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                        </span>
                    </div>

                    <input type="text" value="{$submit[$k]}" name="{$k}" class="input-small" id="field_{$k}" />

                    </td>
                </tr>
                {/if}
                {/foreach}
                </tbody>
            </table>
        </td>
    </tr>

	
</table>
<script type="text/javascript" src="{$template_dir}js/chosen.min.js"></script>
{literal}
    <script>
        $(document).ready(function(){
            {/literal}{if $cmd=='cart' && $step!=2}{literal}$("#field_country, #state_input, #state_select").change(function(){var e=this;$.post("?cmd=cart&action=regionTax",{country:$("#field_country").val(),state:$("#state_select:visible").length>0?$("#state_select").val():$("#state_input").val()},function(t){if(t==1){$(e).parents("form").append('<input type="hidden" name="autosubmited" value="true" />').submit()}})}){/literal}{/if}{literal}
            $(".chzn-select").chosen();
        });
        function singup_image_reload(){
            var d = new Date();    
            $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
            return false;
        }
    </script>

{/literal}

{/if}


