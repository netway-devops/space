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

{if $isDisplayFreeMonitor == '1'}    
    
<script type="text/javascript">    
{literal}
    $(document).ready(function () {
    	$.zabbix.makeEventViewDiscovery();
        $.zabbix.makeEventAddRowDiscoverMedia();
        /*$.zabbix.makeEventDoViewDiscoveryIp();*/ // Onclick


        $.zabbix.makeEventSwitchDiscoveryUpDown();
        $.zabbix.makeEventInputDiscoveryUpDown();
        $.zabbix.makeEventSwitchDiscoveryDownDelay();
        $.zabbix.makeEventInputDiscoveryDownDelay();
        $.zabbix.makeEventSwitchDiscoveryUpDelay();
        $.zabbix.makeEventInputDiscoveryUpDelay();
        
    });
{/literal}
</script>





<fieldset class="border">

    <legend>Discover</legend>

    <div id="zabbix-discovery-ip-display"></div>
    
    <br clear="all" />
    
    <div style="display: none;" id="container-zabbix-switch-discovery" />
    
        <div id="zabbix-discovery-display-current-ip" style="font-weight:bold;"></div>
        <br clear="all" />
    
        
        <div style="float:left;">
            <input type="checkbox" id="zabbix-switch-discovery-up-down" />
        </div>    
        <div style="float:left;">
              <table>
                  <tr>
                      <td width="120" align="right" nowrap="nowrap">
                            <label>Up/Down</label> 
                      </td>
                      <td>
                            <input  type="text" name="zabbix-discovery-up-down-value" id="zabbix-discovery-up-down-value" size="18" > seconds
                      </td>
                    </tr>
            </table>
        </div>    
        <br clear="all" />
    
        <div style="float:left;">
            <input type="checkbox" id="zabbix-switch-discovery-down-delay" />
        </div>
        <div style="float:left;"> 
               <table>
                  <tr>
                      <td width="120" align="right" nowrap="nowrap">
                            <label>Duration Down</label>
                      </td>
                      <td>
                              <input  type="text" name="zabbix-discovery-down-delay-value" id="zabbix-discovery-down-delay-value" size="18" > seconds
                      </td>
                    </tr>
            </table>
        </div>    
        <br clear="all" />
        
        
        <div style="float:left;">
            <input type="checkbox" id="zabbix-switch-discovery-up-delay" />
        </div>
        <div style="float:left;"> 
              <table>
                  <tr>
                      <td width="120" align="right" nowrap="nowrap">
                            <label>Duration Up</label> 
                      </td>
                      <td>   
                              <input  type="text" name="zabbix-discovery-up-delay-value" id="zabbix-discovery-up-delay-value" size="18" > seconds
                       </td>
                    </tr>
            </table>      
        </div>    
    
    </div>
    
    <br clear="all" />


</fieldset>

<br><br>

<fieldset class="border">

    <legend>Email Group User</legend>

    <div id="zabbix-discovery-media-display">
        {$outputDiscoveryMedia}
    </div>
    
</fieldset> 

{else}

    {$stutusFreeMonitor}

{/if} <!-- end if isStatus -->



<!-- START HIDDEN  -->
<input type="hidden" id = "account-id"  name="account-id" value="{$accountId}">
<input type="hidden" id = "server-id"  name="server-id" value="{$serverId}">

<form>
    <input type="hidden" name="inline-edit-hidden" />
</form>
<!-- END HIDDEN -->