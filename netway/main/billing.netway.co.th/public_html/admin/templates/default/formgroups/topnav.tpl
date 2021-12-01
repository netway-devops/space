<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'form_groups' || $action == 'default'}active{/if} picked">
                <a href="?cmd=formgroups&action=form_groups">{$lang.formgroups}</a>
            </li>
            <li class="{if $action == 'form_item_groups'}active{/if} ">
                <a href="?cmd=formgroups&action=form_item_groups">{$lang.formitemgroups}</a>
            </li>
            {if $action=='form_group' && (!$group.id || $group.id === 'new')}
                <li class="active">
                    <a href="?cmd=formgroups&action=form_group">{$lang.addformgroup}</a>
                </li>
            {elseif $action=='form_item_group' && (!$group.id || $group.id === 'new')}
                <li class="active">
                    <a href="?cmd=formgroups&action=form_item_group">{$lang.addformitemgroup}</a>
                </li>
            {elseif $group}
                <li class="active">
                    <a href="#">
                        {if $action=='form_group'}
                            Form group:
                        {elseif $action=='form_item_group'}
                            Form item group:
                        {/if}
                        {$group.name}
                    </a>
                </li>
            {/if}
        </ul>
    </div>
    <div class="list-2" style="min-height: 15px;">
        {if $action=='form_groups' || $action == 'default'}
            <div class="subm1 haveitems">
                <ul>
                    <li>
                        <a href="?cmd=formgroups&action=form_group">{$lang.addformgroup}</a>
                    </li>
                </ul>
            </div>
        {elseif $action=='form_item_groups'}
            <div class="subm1 haveitems">
                <ul>
                    <li>
                        <a href="?cmd=formgroups&action=form_item_group">{$lang.addformitemgroup}</a>
                    </li>
                </ul>
            </div>
        {/if}
    </div>
</div>