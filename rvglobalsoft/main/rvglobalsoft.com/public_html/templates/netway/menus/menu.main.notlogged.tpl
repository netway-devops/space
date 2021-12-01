<ul class="nav nav-tabs">
    <li class="{if $cmd=='root'}{/if}"><a href="{$ca_url}">Home</a></li>
	<li><a href="{$ca_url}{$paged.url}hosting">Hosting</a></li>      
	<li><a href="{$ca_url}{$paged.url}domain">Domain</a></li>        
	<li><a href="{$ca_url}{$paged.url}googleapps">Google Apps</a></li>     
	<li><a href="{$ca_url}{$paged.url}security">Security</a></li>     
	<li><a href="{$ca_url}{$paged.url}software">Software</a></li>        
	<li><a href="{$ca_url}{$paged.url}reseller">Reseller</a></li>       
	<li><a href="{$ca_url}{$paged.url}payment">Payment</a></li>       
	<li><a href="#">Blog</a></li>  
    <li class="{if $cmd=='tickets' || $cmd=='chat' || $cmd=='knowledgebase' || $cmd=='downloads' || $cmd=='netstat'|| $cmd=='support'}{/if}">
        <a href="https://support.siaminterhost.com" target="external-support" title="{$ca_url}{if $enableFeatures.kb!='off'}knowledgebase/{else}tickets/new/{/if}">{$lang.support}</a>
    </li>
    
    
    {if $enableFeatures.affiliates!='off'}
    <li class="{if $cmd=='affiliates'}{/if}"><a href="{$ca_url}affiliates/">{$lang.affiliates}</a></li>
	{/if}
  {foreach from=$HBaddons.client_mainmenu item=ad}
        <li ><a href="{$ca_url}{$ad.link}/" >{$ad.name}</a></li>
    {/foreach}
</ul>


