<tr class="field-upgrade-row field-checkbox">
    <td class="upgrade-name"><b>{$cf.name}</b>
    </td>
    <td class="upgrade-from">
        {foreach from=$cf.items item=cit}
            {if isset($cf.data[$cit.id])}
                <div>
                    {$cit.name}
                    {if $cit.price!=0}(
                        {if $cit.fee!=0} {$cit.fee|price:$currency:1:1} {$lang[$service.billingcycle]}{/if}
                        {if $cit.setup!=0} {$cit.setup|price:$currency:1:1} {$lang.setupfee}{/if}
                        ){/if}
                </div>
            {/if}
        {/foreach}
    </td>
    <td class="upgrade-to">
        {foreach from=$cf.items item=cit}
            <div>
                {if $cit.options & 1}{continue}{/if}
                <input name="fupgrade[{$cf.id}][{$cit.id}][new_qty]" type="hidden" value="1">
                <input name="fupgrade[{$cf.id}][{$cit.id}][new_config_id]"
                       id="custom_field_{$cf.id}_{$cit.id}" type="checkbox"
                       value="{$cit.id}" {if isset($cf.data[$cit.id])}checked{/if}>
                {$cit.name} {if $cit.price!=0}(
                    {if $cit.fee!=0} {$cit.fee|price:$currency:1:1} {$lang[$service.billingcycle]}{/if}
                    {if $cit.setup!=0} {$cit.setup|price:$currency:1:1} {$lang.setupfee}{/if}
                    ){/if}
                {if $cit.description}
                    <div class="mt-2 mb-3 text-secondary cf_item_description_value">{$cit.description|escape}</div>
                {/if}
            </div>
        {/foreach}
    </td>
    <td class="upgrade-price">
        <div class="custom_field_{$cf.id}_price w-100 text-right">
            {$price.config[$cf.id].total|price:$currency:1:1}
        </div>
    </td>
</tr>