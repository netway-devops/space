<link media="all" type="text/css" rel="stylesheet" href="{$moduleurl}style.css"/>

<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a href="?cmd={$modulename}"><span>Webhooks</span></a>
            </li>
            {if $action == 'details' || $action == 'edit' || $action == 'add'}
            <li class="active">
                <a>
                    <span>
                        {if $hook.id}
                            {$hook.name}
                        {else}
                            New webhook
                        {/if}
                    </span>
                </a>
            </li>
            {/if}
        </ul>
    </div>

</div>

