{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/invoice.tpl.php');
{/php}

{include file="header.tpl"}
        {if $invoice}
            <h1 class="mb-0">
                {if $proforma && !$invoice.paid_id && $invoice.status!='Recurring' && $invoice.status != 'Creditnote'}
                    {$lang.proforma} #
                {elseif $invoice.status=='Recurring'}
                    {$lang.recinvoice} #{$invoice.recurring_id}
                {elseif $invoice.status=='Creditnote'}
                    {$lang.creditnote} #
                {elseif $invoice.status=='Receiptpaid' || $invoice.status=='Receiptunpaid'}
                    {$lang.creditreceipt} #
                {else}
                    {$lang.invoice} #
                {/if}

                {if $proforma && $invoice.paid_id!=''}
                    {$invoice.paid_id}
                {else}
                    {$invoice|@invoice}
                {/if}
            </h1>

            <div class="mb-4">
                <a href="{$ca_url}clientarea/invoices/" class="btn-link my-5"><small>{$lang.backtoinvoices}</small></a>
            </div>

            <div class="content-view-details invoice-btns d-flex flex-column flex-md-row align-items-left align-items-md-center justify-content-between">
                <div class="mb-3 mb-md-0">
                    <span class="badge badge-{$invoice.status} py-2 px-3">{$lang[$invoice.status]}</span>
                    <span class="badge badge-details py-2 px-3">{$invoice.date|dateformat:$date_format}</span>
                </div>
                <div class="d-flex flex-row flex-wrap align-items-center">
                    {if $invoice.status=='Unpaid'}
                        <a class="btn btn-sm btn-primary btn_pay mr-2 my-2 my-md-0" href="#" data-toggle="modal" aria-expanded="false" data-target="#payInvoiceModal">
                            <i class="material-icons icon-btn-color mr-2 size-sm">credit_card</i>
                            {$lang.paynow}
                        </a>
                    {/if}
                    {if ($invoice.status == 'Unpaid' || $invoice.status == 'Receiptunpaid') && $applicable_coupons && !$invoice.discounts}
                        <a class="btn btn-sm btn-info btn_coupon mr-2 my-2 my-md-0" href="#" data-toggle="modal" aria-expanded="false" data-target="#applyCouponModal">
                            <i class="material-icons icon-btn-color mr-2 size-sm">local_offer</i>
                            {$lang.addcouponcode}
                        </a>
                    {/if}
                    <a class="btn btn-sm btn-secondary btn_print mr-2 my-2 my-md-0" href="#" onclick="$('.info-box-invoice').get(0).contentWindow.print();return false;" >
                        <i class="material-icons icon-btn-color mr-2 size-sm">print</i>
                        {$lang.print_invoice}
                    </a>
                    <a class="btn btn-sm btn-secondary btn_pdf mr-2 my-2 my-md-0" target="_blank" href="{$ca_url}root&amp;action=download&amp;invoice={$invoice.id}">
                        <i class="material-icons icon-btn-color mr-2 size-sm">picture_as_pdf</i>
                        {$lang.download_pdf}
                    </a>
                    {if $cancancelinvoice}
                        <a class="btn btn-sm btn-secondary btn_cancel my-2 my-md-0 confirm_js" href="{$ca_url}clientarea&action=invoice&id={$invoice.id}&make=cancel&security_token={$security_token}" data-confirm="{$lang.manualrenew_confirm}">
                            <i class="material-icons icon-btn-color mr-2 size-sm">close</i>
                            {$lang.cancelinvoice}
                        </a>
                    {/if}
                </div>
            </div>
            {if $invoice.status=='Unpaid'}
                <div class="modal fade fade2" id="payInvoiceModal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title font-weight-bold mt-2">{$lang.paynow}</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <i class="material-icons">cancel</i>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="" method="post" class="pb-4">
                                    <select name="paymethod" onchange="ajax_update('?cmd=clientarea&action=gateway&invoice_id={$invoice.id}&gateway_id=' + $(this).val(), '', '#gateway', true);" class="form-control w-100">
                                        {if $invoice.payment_module == 0}
                                            <option value="0"> -</option>
                                        {/if}
                                        {foreach from=$gateways key=gatewayid item=paymethod}
                                            <option value="{$gatewayid}"{if $invoice.payment_module == $gatewayid} selected="selected"{/if} >{$paymethod}</option>
                                        {/foreach}
                                    </select>
                                    {securitytoken}
                                </form>
                                <div class="w-100 my-2">
                                    <div id="gateway" class="d-flex flex-column justify-content-center">{$gateway}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
            {if ($invoice.status == 'Unpaid' || $invoice.status == 'Receiptunpaid') && $applicable_coupons && !$invoice.discounts}
                <div class="modal fade fade2" id="applyCouponModal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title font-weight-bold mt-2">{$lang.addcouponcode}</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <i class="material-icons">cancel</i>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="" method="post" class="pb-4">
                                    {securitytoken}
                                    <div class="form-label-group mt-3">
                                        <input id="applycoupon" class="form-control" type="text" name="applycoupon" placeholder="{$lang.coupon_code}">
                                        <label class="form-label-placeholder" for="applycoupon">{$lang.coupon_code}</label>
                                    </div>
                                    <div class="w-100  mt-4">
                                        <button type="submit" class="btn btn-primary btn-lg w-100">{$lang.submit}</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}

            {if $credit_available && $invoice.status=='Unpaid'}
                <div class="d-block alert alert-info my-5">
                    <div id="credit-applicable">
                        <div class="content">
                        <span id="inv-credit-info">
                            <span class="text-dark">{$lang.youhavecredit}</span>
                            <a href="#" onclick="$('#inv-credit-info').hide();$('#inv-credit-form').show();return false">
                                <b>{$lang.youhavecredit2}</b>
                            </a>
                        </span>
                            <div class="row">
                                <div id="inv-credit-form" style="display:none" class="col-12">
                                    <form method="post" action="">
                                        <span class="text-dark">{$lang.youhavecredit}</span>
                                        <input type="hidden" name="make" value="applycredit" />
                                        <section class="input-self-box fluid">
                                            <form action="{$ca_url}knowledgebase/search/" method="post">
                                                <div class="input-group">
                                                    <input type="text" value="{$credit_available}" size="4" name="amount" class="form-control form-control-noborders" placeholder="{$lang.amountcredittoapply}"/>
                                                    <span class="input-group-btn">
                                                        <button type="submit" class="btn btn-success btn-md">{$lang.applycredit}</button>
                                                    </span>
                                                    {securitytoken}
                                                </div>
                                            </form>
                                        </section>
                                        {securitytoken}
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
            {literal}
                <script>
                    function resizeIframe(obj) {
                        obj.contentWindow.document.write({/literal}{$invoicebody|@json_encode}{literal})
                        obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
                        obj.contentWindow.document.close();
                    }
                </script>
            {/literal}
            <div class="info-box">
                <div class="info-box-items">
                    <iframe class="info-box-invoice" style="width: 100%" frameborder="0" scrolling="no" onload="resizeIframe(this)"></iframe>
                </div>
            </div>
        {/if}
{include file="footer.tpl"}