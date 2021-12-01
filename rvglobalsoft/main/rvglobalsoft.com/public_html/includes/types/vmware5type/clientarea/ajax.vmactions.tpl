    {*
	<div id="lock" {if $VMDetails.status!='ACTIVE' && $VMDetails.status!='VERIFY_RESIZE'}style="display:block"{/if}>
         <img src="includes/types/onappcloud/images/ajax-loader.gif" alt=""> {$lang.server_performing_task} <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}"><b>{$lang.refresh}</b></a>
    </div>
	*}
	{literal}
		<style type="text/css">
			ul#vm-menu li a{
				padding:5px
			}
		</style>
	{/literal}
    <ul id="vm-menu" class="right">
        {if $VMDetails.powerState=='poweredOn'}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reboot&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.sure_to_reboot}?');">
				<img alt="Reboot" src="includes/types/onappcloud/images/icons/24_arrow-circle.png"><br>{$lang.reboot}
			</a>
        </li>
		<li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=hardpoweroff&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.sure_to_shutdown}?');">
				<img alt="Delete" src="includes/types/xenservtype/images/poweroff.png"><br>{$lang.ForcePowerOff}
			</a>
        </li>
        {/if}
        <li>
            <a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel">
				<img alt="Delete" src="includes/types/onappcloud/images/icons/24_cross.png"><br>{$lang.cancelvps}
			</a>
        </li>
          {foreach from=$widgets item=widg}
               <li><a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&vpsid={$vpsid}&vpsdo=vmdetails&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}"><img src="{$system_url}{$widg.location}/big.png" alt=""><br/>{if $lang[$widg.name]}{$lang[$widg.name]}{elseif $widg.fullname}{$widg.fullname}{else}{$widg.name}{/if}</a></li>
           {/foreach}
    </ul>
        <div class="clear"></div>

{if $VMDetails.powerState!='suspended'}
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