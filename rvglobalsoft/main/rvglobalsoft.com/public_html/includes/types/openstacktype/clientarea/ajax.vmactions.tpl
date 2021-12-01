     <div id="lock" {if $VMDetails.task!='None'}style="display:block"{/if}>
          <img src="includes/types/openstacktype/images/ajax-loader.gif" alt=""> {$lang.server_performing_task}: <span style="color:red">{$VMDetails.task}</span> <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}"><b>{$lang.refresh}</b></a>
                  </div>
    <ul id="vm-menu" class="right">
         {if $VMDetails.power=='true'}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=console&vpsid={$vpsid}"><img alt="Console" src="includes/types/openstacktype/images/icons/24_terminal.png"><br>{$lang.console}</a>
        </li>
       {if $op_sections.op_reboot}<li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reboot&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.sure_to_reboot}?');"><img alt="Reboot" src="includes/types/openstacktype/images/icons/24_arrow-circle.png"><br>{$lang.reboot}</a>
        </li>{/if}
        {/if}
        {if $op_sections.op_rebuild}<li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reinstall&vpsid={$vpsid}&security_token={$security_token}" ><img alt="Rebuild" src="includes/types/openstacktype/images/icons/24_blueprint.png"><br>{$lang.rebuild}</a>
        </li>{/if}

        {if $VMDetails.power=='true'}
        {if $op_sections.op_rescue}

            {if $VMDetails.state!='RESCUE'}<li>
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=rescue&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('Are you sure you wish to enter rescue mode? Server password will temporary change, and you will be prompted with new password.');"><img alt="Rescue" src="includes/types/openstacktype/images/icons/24_lifebuoy.png"><br>Rescue</a>
            </li>{else}<li>
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=unrescue&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('Are you sure you wish to return this machine to its previous state?');"><img alt="Un-Rescue" src="includes/types/openstacktype/images/icons/24_lifebuoy.png"><br>Un-Rescue</a>
            </li>{/if}

        
        {/if}
        {/if}

       {if $op_sections.op_logs}<li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=logs&vpsid={$vpsid}&security_token={$security_token}"><img alt="Logs" src="includes/types/openstacktype/images/icons/receipt-text.png"><br>Logs</a>
        </li>{/if}
      

        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo={if $provisioning_type!='single'}editvm{else}upgrade{/if}"><img alt="Scale" src="includes/types/openstacktype/images/icons/24_equalizer.png"><br>{if $provisioning_type!='single'}{$lang.scale}{else}{$lang.upgrade1}{/if}</a>
        </li>
          {foreach from=$widgets item=widg}
               <li><a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&vpsid={$vpsid}&vpsdo=vmdetails&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}"><img src="{$system_url}{$widg.config.bigimg}" alt=""><br/>{if $lang[$widg.name]}{$lang[$widg.name]}{elseif $widg.fullname}{$widg.fullname}{else}{$widg.name}{/if}</a></li>
           {/foreach}

        <li>
            <a {if $provisioning_type=='single'}href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel"{else} href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=destroy&vpsid={$vpsid}&security_token={$security_token}" onclick="return  confirm('{$lang.sure_to_destroy}?')" {/if}><img alt="Delete" src="includes/types/openstacktype/images/icons/24_cross.png"><br>{if $provisioning_type=='single'}{$lang.cancelvps}{else}{$lang.delete}{/if}</a>
        </li>
    </ul>
        <div class="clear"></div>

{if $VMDetails.task!='None'}
{literal}
<script type="text/javascript">
    var wx=setTimeout(function(){
        $.post('{/literal}?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}{literal}',{vpsdo:'vmactions'},function(data){
            var r=parse_response(data);
            if(r)
                $('#lockable-vm-menu').html(r);

            $('#lockable-vm-menu #lock').width($('#lockable-vm-menu').width() - 89);
        });
    }, 4000);
    $('#lockable-vm-menu #lock').width($('#lockable-vm-menu').width() - 89);
</script>
{/literal}
{/if}