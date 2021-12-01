{*

Clientarea dashboard - summary of owned services, due invoices, opened tickets

*}
{if $offer_total > 0}
    <article id="slides">
        <h2><i class="icon-dboard"></i> {$lang.servicedetails}</h2>
        <p>{$lang.my_servicesinfo}</p>
        {*<p>Owned UnBranded license, <a href="#">4 products</a></p>*}
        <div class="services-container" >
            {counter name=secont print=false start=0 assign=secont }
            {if $mydomains>0}
                <div class="service-box  service-first service_{$secont}{counter name=secont}">
                    <div class="service-box-top">
                        <div class="icon-sm-domains"></div>
                        <h4>{$lang.mydomains}</h4>
                        <p class="service-count">{$mydomains}</p>
                        <p class="service-title">{$lang.mydomains}</p>
                    </div>
                    <div class="service-box-bottom">
                        <div class="service-border">
                            <a href="#" class="btn c-white-btn" data-toggle="dropdown"><i class="icon-c-cog"></i> {$lang.manage}</a>
                            <ul class="dropdown-menu">
                                <div class="dropdown-padding">
                                    {if $expdomains}
                                        <li><a href="{$ca_url}clientarea/domains/">{$expdomains_count} {$lang.ExpiringDomains}</a></li>
                                        {/if}
                                    <li><a href="{$ca_url}checkdomain/">{$lang.ordermore}</a><span></span></li>
                                    <li><a href="{$ca_url}clientarea/domains/">{$lang.listmydomains}<span></span></a></li>
                                </div>
                            </ul>
                        </div>
                    </div>
                </div><!--
            {else}<!-- -->
            {/if}
            {foreach from=$offer item=offe}
                {if $offe.total>0}
                    {assign var="offa" value="1"}                        

                    <!-- --><div  class="service-box {if $secont % 3 == 0}service-first{elseif $secont % 3 == 2}service-last{/if} service_{$secont}{counter name=secont}">
                        <div class="service-box-top">
                            <div class="icon-sm-services"></div>
                            <h4>{$lang.services}</h4>
                            <p class="service-count">{$offe.total}</p>
                            <p class="service-title">{$offe.name}</p>
                        </div>
                        <div class="service-box-bottom">
                            <div class="service-border">
                                <a href="{$ca_url}clientarea/services/{$offe.slug}/" class="btn c-white-btn"><i class="icon-c-cog"></i> {$lang.servicemanagement}</a>
                            </div>
                        </div>
                    </div><!--
                {/if}
            {/foreach}

            {if $mydomains>0 || $offa}
                <!-- --><div class="service-box {if $secont % 3 == 0}service-first{/if} service-last service_{$secont}{counter name=secont}">

                    <div class="service-box-top">
                        <div class="icon-sm-more"></div>
                        <h4>{$lang.ordermore}</h4>
                        <p class="service-order-more">{$lang.clickheretoaddmore}</p>
                    </div>

                    <div class="service-box-bottom">
                        <div class="service-border">
                            <a class="btn c-green-btn" href="{$ca_url}cart/"><i class="icon-add"></i> {$lang.order}</a>
                        </div>
                    </div>
                </div>
            {else}<!-- -->
            {/if}
        </div>
    </article>
    <!-- End of Services -->
{/if}
{if $dueinvoices}
    <!-- Invoices -->
    <article>
        <h2><i class="icon-inv"></i> {$lang.invoices}</h2>
        <p>{$lang.currentbalancestatus}</p>

        <div class="invoices-box clearfix">
            <ul id="invoice-tab" class="nav nav-tabs table-nav">
                {*<li class="active"><a href="#tab1" data-toggle="tab"><div class="tab-left"></div> All <div class="tab-right"></div></a></li>*}
                <li class="active">
                    <a href="#Unpaid" data-toggle="tab">
                        <div class="tab-left"></div> {$lang.Unpaid}<div class="tab-right"></div>
                    </a>
                </li>
                {if $enableFeatures.deposit!='off' }
                <li class="custom-tab">
                    <a href="{$ca_url}clientarea/addfunds/">
                        <div class="tab-left"></div> 
                        <i class="icon-add"></i> {$lang.addfunds}
                        <div class="tab-right"></div>
                    </a>
                </li>
                {/if}
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="tab1">
                    <div class="table-details">
                        <div class="right-btns">
                            {if $enableFeatures.bulkpayments!='off'}
                                <form method="post" action="index.php" style="margin:0px">
                                    <button type="submit" class="btn c-green-btn"><i class="icon-pay-due"></i> {$lang.paynowdueinvoices}</button>
                                    <input type="hidden" name="action" value="payall"/>
                                    <input type="hidden" name="cmd" value="clientarea"/>
                                </form>
                            {/if}
                        </div>
                        <div class="detailed-info">
                            <span>{$acc_balance|price:$currency}</span>
                            <p>{$lang.dueinvoices}</p>
                        </div>
                        <div class="detailed-info">
                            {foreach from=$dueinvoices item=invoice name=foo}{break}{/foreach}
                            <span class="Unpaid-label">{$smarty.foreach.foo.total}</span>
                            <p>{$lang.Unpaid}</p>
                        </div>
                    </div>
                    <table class="table styled-table">
                        <tr>
                            <th><i class="icon-sort"></i> {$lang.status}</th>
                            <th><i class="icon-sort"></i> {$lang.invoicenum}</th>
                            <th><i class="icon-sort"></i> {$lang.total}</th>
                            <th><i class="icon-sort"></i> {$lang.invoicedate}</th>
                            <th><i class="icon-sort"></i> {$lang.duedate}</th>
                            <th></th>
                        </tr>
                        {foreach from=$dueinvoices item=invoice name=foo}
                            <tr class="styled-row">
                                <td class="bold Unpaid-label">
                                    <div class="td-rel">
                                        <div class="left-row-side Unpaid-row"></div>
                                    </div>
                                    {$lang.Unpaid}
                                </td>
                                <td class="bold invoice-c">{$lang.invoice} #{if $proforma && ($invoice.status=='Paid' || $invoice.status=='Refunded') && $invoice.paid_id!=''}{$invoice.paid_id}{else}{$invoice.date|invprefix:$prefix}{$invoice.id}{/if}</td>
                                <td>{$invoice.total|price:$invoice.currency_id}</td>
                                <td>{$invoice.date|dateformat:$date_format}</td>
                                <td>{$invoice.duedate|dateformat:$date_format}</td>
                                <td>
                                    <div class="td-rel">
                                        <div class="right-row-side"></div>
                                    </div>
                                    <a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank" class="icon-link"><i class="icon-single-arrow"></i></a></td>
                            </tr>
                            <tr class="empty-row">
                            </tr>
                        {/foreach}
                    </table>
                </div>
                <!-- End of Tab #1 -->
            </div>
        </div>
    </article>
    <!-- End of Invoices -->
{/if}
{if $openedtickets}
<!-- Support Tickets -->
<article>
    <h2><i class="icon-supp"></i> {$lang.openedtickets|capitalize} </h2>
    <p>{$lang.ticketsfromehere}</p>

    <div class="invoices-box clearfix">
        <ul id="support-tab" class="nav nav-tabs table-nav">
            <li class="active"><a href="#" data-toggle="tab"><div class="tab-left"></div> {$lang.all}<div class="tab-right"></div></a></li>
            <li><a href="#Open" data-toggle="tab"><div class="tab-left"></div> {$lang.Open}<div class="tab-right"></div></a></li>
            <li><a href="#Answered" data-toggle="tab"><div class="tab-left"></div> {$lang.Answered}<div class="tab-right"></div></a></li>
            <li class="custom-tab"><a href="{$ca_url}tickets/new/"><div class="tab-left"></div> <i class="icon-add"></i> {$lang.createnew}<div class="tab-right"></div></a></li>
        </ul>
        <div class="tab-content">

            <!-- Tab #1 -->
            <div class="tab-pane active" id="support1">
                <div class="table-details">
                    {*<div class="right-btns">
                        <a href="#" class="btn c-orange-btn"><i class="icon-reply"></i> Submit reply</a>
                        <a href="#" class="btn c-white-btn"><i class="icon-close-issue"></i> {$lang.closeissue}</a>
                    </div>*}
                    {counter print=false name=openticketsc start=0 assign=openticketsc}
                    {counter print=false name=answeredtsc start=0 assign=answeredtsc}
                    {foreach from=$openedtickets item=ticket name=foo}
                        {if $ticket.status == 'Answered'}
                            {counter name=answeredtsc}
                        {elseif $ticket.status != 'Answered'}
                            {counter name=openticketsc}
                        {/if}
                    {/foreach}
                    <div class="detailed-info">
                        <span>{$smarty.foreach.foo.total}</span>
                        <p>{$lang.total}</p>
                    </div>
                    <div class="detailed-info">
                        <span class="Open-label">{$openticketsc}</span>
                        <p>{$lang.Open}</p>
                    </div>
                    <div class="detailed-info">
                        <span class="Answered-label">{$answeredtsc}</span>
                        <p>{$lang.Answered}</p>
                    </div>
                </div>
                <table class="table styled-table">
                    <tr>
                        <th><input type="checkbox"></th>
                        <th class="w15"><i class="icon-sort"></i> {$lang.status}</th>
                        <th class="w60"><i class="icon-sort"></i> {$lang.subject}</th>
                        <th><i class="icon-sort"></i> {$lang.department}</th>
                        <th></th>
                    </tr>
                    {foreach from=$openedtickets item=ticket name=foo}
                        <tr class="styled-row">
                            <td>
                                <div class="td-rel">
                                    <div class="left-row-side {$ticket.status}-row"></div>
                                </div>
                                <input type="checkbox" name="number" value="{$ticket.ticket_number}">
                            </td>
                            <td class="bold {$ticket.status}-label">
                                {$lang[$ticket.status]}
                            </td>
                            <td class="invoice-c  {if $ticket.client_read=='0'}bold{/if}">
                                {$ticket.subject}
                            </td>
                            <td>{$ticket.deptname}</td>
                            <td>
                                <div class="td-rel">
                                    <div class="right-row-side"></div>
                                </div>
                                <a href="{$ca_url}tickets/view/{$ticket.ticket_number}/" class="icon-link"><i class="icon-single-arrow"></i></a></td>
                        </tr>
                        <tr class="empty-row">
                        </tr>
                    {/foreach}
                </table>
            </div>
        </div>
    </div>
</article>
<!-- End of Support Tickets -->
{/if}
<script type="text/javascript" src="{$template_dir}js/slides.min.jquery.js"></script>

