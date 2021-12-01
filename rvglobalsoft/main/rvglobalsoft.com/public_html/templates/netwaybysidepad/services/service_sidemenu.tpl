{if $cid == 1}
    {include_php file=`$template_path`services/ssl_templates/service_sidemenu_ssl.php}
{/if}
<div class="services-box">
    <ul class="nav nav-list">
        <li class="nav-header"><div class="service-nav-header">{$service.name}</div></li>
        
        {php}
            //echo '<pre>'; print_r($this->get_template_vars('service')); echo '</pre>';
            if(isset($_GET['action'])){
                $this->assign('pageAction', $_GET['action']);
            }
        {/php}
        
        {if isset($widgets.0.name) && preg_match("/symantecvip/", $widgets.0.name)}
            <span></span>
        {else}
	        <li {if !$widget && $pageAction == ''}class="active-service"{/if}><a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">
	            <i class="icon-domain-details"></i>{$lang.servicedetails}</a><span></span>
	        </li>
        {/if}
        
        {if $service.status=='Active'}
            {if false && $cid==1 && $service.symantec_status=='COMPLETED'}
                <li class="{if $pageAction == 'downloadCert'}active-service{else}service{/if}" style="cursor: pointer">
                    <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}&action=downloadCert"><i class="icon-domain-details"></i> Download Certificate </a>
                </li>                    
                {if $service.order_info.CertificateInfo.CertificateStatus == 'Active'}
                <li class="{if $pageAction == 'reissue'}active-service{else}service{/if}" style="cursor: pointer">
                    <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}&action=reissue"><i class="icon-domain-details"></i> Reissue </a>
                </li>
                {/if}
                {if isset($service.order_info.CertificateInfo.CanRenew) && $service.order_info.CertificateInfo.CanRenew}
                <li class="{if $pageAction == 'renew'}active-service{else}service{/if}" style="cursor: pointer">
                    <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}&action=renew"><i class="icon-domain-details"></i> Renew </a>
                </li>
                {/if}
                {if $service.order_info.CertificateInfo.CertificateStatus == 'Active'}
                <li style="cursor: pointer">
                    <a href="{$ca_url}clientarea/cancel&id={$service.id}"><i class="icon-domain-details"></i> Revoke </a>
                </li>
                {/if}
            {else}
                {foreach from=$widgets item=widg}

                {if isset($widg.name) && $widg.name=='symantecvip_subscription'}
                     <li {if !$widget}class="active-service"{/if}>
                    <a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">
                {elseif $widg.name == 'directlink'}
                    <li {if $widget.name==$widg.name}class="active-service"{/if}>
                    <a  href="{$widg.config.linkurl}" target="_blank">
                {else}
                    <li {if $widget.name==$widg.name}class="active-service"{/if}>
                    <a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}" >
                {/if}
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
                </a></li>
            {/foreach}
            {/if}
        {elseif $cid == 1}
        {foreach from=$widgets item=widg}
            {if isset($widg.name) && $widg.name=='symantecvip_subscription'} 
                <li {if !$widget}class="active-service"{/if}>
                    <a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">
            {elseif $widg.name == 'directlink'}
                <li {if $widget.name==$widg.name}class="active-service"{/if}>
                    <a  href="{$widg.config.linkurl}" target="_blank">
            {else}
                <li {if $widget.name==$widg.name}class="active-service"{/if}>
                    <a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}" >
            {/if}
                
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
        {/foreach}
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
            {/if}
    	{/foreach}
        
    	{if $service.status!='Terminated' && $service.status!='Cancelled'}
    	   {if $cid != 1}
            <li class="last">
                <a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel" style="color:red"><i><img alt="" src="https://rvglobalsoft.com/includes/types/widgets/accesswebmail/small.png"></i> Cancellation Request</a>
            </li>
            {/if}
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


