<div class="header-bar">
    <h3 class="vmdetails hasicon">{$lang.servdetails}</h3>
</div>
{literal}
    <style>
        .status-bar {
            background: url("templates/common/cloudhosting/images/progress-bg.png") repeat scroll 0 0 #5A5A5A;
            border-bottom: 1px solid #8F8F8F;
            border-radius: 3px 3px 3px 3px;
            border-top: 1px solid #555555;
            clear: both;
            height: 20px;
            position: relative;
            overflow: hidden;
        }

        .status-bar p {
            margin: 0;
            position: relative;
            z-index: 1;
            color: white;
            padding: 0 5px
        }

        .status-bar .usage {
            background: url("templates/common/cloudhosting/images/bg_header1.png") repeat scroll 0 -14px #5A5A5A;
            border-bottom: 1px solid #2B5177;
            border-radius: 3px 3px 3px 3px;
            border-top: 1px solid #87BCE4;
            height: 18px;
            left: 1px;
            position: absolute;
            top: 0;
            z-index: 0;
        }
    </style>
{/literal}
<div class="content-bar">
    <div class="right" id="lockable-vm-menu"> {include file="`$onappdir`ajax.vmactions.tpl"} </div>

    <div class="clear"></div>
    {cloudservices section='details'
    include="../common/cloudhosting/tpl/details.tpl"
    }
    <table border="0" cellspacing="0" cellpadding="0" width="100%" class="vm-details">
        <tr>
            <td width="50%" style="padding-right:10px;">
                <table cellpadding="0" cellspacing="0" width="100%" class="ttable vm-details-part">
                    <tr>
                        <td width="120">
                            <b>{$lang.status}</b>
                        </td>
                        <td class="vm-details-switch">

                            {if $VMDetails.status =='active'}
                                <a href="{$service_url}&vpsdo=shutdown&vpsid={$VMDetails.vpsid}&security_token={$security_token}"
                                   onclick="return powerchange(this, '{$lang.sure_to_poweroff}?', '{$lang.Off}');"
                                   class="state_switch on">
                                    {$lang.On}
                                </a>
                            {else}
                                <a href="{$service_url}&vpsdo=startup&vpsid={$VMDetails.vpsid}&security_token={$security_token}"
                                   onclick="return powerchange(this, '{$lang.sure_to_power_on}?', '{$lang.On}');"
                                   class="state_switch off">
                                    {$lang.Off}
                                </a>
                            {/if}

                        </td>
                    </tr>
                    <tr>
                        <td><b>{$lang.hostname}</b></td>
                        <td>{$VMDetails.hostname}</td>
                    </tr>
                    <tr>
                        <td><b>{$lang.ipadd}</b></td>
                        <td>
                            {if $vps_ips}{$vps_ips|@implode:', '}{else}-{/if}
                        </td>
                    </tr>
                    <tr>
                        <td class="vm-details-label">
                            <b>{$lang.rootpassword}</b>
                        </td>
                        <td class="vm-details-value vm-details-password">
                            <a href="#" onclick="$(this).hide();
                                    $('#rootpss').show();
                                    return false;" style="color:red">{$lang.show}</a>
                            <span id="rootpss" style="display:none">{$VMDetails.rootpass}</span>

                            <a onclick="return confirm('{$lang.suretoresetrootpassword}? {$lang.notethatwillrebooted}');"
                               class="key-solid fs11 small_control"
                               href="{$service_url}&vpsdo=reset_root&vpsid={$vpsid}&security_token={$security_token}">
                                {$lang.reset_root}</a>

                        </td>
                    </tr>

                    <tr>
                        <td>
                            <b>{$lang.ostemplate}</b>
                        </td>
                        <td> {$VMDetails.os.name} </td>
                    </tr>
                </table>
            </td>
            <td width="50%" style="padding-left:10px;">
                <table cellpadding="0" cellspacing="0" width="100%" class="ttable vm-details-part">

                    <tr>
                        <td>
                            <b>{$lang.disk_limit}</b>
                        </td>
                        <td valign="top" style="">
                            {$VMDetails.space} GB
                        </td>
                    </tr>
                    <tr>
                        <td class="lst">
                            <b>CPU</b>
                        </td>
                        <td valign="top" style="">
                            {$VMDetails.cores} Core(s)
                        </td>
                    </tr>
                    <tr>
                        <td class="lst">
                            <b>{$lang.memory}</b>
                        </td>
                        <td valign="top" style="">
                            {$VMDetails.ram} MB
                        </td>
                    </tr>
                    <tr>
                        <td class="lst">
                            <b>{$lang.bandwidth}</b>
                        </td>
                        <td valign="top" style="">
                            {$VMDetails.bandwidth} GB
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    {/cloudservices}

</div>