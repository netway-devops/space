<script type="text/javascript" src="../includes/modules/Other/plesk_service_plan_sync/admin/script.js"></script>
<div id="newshelfnav" class="newhorizontalnav" >
    <div class="list-1">
        <ul>
            <li {if !$config}class="active"{/if}>
                <a href="?cmd={$modulename}"><span>{$modname}</span></a>
            </li>

            <li class="">
                <a href="?cmd=logs&action=logfiles&logfile=plesk_plansync.log" target="_blank"><span>Synch Logs</span></a>
            </li>
            {if $config}
                <li class="{if $action=='config'}last active{/if}">
                    <a href="?cmd={$modulename}&action=config&id={$config.id}"><span>{$config.name}</span></a>
                </li>
            {/if}

        </ul>
    </div>
    {if $action=='default'}

    <div class="list-2">
        <div class="subm1 haveitems" style="">
            <ul>
                <li >
                    <a href="#"  data-toggle="modal" data-target="#assign-client"><span>Add new configuration</span></a>
                </li>

            </ul>
        </div>
    </div>
    {/if}
</div>
