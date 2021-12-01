<div class="header-bar">
    <h3 class="vmdetails hasicon">{$lang.servdetails}</h3>
</div>
<div class="content-bar" >
   <div class="right" id="lockable-vm-menu"> {include file="`$cloudstackdir`ajax.vmactions.tpl"} </div>
    
    <div class="clear"></div>

    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td width="50%" style="padding-right:10px;" valign="top">
                <table cellpadding="0" cellspacing="0" width="100%" class="ttable">
                    <tr>
                        <td width="120">
                            <b>{$lang.status}</b>
                        </td>
                        <td style="padding:8px 5px 9px;">
                            {if $VMDetails.locked=='false'}
                                {if $VMDetails.power=='true'}
                                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweroff&vpsid={$VMDetails.id}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_on" onclick="return powerchange(this,'Are you sure you want to Power OFF this VM?');"><img src="includes/types/cloudstacktype/images/iphone_switch_container_off.png" alt="" /></a>

                                {else}
                                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweron&vpsid={$VMDetails.id}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_off" onclick="return powerchange(this,'Are you sure you want to Power ON this VM?');"><img src="includes/types/cloudstacktype/images/iphone_switch_container_off.png" alt="" /></a>
                                
                                {/if}
                            {else}
                                 <a  class="iphone_switch_container iphone_switch_container_pending left"><img src="includes/types/cloudstacktype/images/iphone_switch_container_off.png" alt="" /></a>
                                 <a class="fs11" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$VMDetails.id}" style="padding-left:10px;">{$lang.refresh}</a>
                             {/if}

                            </td>
                    </tr>
                    <tr>
                        <td ><b>{$lang.hostname}</b> </td>
                        <td >{$VMDetails.hostname}</td>
                    </tr>
                    <tr>
                        <td ><b>{$lang.ipadd}</b> </td>
                        <td>
                            {foreach from=$VMDetails.ip item=ipp key=nic name=ssff}
                                {if $VMDetails.static_nat[$nic]}{$VMDetails.static_nat[$nic]}
                                {elseif $VMDetails.source_nat[$nic]}
                                    <span class="vtip_description" style="background: none; padding: 0;" title="Source NAT, Local IP: {$ipp}">{$VMDetails.source_nat[$nic]}*</span>
                                {else}{$ipp}
                                {/if}
                                {if !$smarty.foreach.ssff.last},
                                {/if} 
                            {/foreach}
                        </td>
                    </tr>
                   
                    {if $VMDetails.passwordenabled}
                    <tr>
                        <td >
                            <b>{$lang.rootpassword}</b>
                        </td>
                        <td id="rootpsstd">
                            {if $VMDetails.rootpassword && $VMDetails.rootpassword != '_pending_reset_'}
                                <a href="#" onclick="$(this).hide();$('#rootpss').show();return false;" style="color:red">{$lang.show}</a>
                                <span id="rootpss" style="display:none">{$VMDetails.rootpassword}</span>
                            {/if}
                            <a class="key-solid fs11 small_control" 
                               {if $VMDetails.power=='true'}href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=poweroff&resetroot=true&security_token={$security_token}" onclick="return confirm('{$lang.turnoffbeforereset} {$lang.sure_to_shutdown}?')"
                               {else} href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=resetroot&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.resetpassconfirm}');" 
                               {/if}>
                                {if $VMDetails.rootpassword}
                                    {$lang.reset_root}
                                {else}
                                    {$lang.newrootpasword}
                                {/if}
                            </a>
                        </td>
                    </tr>
                    {/if}
                    <tr class="lst">
                        <td >
                            <b>{$lang.ostemplate}</b>
                        </td>
                        <td > {$VMDetails.os} </td>
                    </tr>
                </table>
            </td>
            <td width="50%" style="padding-left:10px;">
                <table  cellpadding="0" cellspacing="0" width="100%" class="ttable">
                    <tr>
                        <td width="120">
                            <b>{$lang.bwused}</b>
                        </td>
                        <td>  {$vpsdetails.bwused} {$vpsdetails.bandwidth_s}</td>
                    </tr>

                      <tr >
                        <td >
                            <b>{$lang.cpucharts}</b>
                        </td>
                        <td > {$VMDetails.cpuused} </td>
                    </tr>

                    <tr>
                        <td  >
                            <b>{$lang.disk_limit}</b>
                        </td>
                        <td >
                            {$VMDetails.disk_size} GB

                        </td>
                    </tr>
                    <tr>
                        <td >
                            <b>{$lang.memory}</b>
                        </td>
                        <td >
                            {$VMDetails.memory} MB
                        </td>
                    </tr>

                    <tr class="lst">
                        <td  >
                            <b>{$lang.cpus}</b>
                        </td>
                        <td valign="top" style="">
                            {$VMDetails.cpus} x {$VMDetails.cpu_shares}

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>


</div>