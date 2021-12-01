{if $logs}
    {foreach from=$logs item=log}
        <tr>
            <td>{$log.id}</td>
            <td>{$log.parent_id}</td>
            <td>{$log.queue}</td>
            <td>{if $log.rel_id}
                 {if $log.rel_type=='Hosting'}
                     Account: <a href="?cmd=accounts&action=edit&id={$log.rel_id}" target="_blank">{$log.rel_id}</a>
                 {elseif   $log.rel_type=='Domain'}
                     Domain: <a href="?cmd=domains&action=edit&id={$log.rel_id}" target="_blank">{$log.rel_id}</a>
                 {elseif   $log.rel_type=='Order'}
                     Order: <a href="?cmd=orders&action=edit&id={$log.rel_id}" target="_blank">{$log.rel_id}</a>
                 {/if}

                    {else}-{/if}</td>
            <td>{$log.description}</td>
            <td>{$log.added|dateformat:$date_format}</td>
            <td>{$log.changed|dateformat:$date_format}</td>
            <td>{$statuses[$log.status]}</td>
        </tr>
    {/foreach}
{else}
    <tr><td colspan="5"><p align="center" >{$lang.nothingtodisplay}</p></td></tr>

{/if}