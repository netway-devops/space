<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>VM Flavor List</span></a>
            </li>
            <li class="{if $action == 'storage'}active{/if}">
                <a {if $action != 'storage'} href="?cmd={$modulename}&action=storage"{/if}><span>Storage Flavor
                        List</span></a>
            </li>

            <li class="{if $action == 'ip'}active{/if}">
                <a {if $action != 'ip'} href="?cmd={$modulename}&action=ip"{/if}><span>IP Flavor List</span></a>
            </li>
        </ul>
    </div>
    <ul class="breadcrumb" style="margin-bottom: 0">
        {if $action == 'add' || $action == 'edit'}
            <li>
                {if $entry.type == 0}
                    <a href="?cmd={$modulename}">VM Flavors</a>
                {elseif $entry.type==1}
                    <a href="?cmd={$modulename}&action=storage">Storage Flavors</a>
                {elseif $entry.type==2}
                    <a href="?cmd={$modulename}&action=ip">IP Flavors</a>
                {else}
                    <a href="?cmd={$modulename}">Flavor List</a>
                {/if}
            </li>
        {else}
            <li><a href="?cmd={$modulename}&action=add&stype={$action}">New Flavor</a></li>
        {/if}

        {if  $action == 'add'}
            <li class="active">New Flavor</li>
        {elseif $action == 'edit' }
            <li class="active">{$entry.name|truncate}</li>
        {/if}
    </ul>
</div>