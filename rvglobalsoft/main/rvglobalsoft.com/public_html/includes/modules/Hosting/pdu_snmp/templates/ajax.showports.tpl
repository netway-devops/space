{if $ports}
<select name="pdu_port_id" id="pdu_port_id" class="inp">
    {foreach from=$ports item=port key=k}
    <option value="{$k}">{$port}</option>
    {/foreach}
</select>

<a href="#" onclick="return assignPort();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>Assign</strong></span></a>
{else}
    Unable to list ports
{/if}