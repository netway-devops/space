{if !$switches}
Error: unable to load switches from related Observium App
{else}
<select id="observium_switch_id" class="inp" onchange="change_observium_sw(this);">
    {foreach from=$switches item=sw}
    <option value="{$sw.device_id}">{$sw.hostname}</option>
    {/foreach}
</select>

Port:
{foreach from=$switches item=sw name=f}
<select id="observium_port_id_{$sw.device_id}" class="inp sw_observium_port" {if !$smarty.foreach.f.first}style="display:none"{/if}>
        {foreach from=$sw.ports item=i key=k}
        <option value="{$k}">{$i}</option>
    {/foreach}
</select>
{/foreach}

<a href="#" onclick="return assignobserviumPort();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>Assign</strong></span></a>
{/if}
