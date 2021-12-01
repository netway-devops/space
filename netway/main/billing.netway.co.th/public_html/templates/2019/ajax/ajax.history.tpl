{foreach from=$logs item=log name=foo}
    <tr>
        <td>{$log.date|dateformat:$date_format}</td>
        <td>{$log.description}</td>
        <td><span class="label label-styled {if $log.result} label-success {else} label-warning {/if}">{if $log.result}{$lang.success}{else}{$lang.fail}{/if}</span></td>
        <td>
            {if $log.type == 'account'}
                <a href="?cmd=clientarea&action=services&service={$log.id}" target="_blank">
                    <span data-title="ID {$log.id}">ID {$log.id}</span>
                </a>
            {elseif $log.type=='domain'}
                <a href="?cmd=clientarea&action=domains&id={$log.id}" target="_blank">
                    <span data-title="ID {$log.id}">ID {$log.id}</span>
                </a>
            {else}
                <span data-title="">-</span>
            {/if}
        </td>
    </tr>
{foreachelse}
    <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
{/foreach}