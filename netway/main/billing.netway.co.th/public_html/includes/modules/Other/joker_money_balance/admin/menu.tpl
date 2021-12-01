<div id="newshelfnav" class="newhorizontalnav" >
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a href="?cmd={$modulename}"><span>{$modname}</span></a>
            </li>
            <li class="last {if $action == 'add'}active{/if}">
                <a href="?cmd={$modulename}&action=add"><span>Add</span></a>
            </li>
            {if $action == 'edit'}
                <li class="last active">
                    <a href="?cmd={$modulename}&action=edit&id={$connect.id}"><span>{$connect.name}</span></a>
                </li>
            {/if}
        </ul>
    </div>
</div>
<script type="text/javascript" src="{$moduleurl}script.js"></script>