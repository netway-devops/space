{if !$switches}
Error: unable to load switches from related Cacti App
{else}
<select id="cacti_switch_id" class="inp" onchange="change_cacti_sw(this);">
    {foreach from=$switches item=sw}
    <option value="{$sw.id}">{$sw.description} - {$sw.hostname}</option>
    {/foreach}
</select>

Port:
{foreach from=$switches item=sw name=f}
<select id="cacti_port_id_{$sw.id}" class="inp sw_cacti_port" {if !$smarty.foreach.f.first}style="display:none"{/if}>
        {foreach from=$sw.ports item=i key=k}
        <option value="{$k}">{$i.ifName} - {$i.ifDescr}</option>
    {/foreach}
</select>
{/foreach}

<a href="#" onclick="return assignCactiPort();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>Assign</strong></span></a>
{/if}
