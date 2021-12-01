<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'groups' || $action == 'default' || $action == 'addgroups'}active{/if}">
                <a href="?cmd=gatewayperclient&action=groups"><span>Gateway per groups</span></a>
            </li>
            <li class="{if $action == 'products' || $action == 'addproducts'}active{/if}">
                <a href="?cmd=gatewayperclient&action=products"><span>Gateway per products</span></a>
            </li>
            <li class="{if $action == 'cycles' || $action == 'addcycles'}active{/if}">
                <a href="?cmd=gatewayperclient&action=cycles"><span>Gateway per cycle</span></a>
            </li>
            <li class="{if $action == 'countries' || $action == 'addcountries'}active{/if}">
                <a href="?cmd=gatewayperclient&action=countries"><span>Gateway per country</span></a>
            </li>
            <li class="{if $action == 'cart'}active{/if}">
                <a href="?cmd=gatewayperclient&action=cart"><span>Gateway per cart</span></a>
            </li>
        </ul>
    </div>
    <div class="list-2">
        <div class="subm1 haveitems">
            <ul>
                {if $action != 'addgroups' && $action != 'addproducts' && $action != 'addcycles' && $action != 'addcountries'}
                    {if $action == 'groups' || $action == 'default' }
                        <li><a href="?cmd=gatewayperclient&action=addgroups"><span>Add new config</span></a></li>
                    {elseif $action == 'products'}
                        <li><a href="?cmd=gatewayperclient&action=addproducts"><span>Add new config</span></a></li>
                    {elseif $action == 'cycles' }
                        <li><a href="?cmd=gatewayperclient&action=addcycles"><span>Add new config</span></a></li>
                    {elseif $action == 'countries' }
                        <li><a href="?cmd=gatewayperclient&action=addcountries"><span>Add new config</span></a></li>
                    {/if}
                {/if}
            </ul>
        </div>
    </div>
</div>