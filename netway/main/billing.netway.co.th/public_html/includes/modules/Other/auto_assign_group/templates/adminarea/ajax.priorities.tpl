{foreach from=$configs item=config name=loop}
    <li class="{if $smarty.foreach.loop.index%2==0}even{/if}">
        <div class="actions">
            <input type="hidden" name="order[{$config.id}]" value="{$smarty.foreach.loop.index+1}" class="sort-order"/>
            <a href="#" onclick="return false" class="sorter-handler menuitm menu-auto">
                <span class="movesth" title="move">&nbsp;</span>
            </a>
        </div>
        <div class="" style="width: 120px">Priority: <b>{$config.priority}</b></div>
        <div class="isclient isclient-{$config.group_id}" style="width: 200px">Group: <b>{$config.group_name}</b></div>
        <div class="" style="width: 200px">Type: <b>{$config.type|ucfirst}</b></div>
        <div class="" style="width: 40px;">
            Items:
        </div>
        <div class="">
            {foreach from=$config._countries item=item}
               <b> {$item}</b> <br>
            {/foreach}
        </div>
    </li>
{/foreach}