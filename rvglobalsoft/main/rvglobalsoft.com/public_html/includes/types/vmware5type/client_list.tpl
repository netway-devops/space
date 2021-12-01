<link media="all" type="text/css" rel="stylesheet" href="includes/types/onappcloud/clientarea/styles3.css" />

<a href="?cmd=clientarea&amp;action=services" id="currentlist" style="display:none" updater="#updater"></a>
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="tonapp">

    <thead>
        <tr>
			<th width="66"></th>
            <th>{$lang.hostname}</th>
            <th width="100">{$lang.ipadd}</th>
            <th width="70">Disk Space</th>
            <th width="70">Memory</th>
            <th width="80">Price</th>
            <th width="80">{$lang.status}</th>
        </tr>
    </thead>
    <tbody id="updater">

        {foreach from=$services item=service name=foo}
        <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if} >
                {if $service.status=='Active'}
                    <td class="load_vm_status" rel="{$service.id}"></td>
                {else}
                    <td></td>
                {/if}
                <td ><a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}" style="text-decoration:none"><strong>{$service.domain}</strong></a></td>
                <td  align="center">{if $service.status=='Active' && $service.vpsip}{$service.vpsip}{else}-{/if}</td>

            <td>{$service.disk_limit} GB</td>
            <td>{$service.mem_limit} MB</td>
           

            <td>{$service.total|price:$currency} <span class="fs11">{$lang[$service.billingcycle]}</span></td>
            <td ><span class="{$service.status}">{$lang[$service.status]}</span></td>
        </tr>
        {/foreach}
    </tbody>

</table>

{literal}
<script type="text/javascript">
    function powerchange(el) {
        if($(el).hasClass('iphone_switch_container_on')) {
            if(confirm('Are you sure you want to Power OFF this VM?')) {
				loadStatus($(el).parent(),'poweroff');
            }
        } else if ($(el).hasClass('iphone_switch_container_off')) {
              if(confirm('Are you sure you want to Power ON this VM?')) {
				loadStatus($(el).parent(),'poweron');
            }

        }
        return false;
    }
    $(document).ready(function(){
        $('.load_vm_status').each(function(){
           loadStatus(this,'loadvmstatus');
        })
    });
	function loadStatus(thi, make){
		var el=$(thi).html("<img src='includes/types/onappcloud/images/ajax-loader.gif' />");
		$.post('?cmd=clientarea',{
			action: 'services',
			cid: '{/literal}{$cid}{literal}',
			make: make,
			vmid: el.attr('rel')
		},function(data){
			var r= parse_response(data);
			el.html(r);
		})	
	}

</script>
{/literal}