{if $vpsaddons.disk.available}<div id="addon_bar" style="display:none; padding:20px 10px;">
									{foreach from=$alladdons item=i}
									{if $i.module=='class.onapp_diskspace.php'}

    <form name="" action="?cmd=cart&cat_id=addons" method="post">
        <input name="action" type="hidden" value="add">
        <input name="id" type="hidden" value="{$i.id}">
        <input name="account_id" type="hidden" value="{$service.id}">

        <table width="100%" cellspacing=0 cellpadding=5>
            <tbody>
                <tr>
                    <td >
                        <strong>{$i.name}</strong>{if $i.description!=''}<br />{$i.description}{/if}
                    </td><td>
                        {if $i.paytype=='Free'}
                        <input type="hidden" name="addon_cycles[{$i.id}]" value="free" />
                        {$lang.price}:<strong> {$lang.Free}</strong>

                        {elseif $i.paytype=='Once'}
                        <input type="hidden" name="addon_cycles[{$i.id}]" value="once" />
                        {$lang.price}: {$i.m|price:$currency} {$lang.once} / {$i.m_setup|price:$currency} {$lang.setupfee}
                        {else}
                        <select name="addon_cycles[{$i.id}]" >
	 {if $i.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$i.d|price:$currency} {$lang.d}{if $i.d_setup!=0} + {$i.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$i.w|price:$currency} {$lang.w}{if $i.w_setup!=0} + {$i.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$i.m|price:$currency} {$lang.m}{if $i.m_setup!=0} + {$i.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$i.q|price:$currency} {$lang.q}{if $i.q_setup!=0} + {$i.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$i.s|price:$currency} {$lang.s}{if $i.s_setup!=0} + {$i.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$i.a|price:$currency} {$lang.a}{if $i.a_setup!=0} + {$i.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$i.b|price:$currency} {$lang.b}{if $i.b_setup!=0} + {$i.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$i.t|price:$currency} {$lang.t}{if $i.t_setup!=0} + {$i.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
						</select>

                        {/if}
                        <br />
                    </td>
                    <td width="25%" align="right">
                        <input type="submit" value="{$lang.ordernow}" style="font-weight:bold;" class="blue"/>
                        <span class="fs11">{$lang.or} <a href="#" onclick="$('#addon_bar').hide();return false" class="fs11" >{$lang.cancel}</a></span>
                    </td>
                </tr>
            </tbody>
        </table>

    </form>

			{/if}
		{/foreach}
</div>{/if}
{if !$do}
<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td>{$lang.size}</td>
            <td>{$lang.type}</td>
            <td>{$lang.Built}</td>
            <td>{$lang.Autobackup}</td>
            <td width="120"></td>
        </tr>
    </thead>
    {foreach item=disk from=$disks}
    <tr>
        <td align="right">{$disk->_disk_size} GB</td>
        <td>
            {if $disk->_primary == "true"}
                {$lang.standardpri}
            {elseif $disk->_is_swap == "true"}
                {$lang.swaplabel}
            {else}
                {$lang.standardd}
            {/if}
        </td>
        <td>
            {if $disk->_built == "true"}
            {$lang.yes}
            {else}
            {$lang.no}
            {/if}
        </td>&nbsp;<td>
            {if $disk->_is_swap != "true" && $disk->_locked!="true"}
                                    	 {if $disk->_has_autobackups == "true"}
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}&do=autobackupoff&diskid={$disk->_id}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_on" onclick="return powerchange(this,'Disable autobackup?');"><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>

            {else}
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}&do=autobackupon&diskid={$disk->_id}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_off" onclick="return powerchange(this,'Enable autobackup?');"><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>

            {/if}


            {/if}
        </td>
        <td>
            {if $disk->_is_swap != "true"}
									{if $disk->_locked=="true"}
									{$lang.locked}
									{else}
          {if $o_sections.o_editdisk}  <a title="{$lang.edit}" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&do=editor&diskid={$disk->_id}&vpsid={$vpsid}" class="small_control small_pencil fs11" >
                {$lang.edit}
            </a> &nbsp;&nbsp;&nbsp;&nbsp; {/if}

            <a title="{$lang.backup}" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backups&do=create&diskid={$disk->_id}&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.suretocreatebkp}');" class="small_control small_backup fs11" >
                {$lang.backup}
            </a>
           {if $showschedules} <br/>
             <a title="{$lang.backupschedule}" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backupschedule&diskid={$disk->_id}&vpsid={$vpsid}" class="small_control small_backup_schedule fs11" >
                {$lang.backupschedule}
            </a>{/if}

            {if $disk->_primary == "true"}
            {elseif $disk->_is_swap == "true"}
            {else} <br/><a title="{$lang.delete}" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&do=delete&diskid={$disk->_id}&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.suretoremovedisk1}');" class="small_control small_delete fs11" >
                {$lang.delete}
            </a>
            {/if}
									{/if}

            {/if}
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="5">{$lang.nothing}</td>
    </tr>
    {/foreach}
