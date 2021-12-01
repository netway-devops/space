<ul class="opt-list">
    {foreach from=$gateways item=gate key=modid}
        <li class="li-cat">
            <input id="gate{$gate.id}" class="gate-enabled" type="checkbox" name="gateways[]"  value="{$gate.id}" {if $selected[$gate.id] || !$selected}checked="checked"{/if}/>
            <label for="gate{$gate.id}">
                <strong>{$gate.modname}</strong>
            </label>
        </li>
    {/foreach}
</ul>