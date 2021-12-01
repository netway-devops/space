<div class="zabbix_info zabbix_repeat">
    {$lang.zb_info_disc}
</div>

<fieldset class="border">

    <legend>
        {$lang.zb_legend_disc}
    </legend>

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


<div class="zabbix_info zabbix_repeat">
    {$lang.zb_info_disc_emailgroup_user}
</div>


<fieldset class="border">

    <legend>
        {$lang.zb_legend_disc_emailgroup_user}
        <a href="javascript:void(0);" id="tooltip-discovery-email" rel="#tooltip-details-discovery-email" title="{$lang.zb_tooltip_tt_disc_emailgroup_user}">
            <img src="{$system_url}includes/modules/Hosting/zabbix/public_html/images/tooltip_icon.jpg" />
        </a>
    </legend>

	<div id="zabbix-discovery-media-display">
	    {$outputDiscoveryMedia}
	</div>
	
</fieldset>	