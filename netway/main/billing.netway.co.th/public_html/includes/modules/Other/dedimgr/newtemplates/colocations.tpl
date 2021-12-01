{if $colocations}
<ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter">

    {foreach from=$colocations item=colo}

    <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                    <td width="120" valign="top"><div style="padding:10px 0px;">
                            <a  class="sorter-ha menuitm menu-auto" href="?cmd=dedimgr&do=floors&colo_id={$colo.id}"><span >Floors</span></a>
                            <a  title="Edit" class="menuitm menu-auto" href="?cmd=dedimgr&do=floors&colo_id={$colo.id}"
                                onclick="return editColocation('{$colo.id}')">
                                <span class="editsth"></span>
                            </a>
                            <a  onclick="return confirm('Are you sure you want to delete this colocation?');" title="delete"
                                class="menuitm menu-auto" href="?cmd=dedimgr&do=removecolo&colo_id={$colo.id}">
                                <span class="delsth"></span>
                            </a>
                        </div></td>
                        <td  style="line-height:20px">
                            <h3><a href="?cmd=dedimgr&do=floors&colo_id={$colo.id}">{$colo.name}</a></h3>
                            Floors: <a href="?cmd=dedimgr&do=floors&colo_id={$colo.id}"><strong>{$colo.floors}</strong></a><br />
                            Racks: <strong>{$colo.racks}</strong> {foreach from=$colo.rack_list item=rack}<em class="fs11" style="padding-left:20px"><a href="?cmd=dedimgr&do=rack&rack_id={$rack.id}">{$rack.name} ({$rack.units} U)</a></em>{/foreach} <em class="fs11" style="padding-left:20px"><a href="?cmd=dedimgr&do=floors&colo_id={$colo.id}">...</a></em><br />
                            {if $colo.address}<strong>Address:</strong> {$colo.address}<br />{/if}
                            {if $colo.phone}<strong>Phone:</strong> {$colo.phone}<br />{/if}
                            {if $colo.emergency_contact}<strong>Emergency:</strong> {$colo.emergency_contact}<br />{/if}
                        </td>
                        <td width="150" valign="top" style="background:#F0F0F3;color:#767679;font-size:11px">
                            <strong>Price / 1GB:</strong> {$colo.price_per_gb|price:$currency}<br />
                            <strong>Price / IP:</strong> {$colo.price_per_ip|price:$currency}<br />
                            <strong>Price / Reboot:</strong> {$colo.price_reboot|price:$currency}
                        </td>
                    </tr>
                </tbody></table></div></li>


    {/foreach}
</ul>

<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="return addColocation();" class="new_control" href="#"><span class="addsth"><strong>Add new colocation</strong></span></a>
</div>
{else}
<div class="blank_state_smaller blank_forms" id="blank_pdu">
    <div class="blank_info">
        <h1>You dont have any colocations defined yet</h1>
        Dedicated Servers module organises your inventory in Colocation->Floors->Racks->Items structures. To begin add colocation <br/><br/>


        <div class="clear"></div>
            <a onclick="return addColocation();" class="new_control" href="#"><span class="addsth"><strong>Add colocation</strong></span></a>
        <div class="clear"></div>
    </div>
</div>

{/if}