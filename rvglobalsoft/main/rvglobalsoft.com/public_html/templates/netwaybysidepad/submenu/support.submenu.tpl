
{if $cmd == 'tickets' && $action == 'view'}
	<h2>{$lang.tickets}</h2>
{/if}
<ul class="nav nav-tabs {if $cmd == 'tickets' && $action == 'view'} services-nav {else} space-nav {/if}">
    <!-- <li {if $cmd == 'support'} class="active-nav" {/if}><a href="{$ca_url}support/"><div class="nav-bg-fix">{$lang.supporthome}</div></a></li> -->
    <li {if $cmd == 'tickets'} class="active-nav" {/if}><a href="{if $logged=='1'}{$ca_url}tickets{else}{$ca_url}tickets/new/{/if}"><div class="nav-bg-fix">{$lang.mytickets}</div></a></li>
    {if $enableFeatures.kb!='off'}
    <li {if $cmd == 'knowledgebase'} class="active-nav" {/if}><a href="https://rvglobalsoft.zendesk.com/hc/en-us"><div class="nav-bg-fix">{$lang.knowledgebase}</div></a></li>
    {/if}
    {if $enableFeatures.downloads!='off'}
    <li  {if $cmd == 'downloads'} class="active-nav" {/if}><a href="{$ca_url}downloads/"><div class="nav-bg-fix">{$lang.downloads}</div></a></li>
    {/if}
    {if $enableFeatures.netstat!='off'}
    <li {if $cmd == 'netstat'} class="active-nav" {/if}><a href="{$ca_url}netstat/"><div class="nav-bg-fix">{$lang.netstat}</div></a></li>
    {/if}
</ul>