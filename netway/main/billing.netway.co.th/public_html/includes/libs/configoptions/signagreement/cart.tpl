<div id="agreement_{$cf.id}">
    {foreach from=$cf.items item=cit name=nit}
        <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]"
               value="0" type="hidden" />
        <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]"
               id="sign_agreement_{$cf.id}"
               value="1" {if $smarty.foreach.nit.first}id="custom_field_{$cf.id}"{/if}
               type="checkbox" {cartformvalue}{if $cfvalue.val == '1'}checked="checked"{/if}
                {if !$clientdata.id && $cfvalue.val == '-1'}disabled="disabled"{/if}
               onchange="$(document).trigger('hbcart.changeform', [this]);"
               onclick="if (typeof (simulateCart) == 'function')
                       simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}')"
               class="pconfig_ styled"/>
        {assign var=agreement_name value=$cf.contracts[$cf.config.contract]}
        {if $cit.name}{$cit.name}{else}{$lang.tos1}{/if}
            <a href="?cmd=contracts&action=sign_agreement&agreement={$cf.id}" target="_blank">{if $agreement_name}{$agreement_name}{else}{$lang.agreement}{/if}</a>{if $cit.price!=0}(
        {if $cit.fee!=0} {$cit.fee|price:$currency} {$lang[$cit.recurring]}{/if}
        {if $cit.setup!=0} {$cit.setup|price:$currency} {$lang.setupfee}{/if}
        ){/if}
        <br/>
    {/foreach}
</div>