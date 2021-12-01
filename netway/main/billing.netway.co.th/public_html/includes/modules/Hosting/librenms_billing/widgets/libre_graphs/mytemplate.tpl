{if $librenms_datasources}
 {foreach from=$librenms_datasources item=ds}
     {$ds.name}
     <div class="card">
         <h5 class="card-header h5">{$lang.hour_view}</h5>
         <div class="card-body">
             <div class="lgraph"><img loading="lazy" src="?cmd=librenms_billing&action=showgraph&account_id={$service.id}&switch_id={$ds.device_id}&port_id={$ds.port_id}&type=day" alt="Daily usage " /></div>
         </div>
     </div>
     <div class="card">
         <h5 class="card-header h5">{$lang.weekly_view}</h5>
         <div class="card-body">
             <div class="lgraph"><img loading="lazy" src="?cmd=librenms_billing&action=showgraph&account_id={$service.id}&switch_id={$ds.device_id}&port_id={$ds.port_id}&type=week" alt="Weekly usage " /></div>
         </div>
     </div>
     <div class="card">
         <h5 class="card-header h5">{$lang.monthly_view}</h5>
         <div class="card-body">
             <div class="lgraph"><img loading="lazy" src="?cmd=librenms_billing&action=showgraph&account_id={$service.id}&switch_id={$ds.device_id}&port_id={$ds.port_id}&type=month" alt="Monthly usage " /></div>
         </div>
     </div>
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