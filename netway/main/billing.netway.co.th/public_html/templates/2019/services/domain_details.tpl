{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'services/domain_details.tpl.php');
{/php}

{if $bulkdetails}
    <div class="widget spacing">
        <div class="wbox">
            <div class="wbox_header">{$lang.bulkdomains}</div>
            <div class="wbox_content" id="cartSummary">
                {foreach from=$bulkdetails item=b}
                    <a href="{$ca_url}clientarea/domains/{$b.id}/{$b.name}/"><span
                                class="label label-danger">{$b.name}</span></a>
                {/foreach}
            </div>
        </div>
        {if $widget.replacetpl}
            {include file=$widget.replacetpl}
        {elseif $widget.appendtpl}
            {include file=$widget.appendtpl}
        {elseif $widget.appendaftertpl}
            <a name="{$widget.name}"></a>
            {include file=$widget.appendaftertpl}
        {/if}
    </div>
{elseif $details}
    <section class="d-flex flex-row flex-wrap align-items-center mb-3" style="width: 100%;">
        <p class="mb-0 left">
            <i class="material-icons icon-info-color">cloud</i>
            <span class="h2 mb-0 pb-0 ml-3  align-middle">{$details.name}</span>
            <span class="ml-3 badge badge-{$details.status} ">{$lang[$details.status]}</span>
        </p>
        <p class="mb-0 float-right" style="margin-left: auto;">
            <a class="btn btn-sm btn-primary" href="{$ca_url}clientarea/domains/"><strong><i class="material-icons icon-btn-color size-sm md-right">arrow_back</i> {$lang.backtodom}</strong></a>
        </p>
    </section>
    <section class="section-account section-account-service row {if $layout === 'right'} flex-row-reverse {/if}">
        {if $layout === 'left' || $layout === 'right'}
            <div class="px-0 col-12 col-md-3">
                <div class="mb-5 {if $layout === 'left'}pr-md-3{elseif $layout === 'right'}pl-md-5{/if}">
                    <ul class="leftnavigation-box nav flex-column">
                        {include file='services/left_nav_domain.tpl' widget_group='sidemenu'}
                    </ul>
                </div>
            </div>
            <hr class="d-block d-md-none border-light">
        {/if}
        <div class="px-0 col-12 {if $layout === 'top'}{else}col-md-9{/if}">
            {if $widget.appendtpl && $layout !== 'top'}
                <div class="widget">
                    {include file=$widget.appendtpl}
                </div>
            {/if}
            {if $widget.replacetpl}
                <div class="widget">
                    {include file=$widget.replacetpl}
                </div>
            {/if}

            <div class="mb-2 mt-1 cloud d-flex flex-row justify-content-between position-relative align-items-center">
                <div class="">
                    <h4 class="mb-3">{$lang.domdetails}</h4>
                    <a href="http://{$details.name}" target="_blank">{$details.name}</a>
                    {if $details.status!='Active'}
                        <div class="alert alert-warning my-3">
                            {if $details.status=='Pending' ||  $details.status=='Pending Registration'}
                                {$lang.domainpendinginfo}
                            {elseif $details.status=='Pending Transfer'}
                                {$lang.domainpendingtransferinfo}
                            {elseif $details.status=='Expired'}
                                {$lang.domainexpiredinfo}
                            {elseif $details.status=='Cancelled' ||  $details.status=='Fraud'}
                                {$lang.domaincanceledinfo}
                            {/if}
                        </div>
                    {/if}
                </div>
                <ul class="position-relative service-header-menu d-fle flex-row align-items-center" id="vm-menu">
                    {if $layout === 'top'}
                        {include file='services/left_nav_domain.tpl' widget_group='all'}
                    {else}
                        {include file='services/left_nav_domain.tpl' widget_group='apps'}
                    {/if}
                </ul>
            </div>

            {include file="services/service_upgrades.tpl"}
            <section class="bordered-section mt-3 service-details">
                <div class="service-details-line p-4">
                    <small class="d-block font-weight-bold mb-2">{$lang.registrationdate}</small>
                    <span class="text-small break-word">{if !$details.date_created || $details.date_created == '0000-00-00'}{$lang.none}{else}{$details.date_created|dateformat:$date_format}{/if}</span>
                </div>
                <div class="service-details-line p-4">
                    <small class="d-block font-weight-bold mb-2">{$lang.expirydate}</small>
                    <span class="text-small break-word">
                        {if $details.status == 'Active' || $details.status == 'Expired'}
                            {if !$details.expires || $details.expires == '0000-00-00'}{$lang.none}
                            {else}
                                {$details.expires|dateformat:$date_format}
                                {if $details.daytoexpire >= 0}
                                    <span class="text-secondary">
                                        ({$details.daytoexpire}
                                        {if $domain.daytoexpire==1}{$lang.day}
                                        {else}{$lang.days}
                                        {/if} {$lang.toexpire})
                                    </span>
                                {/if}
                            {/if}
                            {if $allowrenew}
                            <i class="material-icons size-sm icon-info-color mg-left-10 mg-right-5">shopping_cart</i>
                            <a href="{$ca_url}clientarea/domains/renew/&ids[]={$details.id}" class="text-small">
                                    <span data-title="{$lang.renewdomain}">{$lang.renewdomain}</span>
                                </a>
                        {/if}
                        {else}
                            <span class="text-secondary text-small">{$lang.nothing}</span>
                        {/if}
                    </span>
                </div>
                <div class="service-details-line p-4">
                    <small class="d-block font-weight-bold mb-2">{$lang.reglock}</small>
                    <span class="text-small break-word">
                        {if $details.status == 'Active'}
                            {if $details.reglock=='1'}<span class="badge badge-Active">{$lang.On}</span>
                            {else}
                                <span class="badge badge-Pending">{$lang.Off}</span>
                            {/if}
                            {foreach from=$widgets item=widg name=cst}
                            {if $widg.name=='reglock'}
                                <i class="icon-sh-password"></i>
                                <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#{$widg.name}"
                                   class="text-small">
                                        <span data-title="{$widg.fullname}">
                                            {$widg.fullname}
                                        </span>
                                    </a>
                                {break}
                            {/if}
                        {/foreach}
                        {else}
                            <span class="text-secondary text-small">{$lang.nothing}</span>
                        {/if}
                    </span>
                </div>
                <div class="service-details-line p-4">
                    <small class="d-block font-weight-bold mb-2">{$lang.autorenew}</small>
                    <span class="text-small break-word">
                        {if !$details.not_renew}
                            {if $details.autorenew=='1'}
                                <span class="badge badge-Active">{$lang.On}</span>
                            {else}
                                <span class="badge badge-Pending">{$lang.Off}</span>
                            {/if}
                            {foreach from=$widgets item=widg name=cst}
                                {if $widg.name=='autorenew'}
                                    <i class="icon-renewal inline-block"></i>
                                    <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#{$widg.name}"
                                       class="text-small">
                                        <span data-title="{$widg.fullname}">
                                            {$widg.fullname}
                                        </span>
                                    </a>
                                    {break}
                                {/if}
                        {/foreach}
                        {else}
                            <span class="text-secondary text-small">{$lang.nothing}</span>
                        {/if}
                    </span>
                </div>
                {if $details.offerprotection}
                    <div class="service-details-line p-4">
                        <small class="d-block font-weight-bold mb-2">{$lang.privacyprotection}</small>
                        <span class="text-small break-word">
                            {if $details.offerprotection.enabled}
                                <span class="badge badge-Active">{$lang.On}</span>
                            {else}
                                <span class="badge badge-Pending">{$lang.Off}</span>
                            {/if}
                            {if $details.offerprotection.purchased}
                            {foreach from=$widgets item=widg name=cst}
                                {if $widg.name=='idprotection'}
                                    <i class="icon-sh-password inline-block"></i>
                                    <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#{$widg.name}"
                                       class="roll-link text-small">
                                            <span data-title="{$widg.fullname}">
                                                {$widg.fullname}
                                            </span>
                                        </a>
                                    {break}
                                {/if}
                            {/foreach}
                            {else}
                                <i class="icon-sh-password inline-block"></i>
                            <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&make=domainaddons"
                               class="text-small"><span>{$lang.addprivacy}</span></a>
                        {/if}
                            <span class="vtip_description" title="{$lang.privacyprotection_desc}"></span>
                        </span>
                    </div>
                {/if}
            </section>
            {if $details.custom}
                {assign var="service" value=$details}
                {include file='services/service_forms.tpl' service_details="domdetails"}
            {/if}
            <h4 class="mt-5 mb-3">{$lang.nameservers}</h4>
            <div class="table-responsive table-borders table-radius">
                <table class="table">
                    <thead>
                    <tr>
                        <th class="w-50">{$lang.hostname}</th>
                        <th class="w-50">{$lang.ipadd}</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach from=$details.nameservers item=ns name=namserver}
                        {if $ns!=''}
                            <tr class="no-border">
                                <td>{$ns}</td>
                                <td>
                                    {if $details.nsips[$smarty.foreach.namserver.index]}
                                        {$details.nsips[$smarty.foreach.namserver.index]}
                                    {/if}
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                    {foreach from=$widgets item=widg name=cst}
                        {if $widg.name=='nameservers'}
                            <tr>
                                <td>
                                    <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/&widget={$widg.name}#nameservers">
                                        {$widg.fullname}
                                    </a>
                                <td></td>
                            </tr>
                            {break}
                        {/if}
                    {/foreach}
                    </tbody>
                </table>
            </div>
            {if $widget.appendtpl && $layout === 'top'}
                <div class="widget mt-5">
                    <a name="{$widget.name}"></a>
                    {include file=$widget.appendtpl}
                </div>
            {elseif $widget.appendaftertpl}
                <div class="widget mt-5">
                    <a name="{$widget.name}"></a>
                    {include file=$widget.appendaftertpl}
                </div>
            {/if}
        </div>
    </section>
{/if}