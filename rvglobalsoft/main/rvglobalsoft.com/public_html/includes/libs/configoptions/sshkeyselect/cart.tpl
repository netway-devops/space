{foreach from=$cf.items item=cit}
{assign var="checked" value=$contents[1][$cf.id][$cit.id].val}
<br>
{if !$cf.client_id}
    <label>{$lang.use_current_key_login}
        <a href="?cmd=login&redirect={'?cmd=cart&step=3'|escape:'url'}">{$lang.log_in}</a>
    </label>
    <br>
{/if}
{if $cf.ssh_keys}
    {foreach from=$cf.ssh_keys item=key}
        <input class="new_ssh_key custom_field custom_field_{$cf.id}" type="checkbox" value="{$key.id}" style="margin: 7px 3px 7px 0px;"
               name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}][]"
               data-field="{$cf.id}"  {foreach from=$checked item=check}{if $check == $key.id}checked="checked"{/if}{/foreach}>
        <span style="margin-right: 5px;">{$key.name}</span>
    {/foreach}
    <br>
{/if}
    <input class="new_ssh_key custom_field custom_field_{$cf.id} new_key" type="checkbox" value="new" style="margin: 7px 0;" name="custom[{$cf.id}][{$cit.id}][]"
           data-field="{$cf.id}" {foreach from=$checked item=check}{if $check == 'new'}checked="checked" {assign var='has_key' value="1"}{/if}{/foreach}>
    {$lang.enter_new_key}
<textarea
        name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}][]"
        id="custom_field_{$cf.id}"  class="styled custom_field ssh_key_textarea custom_field_{$cf.id} textarea_{$cf.id}" style="width:99%; height: 150px;"
        placeholder="{$lang.enter_publi_ssh_key}"
        onchange="$(document).trigger('hbcart.changeform', [this]);if (typeof(simulateCart)=='function')simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');">{foreach from=$checked item=check}{if $has_key && !is_numeric($check) && $check !='new'}{$check}{/if}{/foreach}</textarea>
<br/>
{/foreach}
{literal}
<script>
    $('.new_ssh_key').on('change', function () {
        $(document).trigger('hbcart.changeform', [this]);if(typeof (simulateCart)=='function') simulateCart('#cart3');
    });
</script>
{/literal}
{if !$cf.client_id || !$cf.ssh_keys}
    {literal}
        <script>
            $(function () {
                $('.custom_field_{/literal}{$cf.id}{literal}.new_key').prop('checked', true);
            });
        </script>
    {/literal}
{/if}

