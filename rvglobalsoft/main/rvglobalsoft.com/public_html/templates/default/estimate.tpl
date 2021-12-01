{if $estimate}
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <script type="text/javascript" src="{$template_dir}js/jquery.js"></script>
            <base href="{$system_url}" />
            <title>{$hb}{$business_name} - {$lang.customerquote}</title>
            {if !empty($HBaddons.header_js)}
                {foreach from=$HBaddons.header_js item=module}
                    {$module}
                {/foreach}
            {/if}
            {literal}
                <style type="text/css" media="all">

                    body {
                        background: #f6f6f6;
                        font-family:Arial,Tahoma,sans-serif;
                        font-size:12px;
                        color:#484740;
                        margin:0px;
                        padding:0px;

                    }
                    #backlink {
                        text-align: center;
                        margin: 10px;
                        padding: 0;
                    }
                    #backlink a, a:active, a:visited {
                        color: #a4a4a4;
                        text-decoration: none;
                    }
                    #backlink  a:hover {
                        color: #a4a4a4;
                        text-decoration: underline;
                    }
                    #invoice-container {
                        width:759px;
                        margin:20px auto;
                    }
                    #payform-container {
                        padding:10px;
                        margin:40px 0px;
                        width:164px;
                        background:#ECEFF1;
                        border: 1px solid #BEC9D0;
                        border-radius: 5px ;
                        box-shadow: 1px 1px 0 0 rgba(255, 255, 255, 0.65) inset;
                    }
                    #payform-container .paynow {
                        text-shadow:0 1px 0 #FFFFFF;
                        color:#333333;
                        font-weight:bold;
                        background:url({/literal}{$template_dir}{literal}img/money--plus.png) no-repeat left center;
                        margin-bottom:5px;
                        padding:3px 0px 3px 20px;
                    }
                    #payform-container select {
                        width:140px;
                    }
                    .unpaid-container {
                        width:959px !important;
                    }
                    #invoice-content {
                        width:749px;
                        padding:5px;
                        float:left;
                        background:url({/literal}{$template_dir}{literal}images/invoice_rep.gif) repeat-y top left;
                        position:relative;

                    }
                    #invoice-top {
                        width:759px;
                        position:absolute;
                        top:0px;
                        left:0px;
                        height:10px;
                        background:url({/literal}{$template_dir}{literal}images/invoice_top.gif) no-repeat top left;
                    }
                    #invoice-bottom {
                        width:759px;
                        position:absolute;
                        bottom:0px;
                        left:0px;
                        height:10px;
                        background:url({/literal}{$template_dir}{literal}images/invoice_bottom.gif) no-repeat top left;
                    }

                    .left {
                        float:left;
                    }
                    .right {
                        float:right;
                    }
                    #invoice-status strong {
                        color:#a4a4a4;
                    }
                    #invoice-body {
                        font-size:11px;

                        width:709px;
                        padding:130px 20px 40px;
                    }
                    strong.larger {
                        font-size:12px;
                    }
                    strong.status {

                        text-transform:uppercase;
                    }
                    strong.Paid {
                        color:#a6ca04;
                    }
                    strong.Unpaid {
                        color:#891539;
                    }
                    strong.Cancelled {
                        color:#b7b7b7;
                    }
                    #invoce-transactions {
                        margin-top:30px;
                        margin-bottom:20px;
                    }
                    .invoice-table{
                        margin-top:20px;
                        margin-bottom:20px;
                        font-size:11px;
                    }
                    .invoice-table th, .invoice-table-transaction th {
                        background:#f0f0f0;
                        font-weight:bold;
                        padding:0px;
                        margin:0px;
                        border-top:1px solid #eeeeee;
                        border:none;
                    }

                    .invoice-table .aright, .invoice-table-transaction .aright {
                        text-align:right;
                    }
                    .invoice-table .acenter, .invoice-table-transaction .acenter {
                        text-align:center;
                    }

                    .invoice-table td.noborder {
                        border:none !important;
                    }

                    .invoice-table-transaction td, .invoice-table-transaction th{
                        padding:3px 12px;
                    }
                    .invoice-table-transaction .summary {
                        font-size:12px;
                        border:none !important;
                    }
                    .invoice-table-transaction td {
                        border-bottom:solid 1px #f0f0f0;
                    }
                    .invoice-table .summary {
                        font-size:12px;
                        padding:5px 12px;
                        border:none !important;
                    }
                    .invoice-table .summary .bigger {
                        font-size:14px;
                    }
                    #invoice-icons {
                        position:absolute;
                        top:-11px;
                        right:0px;
                        width:75px;
                    }
                    #invoice-icons img {
                        border:none;
                        float:left;
                        margin-right:6px;
                    }
                    .tbs {
                        font-size:11px;
                    }
                    #gateway {
                        margin: 10px;
                    }
                    #invoice-footer {
                        border-top: 1px solid #F0F0F0;
                        text-align: center;
                        margin: 20px auto 0 auto;
                        color:#A4A4A4;
                        padding: 10px 20px;
                    }
                    #credit-applicable {
                        background:#D9FFB2;
                        padding:20px 0px;
                        color:#4C8700;
                    }
                    #credit-applicable .content {
                        width:749px;
                        margin:0px auto;
                    }
                    #credit-applicable input[type="text"], select.paymethod {
                        border: 1px solid #CCCCCC;
                        border-radius: 3px 3px 3px 3px;
                        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) inset;
                        font: 13px/16px Arial,sans-serif !important;
                        padding: 4px 6px;
                    }
                    #credit-applicable a {
                        color: #097BFB;
                        text-decoration: underline;}

                </style>
                <style type="text/css" media="print">
                    #credit-applicable  {
                        display:none;
                    }
                    #backlink {
                        display: none;
                    }
                    #invoice-top {
                        display:none;
                    }
                    #invoice-bottom {
                        display:none;
                    }
                    #invoice-container {
                        width:650px !important;
                    }
                    #invoice-content {
                        background:none;
                        width:650px !important;
                    }
                    body {
                        background:#ffffff;
                        margin:0px;
                    }
                    #invoice-body {

                        padding-left:0px;
                        padding-right:0px;
                        width:650px !important;
                    }
                    #invoice-status {
                        background-image:url({/literal}{$template_dir}images/invoice_{$estimate.status}_{$language}{literal}.gif);
                    }
                    #gateway {
                        display:none;
                    }
                    #invoice-icons, #payform-container {
                        display:none;
                    }
                </style>

                <!--[if IE]>
                
                <style type="text/css">
                #invoice-bottom {
                                bottom:-5px;
                        }
                        #invoice-status {
                        height:150px;
                        }
                        #invoice-content {
                        width:759px;
                        }
                </style>
                <![endif]-->
            {/literal}


        </head>

        <body>
            <div id="backlink"><a href="{$ca_url}clientarea/">- {$lang.backtoclientarea} -</a></div>
            <div class="right" id="payform-container" style="margin-right: 50px;">
                <div id="paymenu">
                    {if $order_id}
                        <a href="{$ca_url}&amp;action=accept&amp;estimate={$estimate.hash}" class="pelem" onclick="return confirm('{$lang.accept_estimate_q}');"><i class="icon-order"></i> {$lang.accept_estimate}</a>
                    {/if}
                </div>
            </div>
            <div id="invoice-container">
                <div id="invoice-content">

                    <div id="invoice-top"></div>

                    <div id="invoice-bottom"></div>
                    <div id="invoice-icons">
                        <a href="#" onclick="window.print();"><img src="{$template_dir}images/invoice_print.gif" /></a>
                        <a href="{$ca_url}&amp;action=download&amp;estimate={$estimate.hash}" onclick=""><img src="{$template_dir}images/invoice_pdf.gif" /></a>
                    </div>


                    <div>

                        {$estiamatebody}

                    </div>
                </div>
                <div style="clear:both"></div>
            </div>
            </div>

            </div>
        </body>
    </html>
{/if}