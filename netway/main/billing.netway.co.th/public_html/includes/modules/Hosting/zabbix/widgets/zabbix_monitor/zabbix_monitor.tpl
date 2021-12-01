<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.ui/1.8.24/jquery-ui.min.js?v={$hb_version}"></script>
<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.ibutton/lib/jquery.ibutton.js"></script>
<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/zabbix.js"></script>
<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/ZB.js"></script>

<link href="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.ui/1.8.24/themes/base/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.ibutton/css/jquery.ibutton.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Hosting/zabbix/public_html/themes/zabbix.css?v={$hb_version}" rel="stylesheet" media="all" />

<script type="text/javascript">
    var system_url = "{$system_url}";
</script>    

<script type="text/javascript">
{literal}
    $(document).ready(function () {

    	// UI
    	$.zabbix.makeUiPing();
        $.zabbix.makeUiUserMedia();

        // EVENT
        $.zabbix.makeEvent();
        
    });
{/literal}
</script>



<div style="float:left;">
<input type="checkbox" id="zabbix-switch-action-ping" checked /> 
</div>
<div style="float:left;">
 ถ้า down email จะแจ้งทันทีและแจ้งซ้ำทุกๆ 
<input  type="text" name="zabbix-action-ping-esc-period" id="zabbix-action-ping-esc-period" value="600" size="6" maxlength="6" style="text-align: right;"> 
seconds จนกว่าเครื่องจะ up
</div>

<br><br><br><br>

<div id="zabbix-user-media-display"></div>




<!-- START INCLUDE FILE -->
{if $rvtooltip}
    {include file=$rvtooltip}
{/if}
<!-- END INCLUDE FILE -->

<!-- START HIDDEN  -->
<input type="hidden" id = "account-id"  name="account-id" value="{$accountId}">
<input type="hidden" id = "server-id"  name="server-id" value="{$serverId}">
<input type="hidden" id = "client-id"  name="client-id" value="{$clientId}">

<form>
    <input type="hidden" name="inline-edit-hidden" />
    <input type="hidden" name="network-traffic-trigger-info-hidden" id="network-traffic-trigger-info-hidden"/>
</form>

<!-- END HIDDEN -->