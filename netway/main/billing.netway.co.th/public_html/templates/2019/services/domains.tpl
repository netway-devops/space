{if $edit}
    {include file='services/domain_details.tpl'}
{else}
    {if $domains}

        <h1>{$lang.domains|capitalize}</h1>

        <section class="section-services">
            <div class="nav-tabs-wrapper">
                <ul class="nav nav-tabs d-flex justify-content-between align-items-center flex-nowrap" role="tablist">
                    <li>
                        <ul class="nav nav-slider flex-nowrap">
                            <li class="nav-item active"><a class="nav-link nav-link-slider" href="#" data-sorter="filter[status]">{$lang.all}</a></li>
                            <li class="nav-item"><a class="nav-link nav-link-slider" href="#Active" data-sorter="filter[status]">{$lang.Active}</a></li>
                            <li class="nav-item"><a class="nav-link nav-link-slider" href="#Pending" data-sorter="filter[status]">{$lang.Pending}</a></li>
                        </ul>
                    </li>
                    <li>
                        <ul class="nav flex-nowrap">
                            <li>
                                <button class="btn btn-sm btn-secondary dropdown-toggle ml-3" id="service-filters" data-box="service-filters-box" type="button">
                                    {$lang.filterdata}
                                </button>
                            </li>
                            <li>
                                <a class="btn btn-sm btn-success ml-3" href="#bulkdomaintransfer" data-toggle="modal" >
                                    {$lang.bulkdomaintransfer}
                                </a>
                            </li>
                            <li>
                                <a class="btn btn-sm btn-success ml-3" href="{$ca_url}checkdomain" >
                                    {$lang.add_domain}
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>

            {*
                bulk domain transfer modal
            *}
            <div id="bulkdomaintransfer" class="modal fade fade2" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title font-weight-bold mt-2">{$lang.bulkdomaintransfer}</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <i class="material-icons">cancel</i>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="?cmd=cart&action=bulk_domain_transfer" method="POST">
                                <p>{$lang.bulkdomaintransferdesc}</p>
                                <div class="form-label-group mt-3">
                                    <textarea name="domains" rows="10" class="form-control" placeholder="ex: example.com:AuthCode" required="required"></textarea>
                                </div>
                                <div class="w-100  mt-4">
                                    <button type="submit" class="btn btn-primary btn-lg w-100">{$lang.submit}</button>
                                </div>
                                {securitytoken}
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <h5 class="my-5">{$lang.listallyoursdomain}</h5>

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


            <a href="{$ca_url}clientarea&amp;action=domains" id="currentlist" style="display:none" updater="#updater"></a>
            <input type="hidden" id="currentpage" value="0" />
            <div class="table-responsive table-borders table-radius">
                <table class="table domains-table position-relative stackable">
                    <thead class="noncrucial">
                    <tr>
                       <th colspan="3" style="vertical-align: middle">
                           {$lang.withdomains}
                           <div class="selected-names"></div>
                       </th>
                       <th colspan="4" class="text-right domain-widgets">
                           <a href="{$ca_url}clientarea/domains/renew/"
                              title="{$lang.renew_widget}" data-toggle="tooltip"
                              class="btn btn-primary btn-sm disabled widget_domainrenewal">
                               <i class="material-icons size-sm">refresh</i>
                           </a>
                           {if $domwidgets}
                               {foreach from=$domwidgets item=widg}
                                   {assign var=widg_name value="`$widg.name`_widget"}
                                   <a href="{$ca_url}clientarea/domains/bulkdomains/&widget={$widg.widget}"
                                      title="{$widg.fullname}"
                                      data-toggle="tooltip"
                                      class="btn btn-sm btn-primary disabled widget_{$widg.widget}">
                                       <i class="material-icons size-sm">
                                           {if $widg.widget=='renew'} refresh
                                           {elseif $widg.widget=='contactinfo'} contacts
                                           {elseif $widg.widget=='autorenew'} autorenew
                                           {elseif $widg.widget=='reglock'} lock
                                           {elseif $widg.widget=='domainforwarding' || $widg.widget=='emailforwarding'} screen-share
                                           {elseif $widg.widget=='nameservers' || $widg.widget=='registernameservers' || $widg.widget=='dnsmanagement_widget'} settings_brightness
                                           {/if}
                                       </i>
                                   </a>
                               {/foreach}
                           {/if}
                       </th>
                    </tr>
                    </thead>
                    <thead>
                    <tr>
                       <th class="noncrucial" width="14"><input type="checkbox" id="change-all"></th>
                       <th><a href="{$ca_url}clientarea/domains/&orderby=name|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.domain}</a></th>
                        <th style="width: 130px"><a href="{$ca_url}clientarea/domains/&orderby=status|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.status}</a></th>
                        <th style="width: 160px"><a href="{$ca_url}clientarea/domains/&orderby=date_created|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.registrationdate}</a></th>
                       <th style="width: 130px"><a href="{$ca_url}clientarea/domains/&orderby=expires|ASC" data-sorter="orderby"> <i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.expirydate}</a></th>
                       <th colspan="2" style="width: 110px" class="noncrucial">{$lang.autorenew}</th>
                    </tr>
                    </thead>
                    <tbody id="updater">
                    {include file='ajax/ajax.domains.tpl'}
                    </tbody>
                </table>
            </div>
            {include file="components/pagination.tpl"}
        </section>
        {literal}
            <script>
                $(function(){
                    handle_domain_widgets('<a href="#rem" class="badge badge-Active">%name <i class="fa fa-times remove"></i></a>');
                })
            </script>
        {/literal}
    {else}
        <section class="section-services">
            <div class="d-flex flex-row justify-content-between align-items-end">
                <div class="">
                    <h1>{$lang.domains|capitalize}</h1>
                    <h5>{$lang.nothing}</h5>
                </div>
            </div>

            {if $lang.add_domain}
                <form method="post" action="{$ca_url}checkdomain" class="d-flex flex-row justify-content-start">
                    <button class="btn btn-lg btn-danger font-weight-bold">
                        <i class="material-icons">shopping_cart</i>
                        {$lang.add_domain}
                    </button>
                    {securitytoken}
                </form>
            {/if}
        </section>
    {/if}
{/if}
