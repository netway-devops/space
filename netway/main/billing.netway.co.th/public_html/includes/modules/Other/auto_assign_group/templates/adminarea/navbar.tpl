<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'countries' || $action == 'default' || $action == 'addcountries'}active{/if}">
                <a href="?cmd={$modulename}&action=countries"><span>Group per country</span></a>
            </li>
          {*  <li class="{if $action == 'priorities'}active{/if}">
                <a href="?cmd={$modulename}&action=priorities"><span>Priorities</span></a>
            </li>
*}
            {if $action == 'group' }
                <li class="active">
                    <a href="#"><span>Group configuration</span></a>
                </li>
            {/if}
        </ul>
    </div>
    <div class="list-2">
        <div class="subm1 haveitems">
            <ul>
                {if $action == 'countries' || $action == 'default' }
                    <li><a href="?cmd={$modulename}&action=addcountries"><span>Add new config</span></a></li>
                {elseif $action == 'group' }
                    <li><span>Group: {$group.name}</span></li>
                {/if}
            </ul>
        </div>
    </div>
</div>