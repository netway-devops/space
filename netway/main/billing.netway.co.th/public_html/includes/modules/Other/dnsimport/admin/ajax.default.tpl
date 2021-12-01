{foreach from=$result item=req}
    <div class="panel panel-default">
        <div class="panel-body">
            Imported {$req.done|@count} zone(s) from {$req.zone|@count} requested. 
            {if $req.accountId}
                Zones for this request are imported under <a href="?cmd=accounts&action=edit&id={$req.accountId}">Account #{$req.accountId}</a>
            {/if}

            <div class="zone-list">
                {foreach from=$req.done item=status key=zone}
                    <div class="zone-status">
                        <div class="zone-line">
                            {$zone} {if $status.imported}<span class="label label-success">Imported</span>{else}<span class="label label-danger">Failed</span>{/if}
                        </div>
                        {foreach from=$status.log item=log}
                            <div class="zone-log">{$log}</div>
                        {/foreach}
                        {if $status.failed}
                            <div class="zone-failed">
                                Records that failed to import:
                                {foreach from=$status.failed item=log}
                                    <div class="zone-log">{$log}</div>
                                {/foreach}
                            </div>
                        {/if}
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
{/foreach}
<script>statusreload({$progress|@json_encode})</script>