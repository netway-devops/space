<div class="header-bar">
    <h3 class="vmdetails hasicon">{$lang.servdetails}</h3>
</div>
<div class="content-bar" >
   <div class="right" id="lockable-vm-menu"> {include file="`$reselldir`ajax.vmactions.tpl"} </div>
    
    <div class="clear"></div>

    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td width="50%" style="padding-right:10px;">
                <table cellpadding="0" cellspacing="0" width="100%" class="ttable">
                     <tr>
                        <td width="120">
                            <b>{$lang.hostname}</b>
                        </td>
                        <td >{$VMDetails.hostname}</td>
                    </tr>
                    <tr>
                        <td width="120">
                            <b>{$lang.status}</b>
                        </td>
                        <td style="padding:8px 5px 9px;">
                            {if $VMDetails.powerState=='poweredOn' || $VMDetails.powerState=='poweredOff'}
                                {if $VMDetails.powerState=='poweredOn'}
                                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweroff&vpsid={$VMDetails.uuid}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_on" onclick="return powerchange(this,'Are you sure you want to Power OFF this VM?');"><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>

                                {else}
                                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweron&vpsid={$VMDetails.uuid}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_off" onclick="return powerchange(this,'Are you sure you want to Power ON this VM?');"><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>
                                
                                {/if}
                            {else}
                                 <a  class="iphone_switch_container iphone_switch_container_pending left"><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>
                                 <a class="fs11" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$VMDetails.id}" style="padding-left:10px;">{$lang.refresh}</a>
                             {/if}

                            </td>
                    </tr>
                    <tr class="lst">
                        <td >
                            <b>{$lang.ostemplate}</b>
                        </td>
                        <td >{$VMDetails.guestOS}</td>
                    </tr>

                </table>
            </td>
            <td width="50%" style="padding-left:10px; vertical-align: top">
                <table  cellpadding="0" cellspacing="0" width="100%" class="ttable">
                     <tr>
                        <td>
                            <b>{$lang.disk_limit}</b>
                        </td>
                        <td >
                            {$VMDetails.diskSpaceGB} GB

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>{$lang.memory}</b>
                        </td>
                        <td >
                            {$VMDetails.memoryMB} MB
                        </td>
                    </tr>
					<tr>
                        <td>
                            <b>{$lang.cpucores}</b>
                        </td>
                        <td>
                            {$VMDetails.numCPU} CPU(s)
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>


</div>