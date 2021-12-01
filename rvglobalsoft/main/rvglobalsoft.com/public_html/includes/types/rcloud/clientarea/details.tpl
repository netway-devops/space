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
                            <b>{$lang.status}</b>
                        </td>
                        <td style="padding:8px 5px 9px;">
                                {$VMDetails.hrstatus}  
								{if $VMDetails.status != 'ACTIVE' && $VMDetails.status!='VERIFY_RESIZE'}{$VMDetails.progress}% <a class="fs11" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$VMDetails.id}" style="padding-left:10px;">{$lang.refresh}</a>{/if}
                            </td>
                    </tr>
                    <tr>
                        <td ><b>{$lang.hostname}</b> </td>
                        <td >{$VMDetails.name}</td>
                    </tr>
                    <tr>
                        <td ><b>{$lang.ipadd}</b> </td>
                        <td>{foreach from=$VMDetails.addresses.public item=ipp name=ssff}{$ipp}{if !$smarty.foreach.ssff.last},{/if} {/foreach}</td>
                    </tr>
                    <tr>
                        <td >
                            <b>{$lang.rootpassword}</b>
                        </td>
                        <td>
                            <span id="rootpss" style="display:none">
                                {$VMDetails.rootpassword}</span> 
                                <a onclick="return confirm('Are you sure you wish to reset root password? Note that VM will be rebooted');" class="key-solid fs11 small_control" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reset_root&vpsid={$vpsid}&security_token={$security_token}">{$lang.reset_root}</a></td>
                    </tr>
                    <tr class="lst">
                        <td >
                            <b>{$lang.ostemplate}</b>
                        </td>
                        <td > {$VMDetails.os} </td>
                    </tr>

                </table>
            </td>
            <td width="50%" style="padding-left:10px; vertical-align: top">
                <table  cellpadding="0" cellspacing="0" width="100%" class="ttable">
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

                </table>
            </td>
        </tr>
    </table>


</div>