<div class="sidebar-overlay" data-toggle="sidebar"></div>
<aside class="sidebar">
    <div class="sidebar-wrap">
        <h5 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1"><span>{$lang.Managee}</span></h5>
        <ul class="nav nav-pills flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link {if $cmd == ''}active{/if}" href="{$ca_url}">
                    <i class="material-icons mr-3">home</i> <span>{$lang.homepage}</span>
                </a>
            </li>
        </ul>

        <h5 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1"><span>{$lang.account}</span></h5>
        <ul class="nav nav-pills flex-column mb-2">
            <li class="nav-item">
                <a href="{$ca_url}clientarea/" class="nav-link {if $cmd == 'clientarea'}active{/if}">
                    <i class="material-icons mr-3">person</i>
                    <span>{$lang.clientarea}</span>
                </a>
            </li>
            {if $enableFeatures.affiliates!='off'}
                <li class="nav-item">
                    <a href="{$ca_url}affiliates/" class="nav-link {if $cmd == 'affiliates'}active{/if}">
                        <i class="material-icons mr-3">group_add</i>
                        <span>{$lang.affiliates}</span>
                    </a>
                </li>
            {/if}
        </ul>
        <h5 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1"><span>{$lang.Help}</span></h5>
        <ul class="nav nav-pills flex-column mb-2">
            {if $enableFeatures.kb!='off'}
                <li class="nav-item">
                    <a class="nav-link {if $cmd == 'knowledgebase'}active{/if}" href="{$ca_url}knowledgebase/">
                        <i class="material-icons mr-3">note</i>
                        <span data-feather="file-text"></span>
                        {$lang.knowledgebase}
                    </a>
                </li>
            {/if}
            {if $enableFeatures.support && $enableFeatures.support!='off'}
                <li class="nav-item">
                    <a class="nav-link {if $cmd=="tickets" && $action == 'default'} active{/if}" href="{$ca_url}tickets/">
                        <i class="material-icons mr-3">style</i>
                        {$lang.tickets}
                    </a>
                </li>
            {/if}
            {if $enableFeatures.downloads!='off'}
                <li class="nav-item">
                    <a class="nav-link {if $cmd=="downloads"} active{/if}" href="{$ca_url}downloads/">
                        <i class="material-icons mr-3">save</i>
                        {$lang.downloads}
                    </a>
                </li>
            {/if}
            {if $enableFeatures.chat!='off'}
                <li class="nav-item">
                    <a class="nav-link {if $cmd=="chat"} active{/if}" href="{$ca_url}chat/">
                        <i class="material-icons mr-3">chat</i>
                        {$lang.chat}
                    </a>
                </li>
            {/if}
        </ul>
        {if $HBaddons.client_mainmenu || $infopages}
            <h5 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1"><span>{$lang.other}</span></h5>
            <ul class="nav flex-column mb-2">
                {foreach from=$HBaddons.client_mainmenu item=ad}
                    <li class="nav-item">
                        <a href="{$ca_url}{$ad.link}/" class="nav-link"><i class="material-icons mr-3">link</i> <span>{$ad.name}</span></a>
                    </li>
                {/foreach}
                {if $infopages}
                    <li class="nav-item">
                        <a class="nav-link nav-link-dropdown collapsed" role="button" aria-expanded="false" data-toggle="collapse" href="#menu-other">
                            <i class="material-icons mr-3">link</i>
                            Pages
                            <i class="material-icons icon-expand ml-1 size-ss pull-right">expand_more</i>
                        </a>
                        <div id="menu-other" class="collapse sub-nav">
                            {include file="`$template_path`menus/menu.left.dropdown.tpl" dropdown_type="info_pages" show_label=true}
                        </div>
                    </li>
                {/if}
            </ul>
        {/if}
    </div>
</aside>
