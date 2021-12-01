








<div class="wrapper-bg">
    <!-- Left Navigation -->
    <div class="services-box">
    {if $details.status=='Active'}
        <ul class="nav nav-list">
        
        <li class="nav-header"><div class="service-nav-header">{$lang.domdetails}</div></li>
        <li {if !$widget}class="active-service"{/if}>
        	<a  href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/"><i class="icon-domain-details"></i>{$lang.domdetails}</a><span></span></li>
            
            {foreach from=$widgets item=widg name=cst}
            	{if $widg.name!='reglock' && $widg.name!='nameservers'  && $widg.name!='autorenew' } 
                	{if $widg.name=='idprotection' && $details.offerprotection && !$details.offerprotection.purchased}
                    	{continue}
                    {/if}
            <li {if $widget.name==$widg.name}class="current"{/if}><a  href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}#{$widg.name}">
                    <i>
                        <img src="{$system_url}{$widg.location}/small.png" alt="" />
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
            <span></span></li>
            	{/if}
            {/foreach}
            
            {if $custom} 
            	{foreach from=$custom item=btn name=cst}
            	<li style="border-bottom:none" {if $smarty.foreach.cst.last}class="last"{/if}><a href="#" onclick="$('#cbtn_{$btn}').click();return false;">{$lang.$btn}</a><span></span> </li>
            	{/foreach} 
            {/if}

        
