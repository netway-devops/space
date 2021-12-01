<ul class="nav nav-subnav flex-column">
    {if $dropdown_type == 'services'}
            {clientservicesmenu}
            {foreach from=$offer_menu item=offe}
                {if $offe.total>0}
                    {assign value=true var=hasservicedrop}

                    {if $offe.contains === 'products'}
                        <li class="nav-item">
                            <a class="nav-link" href="{$ca_url}clientarea/services/{$offe.slug}/">
                                {$offe.name}
                                {if $show_label}
                                    <span class="badge badge-secondary badge-top">{$offe.total}</span>
                                {/if}
                            </a>
                        </li>
                    {elseif $offe.contains === 'categories'}
                        <li class="nav-item">
                            <span class="cursor-pointer nav-link-dropdown nav-link collapsed pl-5 pr-3 my-1 py-2" role="button" aria-expanded="false" data-toggle="collapse" href="#menu-category-{$offe.id}">
                                <span>{$offe.name}</span>
                                <i class="material-icons icon-expand ml-1 size-ss pull-right">expand_more</i>
                            </span>
                            <div id="menu-category-{$offe.id}" class="collapse sub-nav sidebar-services-menu">
                                <ul class="nav nav-subnav flex-column mb-2">
                                    {foreach from=$offe.categories item=offe2}
                                        {if $offe2.total>0}
                                            <li class="nav-item">
                                                <a class="nav-link" href="{$ca_url}clientarea/services/{$offe2.slug}/">
                                                    <span class="pl-2">
                                                        <i class="material-icons size-xs mr-1">fiber_manual_record</i>
                                                        {$offe2.name}
                                                    </span>
                                                    {if $show_label}
                                                        <span class="badge badge-secondary badge-top">{$offe2.total}</span>
                                                    {/if}
                                                </a>
                                            </li>
                                        {/if}
                                    {/foreach}
                                </ul>
                            </div>
                        </li>
                    {/if}
                {/if}
            {/foreach}
            {if $offer_domains}
                <li class="nav-item">
                    <a class="nav-link" href="{$ca_url}clientarea/domains/">
                        {$lang.domains}
                        {if $show_label}
                            <span class="badge badge-secondary badge-top">{$offer_domains}</span>
                        {/if}
                    </a>
                </li>
            {/if}
            {if $offer_domains==0 && !$hasservicedrop}
                <li class="nav-item">
                    <span class="cursor-pointer nav-link text-center d-flex flex-column py-5 px-2">
                        <span>{$lang.noservicesyet}</span>
                    </span>
                </li>
            {/if}
    {elseif $dropdown_type == 'products'}
        {foreach from=$orderpages item=op}
            <li class="nav-item">
                <a class="nav-link" href="{$ca_url}{$op.slug}">{$op.name}</a>
            </li>
        {/foreach}
    {elseif $dropdown_type == 'info_pages'}
        {foreach from=$infopages item=paged}
            <li class="nav-item">
                <a href="{$ca_url}page/{$paged.url}/" class="nav-link ">
                    {$paged.title}
                </a>
            </li>
        {/foreach}
    {/if}
</ul>