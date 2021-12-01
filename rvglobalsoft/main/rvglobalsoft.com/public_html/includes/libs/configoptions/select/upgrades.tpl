<tr class="field-upgrade-row field-select">
    <td class="upgrade-name"><b>{$cf.name}</b>
    </td>
    <td class="upgrade-from">
        <input name="fupgrade[{$cf.id}][new_qty]"  value="{$cf.qty}" type="hidden"   />
        {foreach from=$cf.items item=cit}
            {if isset($cf.data[$cit.id])}{$cit.name} {if $cit.price!=0}(
                {if $cit.fee!=0} {$cit.fee|price:$currency:1:1} {$lang[$service.billingcycle]}{/if}
            {if $cit.setup!=0} {$cit.setup|price:$currency:1:1} {$lang.setupfee}{/if}
            ){/if}{break}{/if}
        {/foreach}
    </td>
    <td class="upgrade-to">
        <select name="fupgrade[{$cf.id}][new_config_id]" id="custom_field_{$cf.copy_of}" >
            {foreach from=$cf.items item=cit} {if $cit.options & 1}{continue}{/if}
                <option value="{$cit.id}" {if isset($cf.data[$cit.id])}selected="selected"{/if}>{$cit.name} {if $cit.price!=0}(
                {if $cit.fee!=0} {$cit.fee|price:$currency:1:1} {$lang[$service.billingcycle]}{/if}
                {if $cit.setup!=0} {$cit.setup|price:$currency:1:1} {$lang.setupfee}{/if}
                ){/if}</option>
            {/foreach}
        </select>
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