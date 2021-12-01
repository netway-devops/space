<div class="onapptab form" id="network_tab">
    <div class="pdx">You can set custom bandwidth limit for your client Virtual Private Server here, those settings are optional</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
         <tr>
            <td width="160">
                <label >IP Address Count
                    <a class="vtip_description" title="Number of ip addresses that wll be delagated for new VPS, minimum is 1"></a>
                </label>
            </td>
            <td id="option13container">
                <input type="text" size="3" name="options[ips]" value="{$default.ips}" id="option13"/> 
                <span class="fs11"><input type="checkbox"  class="formchecker" rel="ip_address" />Allow client to adjust with slider during order</span>
            </td>
        </tr>
        <tr>
            <td width="160"><label >Port Speed [Mbps] <a class="vtip_description" title="Leave blank to unlimited."></a></label></td>
            <td id="portspeedcontainer"><input type="text" size="3" name="options[portspeed]" value="{$default.portspeed}" id="portspeed"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="portspeed"  />Allow client to select during order</span>
            </td>
        </tr>
        <tr>
            <td width="160">
                <label >Bandwidth [GB] 
                    <a class="vtip_description" title="This is a monthly limit for single VPS"></a>
                </label>
            </td>
            <td>
                <input type="text" size="3" name="options[bandwidth]" value="{$default.bandwidth}" id="option16"/>
                <span class="fs11"><input type="checkbox"  class="formchecker" rel="bandwidth" />Allow client to adjust with slider during order</span>
            </td>
        </tr>
</table>
<div class="nav-er"  id="step-5">
    <a href="#" class="prev-step">Previous step</a>
    <a href="#" class="next-step">Next step</a>
</div>
</div>