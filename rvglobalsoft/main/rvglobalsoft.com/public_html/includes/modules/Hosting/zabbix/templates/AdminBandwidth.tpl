<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.ui/1.8.24/jquery-ui.min.js?v={$hb_version}"></script>
<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.ibutton/lib/jquery.ibutton.js"></script>
<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.cluetip/jquery.cluetip.js"></script>
<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.dynotable/jquery.dynotable.js"></script>
<!-- <script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.editinplace/jquery.editinplace.js"></script>  -->
<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/tooltip.js"></script>
<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/zabbix.js"></script>
<script src="{$system_url}includes/modules/Hosting/zabbix/public_html/js/ZB.js"></script>


<link href="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.ui/1.8.24/themes/base/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.ibutton/css/jquery.ibutton.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Hosting/zabbix/public_html/js/external/jquery.cluetip/jquery.cluetip.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Hosting/zabbix/public_html/themes/zabbix.css?v={$hb_version}" rel="stylesheet" media="all" />


	<script type="text/javascript">

	var system_url = "{$system_url}";

{literal}	

     $(document).ready(function () {
     	
		$.zabbix.init();
		$.tooltip.init();
	
	});
	</script>
	
{/literal}


<!-- ASSIGN VALUES -->
{assign var='currenttriggerbyte' value=''}
{assign var='currenttriggerdelay' value=''}
{assign var='currenttriggerstatus' value='1'}
{assign var='currenttriggerstatus' value='1'}
{assign var='istriggershow' value='0'}
<!-- END ASSIGN VALUES -->

<div class="zabbix_info zabbix_repeat">
    {$lang.zb_info_nt}
</div>

<fieldset class="border">

    <legend>{$lang.zb_legend_nt}</legend>

	<div id="zabbix-traffic-bandwidth-trigger-display">
	    <!-- {$outputNetworkTrafficTrigger} -->
	    <table id="network-traffic-trigger-table" cellpadding="0" cellspacing="0" width="866" class="tbl-status">
            <tbody>
                <tr>
                    <th align="left" valign="top">{$lang.zb_tb_nt_trigg_name}</th>
                    <th align="center" valign="top">{$lang.zb_tb_nt_host_name}</th>
                </tr>
                
	        {foreach from=$aNetworkTrafficTrigger key=k item=i}
	        
	            {assign var='istriggershow' value='1'}
	            {if $k == '0'}{assign var='currenttriggerbyte' value=$i.triggerbyte}{/if}
	            {if $k == '0'}{assign var='currenttriggerdelay' value=$i.itemdelay}{/if}
	            {if $k == '0'}{assign var='currenttriggerstatus' value=$i.triggerstatus}{/if}
            
                <tr>
                    <td align="left" valign="top">
                        <a href="javascript:void(0);" id="network-traffic-trigger-list-name-{$k}" attrId="network-traffic-trigger-list-name-{$k}" attrExpression="{$i.expression}" attrItemId="{$i.itemid}" attrHostId="{$i.hostid}" attrPortId="{$i.portid}" attrTriggerId="{$i.triggerid}" attrType="{$i.type}" attrTriggerByte="{$i.triggerbyte}" attrItemDelay="{$i.itemdelay}" attrTriggerStatus="{$i.triggerstatus}" attrTriggerDesc="{$i.triggerdesc}" onclick="jQuery.zabbix.makeEventDoViewNetworkTrafficTrigger('network-traffic-trigger-list-name-{$k}');">{$i.triggerdesc}</a>                       
                    </td>
                    <td align="center" valign="top">
                        {$i.hostname}
                    </td>
                </tr>
            {/foreach}
        
            </tbody>
        </table>
        
	</div>
	
	
	<br clear="all">
	
	
	<div {if $istriggershow=='0'}style="display: none;"{/if} id="container-zabbix-switch-network-traffic" />
	
	    <div id="zabbix-network-traffic-display-current-trigger" style="font-weight:bold;"></div>
	    <br clear="all" />
	
	    
	    <div style="float:left;">
	        <input type="checkbox" id="zabbix-switch-network-traffic-trigger" />
	    </div>    
	    <div style="float:left;">
	        <!-- <input  type="text" name="zabbix-switch-network-traffic-trigger-bytes-value" id="zabbix-switch-network-traffic-trigger-bytes-value" size="18" > bytes  -->
	        
		      <select id="zabbix-switch-network-traffic-trigger-bytes-select" class="selectbox" {if $currenttriggerstatus == '1'}disabled{/if} >
                {foreach from=$aSelectionNetworkTrafficByte key=k item=v}
                
                    {if $currenttriggerbyte == ''}
                        <option value="{$v}" {if $k == '0'}selected="selected"{/if}>{$v}</option>
                    {else}
                        {if $v == $currenttriggerbyte}
                            <option value="{$v}" selected="selected">{$v}</option>
                        {else}
                            <option value="{$v}" >{$v}</option>
                        {/if}
                    {/if}
                    
                    
                {/foreach}
            </select> bytes
	        
	    </div>    
	    <br clear="all">
	    <div style="float:left; margin-left:75px;margin-top:5px;">    
	        <!-- <input  type="text" name="zabbix-switch-network-traffic-items-delay-value" id="zabbix-switch-network-traffic-items-delay-value" size="18" > duration time seconds  -->
	        	        
	        <select id="zabbix-switch-network-traffic-items-delay-select" class="selectbox" {if $currenttriggerstatus == '1'}disabled{/if} >
                {foreach from=$aSelectionNetworkTrafficDelay key=k item=v}
                
                    {if $currenttriggerdelay == ''}
                        <option value="{$v}" {if $k == '0'}selected="selected"{/if}>{$v}</option>
                    {else}
                        {if $v == $currenttriggerdelay}
                            <option value="{$v}" selected="selected">{$v}</option>
                        {else}
                            <option value="{$v}" >{$v}</option>
                        {/if}
                    {/if}
                    
                {/foreach}
            </select> duration time seconds
	        
	    </div>    
	      
	
	</div>


