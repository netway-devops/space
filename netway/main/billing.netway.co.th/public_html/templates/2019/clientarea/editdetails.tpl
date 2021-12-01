{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clientarea/editdetails.tpl.php');
{/php}

<section class="section-account-header">
    <h1>{$lang.accountdetails}</h1>
</section>

{include file="clientarea/top_nav.tpl" nav_type="details"}

<section class="section-account">
    <form action='' method='post' enctype="multipart/form-data" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], [disabled], :hidden" >
        <input type="hidden" name="make" value="details" />
        {securitytoken}
        <div class="table-responsive table-borders table-radius overflow-unset">
            <table class="table stackable overflow-unset">
                <tbody>
                {foreach from=$fields item=field name=floop key=k}
                    {if $field.field_type=='Password'}{continue}{/if}
                    <tr {if $field.type=='Company' && $fields.type}
                            class="iscomp {if $k=='phonenumber' || $field.field_type=='Phonenumber'}overflow-unset{/if}" style="{if !$client.company || $client.type=='Private'}display:none{/if}"
                        {elseif $field.type=='Private' && $fields.type}
                            class="ispr {if $k=='phonenumber' || $field.field_type=='Phonenumber'}overflow-unset{/if}" style="{if $client.company=='1'}display:none{/if}"
                        {/if}>
                        <td class="w-25">
                            {if $k=='type'}
                                {$lang.clacctype}
                            {elseif $field.options & 1}
                                {if $lang[$k]}
                                    {$lang[$k]}
                                {else}
                                    {$field.name}
                                {/if}
                            {else}
                                {$field.name}
                            {/if}
                            {if $field.options & 2}
                                *
                            {/if}
                        </td>
                        <td>
                            {if $k=='type'}
                            {if !($field.options & 8)}
                                {if $client.company=='0'}{$lang.Private}{/if}
                                {if $client.company=='1'}{$lang.Company}{/if}
                            {else}
                                <select class="form-control" name="type" onchange="{literal}if ($(this).val() == 'Private') {
                                                    $('.iscomp').hide();
                                                    $('.ispr').show();
                                                } else {
                                                    $('.ispr').hide();
                                                    $('.iscomp').show();
                                                }{/literal}" {parsley data=$field value=$client[$k]}>
                                    <option value="Private" {if $client.company=='0'}selected="selected"{/if}>{$lang.Private}</option>
                                    <option value="Company" {if $client.company=='1'}selected="selected"{/if}>{$lang.Company}</option>
                                </select>
                            {/if}
                            {elseif $k=='country'}
                                {if !($field.options & 8)}
                                    {foreach from=$countries key=k item=v}
                                        {if $k==$client.country}
                                            {$v}
                                        {/if}
                                    {/foreach}
                                {else}
                                    <select name="country" class="form-control"  {parsley data=$field value=$client[$k]}>
                                    {foreach from=$countries key=k item=v}
                                        <option value="{$k}" {if $k==$client.country  || (!$client.country && $k==$defaultCountry)} selected="selected"{/if}>{$v}</option>
                                    {/foreach}
                                {/if}
                                </select>
                            {else}
                                {if !($field.options & 8)}
                                    {if $field.field_type=='Password'}
                                    {elseif $field.field_type=='Check'}
                                        {foreach from=$field.default_value item=fa}
                                            {if in_array($fa,$client[$k])}
                                                {$fa}<br/>
                                            {/if}
                                        {/foreach}
                                    {elseif $field.field_type=='File'}
                                        {if $client[$k]}
                                            <a href="{$ca_url}root&amp;action=download&amp;type=downloads&amp;id={$client[$k]}" target="_blank">
                                                <i class="material-icons icon-info-color mr-3">cloud_download</i>
                                                <span class="text-small">{$lang.download}</span>
                                            </a>
                                        {else} - {/if}
                                    {elseif $field.field_type == 'Contact'}
                                        {foreach from=$field.default_value item=fa key=id}
                                            {if $client[$k]==$id}
                                                {$fa} <input type="hidden" value="{$client[$k]}" name="{$k}"/>
                                            {/if}
                                        {/foreach}
                                    {else}
                                        {$client[$k]} <input type="hidden" value="{$client[$k]}" name="{$k}"/>
                                    {/if}
                                {else}
                                    {if $field.field_type=='Input' || $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}
                                        <input type="text" { parsley data=$field value=$client[$k] } value="{$client[$k]}" name="{$k}" class="form-control" id="field_{$k}" data-initial-country="{if $client.country|strlen == 2}{$client.country}{else}{$default_country}{/if}" {if $field.options & 2}required{/if}/>
                                        {if $k=='phonenumber' || $field.field_type=='Phonenumber'}<script>initPhoneNumberField($('#field_{$k}'));</script>{/if}
                                    {elseif $field.field_type=='Password'}
                                    {elseif $field.field_type=='Select'}
                                        <select name="{$k}" class="form-control">
                                            {foreach from=$field.default_value item=fa}
                                                <option {if $client[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                                            {/foreach}
                                        </select>
                                    {elseif $field.field_type=='Check'}
                                        {foreach from=$field.default_value item=fa}
                                            <input type="checkbox" name="{$k}[{$fa|escape}]" value="1" {if in_array($fa,$client[$k])}checked="checked"{/if} />
                                            {$fa}<br />
                                        {/foreach}
                                    {elseif $field.field_type=='File'}
                                        <div>
                                            <div class="d-flex flex-row align-items-center">
                                                <input type="file" name="{$k}" />
                                                <small class="form-text text-muted">{$field.expression|string_format:$lang.allowedext}</small>
                                            </div>
                                        </div>
                                    {elseif $field.field_type == 'Contact'}
                                        <select name="{$k}" class="form-control">
                                            {foreach from=$field.default_value item=fa key=id}
                                                <option value="{$id}" {if $client[$k]==$id}selected="selected"{/if}>{$fa}</option>
                                            {/foreach}
                                        </select>
                                    {/if}
                                {/if}
                            {/if}
                            {if $field.description}
                                <div class="mt-2 text-small text-muted">{$field.description|htmlspecialchars}</div>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>

        <div class="d-flex flex-row justify-content-center align-items-center">
            <button type="submit" class="btn btn-primary btn-lg btn-long my-4">{$lang.savechanges}</button>
        </div>
    </form>
</section>

{literal}
<script>
      $(function () {
          $('select[name="type"],input[type="text"],select[name="country"]').trigger('change');
        })
</script>
{/literal}