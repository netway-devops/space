{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'clientarea/invoices.tpl.php');
{/php}

{include file="components/billing_header.tpl"}

{include file="clientarea/top_nav.tpl" nav_type="billing"}

<div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-5">
    <h5>{$lang.currentbalancestatus}</h5>

    {if $acc_balance && $acc_balance > 0 && $enableFeatures.bulkpayments!='off'}
        <div>
            <a href="#" onclick="$(this).next().submit();return false;" class="btn btn-primary">
                <span class="payall-all">{$lang.paynowdueinvoices}</span>
                <span class="payall-selected">{$lang.payselectedinvoices}</span>
            </a>
            <form method="post" action="index.php" style="display: none;" id="payall">
                <input type="hidden" name="action" value="payall"/>
                <input type="hidden" name="cmd" value="clientarea"/>
                {securitytoken}
            </form>
        </div>
    {/if}
</div>

<section class="section-invoices">
    <div class="filters-box my-4 py-4 px-3" id="service-filters-box" style="display: none;">
        <div class="d-flex flex-column flex-md-row align-items-start align-items-md-end">
            <div class="w-100 w-md-25 mx-2 my-2">
                <label for="filter-service">{$lang.status}:</label>
                <select data-sorter-select name="filter[status]" class="form-control" id="filter-status">
                    <option value="" selected>{$lang.showall}</option>
                    {foreach from=$invoice_statuses item=param}
                        <option value="{$param}">{if $lang.$param}{$lang.$param}{else}{$param}{/if}</option>
                    {/foreach}
                </select>
            </div>
            <div class="w-100 w-md-50 mx-2 my-2">
                <label for="filter-service">{$lang.filterbyservice}</label>
                <select data-sorter-select name="filter[service]" class="form-control" id="filter-service">
                    <option value="" selected>{$lang.showall}</option>
                    {foreach from=$filters.services item=param}
                        <option value="#{$param.id}" {if $filter_service == $param.id} selected="selected" {/if}>#{$param.id} - {$param.catname} - {$param.name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="w-100 w-md-25 mx-2 my-2">
                <select data-sorter-select name="filter[service_status]" class="form-control" id="filter-service-status">
                    <option value="" selected>{$lang.showall}</option>
                    {foreach from=$filters.services_statuses item=param}
                        <option value="#{$param}">{if $lang.$param}{$lang.$param}{else}{$param}{/if}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="mx-2">
            <button id="filter-reset" class="btn btn-default mt-3" type="reset" >{$lang.clearfilters}</button>
        </div>
    </div>

    <a href="{$ca_url}clientarea/invoices/" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="table-responsive table-borders table-radius">
        <table class="table invoices-table position-relative stackable">
            <thead>
                <tr>
                    {if $enableFeatures.bulkpayments!='off'}
                        <th width="14" class="noncrucial">
                            <input type="checkbox" id="checkall"/>
                        </th>
                    {/if}
                    <th><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=id|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.invoicenum}</a></th>
                    <th><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=status|ASC"  data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.status}</a></th>
                    <th><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=total|ASC"  data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.total}</a></th>
                    <th><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=date|ASC"  data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.invoicedate}</a></th>
                    <th  class="noncrucial"><a href="{$ca_url}clientarea&amp;action=invoices&amp;orderby=duedate|ASC"  data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.duedate}</a></th>
                    <th  class="noncrucial"></th>
                </tr>
            </thead>
            <tbody id="updater">
                {include file='ajax/ajax.invoices.tpl'}
            </tbody>
        </table>
    </div>

    {include file="components/pagination.tpl"}

</section>
{if $enableFeatures.bulkpayments!='off'}
    {literal}
        <script type="text/javascript">
            function bindInvoicesPay() {
                var checks = $('input[name="selected[]"]');
                var pay = $('#payall');
                checks.change(function(){
                    if(checks.filter(':checked').length){
                        $('.payall-selected').show();
                        $('.payall-all').hide();
                    }else{
                        $('.payall-selected').hide();
                        $('.payall-all').show();
                    }
                }).change();
                pay.submit(function(){
                    if(checks.filter(':checked').length){
                        var a = checks.serializeArray();
                        for(var i = 0; i < a.length; i++){
                            pay.append('<input type="hidden" name="selected[]" value="'+a[i].value+'" />');
                        }
                    }
                });
            }
            $(document).ready(function () {
                bindInvoicesPay();
                var timeout = null;
                $(".invoices-table").on('DOMSubtreeModified', "#updater", function() {
                    timeout && clearTimeout(timeout);
                    timeout = setTimeout(bindInvoicesPay, 100);
                });
            });
        </script>
    {/literal}
{/if}