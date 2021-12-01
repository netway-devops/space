{php}
    $templatePath   = $this->get_template_vars('template_path');
    include($templatePath . 'services/service_sidemenu.tpl.php');
{/php}

<div class="services-box">
    <ul class="nav nav-list">
        <li class="nav-header"><div class="service-nav-header">{$service.name}</div></li>
        <li {if !$widget}class="active-service"{/if}><a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">
        	<i class="icon-domain-details"></i>{$lang.servicedetails}</a><span></span>
        </li>
        
        {if $service.status=='Active'}
            {foreach from=$widgets item=widg}

                {assign var='isDispaly' value='1'}
                {if $widg.name=='reverse_dns'}
                    {if $isIpMask=='0'}
                        {assign var='isDispaly' value='0'}
                    {/if}
                {/if}
                {if $isAppManageService=='1'}
                    {if $widg.name=='zabbix_monitor'}
                        {assign var='isDispaly' value='0'}
                    {/if}
                {/if}
                {if $isAppManageService=='0'}
                    {if $widg.name=='manage_service_monitor' || $widg.name=='manage_service_notification'}
                        {assign var='isDispaly' value='0'}
                    {/if}
                {/if}
                
                {if $isDispaly=='1'}
                    <li {if $widget.name==$widg.name}class="active-service"{/if}>
                        <a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}">
                            <i>
                               <img src="{$system_url}{$widg.config.smallimg}" alt="" />
                            </i>
                            {assign var=widg_name value="`$widg.name`_widget"}
                                {if $lang[$widg_name]}
                                    {$lang[$widg_name]}
                                {elseif $lang[$widg.name]}
                                    {$lang[$widg.name]}
                                {elseif $widg.fullname}
                                    {$widg.fullname}
                                {else}
                                    {$widg.name}
                                {/if}
                        </a>
                    </li>
                {/if}
                
			{/foreach}
			
		
          {*  Start rDNS for VPS *} 
          {if $service.slug=='vps-hosting' && $isOnrDnsVps=='1'}
              <li>
                    <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/rdns_vps">
                        <i>
                            <img src="{$system_url}includes/types/server/widgets/reverse_dns/small.png" alt="">
                        </i>
                        Reverse DNS
                    </a>
               </li>
           {/if}
           {* End rDNS for VPS *}
           
                
			
			
		{/if}
        
        
        {if $service.status=='Active' && $service.isvpstpl}
			{if $commands.RebuildOS} 	
            	<li><a href="#" onclick="return callcustomfn('RebuildOS',{$service.id},'#_rebuild',true)">
                	<span class="cog">{$lang.reload_os}</span></a>
                </li>
            {/if}
			{if $commands.Backup}	
            	<li><a class="tchoice" href="#">
                	<span class="cog">{$lang.backup}</span></a> 
                </li>
            {/if}
			{if $commands.ResetRootPassword} 	
            	<li><a onclick="return process('ResetRootPassword',{$service.id},'#_rootp')" href="#">
                	<span class="cog">{$lang.reset_root}</span></a>
                </li>
            {/if}
			{if ($commands.Statistics)}	
            	<li><a  href="#" onclick="return callcustomfn('Statistics',{$service.id},'#_stats')">
                	<span class="cog">{$lang.Statistics}</span></a>
                </li>
            {/if}
			{if ($commands.Console)}	
            	<li><a  href="#" onclick="return callcustomfn('Console',{$service.id},'#_console')">
                	<span class="cog">{$lang.Console}</span></a>
                </li>
            {/if}
		{/if}
        
        
        {if $service.status=='Active'}
        	{foreach from=$commands item=command}
				{if $service.isvpstpl && ($command=='RebuildOS' || $command=='Backup' || $command=='ResetRootPassword' || $command=='Statistics' || $command=='Console' || $command=='GetStatus'  || $command=='Stop'  || $command=='Start'  || $command=='Reboot' || $command=='Shutdown'  || $command=='FastStat' || $command=='PowerON' || $command=='PowerOFF' || $command=='Destroy' || $command=='VMDetails')}
                
                {else}
                <li>
                    <a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&customfn={$command}" onclick="return callcustomfn('{$command}',{$service.id},'#_ocustom',true)">
                        <span class="cog">{if $lang.$command}{$lang.$command}{else}{$command}{/if}</span>
                    </a>
                </li>
                {/if}
        
    	   {/foreach}
       {/if}
       
       
       {if $enableFeatures.dnsmanagement!='off' && $dnsmodule_id}
       		<li><a href="{$ca_url}module&amp;module={$dnsmodule_id}">
            	<span>{$lang.mydns}</span>
            </a></li>
       {/if}
 
    	{foreach from=$haveaddons item=newaddon}
    	    {if $newaddon.name == 'Free Monitoring'}
            {else}
        	<li>
            	<a class="no-restriction" href="{$ca_url}cart&amp;action=add&amp;cat_id=addons&amp;id={$newaddon.id}&amp;account_id={$service.id}&amp;addon_cycles[{$newaddon.id}]={$newaddon.paytype}">	
                <span class="plus">{$lang.Add} {$newaddon.name}</span></a></li>
            {/if}
    	{/foreach}
        

    	{if $service.status!='Terminated' && $service.status!='Cancelled'}
        	<li class="last">
        		<a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel" style="color:red">
                	<span class="cancel">{$lang.cancelrequest}</span>
                </a>
            </li>
        {/if}


</ul>

        
    </ul>
</div>


{literal} 
<script type="text/javascript">
	
    function process(f,id,pole) {
        if(f=='Start' || f=='Stop' || f=='Reboot' ||  f=='GetStatus')
           ajax_update('?cmd=clientarea&action=checkstatus&do='+f+'&id='+id,{},'#vpsdetails');
             else
       callcustomfn(f,id,pole);
   return false;
    }
	
    function callcustomfn(f,id,pole) {
        $('#extrafields').hide();
        $('#extrafields #content_field').html('');
        $('#extrafields').show();
        ajax_update('?cmd=clientarea&action=customfn&val='+f+'&id='+id,{},'#extrafields #content_field');
		
	
        return false;
    }
</script>
{/literal}