</table>
<div style="padding:10px 0px;text-align:right">
    
{if $vpsaddons.disk.available} <input type="button" class="gray" onclick="$('#addon_bar').toggle();return false;" value="{$lang.orderextradisk}"/>{/if}

{if $provisioning_type=='cloud' && $o_sections.o_adddisk}
<input type="button" class="blue" onclick="window.location='?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&do=adddisk&vpsid={$vpsid}'" value="Add new disk"/>
{/if}
</div>

{elseif $do=='editdisk'}
<form method="post" action="">
    <input type="hidden" value="editdisk" name="make" />

    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">

        <tr>
            <td colspan="2">
                <div class='input-with-slider'>
                    <span class="slabel">{$lang.diskspace}</span>
                    <input type="text" size="4" required="required" name="disk_size" class="styled" value="{$editdisk.current}" id="disk_size"/>
                    GB
                    <div class='slider' max='{$editdisk.max}' min='{$editdisk.min}' step='1' target='#disk_size'></div>
                </div>

            </td>

        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" class="padded blue" style="font-weight: bold;" value="{$lang.savechanges}" onclick="return confirm('{$lang.diskconfirm1}')"/>
                <input type="button" class="padded gray" value="{$lang.cancel}"  style="font-weight:normal" onclick="window.location='?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}'"/>
            </td></tr>
    </table>{securitytoken}
</form><script type="text/javascript">
    {literal}
    $(document).ready(function(){
        init_sliders();
    });
    {/literal}
</script>

                                                                        {elseif $do=='adddisk'}<div style="padding:15px">
 <h3>{$lang.addnewdisk}</h3>
</div>
                                                                       
<form method="post" action="">
    <input type="hidden" value="adddisk" name="make" />

    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">

        <tr>
            <td colspan="2">
                <div class='input-with-slider'>
                    <span class="slabel">{$lang.diskspace}</span>
                    <input type="text" size="4" required="required" name="disk[disk_size]" class="styled" value="0" id="disk_size"/>
                    GB
                    <div class='slider' max='{$editdisk.max}' min='{$editdisk.min}' step='1' target='#disk_size'></div>
                </div>
                <div class="clear"></div>

                 <span class="slabel">{$lang.storagedc}</span>
                    <select name="disk[data_store_id]" id="virtual_machine_data_zone_id"  style="min-width:250px;" >
                            {foreach from=$zones item=zone}
                                <option value="{$zone.id}" {if $submit.disk.data_zone_id==$zone.id}selected="selected"{/if}>{$zone.label}</option>
                            {/foreach}
                    </select>


            </td>
        </tr>
        <tr>
            <td colspan="2"><span class="slabel">{$lang.swapspace}</span>
                <input name="disk[is_swap]"  value="1" type="checkbox" style="margin:8px 20px 0px;"/></td>
        </tr>
        <tr>
            <td colspan="2"><span class="slabel">{$lang.requireformat}</span>
                <input name="disk[require_format_disk]"  checked="checked" value="1" type="checkbox" style="margin:8px 20px 0px;"/></td>
        </tr>
        <tr>
            <td colspan="2"><span class="slabel">{$lang.add_to_linux_fstab}</span>
                <input name="disk[add_to_linux_fstab]"  value="1" type="checkbox" style="margin:8px 20px 0px;"/></td>
        </tr>

        <tr>
            <td colspan="2"><span class="slabel">{$lang.mount_point}</span>
                <input name="disk[mount_point]"  type="text"class="styled" value="{$submit.disk.mount_point}" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" class="padded blue" style="font-weight: bold;" value="{$lang.addnewdisk}" />
                <input type="button" class="padded gray" value="{$lang.cancel}"  style="font-weight:normal" onclick="window.location='?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}'"/>
            </td></tr>
    </table>{securitytoken}
</form><script type="text/javascript">
    {literal}
    $(document).ready(function(){
        init_sliders();
    });
    {/literal}
</script>
									{/if}