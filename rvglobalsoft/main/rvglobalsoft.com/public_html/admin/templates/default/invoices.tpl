{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'invoices.tpl.php');
{/php}

<script type="text/javascript">
    lang['invoicerecurrnow'] = {$lang.invoicerecurrnow|@json_encode};
    var RcStartDate = '{''|dateformat:$date_format}'; 
    loadelements.invoices = true;
    {if $edit_warning && $invoice.status != 'Creditnote'}
    window.EditWarning = true;
    {/if}
</script>
<script type="text/javascript" src="{$template_dir}js/invoices.js?v={$hb_version}"></script>
<link href="templates/default/css/invoices.css?v={$hb_version}" rel="stylesheet" type="text/css"/>

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.Invoices}</h3></td>
        <td  class="searchbox">
            <div id="hider2" style="text-align:right"><a href="?cmd=invoices&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
                <a href="?cmd=invoices&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
            </div>
            <div id="hider" style="display:none"></div>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            {if !$forbidAccess.addInvoices}
                {if "config:CnoteEnable:on"|checkcondition && $currentlist == 'creditnote'}
                    <a class="tstyled btn btn-success" href="?cmd=invoices&action=createcreditnote&client_id=0" >
                        <strong>{$lang.createcreditnote}</strong>
                    </a><br/>
                {else}
                    <a class="tstyled btn btn-success" href="?cmd=invoices&action=createinvoice&client_id=0" >
                        <strong>{$lang.createinvoice}</strong>
                    </a><br/>
                {/if}
            {/if}


            <a href="?cmd=invoices&list=all&showall=true"  {if $currentlist!='recurring' && $currentlist!='creditnote'}data-pjax{/if}
               class="tstyled {if $currentlist=='all' || !$currentlist}selected{/if}">{$lang.Allinvoices} {if $stats}<span>({$stats.All})</span>{/if}</a>
            <a href="?cmd=invoices&list=paid&showall=true" {if $currentlist!='recurring' && $currentlist!='creditnote'}data-pjax{/if}
               class="tstyled tsubit {if $currentlist=='paid'}selected{/if}">{$lang.Paidinvoices} {if $stats}<span>({$stats.Paid})</span>{/if}</a>
            <a href="?cmd=invoices&list=unpaid&showall=true" {if $currentlist!='recurring' && $currentlist!='creditnote'}data-pjax{/if}
               class="tstyled tsubit {if $currentlist=='unpaid'}selected{/if}">{$lang.Unpaidinvoices} {if $stats}<span>({$stats.Unpaid})</span>{/if}</a>
            <a href="?cmd=invoices&list=cancelled&showall=true" {if $currentlist!='recurring' && $currentlist!='creditnote'}data-pjax{/if}
               class="tstyled tsubit {if $currentlist=='cancelled'}selected{/if}">{$lang.Cancelledinvoices} {if $stats}<span>({$stats.Cancelled})</span>{/if}</a>
            <a href="?cmd=invoices&list=collections&showall=true" {if $currentlist!='recurring' && $currentlist!='creditnote'}data-pjax{/if}
               class="tstyled tsubit {if $currentlist=='collections'}selected{/if}">{$lang.Collections} {if $stats}<span>({$stats.Collections})</span>{/if}</a>
            <a href="?cmd=invoices&list=refunded&showall=true"  {if $currentlist!='recurring' && $currentlist!='creditnote'}data-pjax{/if}
               class="tstyled tsubit {if $currentlist=='refunded'}selected{/if}">{$lang.Refundedinvoices} {if $stats}<span>({$stats.Refunded})</span>{/if}</a>
            <a href="?cmd=invoices&list=cancelled&showall=true"  
                class="tstyled tsubit  {if $currentlist!='recurring'}tload{/if} {if $currentlist=='cancelled'}selected{/if}">{$lang.Cancelledinvoices} {if $stats}<span>({$stats.Cancelled})</span>{/if}</a>
            <a href="?cmd=invoices&list=print&showall=true"  {if $currentlist!='recurring' && $currentlist!='creditnote'}data-pjax{/if}
               class="tstyled tsubit {if $currentlist=='print'}selected{/if}">{$lang.PrintQueue} {if $stats}<span>({$stats.Print})</span>{/if}</a>

            {if "config:CnoteEnable:on"|checkcondition}
                <br/>
                <a href="?cmd=invoices&list=creditnote&showall=true"  class="tstyled   {if $currentlist=='creditnote'}selected{/if}">
                    {$lang.Creditnotes} {if $stats}<span>({$stats.Creditnote})</span>{/if}
                </a>
            {/if}
            {if "config:ReceiptEnable:on"|checkcondition}
                <br/>
                <a href="?cmd=invoices&list=receiptpaid&showall=true"  class="tstyled   {if $currentlist=='receiptpaid'}selected{/if}">
                    {$lang.Receiptspaid} {if $stats}<span>({$stats.Receiptpaid})</span>{/if}
                </a>
                <a href="?cmd=invoices&list=receiptunpaid&showall=true"  class="tstyled   {if $currentlist=='receiptunpaid'}selected{/if}">
                    {$lang.Receiptsunpaid} {if $stats}<span>({$stats.Receiptunpaid})</span>{/if}
                </a>
                <a href="?cmd=invoices&list=receiptcanceled&showall=true"  class="tstyled   {if $currentlist=='receiptcanceled'}selected{/if}">
                    {$lang.Receiptscanceled} {if $stats}<span>({$stats.Receiptcanceled})</span>{/if}
                </a>
            {/if}

            <br/>
            <a href="?cmd=invoices&list=all&listExt=invoiceNumber&timePeriod=thisMonth&showall=true"  class="tstyled {if $currentlist!='recurring'}tload{/if} {if $listExt=='invoiceNumber'}selected{/if}">ที่ออกใบกำกับภาษีเดือนนี้</a>
            <a href="?cmd=invoices&list=unpaid&listExt=invoiceNumber&timePeriod=lastMonth&showall=true"  class="tstyled tsubit  {if $currentlist!='recurring'}tload{/if} {if $listExt=='invoiceNumber' && $timePeriod=='lastMonth'}selected{/if}">เดือนที่แล้ว</a>
            <a href="?cmd=invoices&list=unpaid&listExt=invoiceNumber&timePeriod=last2Month&showall=true"  class="tstyled tsubit  {if $currentlist!='recurring'}tload{/if} {if $listExt=='invoiceNumber' && $timePeriod=='last2Month'}selected{/if}">๒ เดือนที่แล้ว</a>
            <a href="?cmd=invoices&list=unpaid&listExt=invoiceNumber&timePeriod=last3Month&showall=true"  class="tstyled tsubit  {if $currentlist!='recurring'}tload{/if} {if $listExt=='invoiceNumber' && $timePeriod=='last3Month'}selected{/if}">๓ เดือนที่แล้ว</a>

            <br/>
            <a href="?cmd=invoices&list=recurring&showall=true"  class="tstyled {if $currentlist=='recurring'}selected{/if}">{$lang.Recurringinvoices} {if $stats}<span>({$stats.Recurring})</span>{/if}</a>
            <br />


            <a href="?cmd=estimates"  class="tstyled">{$lang.Estimates}</a><br />
            <a href="?cmd=transactions"  class="tstyled">{$lang.Transactions}</a>
            <a href="?cmd=gtwlog"  class="tstyled ">{$lang.Gatewaylog}</a>
            
            
            <br />
            <br />
            
            {include file='ajax.taxnumber.tpl' view='taxnumber'}
            (run หมายเลขใบกำกับภาษี2222)
            
            
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont"> 
                {include file='ajax.invoices.tpl'}
            </div>
        </td>
    </tr>
</table>