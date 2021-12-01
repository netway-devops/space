<select name="option[Return address]">
    {if $addresses}
        {foreach from=$addresses item=address}
            <option value="{$address.return_address_id}" {if $config.value == $address.return_address_id}selected{/if}>{$address.address_name}</option>
        {/foreach}
    {/if}
</select>
