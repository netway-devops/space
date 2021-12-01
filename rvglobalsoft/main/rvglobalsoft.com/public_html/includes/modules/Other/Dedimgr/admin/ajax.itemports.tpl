{* singe item ports *}
<label class="nodescr">Connected port</label>
<select  class="w250" name="port[connected_to]"   id="port_port_id"><option value="0">Not Connected</option>

{foreach from=$ports item=item}
        <option value="{$item.id}" {if $port.connected_to==$item.id}selected="selected"{/if} >
                {if $item.type=='PDU' && $item.direction=='in'}In socket:
                {elseif $item.type=='NIC' && $item.direction=='out'}Uplink: {/if}
                #{$item.number}</option>
        {/foreach}</select>
<div class="clear"></div>