<!--        
            <li class="nav-header"><div class="service-nav-header">Domain details</div></li>
            <li class="active-service"><a href="#"><i class="icon-domain-details"></i>Domain Details</a><span></span></li>
            <li><a href="#"><i class="icon-login-details"></i>Login Details</a><span></span></li>
            <li><a href="#"><i class="icon-contact-info"></i>Contact Information</a><span></span></li>
            <li><a href="#"><i class="icon-dns-manage"></i>DNS Management</a><span></span></li>
            <li><a href="#"><i class="icon-email"></i>Email Forwarding</a><span></span></li>
            <li><a href="#"><i class="icon-epp-key"></i>Auth Info/ EPP Key</a><span></span></li>
            <li><a href="#"><i class="icon-ns"></i>Register Nameservers</a><span></span></li>
            <li><a href="#"><i class="icon-privacy"></i>Manage Privacy</a><span></span></li>-->
        </ul>
    {/if}
    </div>
    <!-- End of Left Navigation -->

    <!-- Right Content -->
    <div class="services-content">
    {if $bulkdetails}
        <ul class="breadcrumb">
            <li><a href="{$ca_url}clientarea/">{$lang.clientarea}</a><span class="divider">></span></li>
            <li><a href="{$ca_url}clientarea/domains/">{$lang.domains}<span class="divider">></span></li>

            {if $widget}
            <li><a href="{$ca_url}clientarea/services/domains/{$service.id}/"><strong>{$details.name}</strong></a>  <span>></span></li>
    		<li>{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</li>{else}
    		<li>{$details.name}</li>
            {/if}
        </ul>
        <div class="line-separaotr-m"></div>
        
        
        {if $widget.replacetpl}
        	{include file=$widget.replacetpl}
        {elseif $widget.appendtpl}
        	{include file=$widget.appendtpl}
        {elseif $widget.appendaftertpl}
        	<a name="{$widget.name}"></a>
        	{include file=$widget.appendaftertpl}
        {/if}
        

        
        <table width="100%" cellspacing="0" cellpadding="0" class="table table-striped ">
                {if $details.custom}
                {assign var="service" value=$details}
			{foreach from=$details.custom item=cst name=cstloop}{if $cst.variable!='idprotection'}
                <tr {if $smarty.foreach.cstloop.index%2==0}class="even"{/if}>
                    <td align="right">{$cst.name}</td>
                    <td colspan="2">{include file=$cst.configtemplates.clientarea}</td>

                </tr>
                {/if}
			{/foreach}

                {/if}
        </table>
        
        
        
        
    {elseif $details}
		{if ($details.status=='Pending' || $details.status=='Pending Registration' || $details.status=='Pending Transfer' || $details.status=='Active') && stristr($details.name, '.hu') }
        <div class="wbox" style="display:none" id="huregistrar">
        <div class="wbox_header">
                {$lang.hu_formtitle}
            </div>
            <div class="wbox_content">
                <div class="tabb" style="padding:5px;border-bottom: 1px solid #DDDDDD;">
                    {$lang.hu_linkdescr} <a href="" id="hu_form_link" target="_blank">{$lang.hu_downloadform}</a>
                </div>
                <div style="padding:5px;">
                    <form style="padding:10px 0 0;"action="" method="POST" enctype="multipart/form-data" id="hu_upform" class="form-inline">
                        <input type="file" name="signedform"> <input class="btn btn-primary" type="submit" value="{$lang.hu_sendform}" style="vertical-align: bottom">
                    </form>
                </div>
            </div>
        </div>
        {/if}
        
        <ul class="breadcrumb">
            <li><a href="{$ca_url}clientarea/">{$lang.clientarea}</a><span class="divider">></span></li>
            <li><a href="{$ca_url}clientarea/domains/">{$lang.domains}</a><span class="divider">></span></li>

            {if $widget}
            <li>
            	<a href="{$ca_url}clientarea/services/domains/{$service.id}/"><strong>{$details.name}</strong></a>  
                <span>></span>
            </li>
    		<li>
            	{if $lang[$widget.name]}
                	{$lang[$widget.name]}
                {elseif $widget.fullname}
                	{$widget.fullname}
                {else}
                	{$widget.name}
                {/if}
             </li>
            {else}
    		<li>{$details.name}</li>
            {/if}
        </ul>
        <div class="line-separaotr-m"></div>
        
        {if $widget.replacetpl}
        {include file=$widget.replacetpl}
        {else}
        
        {if $widget.replacetpl}
        {include file=$widget.replacetpl}
        {else}
        
        <div class="services-container no-p-left">
            <p>{$lang.domain}</p>
            <a href="http://{$details.name}" target="_blank">{$details.name}</a>
            
            <div>
                <div class="domain-info-box span2">
                    <p>{$lang.registrationdate}</p>
                    <span>{if !$details.date_created || $details.date_created == '0000-00-00'}{$lang.none}{else}{$details.date_created|dateformat:$date_format}{/if}</span>
                </div>
                
                {if $details.status == 'Active' || $details.status == 'Expired'}
                <div class="domain-info-box span3">
                    <p>{$lang.expirydate}</p>
                    {if !$details.expires || $details.expires == '0000-00-00'}{$lang.none}{else}<span>{$details.expires|dateformat:$date_format}</span> 
                    	{if $details.daytoexpire >= 0}
                    	<small>({$details.daytoexpire} {if $domain.daytoexpire==1}{$lang.day}{else}{$lang.days}{/if} {$lang.toexpire})</small>
                    	{/if}
                    {/if}
                {/if}
            	</div>
                {if $allowrenew}
                <a  style="font-size:11px;" href="{$ca_url}clientarea/domains/renew/&ids[]={$details.id}" class="clearstyle btn grey-custom-btn"><i class="icon-cycle-large"></i>{$lang.renewdomain}</a>
                {/if}
        	</div>
        </div>
        
        
        <div class="services-container no-p-left">
            <div>
                <div class="domain-status span2">
                    <p>{$lang.status}</p>
                    <span class="label-{$details.status}">{$lang[$details.status]}</span>
                </div>
                
                {if $widget.appendtpl}
        			{include file=$widget.appendtpl}
        		{/if}
                
                {if $details.status == 'Active'}
                
                <div class="domain-status span2">
                    <p>{$lang.reglock}: </p>
                    {if $details.reglock=='1'}
                    	<span class="label-Active">{$lang.On}</span>
                    {else}
                    	<span class="label-Expired">{$lang.Off}</span>
                    {/if}
                    <!--<i class="icon-info-tip"></i>-->
                </div>
                {foreach from=$widgets item=widg name=cst}{if $widg.name=='reglock'}
                        <a style="font-size:11px;" class="clearstyle btn grey-custom-btn" href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#reglock">
                        	<i class="icon-lock-large"></i> 
                            {assign var=widg_name value="`$widg.name`_widget"}
                            {if $lang[$widg_name]}{$lang[$widg_name]}
                            {elseif $lang[$widg.name]}{$lang[$widg.name]}
                            {elseif $widg.fullname}{$widg.fullname}
                            {else}{$widg.name}
                            {/if}
                        </a>{break}{/if}{/foreach}&nbsp;
                {/if}
        		</div>
                
                
                {if !$details.not_renew}
                <div>
                	<div class="domain-info-box">
                        <p>{$lang.autorenew}:</p>
                        {if $details.autorenew=='1'}
                            <span class="label-Active">{$lang.On}</span>
                        {else}
                            <span class="label-Expired">{$lang.Off}</span>
                        {/if}
                    </div>
                        {foreach from=$widgets item=widg name=cst}
                        {if $widg.name=='autorenew'}
                        <a style="font-size:11px;" class="clearstyle btn grey-custom-btn" href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#autorenew">
                        	<i class="icon-renewal"></i>
                            {assign var=widg_name value="`$widg.name`_widget"}
                            {if $lang[$widg_name]}{$lang[$widg_name]}
                            {elseif $lang[$widg.name]}{$lang[$widg.name]}
                            {elseif $widg.fullname}{$widg.fullname}
                            {else}{$widg.name}
                            {/if}</a>{break}
                        {/if}
                        {/foreach}&nbsp;
           	 	</div>
                {/if}
        </div>
        {/if}
        
        
        <p class="ns">{$lang.nameservers}</p>
        <div class="services-table">
            <table class="table table-striped tb-header-fix">
                <tr class="header-row">
                    <td class="w50 table-g">Host name</td>
                    <td class="w50 table-g border-h">IP Address</td>
                </tr>
                {foreach from=$details.nameservers item=ns name=namserver}
                {if $ns!=''}
                <tr>
                    <td class="cell-border">{$ns}</td>
                    <td class="cell-border">
                    	{if $details.nsips[$smarty.foreach.namserver.index]}{$details.nsips[$smarty.foreach.namserver.index]}{/if}
                    </td>
                </tr>
                {/if}
                {/foreach}
                <tr>
                	<td>
                	{foreach from=$widgets item=widg name=cst}
                    	{if $widg.name=='nameservers'}
                        <a  href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#nameservers">
                        <i class="icon-mg-ns"></i>
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
                       </a>{break}
                      	{/if}
                    {/foreach}&nbsp;
                    </td>
                </tr>
            </table>
            
            {if $widget.appendaftertpl}
            	<a name="{$widget.name}"></a>
            	{include file=$widget.appendaftertpl}
            {/if}
            
       </div>
       {/if}
       {/if}
    </div>
    <!-- End of Right Content -->
</div>

