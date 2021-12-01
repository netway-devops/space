{if !$ajax}
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
                    <li class="nav-item active">
                        <a class="nav-link nav-link-slider" href="#" data-sorter="filter[status]">{$lang.all}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-slider" href="#Active"
                           data-sorter="filter[status]">{$lang.Active}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-slider" href="#Cancelled"
                           data-sorter="filter[status]">{$lang.Cancelled}</a>
                    </li>
                </ul>
            </li>
            <li>
                <ul class="nav flex-nowrap">
                    <li>
                        <div class="btn-group">
                            <button class="btn btn-sm btn-secondary dropdown-toggle ml-3" id="service-filters"
                                    data-box="service-filters-box" type="button">
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
                <input {if $saved_filters.hide_terminated} checked="checked" {/if} data-sorter-checkbox type="checkbox"
                                                                                   id="filter-hide-terminated"
                                                                                   name="filter[hide_terminated]"
                                                                                   value="1">
                <label class="form-check-label" for="filter-hide-terminated">{$lang.hideterminated}</label>
            </div>
            <div class="form-check mr-3">
                <input {if $saved_filters.hide_cancelled} checked="checked" {/if} data-sorter-checkbox type="checkbox"
                                                                                  id="filter-hide-cancelled"
                                                                                  name="filter[hide_cancelled]"
                                                                                  value="1">
                <label class="form-check-label" for="filter-hide-cancelled">{$lang.hidecancelled}</label>
            </div>
            <div class="form-check mr-3">
                <input {if $saved_filters.hide_suspended} checked="checked" {/if} data-sorter-checkbox type="checkbox"
                                                                                  id="filter-hide-suspended"
                                                                                  name="filter[hide_suspended]"
                                                                                  value="1">
                <label class="form-check-label" for="filter-hide-suspended">{$lang.hidesuspended}</label>
            </div>
            <div class="form-check mr-3">
                <input {if $saved_filters.hide_fraud} checked="checked" {/if} data-sorter-checkbox type="checkbox"
                                                                              id="filter-hide-fraud"
                                                                              name="filter[hide_fraud]" value="1">
                <label class="form-check-label" for="filter-hide-fraud">{$lang.hidefraud}</label>
            </div>
        </div>
        <div class="">
            <button id="filter-apply" class="btn btn-primary mt-3 mr-2">{$lang.scaleapply}</button>
            <button id="filter-reset" class="btn btn-default mt-3 mr-2" type="reset">{$lang.clearfilters}</button>
        </div>
    </div>
    <a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none"
       updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0"/>

    {clientwidget module='services' section='list'}
    <div class="table-responsive table-borders table-radius">
        <table class="table services-table position-relative stackable">
            <thead>
            <tr>
                <th class="w-25">
                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=name|ASC"
                       data-sorter="orderby">
                        <i class="material-icons size-sm sort-icon">unfold_more</i>
                        {$lang.service}
                    </a>
                </th>
                <th>
                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=domain|ASC"
                       data-sorter="orderby">
                        <i class="material-icons size-sm sort-icon">unfold_more</i>
                        {$lang.hostname}
                    </a>
                </th>
                <th>
                    {$lang.ipadd}
                </th>
                <th>
                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=status|ASC"
                       data-sorter="orderby">
                        <i class="material-icons size-sm sort-icon">unfold_more</i>
                        {$lang.status}
                    </a>
                </th>
                <th colspan="2">
                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=next_due|ASC"
                       data-sorter="orderby">
                        <i class="material-icons size-sm sort-icon">unfold_more</i>
                        {$lang.nextdue}
                    </a>
                </th>
            </tr>
            </thead>
            <tbody id="updater">
            {/if}
            {foreach from=$services item=service name=foo}
                <tr>
                    <td class="inline-row">
                        <div class="service-name-labeled">
                            <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">
                                <span data-title="{$service.name}">{$service.name}</span>
                                <i class="serlabel-sl service_label_{$service.id}">{if $service.label} - {/if}</i>
                                <i class="serlabel-lb service_label_{$service.id}">{$service.label}</i>
                            </a>
                            <small class="text-danger serlabel-ed" data-id="{$service.id}" data-toggle="modal"
                                   href="#service_label_modal">{$lang.editlabel}</small>
                            {if $service.domain!=''}
                                <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/"
                                   class="d-block text-secondary">
                                    <small>({$service.domain})</small>
                                </a>
                            {/if}
                        </div>
                    </td>
                    <td data-label="{$lang.hostname}:">
                        <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">{$service.domain}</a>
                    </td>
                    <td data-label="{$lang.ipadd}">{if $service.ip && $service.ip!='0.0.0.0'}{$service.ip}{else}-{/if}</td>
                    <td><span class="badge badge-{$service.status}">{$lang[$service.status]}</span></td>
                    <td data-label="{$lang.nextdue}:">{if $service.next_due!=0}{$service.next_due|dateformat:$date_format}{else}-{/if}</td>
                    <td class="text-right noncrucial" style="width: 50px;">
                        <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">
                            <i class="material-icons icon-info-color">settings</i>
                        </a>
                    </td>
                </tr>
                {foreachelse}
                <tr>
                    <td colspan="100%" class="text-center">{$lang.nothing}</td>
                </tr>
            {/foreach}
            {include file='components/editlabel_modal.tpl'}
            {include file='components/editlabel_modal.tpl'}
            {if !$ajax}
            </tbody>
        </table>
    </div>
    {include file="components/pagination.tpl"}
</section>
{/if}