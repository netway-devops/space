<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>HTML snippets</span></a>
            </li>
            <li class="{if $action == 'js'}active{/if} last">
                <a {if $action != 'add'}href="?cmd={$modulename}&action=js"{/if}><span>Javscript snippets</span></a>
            </li>
        </ul>
    </div>
</div>