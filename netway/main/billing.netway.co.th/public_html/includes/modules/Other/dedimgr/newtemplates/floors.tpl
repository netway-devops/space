<h1>Colocation: <strong><a href="?cmd=dedimgr&do=floors&colo_id={$colocation.id}">{$colocation.name}</a></strong> &raquo; Floors:  </h1>

{if $floors}
    <ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter">

        {foreach from=$floors item=floor}

            <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                        <tbody><tr>
                            <td width="120" valign="top"><div style="padding:10px 0px;">
                                    <a class="sorter-ha menuitm menu-auto" href="?cmd=dedimgr&do=floor&floor_id={$floor.id}"><span >Racks</span></a>
                                    <a title="Edit" class="menuitm menu-auto" href="#" onclick="return editFloor('{$floor.id}')"><span class="editsth"></span></a>
                                    <a href="?cmd=dedimgr&do=removefloor&floor_id={$floor.id}&colo_id={$floor.colo_id}"
                                       onclick="return confirm('Are you sure you want to remove this floor and all its contents?');" title="delete" class="menuitm menu-auto" >
                                        <span class="delsth"></span>
                                    </a>
                                </div>
                            </td>
                            <td style="line-height:20px">
                                <h3><a href="?cmd=dedimgr&do=floor&floor_id={$floor.id}">Floor #{$floor.floor}- {$floor.name}</a></h3>
                                Racks: <a href="?cmd=dedimgr&do=floor&floor_id={$floor.id}"><strong>{$floor.racks}</strong></a><br/>

                                {foreach from=$floor.rack_list item=rack}<em class="fs11" style="padding-left:20px"><a href="?cmd=dedimgr&do=rack&rack_id={$rack.id}">{$rack.name} ({$rack.units} U)</a></em>{/foreach} <em class="fs11" style="padding-left:20px"><a href="?cmd=dedimgr&do=floor&floor_id={$floor.id}">...</a></em>

                            </td>

                        </tr>
                        </tbody>
                    </table>
                </div>
            </li>


        {/foreach}
    </ul>
    <div style="padding:10px 4px">
        <a id="addnew_conf_btn" onclick="return addFloor('{$colocation.id}');" class="new_control" href="#"><span class="addsth"><strong>Add new floor</strong></span></a>
    </div>
{else}

    <div class="blank_state_smaller blank_forms" id="blank_pdu">
        <div class="blank_info">
            <h1>You dont have any floors defined yet</h1>
            Dedicated Servers module organises your inventory in Colocation->Floors->Racks->Items structures. To begin add floor <br/><br/>


            <div class="clear"></div>
            <a onclick="return addFloor('{$colocation.id}');" class="new_control" href="#"><span class="addsth"><strong>Add floor</strong></span></a>
            <div class="clear"></div>
        </div>
    </div>

{/if}





