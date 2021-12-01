{if $toggle}
    {foreach from=$toggle item=value key=id}
        <input type="hidden" name="config[toggle][{$id}]" value="{$value}">
    {/foreach}
{/if}
