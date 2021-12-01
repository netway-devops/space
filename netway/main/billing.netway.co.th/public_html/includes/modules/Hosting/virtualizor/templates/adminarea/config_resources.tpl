<div class="onapptab form" id="resources_tab">
    <div class="odesc_ odesc_single_vm pdx">Your client Virtual Machine will be provisioned using options configured here</div>
    <div class="odesc_ odesc_cloud_vm pdx">Your client will be able to use resource with limits configured here</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
        <tr><td colspan="4" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Virtualizor, please wait...</td></tr>

        <tr class="odesc_ odesc_single_vm">
            <td width="160">
                <label >Type
                    <a class="vtip_description" title="Select witch virtual server type you want to use. Type will be available if there is at least one vps plan created for it."></a>
                </label>
            </td>
            <td>
                <select name="options[vpstype]" id="vpstype" onchange="return virtualizor.filter_types()">
                    {foreach from=$virttypes item=name key=vtype}
                        <option value="{$vtype}" {if $default.vpstype==$vtype}selected="selected"{/if}>{$name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>

        <tr class="odesc_ odesc_cloud_vm odesc_reseller">
            <td width="160">
                <label >Allowed VPS types
                    <a class="vtip_description" title="Select witch virtual server types your client is allowed to build. Type will be available if there is at least one vps plan created for it."></a>
                </label>
            </td>
            <td>
                <select name="options[vpstype][]" id="vpstypes" multiple="multiple" class="multi" onchange="return virtualizor.filter_types()">
                    {foreach from=$virttypes item=name key=vtype}
                        <option value="{$vtype}" {if is_array($default.vpstype) && in_array($vtype, $default.vpstype)}selected="selected"{/if}>{$name}</option>
                    {/foreach}
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
                        <input class="odesc_ odesc_single_vm " name="options[vpsplan]" id="vpsplan" />
                    {/if}

                    <div id="vpstypeplanscontainer" class="odesc_ odesc_cloud_vm disable_ disable_cloud_vm row" >
                        {foreach from=$virttypes item=name key=vtype}
                            <div class="type_opt opt_{$vtype}  col-sm-6 col-md-4" >
                                <span>{$name}</span>
                                <select name="options[vpsplan][{$vtype}]" class="form-control">
                                    {if $default.vpsplan && !is_array($default.vpsplan) && $default.vpstype===$vtype}
                                        <option value="{$default.vpsplan}" selected="selected" >{$default.vpsplan}</option>
                                    {elseif !$default.vpsplan || !$default.vpsplan[$vtype]}
                                        <option value="" selected="selected">--none--</option>
                                    {elseif is_array($default.vpsplan) && $default.vpsplan[$vtype]}
                                        <option value="{$default.vpsplan[$vtype]}" selected="selected">{$default.vpsplan[$vtype]}</option>
                                    {/if}
                                </select> 
                            </div>
                        {/foreach}
                        <div class="type_opt opt_none col-md-12">
                            Select at least one VPS type.
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr class="odesc_ odesc_cloud_vm">
            <td width="160">
                <label >Limit VS
                    <a class="vtip_description" title="Maximum number of virtual servers that client can create. Leave 0 for unlimited"></a>
                </label>
            </td>
            <td id="num_vscontainer"><input type="text" size="3" name="options[num_vs]" value="{$default.num_vs}" id="num_vs"/>
                <span class="fs11"  ><input type="checkbox" class="formchecker" rel="num_vs" />Allow client to adjust with slider during order</span>
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
        </tr>
        <tr class="odesc_ odesc_cloud_vm">
            <td width="160">
                <label >Max CPU Cores per VM</label>
            </td>
            <td id="cpuscontainer">
                <input type="text" size="3" name="options[vm_cores]" value="{$default.vm_cores}" id="vm_cores"/>
            </td>
        </tr>
        <tr >
            <td width="160">
                <label class="odesc_ odesc_single_vm" >CPU %
                    <a class="vtip_description" title="The CPU time in percent the corresponding VPS is not allowed to exceed. Set 0 for no restriction."></a>
                </label>
                <label class="odesc_ odesc_cloud_vm">Default CPU % / Core
                    <a class="vtip_description" title="All VPS created by the user would have this CPU %. This is per core base. E.g. If user creates VM with 2 cores and percentage is 40 total 80% will be assigned."></a>
                </label>
            </td>
            <td id="num_vscontainer"><input type="text" size="3" name="options[cpu_percent]" value="{$default.cpu_percent}" id="cpu_percent"/>
                <span class="fs11"  ><input type="checkbox" class="formchecker" rel="cpu_percent" />Allow client to adjust with slider during order</span>
            </td>
        </tr>

        <tr>
            <td width="160"><label >Memory [MB]</label></td>
            <td id="memorycontainer"><input type="text" size="3" name="options[memory]" value="{$default.memory}" id="memory"/>
                <span class="fs11"/><input type="checkbox" class="formchecker"  rel="memory"> Allow client to adjust with slider during order</span>
            </td>
            <td><div class="resource"><div class="used_resource"></div></div></td>
        </tr>
        <tr class="">
            <td width="160">
                <label >Swap / Burst Memory [MB]
                    <a class="vtip_description odesc_ odesc_single_vm" title="Burst ram/Swap space must be equal or higher than guaranteed ram. If you set it too low a sum of those two will be used."></a>
                </label>
            </td>
            <td id="swapcontainer"><input type="text" size="3" name="options[swap]" value="{$default.swap}" id="swap"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="burstmem" /> Allow client to adjust with slider during order</span>
            </td>
            <td><div class="resource"><div class="used_resource"></div></div></td>
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

        <tr class="odesc_ odesc_single_vm">
            <td width="160">
                <label >Servers <a class="vtip_description" title="If more than one selected HostBill will choose least used Server"></a></label>
            </td>
            <td >
                <div id="servercontainer" class="tofetch">
                    <select class="form-control" name="options[server][]" id="server" multiple>
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
        <tr >
            <td width="160">
                <label >Server Group 
                    <a class="vtip_description odesc_ odesc_single_vm" title="If Server group is set, it will be used instead of Servers settings. Selected Server group has to be valid for selected VPS Type"></a>
                    <a class="vtip_description odesc_ odesc_cloud_vm" title="If no group is selected than the user will not be able to create any VPS"></a>
                </label>
            </td>
            <td>
                <div id="servergroupcontainer" class="tofetch">
                    <select name="options[servergroup][]" id="servergroup" multiple class="form-control">
                        <option class="odesc_ odesc_single_vm" value="-1" {if !$default.servergroup && $default.servergroup != 0}selected="selected"{/if}>--none--</option>
                        {if $default.servergroup && is_array($default.servergroup)}
                            {foreach from=$default.servergroup item=sgs}
                                <option value="{$sgs}" selected="selected">{$sgs}</option>
                            {/foreach}
                        {elseif $default.servergroup || $default.servergroup == 0}
                            <option value="{$default.servergroup}" selected="selected">{$default.servergroup}</option>
                        {/if}
                    </select>
                </div>
                <div class="clear"></div>
                <span class="fs11"> <input type="checkbox" class="formchecker"  rel="servergroup" />Allow to select by client during checkout</span>
            </td>
            <td></td>
        </tr>
        <tr class="odesc_ odesc_cloud_vm">
            <td width="160">
                <label >Number of Users
                    <a class="vtip_description" title="The maximum number of sub-users this user can create. Zero (0) for unlimited."></a>
                </label>

            </td>
            <td id="cpuscontainer">
                <input type="text" size="3" name="options[num_users]" value="{$default.num_users}" id="num_users"/>
            </td>
        </tr>

        <tr class="odesc_ odesc_single_vm">
            <td width="160"><label>Recipe </label></td>
            <td>
                <div id="recipecontainer">
                    <div class="tofetch" style="display:inline">
                        <input type="text" size="50" name="options[recipe]" value="{$default.recipe}" id="recipe"/>
                    </div>
                </div>
                <div class="clear"></div>
                <span class="fs11" ><input type="checkbox" class="formchecker osloader" rel="recipe" />Allow client to select during checkout</span>
            </td>
        </tr>

        <tr class="odesc_ odesc_single_vm">
            <td width="160"><label>Backup plan </label></td>
            <td>
                <div id="recipecontainer">
                    <div class="tofetch" style="display:inline">
                        <input type="text" size="50" name="options[bpid]" value="{$default.bpid}" id="bpid"/>
                    </div>
                </div>
                <div class="clear"></div>
                <span class="fs11" ><input type="checkbox" class="formchecker osloader" rel="bpid" />Allow client to select during checkout</span>
            </td>
        </tr>
    </table>
    <div class="nav-er"  id="step-2">
        <a href="#" class="prev-step">Previous step</a>
        <a href="#" class="next-step">Next step</a>
    </div>
</div>