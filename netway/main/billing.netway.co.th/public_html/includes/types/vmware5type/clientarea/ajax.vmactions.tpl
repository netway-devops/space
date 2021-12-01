{cloudservices section='actions'
include="../common/cloudhosting/tpl/actions.tpl"
}
    <ul id="vm-menu" class="right">
        {if $VMDetails.powerState=='poweredOn'}
            <li>
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reboot&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.sure_to_reboot}?');">
                    <img alt="Reboot" src="templates/common/cloudhosting/images/icons/24_arrow-circle.png"><br>{$lang.reboot}
                </a>
            </li>
            <li>
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=hardpoweroff&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.sure_to_shutdown}?');">
                    <img alt="Delete" src="templates/common/cloudhosting/images/icons/poweroff.png"><br>{$lang.ForcePowerOff}
                </a>
            </li>
        {/if}
        <li>
            <a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel">
                <img alt="Delete" src="templates/common/cloudhosting/images/icons/24_cross.png"><br>{$lang.cancelvps}
            </a>
        </li>
        {foreach from=$widgets item=widg}
            <li><a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&vpsid={$vpsid}&vpsdo=vmdetails&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}"><img src="{$widg.config.bigimg}" alt=""><br/>{if $lang[$widg.name]}{$lang[$widg.name]}{elseif $widg.fullname}{$widg.fullname}{else}{$widg.name}{/if}</a></li>
        {/foreach}
    </ul>

{/cloudservices}
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