     <div id="lock" {if $VMDetails.locked!='false'}style="display:block"{/if}>
         <img src="includes/types/oresell/images/ajax-loader.gif" alt=""> {$lang.server_performing_task} <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}"><b>{$lang.refresh}</b></a>
                  </div>
    <ul id="vm-menu" class="right">
         {if $VMDetails.power=='true'}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=console&vpsid={$vpsid}&popup=true" class="console_popup">
                <img alt="{$lang.Console}" src="includes/types/onappcloud/images/icons/24_terminal.png">
                <br>
                {$lang.console}
            </a>
        </li>
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reboot&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.sure_to_reboot}?');"><img alt="Reboot" src="includes/types/oresell/images/icons/24_arrow-circle.png"><br>{$lang.reboot}</a>
        </li>
        {/if}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reinstall&vpsid={$vpsid}&security_token={$security_token}" ><img alt="Rebuild" src="includes/types/oresell/images/icons/24_blueprint.png"><br>{$lang.rebuild}</a>
        </li>
        {if $VMDetails.power=='true'}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=rebootrecovery&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.reboot_recovery}');"><img alt="Recovery" src="includes/types/oresell/images/icons/24_lifebuoy.png"><br>{$lang.recovery}</a>
        </li>
        {else}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweronrecovery&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.start_recovery}');"><img alt="Recovery" src="includes/types/oresell/images/icons/24_lifebuoy.png"><br>{$lang.recovery}</a>
        </li>

        {/if}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=upgrade"><img alt="Scale" src="includes/types/oresell/images/icons/24_equalizer.png"><br>{$lang.upgrade1}</a>
        </li>
        <li>
            <a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel"><img alt="Delete" src="includes/types/oresell/images/icons/24_cross.png"><br>{if $provisioning_type=='single'}{$lang.cancelvps}{else}{$lang.delete}{/if}</a>
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
{literal}
    <script type="text/javascript">


        $(function() {
            $('a.console_popup').click(function(event) {
                window.open($(this).attr('href'), 'popup', 'width=740,height=505,scrollbars=0,resizable=1,toolbar=0,directories=0,location=0,menubar=0,status=0,left=50,top=50');
                return false;
            });
        })
    </script>

{/literal}