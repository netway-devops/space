{if $license2}
    <table width="100%" class="glike hover" cellpadding="3" cellspacing="0">
        {foreach from=$license2 item=data key=key name=alter}
            {if $smarty.foreach.alter.index%2==0 && !$smarty.foreach.alter.first}<tr>{/if}
            {if $smarty.foreach.alter.index%2==0}<tr>{/if}
            <td style="width:160px;">{if $lang[$key]}{$lang[$key]}{else}{$key}{/if}:</td>
            <td>{$data}</td>
            {if $smarty.foreach.alter.last}</tr>{/if}
        {/foreach}
    </table>
{else}
    License not found
{/if}
