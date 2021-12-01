<div class="sidebar-overlay" data-toggle="sidebar"></div>
<aside class="sidebar">
    <div class="sidebar-wrap">
        <h5 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1"><span>{$lang.Managee}</span></h5>
        <ul class="nav nav-pills flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link {if $cmd == 'clientarea' && $action == 'default'}active{/if}" href="{$ca_url}clientarea/">
                    <i class="material-icons mr-3">home</i> <span>{$lang.dashboard}</span>
                </a>
            </li>
            <li class="nav-item">
                <span class="cursor-pointer nav-link nav-link-dropdown sidebar-services-link collapsed {if $cmd == 'clientarea' && ( $action == 'service' || $action == 'services' || $action == 'domains')}active{/if}" role="button" aria-expanded="false" data-toggle="collapse" href="#menu-services">
                    <i class="material-icons mr-3">portrait</i>
                    <span>{$lang.services}</span>
                    <i class="material-icons icon-expand ml-1 size-ss pull-right">expand_more</i>
                </span>
                <div id="menu-services" class="collapse sub-nav sidebar-services-menu">
                    {include file="`$template_path`menus/menu.left.dropdown.tpl" dropdown_type="services" show_label=true}
                </div>
            </li>
        </ul>

        <h5 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1"><span>{$lang.account}</span></h5>
        <ul class="nav nav-pills flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link {if $cmd == 'clientarea' && ($action == 'overview' || $action == 'details' || $action == 'profilepassword' || $action == 'password' || $action == 'settings')}active{/if}" href="{$ca_url}clientarea/overview/">
                    <i class="material-icons mr-3">person</i>
                    {$lang.accountdetails}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link {if $cmd == 'profiles'}active{/if}" href="{$ca_url}profiles/">
                    <i class="material-icons mr-3">contacts</i>
                    {$lang.managecontacts}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link {if $cmd == 'clientarea' && ( $action == 'invoices' || $action == 'creditreceipts' || $action == 'invoice' || $action == 'addfunds' || $action == 'ach' || $action == 'ccard')}active{/if}" href="{$ca_url}clientarea/invoices/">
                    <i class="material-icons mr-3">attach_money</i>
                    {$lang.billing}
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
            <li class="nav-item">
                <a class="nav-link {if $cmd == 'clientarea' && $action == 'ipaccess'}active{/if}" href="{$ca_url}clientarea/ipaccess/">
                    <i class="material-icons mr-3">security</i>
                    {$lang.security}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link {if $cmd == 'clientarea' && ($action == 'history' || $action == 'emails' || $action == 'creditlogs' || $action == 'portal_notifications')}active{/if}" href="{$ca_url}clientarea/history/">
                    <i class="material-icons mr-3">history</i>
                    {$lang.userhistory}
                </a>
            </li>
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
            {if $enableFeatures.support!='off'}
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
            {if $enableFeatures.netstat!='off'}
                <li class="nav-item">
                    <a class="nav-link {if $cmd=="netstat"} active{/if}" href="{$ca_url}netstat/">
                        <i class="material-icons mr-3">network_check</i>
                        {$lang.netstat}
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
        <ul class="nav nav-pills flex-column mb-2 d-lg-none">
            <li class="nav-item">
                <a class="nav-link nav-link-dropdown collapsed" role="button" aria-expanded="false" data-toggle="collapse" href="#menu-language">
                    <i class="material-icons mr-3">language</i>
                    {foreach from=$languages item=ling}
                        {if  $language==$ling}
                            <span>{$ling|capitalize}</span>{break}
                        {/if}
                    {/foreach}
                    <i class="material-icons icon-expand ml-1 size-ss pull-right">expand_more</i>
                </a>
                <div id="menu-language" class="collapse sub-nav">
                    <ul class="nav nav-subnav flex-column">
                        {foreach from=$languages item=ling}
                            <li class="nav-item">
                                <a class="nav-link language-change" href="{$ca_url}{$cmd}&action={$action}&languagechange={$ling|capitalize}">
                                    {$lang[$ling]|capitalize}
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </li>
        </ul>
    </div>
</aside>