</fieldset>


<br><br>


<div class="zabbix_info zabbix_repeat">
    {$lang.zb_info_nt_emailgroup_admin}
</div>

<fieldset class="border">

    <legend>
        {$lang.zb_legend_nt_emailgroup_admin}
        <a href="javascript:void(0);" id="tooltip-network-traffic-email" rel="#tooltip-details-network-traffic-email" title="{$lang.zb_tooltip_tt_nt_emailgroup_admin}">
            <img src="{$system_url}includes/modules/Hosting/zabbix/public_html/images/tooltip_icon.jpg" />
        </a>
    </legend>

	<div id="zabbix-traffic-bandwidth-media-display">
	    <!-- {$outputTrafficBandwidthMediaAdmin} -->
	    <table id="traffic-bandwidth-media-admin-table" cellpadding="0" cellspacing="0" width="866" class="tbl-status">
                <tbody>
                  <tr>
                    <th align="left" valign="top" width="90%">{$lang.zb_tb_nt_gr_admin}</th>
                    <th align="center" valign="top">{$lang.zb_tb_nt_delete}</th>
                </tr>
                
	    {foreach from=$aTrafficBandwidthMediaAdmin key=k item=i}
	           <tr id="tr-traffic-bandwidth-{$k}">
                    <td align="left" valign="top" class="bg">
                        <p id="inline-edit-traffic-bandwidth-media-{$k}" class="inline-edit-traffic-bandwidth-media-class" attrStatus="edit" attrMediaId="{$i.mediaid}" attrUserId="{$i.userid}" onclick="jQuery.zabbix.makeEventInlineEdit(jQuery(this), 'makeEventAddNetworkTrafficMediaAdmin');">{$i.mediasendto}</p>
                    </td>
                    <td align="center" valign="top" class="bg">      
                        <img class="traffic-bandwidth-remove-media" id="traffic-bandwidth-discovery-remove-media-{$k}" attrNum="{$k}" src="{$i.imgdelete}" alt="Remove Row" onclick="jQuery.zabbix.makeEventRemoveRowNetworkTrafficMedia(jQuery(this));"/>
                    </td>
                </tr>    
	    {/foreach}
	    
	           </tbody>
        </table>
        <div class="position"><a id="add-row-traffic-bandwidth-media-admin" href="javascript:void(0);" class="btn">{$lang.zb_tb_nt_add_email}</a></div>
	</div>

</fieldset>


<br><br>


<div class="zabbix_info zabbix_repeat">
    {$lang.zb_info_nt_graph}
</div>

<fieldset class="border">

    <legend>{$lang.zb_legend_nt_graph}</legend>

	<!-- {$outputTrafficBandwidthSelectHost}    {$outputTrafficBandwidthSelectGraph} --> 
	<div id="traffic-bandwidth-select-host-display" style="display: none;" class="left">
	    <select id="traffic-bandwidth-select-host" class="selectbox" onchange="$.zabbix.makeEventTrafficNetworkSelectHost();"></select>
	</div>
	
	<div id="traffic-bandwidth-select-graph-display" style="display: none;">
	    <select id="traffic-bandwidth-select-graph" class="selectbox" onchange="$.zabbix.makeEventTrafficBandwidthGraph();"></select>
	</div>
	
	<br clear="all" />
	
	<p>
	  <div id="traffic-bandwidth-display-value-slider"></div>
	  <br>
	</p>
	<div id="traffic-bandwidth-slider" style="margin-left:5px;"></div>
	
	<br><br>
	
	
	<div id="traffic-bandwidth-display-graph"></div>


</fieldset>


<!-- START INCLUDE FILE -->
{if $rvtooltip}
    {include file=$rvtooltip}
{/if}
<!-- END INCLUDE FILE -->

<!-- START HIDDEN  -->
<input type="hidden" id = "account-id"  name="account-id" value="{$accountId}">
<input type="hidden" id = "server-id"  name="server-id" value="{$serverId}">

<form>
    <input type="hidden" name="inline-edit-hidden" />
    <input type="hidden" name="network-traffic-trigger-info-hidden" id="network-traffic-trigger-info-hidden"/>
</form>

<!-- END HIDDEN -->