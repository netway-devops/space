
<div class="box box-primary  ">
    <div class="box-header">
        <h3 class="box-title"><i class="fa fa-tasks"></i> Blade Servers</h3>
    </div>
    <div class="box-body">
        <div>

            {if $item.bladeitems}
                <div>
                    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                        <tbody>
                        {foreach from=$item.bladeitems item=blade name=ff}
                            <tr class="havecontrols man {if $smarty.foreach.ff.index%2==0}even{/if}">
                                <td>{$blade.category_name}</td>
                                <td>{$blade.name}</td>
                                <td>{$blade.label}</td>
                                <td class="lastitm fa-actions" align="right">
                                    <a href="?cmd=dedimgr&do=rack&make=delitem&id={$blade.id}{if $backview}&backview=parent&parent_id={$item.id}{/if}&rack_id={$item.rack_id}"
                                       onclick="return confirm('Do you really want to remove this item?')" title="Remove item"><i class="fa fa-trash-o"></i></a>
                                    <a href="?cmd=dedimgr&do=itemeditor&item_id={$blade.id}"
                                       title="Edit item"><i class="fa fa-pencil"></i></a>

                                </td>
                            </tr>
                        {/foreach}

                        </tbody>
                    </table>
                </div>
                {else}
                <em>No blade items added yet</em>
            {/if}


        </div>
    </div>
    <div class="box-footer">
        <a  class="btn btn-sm btn-success" onclick="$('#confirm_ord_delete').trigger('show');return false;">Add new item</a>

    </div>
</div>


<div id="confirm_ord_delete" hidden bootbox data-title="Add new blade entry" data-btnclass="btn-success">
    <form action="index.php?cmd=dedimgr" method="post">
        <p><strong>{$lang.accdeldescr}</strong></p>
        <div class="form-group">
            <label class="nodescr">New blade server category:</label>
            <select id="blade_cat_id" name="category_id"  onchange="loadSubitems(this)" class="form-control">
                <option value="0">Select category to add item from</option>
                {foreach from=$categories item=c}
                    <option value="{$c.id}">{$c.name}</option>
                {/foreach}
            </select>
        </div>
        <div id="updater1" class="form-group"></div>


        <input type="hidden" name="addblade" value="true" />
        <input type="hidden" name="do" value="itemeditor" />
        <input type="hidden" name="parent_id" value="{$item.id}" />
        <input type="hidden" name="item_id" value="new" />
        <input type="hidden" name="position" value="0" />
        <input type="hidden" name="location" value="Blade" />
        <input type="hidden" name="backview" value="parent" />
        <input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />

        {securitytoken}

    </form>
</div>