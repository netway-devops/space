{foreach from=$cf.items item=cit}
<tr class="field-upgrade-row field-qty">
    <td class="upgrade-name"><b>{$cf.name}</b></td>
    <td class="upgrade-from">
        <input name="fupgrade[{$cf.id}][new_config_id]"  value="{$cit.id}" type="hidden" />
        <b>{$cf.qty}</b>
        {if $cit.name}{$cit.name}{/if}
        {if $cit._price!=0} ({$cit._price|price:$currency:1:1:$currency.code})
        {elseif $cit.price>0} ({$cit.price|price:$currency:1:1})
        {/if}
    </td>
    <td class="upgrade-to">
        <input name="fupgrade[{$cf.id}][new_qty]"  value="{$cf.qty}"  class="inp styled" size="3" id="custom_field_{$cf.copy_of}" />
        {if $cit.name}{$cit.name}{/if}

        {cartfieldlogic}
        {if $cf.config.conditionals}
            <script type="text/javascript">
                $('#custom_field_{$cf.copy_of}').fieldLogic({literal}{{/literal}
                    type: '{$cf.type}'
                    {literal}}{/literal}, {$cf.config.conditionals|@array_values|@json_encode});
            </script>
        {/if}
    </td>
</tr>
{/foreach}
