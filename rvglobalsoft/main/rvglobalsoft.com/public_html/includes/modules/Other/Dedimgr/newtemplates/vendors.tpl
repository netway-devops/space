<h1>Hardware vendors: </h1>
<ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter">

    {foreach from=$vendors item=colo}

    <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                        <td width="120" valign="top"><div style="padding:10px 0px;">
                                <a style="width:14px;" title="Edit" class="menuitm menuf" href="#" onclick="return editVendor('{$colo.id}')"><span class="editsth"></span></a><!--
                                --><a  onclick="return confirm('Are you sure you want to delete this Vendor??');" title="delete" class="menuitm menul" href="?cmd=module&module={$moduleid}&do=vendors&make=deletevendor&security_token={$security_token}&vendor_id={$colo.id}"><span class="delsth"></span></a>
                            </div></td>
                        <td  style="line-height:20px">
                            <h3><a href="#"  onclick="return editVendor('{$colo.id}')">{$colo.name}</a></h3>
                            {$colo.items} Items in inventory from this vendor
                        </td>
                        <td width="350" valign="top" style="background:#F0F0F3;color:#767679;font-size:11px">
                            <strong>Comments:</strong> {$colo.comments}
                        </td>
                    </tr>
                </tbody></table></div></li>


    {/foreach}
</ul>


<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="return addVendor();" class="new_control" href="#"><span class="addsth"><strong>Add new vendor</strong></span></a>
</div>