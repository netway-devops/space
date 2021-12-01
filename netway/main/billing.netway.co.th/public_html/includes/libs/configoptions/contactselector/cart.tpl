{foreach from=$cf.items item=cit}
    {cartformvalue}
    <div class="contact-selector">
        <select name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]"
                class="form-control custom_field_{$cf.copy_of}"
                id="custom_field_{$cf.copy_of}"
                onchange="if(typeof (simulateCart)=='function') simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}')">
            <option value="main" {if $cfvalue.val == 'main'}selected="selected"{/if}>{$lang.mainprofiledetails}</option>
            {foreach from=$cf.contacts item=cont}
                <option value="{$cont.id}" {if $cfvalue.val == $cont.id}selected="selected"{/if}>{$cont.firstname} {$cont.lastname}</option>
            {/foreach}
        </select>
    </div>
{/foreach}