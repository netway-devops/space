{if !$login.id}
    <input type="hidden" value="0"  name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}]" id="custom_field_{$cf.id}" />
    <a href="?cmd=login&redirect={$smarty.server.REQUEST_URI|trim:'/'|escape:'url'}">{$lang.loginrelatedservice}</a>
{else}
    {if $cf.config.select_one && $cf.config.only_one}
        {foreach from=$cf.items item=cit}
            <input type="hidden" name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}]" value="{$cit.id}">
            <label>{$cit.name}</label>
            {break}
        {/foreach}
    {else}
        <select name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}]"
                style="width:99%"  class="pconfig_ styled custom_field_{$cf.id}"
                id="custom_field_{$cf.id}"
                onchange="if(typeof (simulateCart)=='function') simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}')">
            {foreach from=$cf.items item=cit}
                <option value="{$cit.id}" {if $contents[1][$cf.id][$cit.id]}selected="selected"{/if}>{$cit.name}</option>
            {/foreach}
        </select>
    {/if}
{/if}
