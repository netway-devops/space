{if !$ajax}
<a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
<link media="all" type="text/css" rel="stylesheet" href="includes/types/oresell/clientarea/styles3.css" />
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
{/if}
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
        {if !$ajax}
    </tbody>

</table>

{literal}
<script type="text/javascript">
    function powerchange(el) {
        if($(el).hasClass('iphone_switch_container_on')) {
            if(confirm('Are you sure you want to Power OFF this VM?')) {
                $(el).removeClass('iphone_switch_container_on').addClass('iphone_switch_container_off');
                window.location=$(el).attr('href')+'off';
            }
        } else if ($(el).hasClass('iphone_switch_container_off')) {
              if(confirm('Are you sure you want to Power ON this VM?')) {
            $(el).removeClass('iphone_switch_container_off').addClass('iphone_switch_container_on');
                window.location=$(el).attr('href')+'on';
            }

        }
        return false;
    }
    $(document).ready(function(){
        $('.load_vm_status').each(function(){
            var el=$(this).html("<img src='includes/types/onappcloud/images/ajax-loader.gif' />");

            $.post('?cmd=clientarea',{
                action: 'services',
                cid: '{/literal}{$cid}{literal}',
                make: 'loadvmstatus',
                vmid: el.attr('rel')
            },function(data){
               var r= parse_response(data);
                el.html(r);
            })
        })
    });

</script>
{/literal}
{/if}