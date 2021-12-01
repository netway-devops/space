<div class="onapptab form" id="memory_tab">
    <div class="pdx">You can set custom memory limit for your client Virtual Private Server here, those settings are optional</div>
    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
        
        <tr>
            <td width="160"><label >Memory [MB]</label></td>
            <td id="memorycontainer"><input type="text" size="3" name="options[memory]" value="{$default.memory}" id="memory"/>
                <span class="fs11"/><input type="checkbox" class="formchecker"  rel="memory"> Allow client to adjust with slider during order</span>
            </td>
            <td><div class="resource"><div class="used_resource"></div></div></td>
        </tr>
        <tr class="">
            <td width="160"><label >Burst Memory or Swapspace [MB]
                    <a class="vtip_description odesc_ odesc_single_vm" title="Burst ram/Swap space must be equal or higher than guaranteed ram. If you set it too low a sum of those two will be used."></a>
                </label>
            </td>
            <td id="swapcontainer"><input type="text" size="3" name="options[swap]" value="{$default.swap}" id="swap"/>
                <span class="fs11"><input type="checkbox" class="formchecker" rel="burstmem" /> Allow client to adjust with slider during order</span>
            </td>
            <td><div class="resource"><div class="used_resource"></div></div></td>
        </tr>
    </table>
    <div class="nav-er"  id="step-2">
        <a href="#" class="prev-step">Previous step</a>
        <a href="#" class="next-step">Next step</a>
    </div>
</div>