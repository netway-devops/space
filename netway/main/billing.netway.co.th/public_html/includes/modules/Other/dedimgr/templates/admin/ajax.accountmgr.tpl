{if $do=='floor'}
    <select id="rack_id" class="inp left" onchange="load_colo_items(this)" style="margin-right:10px;">
        <option value="0">Select Rack</option>
        {foreach from=$racks item=rack}
            <option value="{$rack.id}">{$rack.name} ({$rack.units} U)</option>
        {/foreach}
    </select>
{elseif $do=='rackitms'}
    <select id="item_id" class="inp left"  style="margin-right:10px;">
        <option value="0">Select Item</option>
        {foreach from=$rackitems item=item}
            <option value="{$item.id}">pos: {math equation="x + 1" x=$item.position} {$item.categoryname} - {$item.name} - {$item.label}</option>
        {/foreach}
    </select>
    {if $rackitems}<a href="#" onclick="return assignRackItem();" class="new_control greenbtn left" onclick="return false;"><span class="addsth"><strong>Assign</strong></span></a>{/if}
{elseif $do=='floors'}
    <select id="floor_id" class="inp left" onchange="load_colo_racks(this)" style="margin-right:10px;">
        <option value="0">Select Floor</option>
        {foreach from=$floors item=floor}
            <option value="{$floor.id}">{$floor.name} ({$floor.floor})</option>
        {/foreach}
    </select>
{elseif $do=='getassignments'}{literal}
    <script type="text/javascript">
        function assignRackItem() {
            if(!$('#item_id').val())
                return false;

            $.post('?cmd=dedimgr&do=additemassignment',{
                account_id:$('#account_id').val(),
                item_id:$('#item_id').val()
            },function(){
                loadDediMgr();
            });
            return false;
        }
        function unassignRackItems() {
            if(!confirm('Are you sure?')) {
                return false;
            }
            $.post('?cmd=dedimgr&do=rmitemassignment',{
                account_id:$('#account_id').val(),
                item_id:'all'
            },function(){
                loadDediMgr();
            });
            return false;
        }
        function unassignRackItem(item_id) {
            if(!confirm('Are you sure?')) {
                return false;
            }

            $.post('?cmd=dedimgr&do=rmitemassignment',{
                account_id:$('#account_id').val(),
                item_id:item_id
            },function(){
                loadDediMgr();
            });
            return false;
        }

        function bindConnection(item_id, bind) {
            var msg,
                url;
            if (bind){
                msg = {/literal}'{$lang.dedimgr_bind}';{literal}
                url = '?cmd=dedimgr&do=bindconnection';
            }else{
                msg = {/literal}'{$lang.dedimgr_unbind}';{literal}
                url = '?cmd=dedimgr&do=unbindconnection';
            }

            if(!confirm(msg)) {
                return false;
            }

            $.post(url,{
                account_id:$('#account_id').val(),
                item_id:item_id
            },function(){
                loadDediMgr();
            });
            location.reload();
            return false;
        }

        function unassignDPort(item_id) {

            if(!confirm('Are you sure?')) {
                return false;
            }
            $.post('?cmd=dedimgr&do=rmassignment',{
                account_id:$('#account_id').val(),
                item_id:item_id
            },function(){
                loadDediMgr();
            });
            return false;
        }
        function load_colo_floors(select) {
            var v = $(select).val();
            $('#dedi_floor_loader').html('');
            $('#dedi_rack_loader').html('');
            $('#dedi_item_loader').html('');
            if(!v|| v=='0')
                return;
            ajax_update('?cmd=dedimgr&do=floors',{colo_id:v,account_id:$('#account_id').val()},'#dedi_floor_loader',true);
        }
        function load_colo_racks(select) {
            var v = $(select).val();
            $('#dedi_rack_loader').html('');
            $('#dedi_item_loader').html('');
            if(!v|| v=='0')
                return;
            ajax_update('?cmd=dedimgr&do=floor',{floor_id:v,account_id:$('#account_id').val()},'#dedi_rack_loader',true);
        }
        function load_colo_items(select) {
            var v = $(select).val();
            $('#dedi_item_loader').html('');
            if(!v || v=='0')
                return;
            ajax_update('?cmd=dedimgr&do=rackitms',{rack_id:v,account_id:$('#account_id').val()},'#dedi_item_loader',true);
        }
    </script>
{/literal}
    <div id="add_dedi" style="display:none" class="p6">
        <div class="left" style="margin-right:10px;padding:4px"><b>Assign new New item:</b></div>
        {if $colos}
            <select id="colo_id" class="inp left" onchange="load_colo_floors(this)" style="margin-right:10px;">
                <option value="0">Select Colocation to assign item from</option>
                {foreach from=$colos item=colo}
                    <option value="{$colo.id}">{$colo.name}</option>
                {/foreach}
            </select>
            <div id="dedi_floor_loader" class="left"></div>
            <div id="dedi_rack_loader" class="left"></div>
            <div id="dedi_item_loader" class="left"></div>
        {else}
            No servers/item in Dedimgr added yet.
        {/if}
        <div class="clear"></div>
    </div>
    {if $items}
        <h3>Assigned items</h3>

        <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">

            {foreach from=$items item=itm}
                <li style="background:#ffffff" class="dedi_row" data_1="{$itm.item_id}"  ><div style="border-bottom:solid 1px #ddd;">
                        <table width="100%" cellspacing="0" cellpadding="5" border="0">
                            <tbody><tr>
                                <td width="120" valign="top"><div style="padding:10px 0px;">
                                        <a onclick="return unassignRackItem('{$itm.id}')" title="delete" class="btn btn-sm btn-danger" href="#">
                                            <span class="fa fa-times"></span> Unassign
                                        </a>
                                    </div></td>
                                <td>
                                    Colo: <a href="?cmd=dedimgr&do=floors&colo_id={$itm.colo_id}" target="_blank" class="external">{$itm.colo_name}</a>,
                                    Floor: <a href="?cmd=dedimgr&do=floor&floor_id={$itm.floor_id}" target="_blank" class="external">{$itm.floor_name} {if $itm.room}(Room: {$itm.room}){/if}</a>,
                                    Rack: <a href="?cmd=dedimgr&do=rack&rack_id={$itm.rack_id}" target="_blank" class="external">{$itm.rack_name}</a>,
                                    Item: <a href="?cmd=dedimgr&do=rack&rack_id={$itm.rack_id}&expand={$itm.id}" target="_blank" class="external"><b>#{$itm.id}: {$itm.name} - {$itm.label}</b></a> <em class="fs11">position: {$itm.position}</em>

                                </td>
                                <td width="120">
                                    <a onclick="return bindConnection('{$itm.id}', true)" title="delete" class="btn btn-sm btn-success" href="#">
                                        Bind connections
                                    </a>
                                </td>
                                <td width="120" style="padding-right: 10px;">
                                    <a onclick="return bindConnection('{$itm.id}', false)" title="delete" class="btn btn-sm btn-danger" href="#">
                                        Unbind connections
                                    </a>
                                </td>
                            </tr>
                            </tbody></table></div></li>
            {/foreach}
        </ul>



        <a onclick="$(this).hide();$('#add_dedi').show();return false;" class="new_control" href="#"><span class="addsth"><strong>Add next item</strong></span></a>
        <a onclick="return unassignRackItems()" title="delete" class="menuitm" href="#"><span class="rmsth">Unassign all items</span></a>

    {else}
        <div class="blank_state_smaller blank_forms" id="blank_dedi">
            <div class="blank_info">
                <h3>Assign item from Dedicated Servers Manager module to this account.</h3>
                <span class="fs11">No more mess in your inventory and spreadsheets to keep your hardware organised.</span>
                <div class="clear"></div>
                <br>
                <a onclick="$('#blank_dedi').hide();$('#add_dedi').show();return false;" class="new_control" href="#"><span class="addsth"><strong>Assign item</strong></span></a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{/if}