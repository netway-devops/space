<table style="width: 100%" cellpadding="6" cellspacing="0" class="configs hover">
    <thead>
        <tr>
            <th>Running Configs</th>
            <th>Archived</th>
        </tr>
    </thead>
    {foreach from=$configs item=conf key=main}
        <tbody>
            <tr>
                <td> 
                    {if $conf.active}
                        {$conf.active.description|escape|truncate} 
                        <a href="?cmd=dedimgr&action=itemconfigedit&item_id={$item.id}&id={$conf.active.id}" class="editbtn" onclick="return showEditConfig(this);" >Edit</a>
                        <a href="?cmd=dedimgr&action=itemconfigs&item_id={$item.id}&remove={$conf.active.id}" class="editbtn rem" >Delete</a>
                        <i style="font-size: 10px; display: block; color: rgb(125, 125, 125);">({$conf.active.date|dateformat:$date_format}, {$conf.active.author})</i> 
                    {else}
                        -
                    {/if}
                </td>
                <td>
                    {if $conf.archived}
                        {$conf.archived[0].description|escape|truncate}
                        <a href="?cmd=dedimgr&action=itemconfigs&item_id={$item.id}&remove={$conf.archived[0].id}" class="editbtn right rem" >Delete</a>
                        <a href="?cmd=dedimgr&action=itemconfigedit&item_id={$item.id}&id={$conf.archived[0].id}" class="editbtn right" onclick="return showEditConfig(this);" style="padding: 0 4px;">Edit</a>
                        <i style="font-size: 10px; color: rgb(125, 125, 125);">({$conf.archived[0].date|dateformat:$date_format}, {$conf.archived[0].author})</i> 
                    {else}
                        -
                    {/if}
                </td>
            </tr>
            {foreach from=$conf.archived item=entry name=cfgl}
                {if !$smarty.foreach.cfgl.first}
                    <tr {if $smarty.foreach.cfgl.index > 2}class="fold"{/if}>
                        <td></td>
                        <td>
                            {$entry.description|escape|truncate} 
                            <a href="?cmd=dedimgr&action=itemconfigs&item_id={$item.id}&remove={$entry.id}" class="editbtn right rem" >Delete</a>
                            <a href="?cmd=dedimgr&action=itemconfigedit&item_id={$item.id}&id={$entry.id}" class="editbtn right" onclick="return showEditConfig(this);" style="padding: 0 4px;">Edit</a>
                            <i style="font-size: 10px; color: rgb(125, 125, 125);">({$entry.date|dateformat:$date_format}, {$entry.author})</i> 
                        </td>
                    </tr>
                {/if}
            {/foreach}
            {if $smarty.foreach.cfgl.index > 2}
                <tr>
                    <td></td>
                    <td><a href="#" onclick="$(this).children().toggle().end().parents('tr').eq(0).prevAll('.fold').toggle();
                            return false;" class="editbtn"><span>Show more ..</span><span style="display: none">Hide older entries ..</span></a></td>
                </tr>
            {/if}
        </tbody>
    {foreachelse}
        <tr>
            <td colspan="2">
                {if $item.id > 0}
                    No configurations were added yet.
                {else}
                    Save this item first.
                {/if}
            </td>
        </tr>
    {/foreach}
</table>