{if $invoice}
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <script type="text/javascript" src="{$template_dir}js/jquery.js"></script>
            <base href="{$system_url}" />

            <link media="screen" type="text/css" rel="stylesheet" href="{$template_dir}css/bootstrap.css" />
            <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/invoice.css" />
            <link media="print" type="text/css" rel="stylesheet" href="{$template_dir}css/invoice_print.css" />

            <title>{$hb}{$business_name} - {$invoice|@invoice}</title>
            {if !empty($HBaddons.header_js)}
                {foreach from=$HBaddons.header_js item=module}
                    {$module}
                {/foreach}
            {/if}
        </head>

        <body>
            {if $credit_available && $invoice.status=='Unpaid'}
                <div id="credit-applicable">
                    <div class="content">
                        <span id="inv-credit-info">{$lang.youhavecredit} <a href="#" onclick="$('#inv-credit-info').hide();$('#inv-credit-form').show();return false"><b>{$lang.youhavecredit2}</b></a></span>
                        <div id="inv-credit-form" style="display:none">
                            <form method="post" action="" >
                                <input type="hidden" name="make" value="applycredit" />
                                {$lang.amountcredittoapply} <input type="text" value="{$credit_available}" size="4" name="amount" />
                                <input type="submit" value="{$lang.applycredit}" style="padding:2px 2px;font-size:12px;font-weight:bold;" />
                                {securitytoken}</form>
                        </div>
                    </div>
                </div>
            {/if}
            <div id="backlink"><a href="{$ca_url}clientarea/">- {$lang.backtoclientarea} -</a></div>
            <div id="invoice-container" class="unpaid-container">
                {if $error}
                    <div >
                        <div class="alert alert-error">

                            {foreach from=$error item=blad}{$blad}<br/>{/foreach}
                        </div>

                    </div>{/if}
                    {if $info}
                        <div >

                            <div class="alert alert-info">
                                {if $info}
                                    {foreach from=$info item=infos}{$infos}<br/>{/foreach}
                                {/if}
                            </div>
                        </div>
                    {/if}
                    <div id="invoice-content">
                        <div id="status-ribbon" class="{$invoice.status}">{$lang[$invoice.status]}</div>

                        {literal}
                <script language="javascript" type="text/javascript">
                    function resizeIframe(obj) {
                      obj.contentWindow.document.write({/literal}{$invoicebody|@json_encode}{literal})
                      obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
                    }
              </script>
            {/literal}
            <iframe style="width: 100%" frameborder="0" scrolling="no" onload="resizeIframe(this)"></iframe>

                    </div>

                    <div class="right" id="payform-container">

                        <div id="paymenu">
                            <a href="#" onclick="window.print();" class="pelem"><i class="icon-print"></i> {$lang.print_invoice}</a>
                            <a href="{$ca_url}root&amp;action=download&amp;invoice={$invoice.id}" class="pelem"><i class="icon-download-alt"></i> {$lang.download_pdf}</a>
                            {if $cancancelinvoice}
                                <a  class="pelem" href="{$ca_url}clientarea&action=invoice&id={$invoice.id}&make=cancel&security_token={$security_token}" onclick="return confirm('{$lang.manualrenew_confirm}')"><i class="icon-remove-sign"></i> {$lang.cancelinvoice}</a>
                            {/if}
                            {if ($invoice.status == 'Unpaid' || $invoice.status == 'Receiptunpaid') && $applicable_coupons && !$invoice.discounts}
                                <a class="pelem" href="#" onclick="$(this).remove();$('.applycouponform').show();return false;"><i class="icon-tag"></i>{$lang.addcouponcode}</a>
                                <form action="" method="post" class="applycouponform" style="display:none;margin: 20px 0;">
                                    {securitytoken}
                                    <span class="pelem" style="border-bottom: none;"><i class="icon-tag"></i> {$lang.addcouponcode}</span>
                                    <input type="text" name="applycoupon" style="border:1px solid #CCCCCC;border-radius:3px;box-shadow:0 1px 3px rgba(0,0,0,0.1) inset;padding:5px;width:100%;box-sizing:border-box;height:30px;">
                                    <button type="submit" style="display:block;margin:5px auto;" class="btn btn-primary">{$lang.submit}</button>
                                </form>
                            {/if}
                            {if $invoice.status=='Unpaid'}<span class="pelem"><i class="icon-ok-sign"></i> {$lang.paymethod}</span>    {/if}
                        </div>

                        {if $invoice.status=='Unpaid'}
                            <form action="" method="post" style="margin-bottom:0px;">
                                <select name="paymethod" onchange="submit()" style="width:100%" class="paymethod">
                                    {if $invoice.payment_module == 0}<option value="0"> - </option>{/if}
                                    {foreach from=$gateways key=gatewayid item=paymethod}
                                        <option value="{$gatewayid}"{if $invoice.payment_module == $gatewayid} selected="selected"{/if} >{$paymethod}</option>
                                    {/foreach}
                                </select>
                                {securitytoken}</form>
                            <div id="gateway">
                                {$gateway}
                            </div>
                        {/if}
                    </div>

                    <div style="clear:both"></div>
                </div>
                {literal}
                    <script>
                        $(document).ready(function () {
                            $('#gateway input[type=submit]').addClass('btn').addClass('btn-success').addClass('btn-large');
                        });
                    </script>
                {/literal}
            </body>
        </html>
    {/if}