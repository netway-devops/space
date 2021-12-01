     <div id="lock" {if $VMDetails.status!='ACTIVE' && $VMDetails.status!='VERIFY_RESIZE'}style="display:block"{/if}>
         <img src="includes/types/rcloud/images/ajax-loader.gif" alt=""> {$lang.server_performing_task} <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}"><b>{$lang.refresh}</b></a>
                  </div>
    <ul id="vm-menu" class="right">
        {if $VMDetails.status=='ACTIVE' || $VMDetails.status=='VERIFY_RESIZE'}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reboot&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.sure_to_reboot}?');"><img alt="Reboot" src="includes/types/rcloud/images/icons/24_arrow-circle.png"><br>{$lang.reboot}</a>
        </li>
        {/if}
		{if $VMDetails.status!='VERIFY_RESIZE'}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reinstall&vpsid={$vpsid}&security_token={$security_token}" ><img alt="Rebuild" src="includes/types/rcloud/images/icons/24_blueprint.png"><br>{$lang.rebuild}</a>
        </li>
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=upgrade"><img alt="Scale" src="includes/types/rcloud/images/icons/24_equalizer.png"><br>{$lang.upgrade1}</a>
        </li>
		{/if}
        <li>
            <a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel"><img alt="Delete" src="includes/types/rcloud/images/icons/24_cross.png"><br>{if $provisioning_type=='single'}{$lang.cancelvps}{else}{$lang.delete}{/if}</a>
        </li>
          {foreach from=$widgets item=widg}
               <li><a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&vpsid={$vpsid}&vpsdo=vmdetails&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}"><img src="{$system_url}{$widg.config.bigimg}" alt=""><br/>{if $lang[$widg.name]}{$lang[$widg.name]}{elseif $widg.fullname}{$widg.fullname}{else}{$widg.name}{/if}</a></li>
           {/foreach}
    </ul>
        <div class="clear"></div>

{if $VMDetails.locked!='false'}
{literal}
<script type="text/javascript">
    var wx=setTimeout(function(){
        $.post('{/literal}?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}{literal}',{vpsdo:'vmactions'},function(data){
            var r=parse_response(data);
            if(r)
                $('#lockable-vm-menu').html(r);
        });
    }, 4000);
</script>
{/literal}
{/if}