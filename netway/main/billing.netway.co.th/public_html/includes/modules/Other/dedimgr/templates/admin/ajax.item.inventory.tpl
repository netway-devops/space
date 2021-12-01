<form id="saveform" class="clearfix" method="post" action="?cmd=dedimgr">
    <input type="hidden" name="do" value="rack" />
    <input type="hidden" name="backview" value=item" />
    <input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />
    <input type="hidden" name="id" value="{$item.id}" id="item_id"/>
    <input type="hidden" name="make" value="buildsave" />
    <div class="row no-gutter">
    <div class="col-md-3 mainleftcol">
        <div class="box  box-solid">
            <div class="box-header">
                <h3 class="box-title"><i class="fa fa-tasks"></i> Inventory Mgr</h3>
            </div>
            <div class="box-body" >
                <div class="form-group">
                    <label class="nodescr">Finished Build ID</label>
                    <select  class="form-control" name="build_id" default="{$item.build_id}" onchange="reloadInventory($(this).val())">
                        <option value="0" {if $item.build_id=='0'}selected="selected"{/if}>#0: None</option>
                    </select>
                </div>
            </div>
            <div class="box-footer clearfix no-border">
                <input type="submit" class="btn btn-success btn-xs pull-right" value="Save changes" />
            </div>
        </div>
    </div>
    <div class="col-md-9 mainrightcol">
        <div class="box  box-solid">
            <div class="box-header">
                <h3 class="box-title">Build details</h3>
            </div>
            <div class="box-body" id="inventorygrid">Select build to load items
            </div>
        </div>
    </div>
</div>
    {securitytoken}
</form>
