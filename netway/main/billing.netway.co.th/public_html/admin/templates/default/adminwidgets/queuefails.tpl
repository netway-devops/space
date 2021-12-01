<table cellspacing="0" cellpadding="3" border="0" width="100%" class="table table-fixed whitetable" style="">
    <tbody>
    <tbody>
    <tr>
        <th width="80">Queue</th>
        <th width="120" >Target</th>
        <th >Task</th>
    </tr>
    </tbody>
    {foreach from=$queuefails item=request name=loop}
        <tr  class="{if $request.notseen}notseen{/if}">
            <td >{if $queues[$request.queue]}{$queues[$request.queue].name}{else}{$request.queue}{/if}</td>
            <td >
                {if $request.rel_id}
                    {if $request.rel_type=='Hosting'}
                        Account:
                        <a href="?cmd=accounts&action=edit&id={$request.rel_id}"
                           target="_blank">{$request.rel_id}</a>
                    {elseif   $request.rel_type=='Domain'}
                        Domain:
                        <a href="?cmd=domains&action=edit&id={$request.rel_id}"
                           target="_blank">{$request.rel_id}</a>
                    {elseif   $request.rel_type=='Order'}
                        Order:
                        <a href="?cmd=orders&action=edit&id={$request.rel_id}"
                           target="_blank">{$request.rel_id}</a>
                    {/if}

                {else}-{/if}
            </td>
            <td><div class="errorless fs11">{if $request.human_description}{$request.human_description} - {/if}{$request.description}
                    {if $request.notify.error}
                    <pre>{foreach from=$request.notify.error item=i}{if is_array($i)}{foreach from=$i item=ll}{$ll}, {/foreach}<br/>{else}{$i}<br/>{/if}{/foreach}</pre>
                {/if}</div></td>
        </tr>
        {foreachelse}
        <tr>
            <td colspan="3">
                Nothing found
            </td>
        </tr>
    {/foreach}
    </tbody>
</table>

