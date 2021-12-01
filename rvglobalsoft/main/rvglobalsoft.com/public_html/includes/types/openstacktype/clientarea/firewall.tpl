<h4>Security groups attached to this machine:</h4>
<table class="data-table backups-list"  width="100%" cellspacing=0>
        <thead>
            <tr>
                <td>Name</td>
                <td>Description</td>
                <td>&nbsp;</td>
            </tr>
        </thead>
        {foreach item=group from=$groups.assigned name=ruleloop}
										
        <tr>
                <td>{$group.name}</td>
                <td>{$group.description}</td>
           
            <td  style="text-align:right">
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=securitygroup&vpsid={$vpsid}&security_group_id={$group.id}" class="small_control small_pencil fs11" >Edit rules</a>
                <a class="small_control small_delete fs11" onclick="return  confirm('Are you sure you want to detach this group from this virtual machine?')" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall&vpsid={$vpsid}&name={$group.name}&do=detach&security_token={$security_token}">Detach</a>
            </td>
        </tr>
        {foreachelse}
        <tr>
            <td colspan="3">No security groups are assigned to this virtual machine yet</td>
        </tr>
        {/foreach}
 </table>

<div class="clear"></div>
<br/><br/>
<h4>Other available security groups:</h4>


<table class="data-table backups-list"  width="100%" cellspacing=0>
        <thead>
            <tr>
                <td>Name</td>
                <td>Description</td>
                <td>&nbsp;</td>
            </tr>
        </thead>
        {foreach item=group from=$groups.all name=ruleloop}

        <tr>
                <td>{$group.name}</td>
                <td>{$group.description}</td>

            <td  style="text-align:right">
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=securitygroup&vpsid={$vpsid}&security_group_id={$group.id}" class="small_control small_pencil fs11" >Edit rules</a>
                <a class="small_control small_up fs11" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall&vpsid={$vpsid}&name={$group.name}&do=attach&security_token={$security_token}">Attach to this VM</a>
                <a class="small_control small_delete fs11" onclick="return  confirm('Are you sure you want to remove this group?')" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall&vpsid={$vpsid}&security_group_id={$group.id}&do=delete&security_token={$security_token}">Delete</a>
            </td>
        </tr>
        {foreachelse}
        <tr>
            <td colspan="3">No other security groups are available in your cloud</td>
        </tr>
        {/foreach}
 </table>


<input type="button" class="blue" style="margin-top:10px;" onclick="$(this).hide();$('#fcreate').show();" value="Create new security group" />


<form method="post" action="" style="background:#F5F5F5;display:none;margin-top:20px;padding:10px;" id="fcreate">
<div class="clear"></div>
<h4>Create new security group:</h4>
    <input type="hidden" name="do" value="create"/>
    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
        <tbody><tr>
                <td colspan="2"><span class="slabel">Name</span>
                         <input type="text" id="id_name" name="name">
</td></tr>
            <tr>
                <td colspan="2"><span class="slabel">Description</span>
                        <input type="text" id="id_description" name="description">
</td></tr>
            <tr><td align="center" style="border-bottom:none" colspan="2"> <input type="submit" class="blue" name="changeos" value="Create new group" /></td></tr>
        </tbody></table>

{securitytoken}</form>