{if $observium_datasources}
 {foreach from=$observium_datasources item=ds}
 <div class="lgraph"><img src="?cmd=observium&action=showgraph&account_id={$service.id}&switch_id={$ds.c_switch_id}&port_id={$ds.c_port_id}" alt="Daily usage " /></div>
 <div class="lgraph"><img src="?cmd=observium&action=showgraph&account_id={$service.id}&switch_id={$ds.c_switch_id}&port_id={$ds.c_port_id}&type=weekly" alt="Weekly usage " /></div>
 <div class="lgraph"><img src="?cmd=observium&action=showgraph&account_id={$service.id}&switch_id={$ds.c_switch_id}&port_id={$ds.c_port_id}&type=monthly" alt="Monthly usage " /></div>
 {/foreach}
 {literal}
 <style type="text/css">
        .lgraph {
            min-height:150px;
            text-align: center;
            margin-bottom:10px;
}
    </style>
 {/literal}
{/if}