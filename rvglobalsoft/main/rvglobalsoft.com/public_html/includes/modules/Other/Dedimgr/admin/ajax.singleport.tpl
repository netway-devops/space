<h3 style="margin-bottom:10px;" class="left">
    {if $port.type=='NIC'}
    <img src="{$moduledir}icons/network-ethernet.png" alt="" style="margin-right:5px" class="left"  />
    {else}
    <img src="{$moduledir}icons/plug.png" alt="" style="margin-right:5px" class="left"  />
    {/if} <span class="left">{$port.item_label} - 
      {if $port.type=='PDU'}
    Socket
    {else}
    Port
    {/if}
    #{$port.number}
    </span>
</h3>
<a onclick="$('#porteditor').hide();return false;" class=" menuitm right" href="#"><span><b>Close</b></span></a>
<div class="clear"></div>


{if $port.type=='NIC'}
<label class="nodescr">MAC</label>
<input type="text"   size=""  class="w250" name="port[mac]" value="{$port.mac}" />
<div class="clear"></div>
<label class="nodescr">IPv4 / IPv6</label>
<input type="text"   style="width:100px"  class="w250" name="port[ipv4]" value="{$port.ipv4}" />
<input type="text"   style="width:200px"   class="w250" name="port[ipv6]" value="{$port.ipv6}" />
<div class="clear"></div>
{/if}

<label class="nodescr">Hardware port id/label</label>
<input type="text"  style="width:100px" class="w250" name="port[port_id]" value="{$port.port_id}" />
<input type="text"  style="width:200px"   class="w250" name="port[port_name]" value="{$port.port_name}" />
<div class="clear"></div>



<label class="nodescr">Connected device, rack</label>
<select  class="w250" name="port[rack_id]" default="{$port.rack_id}" id="port_rack_id" onchange="changePortRack($(this).val());"><option value="0">Not Connected</option>
{foreach from=$racks item=rack}
<option value="{$rack.id}" {if $port.rack_id==$rack.id}selected="selected"{/if}>{$rack.name} ({$rack.units} U)</option>
{/foreach}
</select>
<div class="clear"></div>

<div id="port_item_id_container" {if !$port.rack_id}style="display:none"{/if}>
{include file='ajax.rackitems.tpl'}
</div>

<div id="port_port_id_container" {if !$port.connected_id}style="display:none"{/if}>
{include file='ajax.itemports.tpl'}
</div>



<input type="hidden"  name="port[old_connected_to]" value="{$port.connected_to}" id="port_old_connected_to"/>
<input type="hidden"  name="port[type]" value="{$port.type}" id="port_type" />
<input type="hidden"  name="port[id]" value="{$port.id}" id="port_id"/>
<input type="hidden"  name="port[item_id]" value="{$port.item_id}"/>
<input type="hidden"   name="port[direction]" value="{$port.direction}" />
<input type="hidden"    name="port[old_ipv4]" value="{$port.ipv4}" />
<input type="hidden"     name="port[old_ipv6]" value="{$port.ipv6}" />

<a onclick="savePortForm('{$port.id}');return false" href="#" class="new_control greenbtn left"><span>Update port details</span></a>
{if $ipam &&  $port.type=='NIC'}<span class="left"><input type="checkbox" value="1" name="port[ipam]" checked="checked" /> <span class="orspace fs11">Update IP assignments in IPAM</span></span>{/if}

<a onclick="$('#porteditor').hide();return false;" class=" menuitm right" href="#"><span>Close</span></a>
{literal}
<script>


    function savePortForm(id) {
        var s = $('input,select','#porteditor').serialize();
        $('.spinner').show();
        $.post('?cmd=module&module=dedimgr&do=saveport&'+s,{},function(data) {
            $('#porteditor').hide();
            $('.spinner').hide();
            refreshports();

        })
    };
function changePortRack(v) {
    //load items
    if(v=='0') {
        $('#port_item_id_container').hide().html('');
        $('#port_port_id_container').hide().html('');
        return;
    }
    $('#port_item_id_container').html('').show();
    $('#port_port_id_container').html('').show();
    ajax_update('?cmd=module&module=dedimgr&do=rackitms&rack_id='+v,{},'#port_item_id_container');
}
function changePortItem(e) {
    //load ports
    var v = $(e).val();
    $('#port_port_id_container').html('');
    if(v=='0') {
        $('#port_port_id_container').hide();
        return;
    }
    $('#port_port_id_container').show();
    ajax_update('?cmd=module&module=dedimgr&do=itemports&item_id='+v,{
        old: $('#port_old_connected_to').val(),
        type: $('#port_type').val(),
        id: $('#port_id').val()
    },'#port_port_id_container');

}

   
</script>
{/literal}