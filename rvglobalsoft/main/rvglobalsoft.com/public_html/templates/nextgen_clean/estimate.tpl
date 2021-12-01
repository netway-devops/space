{if $estimate}
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <script type="text/javascript" src="{$template_dir}js/jquery.js"></script>
            <base href="{$system_url}" />

            <link media="screen" type="text/css" rel="stylesheet" href="{$template_dir}css/bootstrap.css" />
            <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/invoice.css" />
            <link media="print" type="text/css" rel="stylesheet" href="{$template_dir}css/invoice_print.css" />

            <title>{$hb}{$business_name} - {$lang.customerquote}</title>
            {if !empty($HBaddons.header_js)}
                {foreach from=$HBaddons.header_js item=module}
                    {$module}
                {/foreach}
            {/if}
        </head>

        <body>

            <div id="backlink"><a href="{$ca_url}clientarea/">- {$lang.backtoclientarea} -</a></div>
            <div id="invoice-container" class="unpaid-container">
                {if $error}
                    <div >
                        <div class="alert alert-error">

                            {foreach from=$error item=blad}{$blad}<br/>
                            {/foreach}
                        </div>

                    </div>
                {/if}
                {if $info}
                    <div >
                        <div class="alert alert-info">
                            {if $info}
                                {foreach from=$info item=infos}{$infos}<br/>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                {/if}
                <div id="invoice-content">
                    <div id="status-ribbon" class="{$estimate.status}">{$lang[$estimate.status]}</div>

                    <div>
                        {$estiamatebody}
                    </div>
                </div>
                <div class="right" id="payform-container">
                    <div id="paymenu">
                        <a href="#" onclick="window.print();" class="pelem"><i class="icon-print"></i> {$lang.print_invoice}</a>
                        <a href="{$ca_url}&amp;action=download&amp;estimate={$estimate.hash}" class="pelem"><i class="icon-download-alt"></i> {$lang.download_pdf}</a>
                        {if $order_id}
                            <a href="{$ca_url}&amp;action=accept&amp;estimate={$estimate.hash}" class="pelem" onclick="return confirm('{$lang.accept_estimate_q}');"><i class="icon-order"></i> {$lang.accept_estimate}</a>
                        {/if}
                    </div>
                </div>
                <div style="clear:both"></div>


            </div>
        </body>
    </html>
{/if}

