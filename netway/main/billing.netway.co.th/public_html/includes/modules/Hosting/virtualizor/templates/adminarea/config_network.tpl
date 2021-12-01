<div class="onapptab form" id="network_tab">
    <div class="pdx">You can set custom bandwidth limit for your client Virtual Private Server here, those settings are
        optional
    </div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%">
        <tr>
            <td width="160">
                <label>IP Address Count
                    <a class="vtip_description odesc_ odesc_single_vm"
                       title="Number of ip addresses that wll be delagated for new VPS"></a>
                </label>
            </td>
            <td id="option13container">
                <input type="text" size="3" name="options[ips]" value="{$default.ips}" id="ips"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="ip_address"/>Allow client to adjust
                    with slider during order</span>
            </td>
        </tr>
        <tr>
            <td width="160">
                <label>IP v6 Address Count
                    <a class="vtip_description odesc_ odesc_single_vm"
                       title="Number of ip addresses that wll be delagated for new VPS"></a>
                </label>
            </td>
            <td id="option13container">
                <input type="text" size="3" name="options[ips6]" value="{$default.ips6}" id="ips6"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="ips6"/>Allow client to adjust with
                    slider during order</span>
            </td>
        </tr>
        <tr>
            <td width="160">
                <label>IP v6 Subnet Count
                    <a class="vtip_description odesc_ odesc_single_vm"
                       title="Number of ip addresses that wll be delagated for new VPS"></a>
                </label>
            </td>
            <td id="option13container">
                <input type="text" size="3" name="options[ips6_subnet]" value="{$default.ips6_subnet}"
                       id="ips6_subnet"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="ips6_subnet"/>Allow client to adjust
                    with slider during order</span>
            </td>
        </tr>
        <tr>
            <td width="160">
                <label>Network Speed [KB/s]
                    <a class="vtip_description odesc_ odesc_single_vm"
                       title="Leave blank to use plan values, set to 0 for unlimited speed."></a>
                </label>
            </td>
            <td id="portspeedcontainer">
                <input type="text" size="3" name="options[portspeed]" value="{$default.portspeed}" id="portspeed"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="portspeed"/>Allow client to select
                    during order</span>
            </td>
        </tr>
        <tr>
            <td width="160">
                <label>Upload Speed [KB/s]
                    <a class="vtip_description odesc_ odesc_single_vm"
                       title="Leave blank to use plan values, set to 0 for unlimited speed."></a>
                </label>
            </td>
            <td id="portspeedcontainer">
                <input type="text" size="3" name="options[upload_speed]" value="{$default.upload_speed}"
                       id="upload_speed"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="upload_speed"/>Allow client to select
                    during order</span>
            </td>
        </tr>
        <tr>
            <td width="160">
                <label>Bandwidth [GB]
                    <a class="vtip_description odesc_ odesc_single_vm"
                       title="This is a monthly limit for single VPS"></a>
                </label>
            </td>
            <td>
                <input type="text" size="3" name="options[bandwidth]" value="{$default.bandwidth}" id="bandwidth"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="bandwidth"/>Allow client to adjust
                    with slider during order</span>
            </td>
        </tr>
        <tr class="odesc_ odesc_single_vm">
            <td width="160"><label>NIC Type </label></td>
            <td id="nic_typecontainer">
                <select name="options[nic_type]" id="nic_type">
                    <option value="default" {if $default.nic_type == 'default'}selected{/if}>Realtek 8139</option>
                    <option value="e1000" {if $default.nic_type == 'e1000'}selected{/if}>Intel E1000</option>
                    <option value="virtio" {if $default.nic_type == 'virtio'}selected{/if}>Virtio</option>
                    <option value="ne2k_pci" {if $default.nic_type == 'ne2k_pci'}selected{/if}>Novell NE2000 PCI</option>
                    <option value="i82559er" {if $default.nic_type == 'i82559er'}selected{/if}>Intel i82559er</option>
                    <option value="pcnet" {if $default.nic_type == 'pcnet'}selected{/if}>AMD PCNET</option>
                    <option value="ne2k_isa" {if $default.nic_type == 'ne2k_isa'}selected{/if}>Novell E2000 ISA</option>
                </select>
            </td>
        </tr>
        <tr class="odesc_ odesc_single_vm">
            <td width="160"><label>VIF Type </label></td>
            <td id="vif_typecontainer">
                <select name="options[vif_type]" id="vif_type">
                    <option {if $default.nic_type == 'netfront'}selected{/if}>netfront</option>
                    <option {if $default.nic_type == 'ioemu'}selected{/if}>ioemu</option>
                </select>
            </td>
        </tr>
        <tr class="odesc_ odesc_single_vm">
            <td width="160"><label>IP Pool </label></td>
            <td id="ippoolidcontainer">
                <div class="tofetch" style="display:inline">
                    <input type="text" size="50" name="options[ippoolid]" value="{$default.ippoolid}" id="ippoolid"/>
                </div>
            </td>
        </tr>
        <tr>
            <td width="160"><label>Number of internal IPs</label></td>
            <td id="numberinternalipcontainer">
                <input type="text" size="3" name="options[numberinternalip]" value="{if $default.numberinternalip}{$default.numberinternalip}{else}0{/if}" id="numberinternalip"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="numberinternalip"/>Allow client to adjust with slider during order</span>
            </td>
        </tr>
        <tr class="odesc_ odesc_single_vm">
            <td width="160"><label>Internal IP Pool</label></td>
            <td id="internalippoolcontainer">
                <div class="tofetch" style="display:inline">
                    <input type="text" size="50" name="options[internalippool]" value="{$default.internalippool}" id="internalippool"/>
                </div>
            </td>
        </tr>
    </table>
    <div class="nav-er" id="step-5">
        <a href="#" class="prev-step">Previous step</a>
        <a href="#" class="next-step">Next step</a>
    </div>
</div>