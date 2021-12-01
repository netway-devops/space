{foreach from=$logs item=log}
    <tr>
        <td>{$log.id}</td>
        <td><center>{$log.parent_id}</center></td>
        <td>{if $queues[$log.queue]}{$queues[$log.queue].name}{else}{$log.queue}{/if}</td>
        <td>{if $log.rel_id}
                {if $log.rel_type=='Hosting'}
                    Account:
                    <a href="?cmd=accounts&action=edit&id={$log.rel_id}"
                       target="_blank">{$log.rel_id}</a>
                {elseif   $log.rel_type=='Domain'}
                    Domain:
                    <a href="?cmd=domains&action=edit&id={$log.rel_id}"
                       target="_blank">{$log.rel_id}</a>
                {elseif   $log.rel_type=='Order'}
                    Order:
                    <a href="?cmd=orders&action=edit&id={$log.rel_id}"
                       target="_blank">{$log.rel_id}</a>
                {/if}

            {else}-{/if}</td>
        <td>{if $log.human_description}{$log.human_description} - {/if}{$log.description}</td>
        <td>{$log.added|dateformat:$date_format}</td>
        <td>{$log.changed|dateformat:$date_format}</td>
        <td><span class="{if $log.status==3}Unpaid{/if}">{$statuses[$log.status]}</span></td>
        {if $log.status>2}

        <td>{if $log.notify.info}<a class="btn btn-info btn-sm"
                                    onclick='return showlog("Notifications returned","log-info-{$log.id}");'>
                    <i class="fa fa-info-circle"></i></a>{/if}</td>
        <td>{if $log.notify.error}<a class="btn btn-danger btn-sm"
                                     onclick='return showlog("Errors returned","log-error-{$log.id}");'>
                    <i class="fa fa-exclamation-circle"></i></a>{/if}
            <div style="display: none" id="log-info-{$log.id}">
                <ul>{foreach from=$log.info item=i}{if is_array($i)}
                        <li>{foreach from=$i item=ll}{$ll}, {/foreach}</li>{else}
                        <li>{$i}</li>{/if}{/foreach}</ul>
            </div>
            <div style="display: none" id="log-error-{$log.id}">
                <ul>{foreach from=$log.error item=i}{if is_array($i)}
                        <li>{foreach from=$i item=ll}{$ll}, {/foreach}</li>{else}
                        <li>{$i}</li>{/if}{/foreach}</ul>
            </div>
        </td>
        {else}
            <td colspan="2">
                <center><a href="?cmd=queue&action=cancel&id={$log.id}&security_token={$security_token}" class="btn btn-sm btn-warning" onclick="return confirm('Are you sure?');">Cancel</a></center>
            </td>
        {/if}
    </tr>
    {foreachelse}
    <tr>
        <td colspan="7">
            <p align="center"> {$lang.nothingtodisplay} </p>
        </td>
    </tr>
{/foreach}
