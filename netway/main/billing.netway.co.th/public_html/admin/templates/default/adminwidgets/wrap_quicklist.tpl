{* QUICK LIST CONTENT PLACEHOLDER AND LINK *}
{if $_placeholder}
    {if $widget.template}
        <div class="slide">{include file=$widget.template}</div> 
    {elseif $widget.html}
        <div class="slide">{$widget.html}</div> 
    {else}
        <div class="slide">Loading</div> 
    {/if}
{else}
    <a class="nav_el left" href="{$widget.url}&client={$_client_link}" onclick="return false">
        {if $lang[$widget.name]}{$lang[$widget.name]}
        {else}{$widget.name}
        {/if}
    </a>
{/if}
