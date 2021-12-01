
{if ($cmd=='root' || $cmd=='page') && $infopages}
<ul class="nav nav-tabs">
{foreach from=$infopages item=paged}
    <li {if $page && $page.title==$paged.title}class="active-nav"{/if}>
    	<a href="{$ca_url}page/{$paged.url}/">
        	<div class="nav-bg-fix">{$paged.title}
            </div>
        </a>
    </li>
{/foreach}
    <li class="more-hidden"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><div class="nav-bg-fix">{$lang.more}<span class="caret"></span></div></a>
        <ul id="more-hidden" class="dropdown-menu">
            <div class="dropdown-padding">
            </div>
        </ul>
    </li>
</ul>
{/if}