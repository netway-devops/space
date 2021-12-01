<div>
    <h2>{$lang.servicepanel}</h2>
    <p class="no-icon">{$lang.basiciformations}</p>
    {if $domains || $currentfilter}
        <div class="affiliates-panel">

            <form class="form-inline" href="{$ca_url}clientarea/domains/" method="post">
                <div class="content-search">
                    <i class="icon-search pull-left"></i>
                    <button type="submit" name="resetfilter=1" class="btn c-green-btn btn-rds pull-right">{$lang.Go}</button>
                    <div class="overflow-hidden">
                    <input type="text" class="search-field" name="filter[name]" value="{$currentfilter.name}" placeholder="{$lang.filterdomains}" id="d_filter" >
                    </div>
                </div>
            </form>
        </div>
    {else $action=='services' && $cid}
        <div class="affiliates-panel">
            {foreach from=$offer item=o}
                {if $action=='services' && $cid==$o.id}
                    <form class="form-inline" href="{$ca_url}clientarea/services/{$o.slug}/" method="post">
                        <div class="content-search">
                            <i class="icon-search  pull-left"></i>
                            <button type="submit" name="resetfilter=1" class="btn c-green-btn btn-rds pull-right">{$lang.Go}</button>
                            <div class="overflow-hidden">
                                <input type="text" class="search-field" name="filter[domain|name]" value="{$currentfilter.name}" placeholder="{$lang.searchservices}" id="d_filter" >
                            </div>
                        </div>
                    </form>
                {/if}
            {/foreach}
        </div>
    {/if}
    <div class="add-new-service">
        <div class="btn-group">
            <a href="#" data-toggle="dropdown" class="btn dropdown-toggle">
                <div class="input-append">
                    <div>
                        <span>{$lang.addservice}</span>
                    </div>
                    <span class="add-on">
                        <i class="icon-add-service-caret"></i>
                    </span>
                </div>
            </a>
            <ul class="dropdown-menu">
                <div class="dropdown-padding">
                    {foreach from=$offer item=offe}
                        {if $offe.total>0}
                            <li>
                                <a href="{$ca_url}cart&cat_id={$offe.id}">{$offe.name}</a>
                            </li>
                        {/if}
                    {/foreach}
                    <li>
                        <a href="{$ca_url}checkdomain">{$lang.add_domain}</a>
                    </li>
                </div>
            </ul>
        </div>
    </div>
</div>


<div class="short-separator">
</div>
<!-- End of Invoice Info -->

<!-- Quick Menu -->
<div>
    <h2>{$lang.quicklinks}</h2>
    <p class="no-icon">{$lang.my_services}</p>
    <div class="quick-menu">
        <ul class="link-list">
            {foreach from=$offer item=offe}
                {if $offe.total>0}
                    <li {if $cid == $offe.id}class="active"{/if}>
                        <a href="{$ca_url}clientarea/services/{$offe.slug}/">
                            <i class="icon icon-qm-she"></i>
                            <p>{$offe.name} ({$offe.total})</p>
                            <span>
                                <i class="icon-single-arrow"></i>
                            </span>
                        </a>
                    </li>
                {/if}
            {/foreach}
            {if $offer_domains}
                <li {if $action == 'domains'}class="active"{/if}>
                    <a href="{$ca_url}clientarea/domains/">
                        <i class="icon icon-qm-domains"></i>
                        <p>{$lang.domains} ({$offer_domains})</p>
                        <span>
                            <i class="icon-single-arrow"></i>
                        </span>
                    </a>
                </li>
            {/if}
        </ul>
    </div>
</div>