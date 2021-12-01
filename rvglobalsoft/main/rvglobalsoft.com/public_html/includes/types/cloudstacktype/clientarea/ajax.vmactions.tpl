     <div id="lock" {if $VMDetails.locked!='false'}style="display:block"{/if}>
         <img src="includes/types/cloudstacktype/images/ajax-loader.gif" alt=""> {$lang.server_performing_task} <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}"><b>{$lang.refresh}</b></a>
                  </div>
    <ul id="vm-menu" class="right">
         {if $VMDetails.power=='true'}
       <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=console&vpsid={$vpsid}"><img alt="Console" src="includes/types/cloudstacktype/images/icons/24_terminal.png"><br>{$lang.console}</a>
        </li>
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reboot&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.sure_to_reboot}?');"><img alt="Reboot" src="includes/types/cloudstacktype/images/icons/24_arrow-circle.png"><br>{$lang.reboot}</a>
        </li>
        {/if}
      
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo={if $provisioning_type!='single'}{if $VMDetails.power=='true'}poweroff&security_token={$security_token}{else}editvm{/if}{else}upgrade{/if}" 
            {if $provisioning_type!='single' &&  $VMDetails.power=='true'}onclick="return confirm('VM has to be switched off before you can scale it. {$lang.sure_to_shutdown}?')"{/if}>
            <img alt="Scale" src="includes/types/cloudstacktype/images/icons/24_equalizer.png"><br>{if $provisioning_type!='single'}{$lang.scale}{else}{$lang.upgrade1}{/if}
        </a>
        </li>
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=reinstall&security_token={$security_token}" {if $VMDetails.power=='true'}onclick="return confirm('VM has to be switched off before you can rebuild it. {$lang.sure_to_shutdown}?')"{/if}><img alt="Rebuild" src="includes/types/cloudstacktype/images/icons/24_blueprint.png"><br>{$lang.rebuild}</a>
        </li>
        <li>
            <a {if $provisioning_type=='single'}href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel"{else} href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=destroy&vpsid={$vpsid}&security_token={$security_token}" onclick="return  confirm('{$lang.sure_to_destroy}?')" {/if}><img alt="Delete" src="includes/types/cloudstacktype/images/icons/24_cross.png"><br>{if $provisioning_type=='single'}{$lang.cancelvps}{else}{$lang.delete}{/if}</a>
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
{if $VMDetails.rootpassword && $VMDetails.rootpassword != '_pending_reset_'}
    {literal}
    <script type="text/javascript">
            if($('#rootpss').length){
                $('#rootpss').text('{/literal}{$VMDetails.rootpassword}{literal}');
            }else{
                $('#rootpsstd').html(['<a href="#" onclick="$(this).hide();$(\'#rootpss\').show();return false;" style="color:red">{/literal}{$lang.show}{literal}</a>',
                    '<span id="rootpss" style="display:none">{/literal}{$VMDetails.rootpassword}{literal}</span>'].join(''));
            }
    </script>
    {/literal}
{/if}