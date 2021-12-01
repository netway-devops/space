<div class="sidebar-overlay" data-toggle="sidebar"></div>
<aside class="sidebar">
    <div class="sidebar-wrap">
        {foreach from=$menu item=item}
            {* check login condition*}
            {if $item.conditions.customers}
                {assign var=cs value=$item.conditions.customers}
                {if $cs.value === '1' && !$clientdata.id}
                    {continue}
                {elseif $cs.value === '-1' && $clientdata.id}
                    {continue}
                {elseif $cs.value === null && $cs.default === '1' && !$clientdata.id}
                    {continue}
                {elseif $cs.value === null && $cs.default === '-1' && $clientdata.id}
                    {continue}
                {/if}
            {/if}
            {* end check login condition*}

            {* check enabled feature*}
            {if $item.conditions.enabled_feature.value && $enableFeatures[$item.conditions.enabled_feature.feature] == 'off'}
                {continue}
            {/if}
            {* end check enabled feature*}

            {* check permissions if list:products type*}
            {if $item.type == 'list' && $item.list == 'products' && !"acl_user:misc.accesscart"|checkcondition}
                {continue}
            {/if}
            {* end check permissions*}

            {if $item.type == 'section'}
                <h5 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1"><span>{$item.name|lang}</span></h5>
            {/if}
            <ul class="nav nav-pills flex-column mb-2">
                {if $item.type == 'section'}
                    {foreach from=$item.children item=subitem}
                        {* check login condition*}
                        {if $subitem.conditions.customers}
                            {assign var=css value=$subitem.conditions.customers}
                            {if $css.value === '1' && !$clientdata.id}
                                {continue}
                            {elseif $css.value === '-1' && $clientdata.id}
                                {continue}
                            {elseif $css.value === null && $css.default === '1' && !$clientdata.id}
                                {continue}
                            {elseif $css.value === null && $css.default === '-1' && $clientdata.id}
                                {continue}
                            {/if}
                        {/if}
                        {* end check login condition*}

                        {* check enabled feature*}
                        {if $subitem.conditions.enabled_feature.value && $enableFeatures[$subitem.conditions.enabled_feature.feature] == 'off'}
                            {continue}
                        {/if}
                        {* end check enabled feature*}

                        {* check permissions if is list-products type*}
                        {if $subitem.type == 'list' && $subitem.list == 'products' && !"acl_user:misc.accesscart"|checkcondition}
                            {continue}
                        {/if}
                        {* end check permissions*}

                        <ul class="nav nav-pills flex-column mb-2">
                            <li class="nav-item">
                                {if $subitem.type == 'list'}
                                    <span class="cursor-pointer nav-link nav-link-dropdown sidebar-services-link {if !$subitem.options.open.value}collapsed{/if}" role="button" aria-expanded="{if $subitem.options.open.value}true{else}false{/if}" data-toggle="collapse" href="#menu-{$subitem.id}">
                                    <i class="material-icons mr-3">{$subitem.icon}</i>
                                    <span>{$subitem.name|lang}</span>
                                        <i class="material-icons icon-expand ml-1 size-ss pull-right">expand_more</i>
                                    </span>
                                    <div id="menu-{$subitem.id}" class="collapse sub-nav sidebar-services-menu {if $subitem.options.open.value}show{/if}">
                                        {include file="`$template_path`menus/menu.left.dropdown.tpl" dropdown_type=$subitem.list show_label=$subitem.options.label.value}
                                    </div>
                                {elseif $subitem.type == 'link'}
                                    <a {if $subitem.options.new_tab.value}target="_blank" {/if} class="nav-link" href="{if $subitem.url_type == 'system'}{$ca_url}{$subitem.url}{elseif $subitem.url_type == 'custom'}{$subitem.url}{/if}">
                                        <i class="material-icons mr-3">{$subitem.icon}</i> <span>{$subitem.name|lang}</span>
                                    </a>
                                {/if}
                            </li>
                        </ul>
                    {/foreach}
                {else}
                    <li class="nav-item">
                        {if $item.type == 'list'}
                            <span class="cursor-pointer nav-link nav-link-dropdown sidebar-services-link {if !$item.options.open.value}collapsed{/if}" role="button" aria-expanded="{if $item.options.open.value}true{else}false{/if}" data-toggle="collapse" href="#menu-{$item.id}">
                            <i class="material-icons mr-3">{$item.icon}</i>
                            <span>{$item.name|lang}</span>
                                <i class="material-icons icon-expand ml-1 size-ss pull-right">expand_more</i>
                            </span>
                            <div id="menu-{$item.id}" class="collapse sub-nav sidebar-services-menu {if $item.options.open.value}show{/if}">
                                {include file="`$template_path`menus/menu.left.dropdown.tpl" dropdown_type=$item.list show_label=$item.options.label.value}
                            </div>
                        {elseif $item.type == 'link'}
                            <a {if $item.options.new_tab.value}target="_blank" {/if} class="nav-link" href="{if $item.url_type == 'system'}{$ca_url}{$item.url}{elseif $item.url_type == 'custom'}{$item.url}{/if}">
                                <i class="material-icons mr-3">{$item.icon}</i> <span>{$item.name|lang}</span>
                            </a>
                        {/if}
                    </li>
                {/if}
            </ul>
        {/foreach}
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
                            {$lang.Pages}
                            <i class="material-icons icon-expand ml-1 size-ss pull-right">expand_more</i>
                        </a>
                        <div id="menu-other" class="collapse sub-nav">
                            {include file="`$template_path`menus/menu.left.dropdown.tpl" dropdown_type="info_pages"}
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

