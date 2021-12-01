{* singe item ports *}
<label class="nodescr">Connected port</label>
<select  class="w250" name="port[connected_to]"   id="port_port_id"><option value="0">Not Connected</option>

{foreach from=$ports item=item}
        <option value="{$item.id}" {if $port.connected_to==$item.id}selected="selected"{/if}>
                {if $item.type == 'NIC' && $item.direction == 'in'}
                        Network ports:
                {elseif $item.type == 'NIC' && $item.direction == 'out'}
                        Switch uplink ports:
                {elseif $item.type == 'PDU' && $item.direction == 'in'}
                        In-Power sockets:
                {elseif $item.type == 'PDU' && $item.direction == 'out'}
                        PDU OUT-Power sockets:
                {/if}
                {if !$item.group_name}
                        Default:
                {else}
                        {$item.group_name}:
                {/if}
                 #{$item.number}
                {if $item.port_name} - {$item.port_name}{/if}
        </option>
        {/foreach}</select>
<div class="clear"></div>