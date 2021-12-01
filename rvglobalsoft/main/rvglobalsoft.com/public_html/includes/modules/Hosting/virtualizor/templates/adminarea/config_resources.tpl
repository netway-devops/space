<div class="onapptab form" id="resources_tab">
    <div class="odesc_ odesc_single_vm pdx">Your client Virtual Machine will be provisioned using options configured here</div>
    <div class="odesc_ odesc_cloud_vm pdx">Your client will be able to use resource with limits configured here</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
        <tr><td colspan="4" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Virtualizor, please wait...</td></tr>
 
        <tr>
            <td width="160">
                <label >Type </label>
            </td>
            <td>
                <select name="options[vpstype]" id="vpstype" style="margin:0px;" onchange="return filter_types()">
                    <option value="openvz" {if $default.vpstype=='openvz' || !$default.vpstype}selected="selected"{else}disabled="disabled"{/if}>OpenVZ</option>
                    <option value="xen" {if $default.vpstype=='xen'}selected="selected"{/if}>Xen PV</option>
                    <option value="xenhvm" {if $default.vpstype=='xenhvm'}selected="selected"{/if}>Xen HVM</option>
                    <option value="kvm" {if $default.vpstype=='kvm'}selected="selected"{/if}>KVM</option>
                </select>
            </td>
        </tr>
        
        <tr>
            <td width="160">
                <label >VPS Plan 
                    <a class="vtip_description" title="Select plan that will be used while creating new vps, if you set your own resource limits here, they will owerwrite plan values"></a>
                </label>
            </td>
            <td>
                <div id="vpsplancontainer" class="tofetch">
                    {if $default.vpsplan}
                        <select class="odesc_ odesc_single_vm disable_ disable_single_vm" name="options[vpsplan]" id="vpsplan" >
                            {if is_array($default.vpsplan)}
                                <option value="{$default.vpsplan[$default.vpstype]}" selected="selected">{$default.vpsplan[$default.vpstype]}</option>
                            {else}
                                <option value="{$default.vpsplan}" selected="selected">{$default.vpsplan}</option>
                            {/if}
                        </select>
                    {else}
                        <input class="odesc_ odesc_single_vm" name="options[vpsplan]" id="vpsplan" />
                    {/if}
                </div>
            </td>
        </tr>
        <tr>
            <td width="160">
                <label >Disk size [GB] 
                    <a class="vtip_description" title="Custom disk size, if left empty disk space allocated for new VPS will be taken from selected plan"></a>
                </label>
            </td>
            <td id="option6container"><input type="text" size="3" name="options[disksize]" value="{$default.disksize}" id="disksize"/>
                <span class="fs11"  ><input type="checkbox" class="formchecker" rel="disk_size" />Allow client to adjust with slider during order</span>
            </td>
        </tr>
        <tr>
            <td width="160">
                <label >CPU Cores
                    <a class="vtip_description odesc_ odesc_single_vm" title="If left empty, number of allocated CPUs for new VPS will be taken from selected plan"></a>
                </label>
            </td>
            <td id="cpuscontainer"><input type="text" size="3" name="options[cpus]" value="{$default.cpus}" id="cpus"/>
                <span class="fs11"><input type="checkbox" class="formchecker"  rel="cpu_cores" /> Allow client to adjust with slider during order</span>
            </td>
            <td></td>
        </tr>

        <tr>
            <td width="160">
                <label >Servers <a class="vtip_description" title="If more than one selected HostBill will choose least used Server"></a></label>
            </td>
            <td >
                <div id="servercontainer" class="tofetch">
                    <select class="multi" name="options[server][]" id="server" multiple="multiple">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.server) || empty($default.server)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.server item=vx}
                            {if $vx=='Auto-Assign'}{continue}
                            {/if}
                            <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="clear"></div>
                <span class="fs11"> <input type="checkbox" class="formchecker"  rel="server" />Allow to select by client during checkout</span>
            </td>
            <td></td>
        </tr>
        <tr>
            <td width="160">
                <label >Server Group 
                    <a class="vtip_description odesc_ odesc_single_vm" title="If Server group is set, it will be used instead of Servers settings. Selected Server group has to be valid for selected VPS Type"></a>
                </label>
            </td>
            <td>
                <div id="servergroupcontainer" class="tofetch">
                    <select name="options[servergroup]" id="servergroup" >
                        <option value="-1" {if !$default.servergroup && $default.servergroup != 0}selected="selected"{/if}>--none--</option>
                        {if $default.servergroup || $default.servergroup == 0}
                            <option value="{$default.servergroup}" selected="selected">{$default.servergroup}</option>
                        {/if}
                    </select>
                </div>
                <div class="clear"></div>
                <span class="fs11 odesc_ odesc_single_vm"> <input type="checkbox" class="formchecker"  rel="servergroup" />Allow to select by client during checkout</span>
            </td>
            <td></td>
        </tr>
    </table>
    {literal}
        <script type="text/javascript" >
            filter_types();
        </script>
    {/literal}
    <div class="nav-er"  id="step-2">
        <a href="#" class="prev-step">Previous step</a>
        <a href="#" class="next-step">Next step</a>
    </div>
</div>