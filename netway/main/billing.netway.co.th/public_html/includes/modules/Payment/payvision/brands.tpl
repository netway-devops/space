<select class="chosenedge" name="option[Brands][]" multiple>
    {if $brands}
        {foreach from=$brands item=group key=groupname}
            <optgroup label="{$groupname}">
                {foreach from=$group item=brand key=id}
                    <option value="{$id}" {if in_array($id, $config.value)}selected{/if}>{$brand}</option>
                {/foreach}
            </optgroup>
        {/foreach}
    {/if}
</select>