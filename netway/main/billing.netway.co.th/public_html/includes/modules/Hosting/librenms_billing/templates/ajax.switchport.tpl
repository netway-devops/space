{if !$switches}
    Error: unable to billing graphs from related LibreNMS App
{else}
<select id="librenms_switch_id" class="inp" onchange="change_librenms_sw(this);">
    {foreach from=$switches item=sw}
    <option value="{$sw.device_id}">{$sw.hostname}</option>
    {/foreach}
</select>

{foreach from=$switches item=sw name=f}
<input type="hidden" id="librenms_port_id_{$sw.device_id}" class="sw_librenms_port"
        {foreach from=$sw.ports item=i key=k}
            value="{$k}"{break}
        {/foreach}/>
{/foreach}

<input type="checkbox" value="1" checked="checked" name="billforit" id="billforit" /> Bill for this graph data
<a href="#" onclick="return assignlibrenmsPort();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>Assign</strong></span></a>
{/if}
