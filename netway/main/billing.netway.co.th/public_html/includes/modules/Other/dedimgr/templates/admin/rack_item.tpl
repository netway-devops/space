<div class="rackitem server{$i.units}u default_1u"
     data-position="{$i.position}"
     data-units="{$i.units}"
     data-id="{$i.id}"
     data-depth="{$i.depth}"
     style="background-image: url({$moduledir}images/hardware/{$i.css[$orientation]})">
    <div class="lbl">{*}
        {*}{if $i.label}{$i.label}
        {else}{$i.category_name}
        {/if}
    </div>
    <div class="rackitem-menu">
        <h4>{if $i.label}{$i.label} - {/if}{$i.name}</h4>
        {if $i.bladeitems}
            <h5>BladeSystem: </h5>
            <ul>
                {foreach from=$i.bladeitems item=b}
                    <li>{if $b.label}{$b.label} - {/if}{$b.name}</li>
                {/foreach}
            </ul>
        {/if}
        <small>Drag to change position.</small>
        <div class="fa-actions">
            <br>
            <a href="?cmd=dedimgr&do=rack&make=delitem&id={$i.id}&rack_id={$rack.id}"
               title="Remove item"
               onclick="return confirm('Are you sure you want to remove this item?');">
                <i class="fa fa-trash-o"></i>
            </a>
            <a class="edititem" href="?cmd=dedimgr&do=itemeditor&item_id={$i.id}"
               title="Edit item"
            >
                <i class="fa fa-pencil"></i>
            </a>
            <a class="edititem" href="?cmd=dedimgr&do=cloneitem&item_id={$i.id}&security_token={$security_token}"
               title="Copy item"
               data-off-action="copyRackItem">
                <i class="fa fa-copy"></i>
            </a>
            <a class="edititem" href="?cmd=dedimgr&do=itemeditor&item_id={$i.id}&subdo=graphs"
               title="View / Manage graphs"">
            <i class="fa fa-area-chart"></i>
            </a>
            <a class="edititem" href="?cmd=dedimgr&do=itemeditor&item_id={$i.id}"
               title="Show details in new page">
                <i class="fa fa-share"></i>
            </a>

        </div>
    </div>
</div>