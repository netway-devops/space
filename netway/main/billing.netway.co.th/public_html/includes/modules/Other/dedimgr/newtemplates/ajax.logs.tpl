
            {if $logs}
                {foreach from=$logs item=log key=r}
                    <tr>
                        <td>{$log.when|dateformat:$date_format}</td>
                        <td>{$log.who|capitalize}</td>
                        <td>{if $log.ip}{$log.ip}{else}-{/if}</td>
                        <td>
                            {if $log.rel && $log.rel_id}
                                <a href="?cmd=dedimgr
                                   {if $log.rel == 'colocation'}&do=floors&colo_id={$log.rel_id}
                                   {elseif $log.rel == 'floor'}&do=floors&floor_id={$log.rel_id}
                                   {elseif $log.rel == 'rack'}&do=rack&rack_id={$log.rel_id}
                                   {elseif $log.rel == 'item'}&do=itemeditor&item_id={$log.rel_id}
                                   {elseif $log.rel == 'vendor'}&do=vendors#v{$log.rel_id}
                                   {elseif $log.rel == 'inventory'}&do=inventory&subdo=category&category_id={$log.rel_id}
                                   {elseif $log.rel == 7}&do=inventory&subdo=item&item_id={$log.rel_id}
                                {elseif $log.rel == 8}&do=inventory&subdo=fieldtypes#f{$log.rel_id}{/if}" target="_blank">{$log.what|escape}</a>
                        {else}
                            {$log.what|escape}
                        {/if}
                    </td>
                        <td>{if $log.metadata!='' && $log.metadata!='[]'}
                                <a href="#" class="btn btn-xs btn-default"
                                   onclick="return showDebugLog('{$log.what|escape:'javascript'}','#metadata-{$r}')" >View</a>
                            <div id="metadata-{$r}" style="display: none" ><pre>{$log.metadata}</pre></div>{/if}</td>

                </tr>
            {/foreach}
        {else}
            <tr>
                <td colspan="3">No logs to display yet.</td>
            </tr>
        {/if}
