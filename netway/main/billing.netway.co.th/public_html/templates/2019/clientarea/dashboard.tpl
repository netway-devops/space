{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clientarea/dashboard.tpl.php');
{/php}

<div class="well well-small" style="margin-bottom: 0px;padding: 34px 68px 17px 55px;background-image: linear-gradient(to left, #3891F2, #3891F2);border-radius: 7px;">
    <p style="font-size: 23px;color: #ffffff;font-weight:600;">{$lang.welcomeback}  {$login.firstname} {$login.lastname}</p>
    <!-- <span>{$offer_total} {$lang.services}</span> -->
      <p style="color: #ffffff;font-size:18px;line-height: 25px;">สอบถามสินค้า ผลิตภัณฑ์ และบริการต่างๆ 
          
          <a href="https://support.netway.co.th/hc/th/requests/new" class="btn btn-success mx-3 navbar-order-toggler" target="_blank">
              <b>ติดต่อเจ้าหน้าที่ </b><i class="fa fa-chevron-right" aria-hidden="true"></i> 
          </a>
     </p>
</div>
<Br>
<section class="section-dashboard">
    <div class="d-flex flex-row justify-content-between align-items-end">
        <h1>{$lang.dashboard}</h1>
    </div>

    <h3 class="mt-5">{$lang.my_services}</h3>

    <div class="nav-tabs-wrapper">
        <ul class="nav nav-tabs nav-slider horizontal" id="dashboard_services" role="tablist">
            {clientservicesmenu}
            {if $offer_domains}
                <li class="nav-item active"><a class="nav-link" data-toggle="tab" data-items="domains" href="#domains" role="tab" aria-controls="Domains" aria-selected="true">{$lang.domains}</a></li>
            {/if}
            {foreach from=$offer_menu item=offe name=foo_nb}
                {if $offe.total>0}
                    <li class="nav-item {if !$offer_domains && $smarty.foreach.foo_nb.first} active {/if}"><a class="nav-link" data-items="{$offe.slug}" href="#{$offe.slug}" data-toggle="tab" role="tab" aria-controls="{$offe.name}" aria-selected="true">{$offe.name}</a></li>
                {/if}
            {/foreach}
        </ul>
    </div>

    <div class="tab-content">
        <div class="table-responsive table-borders table-radius">
            <table class="table position-relative stackable" id="dashboard_services_list">
                <thead>
                    <tr>
                        <th>{$lang.service}</th>
                        <th>{$lang.status}</th>
                        {if "acl_user:billing.serviceprices"|checkcondition}
                            <th id="dashboard_services_list_total_title" class="" data-title-domains="{$lang.renewal_cost}" data-title-services="{$lang.total}">{if $offer_domains}{$lang.renewal_cost}{else}{$lang.total}{/if}</th>
                        {/if}
                        <th>{$lang.bcycle}</th>
                        <th>{$lang.duedate}</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                {clientservices}
                {fiveservicesmax}
                {if $client_domains  || $client_services}
                    {foreach from=$client_domains|@array_slice:0:5 item=service name=foo_dm}
                        <tr data-item="domains">
                            <td width="25%">
                                <a href="{$ca_url}clientarea/domains/{$service.id}/{$service.name}/" class="text-small font-weight-bold">
                                    {$service.name}
                                </a>
                            </td>
                            <td class="inline-row"><span class="badge badge-{$service.status}">{$lang[$service.status]}</span></td>
                            {if "acl_user:billing.serviceprices"|checkcondition}
                                <td class="inline-row">{$service.recurring_amount|price:$currency}</td>
                            {/if}
                            <td class="inline-row">{$service.period} {$lang.years}</td>
                            <td data-label="{$lang.duedate}">
                                {if $service.expires && $service.expires!='0000-00-00'}
                                    <small>{$lang.ccardexp}</small><br />
                                    <span>{$service.expires|dateformat:$date_format}</span>
                                {else} -
                                {/if}
                            </td>
                            <td>
                                <a href="{$ca_url}clientarea/domains/{$service.id}/{$service.name}/"><i class="material-icons text-secondary">more_horiz</i></a>
                            </td>
                        </tr>
                    {/foreach}
                    {if $client_domains|@count > 5}
                        <tr data-item="domains">
                            <td colspan="6">
                                <a href="{$ca_url}clientarea/domains/" class="w-100 text-secondary d-block">{$lang.showall}</a>
                            </td>
                        </tr>
                    {/if}
                    {if $client_services}
                        {assign var="service_slug_name" value=$client_services[0].slug}
                        {assign var="service_slug_counter" value=1}
                    {/if}
                    {foreach from=$client_services item=service name=foo_sr}
                        <tr data-item="{if $service.parent_category_slug}{$service.parent_category_slug}{else}{$service.slug}{/if}" {if !$offer_domains &&  ($service.slug == $offer[0].slug || ($service.parent_category_id && $service.parent_category_slug == $offer[0].parent_slug)) }{else} class="hidden" style="display: none" {/if}>
                            <td width="25%">
                                <div class="d-flex flex-column">
                                    {if $service.parent_category_id}
                                        <small class="text-uppercase text-muted font-weight-bold">{$service.catname}</small>
                                    {/if}
                                    <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" class="text-small">
                                        <span class="text-dark font-weight-bold">{$service.name}</span><br />
                                        <span>{$service.domain}</span>
                                    </a>
                                </div>
                            </td>
                            <td class="inline-row"><span class="badge badge-{$service.status}">{$lang[$service.status]}</span></td>
                            {if "acl_user:billing.serviceprices"|checkcondition}
                                <td class="inline-row">{$service.total|price:$currency}</td>
                            {/if}
                            <td class="inline-row">{$lang[$service.billingcycle]}</td>
                            <td>
                                {if $service.next_due && $service.next_due!='0000-00-00'}
                                    <small>{$lang.nextdue}</small><br />
                                    <span>{$service.next_due|dateformat:$date_format}</span>
                                {else} -
                                {/if}
                            </td>
                            <td>
                                <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/"><i class="material-icons text-secondary">more_horiz</i></a>
                            </td>
                        </tr>
                    {/foreach}
                    {foreach from=$client_services_more_links item=slug}
                        <tr data-item="{$slug}" {if !$offer_domains && $slug == $offer[0].slug }{else} class="hidden" style="display: none" {/if}>
                            <td colspan="6">
                                <a href="{$ca_url}clientarea/services/{$slug}/" class="w-100 text-secondary d-block">{$lang.showall}</a>
                            </td>
                        </tr>
                    {/foreach}
                {else}
                    <tr>
                        <td colspan="6" class="text-center p-3">
                            {$lang.nothing}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" class="text-center p-3">
                            <a href="{$ca_url}cart/" class="btn btn-primary"><i class="material-icons icon-btn-color size-md mr-3">shopping_cart</i>{$lang.ordermore}</a>
                        </td>
                    </tr>
                {/if}
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-12 mt-5">
            {clientwidget module="dashboard" section="blocks" wrapper="widget.tpl"}
        </div>
    </div>

    <div class="row">
        {if $openedtickets}
            <div class="{if $dueinvoices} col-lg-6 col-md-6 col-xs-12 {/if} col-12">
                <div class="info-box info-box-table info-box-tickets" data-infobox-list="tickets">
                    <div class="d-flex flex-row justify-content-between align-items-center">
                        <h3>{$lang.tickets}</h3>
                        <a href="{$ca_url}tickets/" class="btn btn-sm btn-secondary btn-view-all">{$lang.viewall} <i class="material-icons size-sm icon-btn-color">chevron_right</i></a>
                    </div>
                    <div class="d-flex flex-row info-box-items">
                        <div class="tab-content w-100">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>{$lang.Ticket}</th>
                                        <th class="w-25">{$lang.status}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {foreach from=$openedtickets|@array_slice:0:5 item=lticket name=foo}
                                    <tr>
                                        <td>
                                            <a href="{$ca_url}tickets/view/{$lticket.ticket_number}/" >
                                                <span class="text-dark text-small">{$lticket.subject|escape}</span>
                                                <br>
                                                <span class="text-secondary">
                                                    <small class="text-secondary">#{$lticket.ticket_number}</small>
                                                    <small class="text-secondary">{$lticket.date|dateformat:$date_format}</small>
                                                </span>
                                            </a>
                                        </td>
                                        <td class="w-25">
                                            <span class="badge badge-{$lticket.status}">{$lang[$lticket.status]}</span>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
        {if $dueinvoices}
        <div class="{if $openedtickets} col-lg-6 col-md-6 col-xs-12 {/if} col-12">
            <div class="info-box info-box-table info-box-invoices">
                    <div class="d-flex flex-row justify-content-between align-items-center">
                        <h3>{$lang.invoices|capitalize}</h3>
                        <a href="{$ca_url}clientarea/invoices/" class="btn btn-sm btn-secondary btn-view-all">{$lang.viewall} <i class="material-icons size-sm icon-btn-color">chevron_right</i></a>
                    </div>
                    <div class="d-flex flex-row info-box-items">
                        <div class="tab-content w-100">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>{$lang.invoice}</th>
                                        <th class="w-25">{$lang.status}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {foreach from=$dueinvoices|@array_slice:0:5 item=invoice name=foo}
                                    <tr>
                                        <td>
                                            <a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank" >
                                                <span class="text-dark text-small">{$lang.invoice|capitalize} #{$invoice|@invoice}</span>
                                                <br>
                                                <span class="text-secondary">
                                                    <small class="text-primary"><b>{$invoice.total|price:$invoice.currency_id}</b></small>
                                                    <small class="text-secondary">{$lang.invoicedate}: {$invoice.date|dateformat:$date_format}</small>
                                                    <small class="text-secondary">{$lang.duedate}: {$invoice.duedate|dateformat:$date_format}</small>
                                                </span>
                                            </a>
                                        </td>
                                        <td class="w-25">
                                            <span class="badge badge-{$invoice.status}">{$lang[$invoice.status]}</span>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    </div>
</section>

{clientwidget module="dashboard" section="footer"}