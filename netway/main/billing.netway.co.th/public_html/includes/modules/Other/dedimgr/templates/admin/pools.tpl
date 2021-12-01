<h1>Hardware Pools - use this feature to group your servers accross racks and use them in auto-provisioning/assignment</h1>
<script src="{$moduledir}js/inventory.js"></script>
<ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter">

    {foreach from=$pools item=colo}

        <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
                <table width="100%" cellspacing="0" cellpadding="5" border="0">
                    <tbody><tr>
                            <td width="120" valign="top"><div style="padding:10px 0px;">
                                    <a menu-autotitle="Edit" class="menuitm menu-auto" href="#" 
                                       onclick="return toggleTypeEdit('{$colo.id}', this)">
                                        <span class="editsth"></span>  
                                    </a>
                                    <a onclick="return confirm('Are you sure you want to delete this Pool?');"
                                       title="delete" class="menuitm menu-auto" 
                                       href="?cmd=dedimgr&do=pools&make=delete&security_token={$security_token}&id={$colo.id}">
                                        <span class="delsth"></span>
                                    </a>
                                </div></td>
                            <td  style="line-height:20px">

                                <h3 id="fname_{$colo.id}">{$colo.name}</h3>
                                <div id="fform_{$colo.id}" style="display:none" class="fform_labels">
                                    <form action="" method="post">
                                        <label>
                                            <span class="l">Name:</span><input type="text" value="{$colo.name}" name="name" class="inp"/>
                                        </label>

                                        <input type="hidden" name="make" value="edit">
                                        <input type="hidden" name="id" value="{$colo.id}">

                                        <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Save">
                                        <span class="orspace">Or</span>
                                        <a class="editbtn" onclick="return toggleTypeEdit('{$colo.id}')" href="#">Cancel</a> {securitytoken}
                                    </form>
                                </div>

                            </td>

                        </tr>
                    </tbody></table></div></li>


    {foreachelse}
        <div class="blank_state_smaller blank_forms" id="blank_pdu"> <div class="blank_info"> <h1>You dont have any pools defined yet</h1>
                To begin add new pool <br><br> <div class="clear"></div><div class="clear"></div> </div> </div>
                {/foreach}
</ul>


<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();
            return false" class="new_control" href="#"><span class="addsth"><strong>Add new pool</strong></span></a>
</div>

<div class="p6" style="margin-bottom: 15px;display:none;" id="addcategory"><form action="" method="post">
        <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
            <tbody><tr>
                    <td>
                        Pool name: <input type="text" value="" name="name" class="inp"/>
                    </td>


                    <td>
                        <input type="hidden" name="make" value="add">
                        <input type="submit" class="btn btn-primary btn-sm"  style="font-weight:bold" value="Add new pool">
                        <span class="orspace">Or</span> <a class="editbtn" onclick="$('#addcategory').hide();
                            return false;" href="#">Cancel</a>
                    </td>
                </tr>
            </tbody></table>
            {securitytoken}
    </form></div>