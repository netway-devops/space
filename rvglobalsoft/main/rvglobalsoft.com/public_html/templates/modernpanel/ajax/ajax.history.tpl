{if $logs}
    {foreach from=$logs item=log name=foo}
        <tr>
            <td>{$log.date|dateformat:$date_format}</td>
            <td>{$log.description}</td>
            <td class="{if $log.result}Success{else}Fail{/if}-label">{if $log.result}{$lang.success}{else}{$lang.fail}{/if}</td>
            <td>
                {if $log.type == 'account'}
                    <a href="?cmd=clientarea&action=services&service={$log.id}" target="_blank" class="view3">ID {$log.id}</a>
                {elseif $log.type=='domain'}
                    <a href="?cmd=clientarea&action=domains&id={$log.id}" target="_blank" class="view3">ID {$log.id}</a>
                {else}
                    <a href="#" target="_blank" class="view3" onclick="return false;"></a>
                {/if}
            </td>
        </tr>
        {foreachelse}
    <tr><td colspan="3">{$lang.nothing}</td></tr>
    {/foreach}
{/if}