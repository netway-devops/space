{if $service}
    {include file='services/service_details.tpl'}
{else}
    {if $services}
        {if $custom_template}
            {include file=$custom_template}
        {else}

            <h1>
                {if $action=='services' && $cid}
                    {foreach from=$offer item=o}{if $action=='services' && $cid==$o.id}{$o.name}
                    {/if}
                    {/foreach}
                {else}
                    {$lang[$action]|capitalize}
                {/if}
            </h1>

            <section class="section-services">
                <div class="nav-tabs-wrapper">
                    <ul class="nav nav-tabs d-flex justify-content-between align-items-center flex-nowrap" role="tablist">
                        <li>
                            <ul class="nav nav-slider flex-nowrap">
                                <li class="nav-item active"><a class="nav-link nav-link-slider" href="#" data-sorter="filter[status]">{$lang.all}</a></li>
                                <li class="nav-item"><a class="nav-link nav-link-slider" href="#Active" data-sorter="filter[status]">{$lang.Active}</a></li>
                                <li class="nav-item"><a class="nav-link nav-link-slider" href="#Cancelled" data-sorter="filter[status]">{$lang.Cancelled}</a></li>
                            </ul>
                        </li>
                        <li>
                            <ul class="nav flex-nowrap">
                                <li>
                                    <div class="btn-group">
                                        <button class="btn btn-sm btn-secondary dropdown-toggle ml-3" id="service-filters" data-box="service-filters-box" type="button">
                                            {$lang.filterdata}
                                        </button>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

                <h5 class="my-5">{$lang.listservices}</h5>

                <div class="filters-box my-4 p-4" id="service-filters-box" style="display: none;">
                    <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center">
                        <div class="form-check mr-3">
                            <input {if $saved_filters.hide_terminated} checked="checked" {/if} data-sorter-checkbox  type="checkbox" id="filter-hide-terminated" name="filter[hide_terminated]" value="1">
                            <label class="form-check-label" for="filter-hide-terminated">{$lang.hideterminated}</label>
                        </div>
                        <div class="form-check mr-3">
                            <input {if $saved_filters.hide_cancelled} checked="checked" {/if} data-sorter-checkbox  type="checkbox" id="filter-hide-cancelled" name="filter[hide_cancelled]" value="1">
                            <label class="form-check-label" for="filter-hide-cancelled">{$lang.hidecancelled}</label>
                        </div>
                        <div class="form-check mr-3">
                            <input {if $saved_filters.hide_suspended} checked="checked" {/if} data-sorter-checkbox  type="checkbox" id="filter-hide-suspended" name="filter[hide_suspended]" value="1">
                            <label class="form-check-label" for="filter-hide-suspended">{$lang.hidesuspended}</label>
                        </div>
                        <div class="form-check mr-3">
                            <input {if $saved_filters.hide_fraud} checked="checked" {/if} data-sorter-checkbox  type="checkbox" id="filter-hide-fraud" name="filter[hide_fraud]" value="1">
                            <label class="form-check-label" for="filter-hide-fraud">{$lang.hidefraud}</label>
                        </div>
                    </div>
                    <div class="">
                        <button id="filter-apply" class="btn btn-primary mt-3 mr-2">{$lang.scaleapply}</button>
                        <button id="filter-reset" class="btn btn-default mt-3 mr-2" type="reset" >{$lang.clearfilters}</button>
                    </div>
                </div>

                <a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
                <input type="hidden" id="currentpage" value="0" />

                {clientwidget module='services' section='list'}

                <div class="table-responsive table-borders table-radius">
                    <table class="table services-table position-relative stackable">
                        <thead>
                            <tr>
                                <th class="w-25">
                                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=name|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.service}</a>
                                </th>
                                <th>
                                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=status|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.status}</a>
                                </th>
                                {if $action=='vps'}
                                    <th>
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=domain|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.hostname}</a>
                                    </th>
                                    <th>
                                        {$lang.ipadd}
                                    </th>
                                {else}
                                    {if "acl_user:billing.serviceprices"|checkcondition}
                                        <th>
                                            <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=total|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.price}</a>
                                        </th>
                                    {/if}
                                    <th>
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=billingcycle|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.bcycle}</a>
                                    </th>
                                {/if}
                                <th colspan="2">
                                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=next_due|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.nextdue}</a>
                                </th>
                            </tr>
                        </thead>
                        <tbody id="updater">
                        {include file='ajax/ajax.services.tpl'}
                        </tbody>
                    </table>
                </div>
                {include file="components/pagination.tpl"}
            </section>
        {/if}
    {else}
        <section class="section-services">
            <div class="d-flex flex-row justify-content-between align-items-end">
                <div class="">
                    <h1>{$lang[$action]|capitalize}</h1>
                    <h5>{$lang.nothing}</h5>
                </div>
            </div>

            {if $cid}
                {foreach from=$offer item=oo}
                    {if $cid==$oo.id && $oo.visible=='1'}
                        <form method="post" action="{$ca_url}cart&cat_id={$cid}" class="d-flex flex-row justify-content-start">
                            <button class="btn btn-lg btn-danger font-weight-bold">
                                <i class="material-icons">shopping_cart</i>
                                {$lang.Add}
                                {$oo.name}
                            </button>
                            {securitytoken}
                        </form>
                    {/if}
                {/foreach}
            {/if}
        </section>
    {/if}
{/if}
