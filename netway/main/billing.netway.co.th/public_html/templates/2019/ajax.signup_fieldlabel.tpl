<label for="field_{$k}" >
    {if $k=='type'}
        {$lang.clacctype}
    {elseif $field.options & 1}
        {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
    {else}
        {$field.name}
    {/if}
    {if $field.options & 2}*{/if}
    {if $field.description}<span class="vtip_description" title="{$field.description|htmlspecialchars}"></span>{/if}
</label>