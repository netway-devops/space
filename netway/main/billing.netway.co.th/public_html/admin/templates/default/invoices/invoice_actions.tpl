{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/invoices/invoice_actions.tpl.php');
{/php}

<div class="blu"> 
    <div class=" menubar">
        {if $action == 'viewlog'}
            <a href="?cmd=invoices&action=edit&id={$invoice.id}"  class="tload2" id="backto">
                <strong>&laquo; {$lang.backto} {$lang.invoice}</strong>
            </a>
        {else}
            <a href="?cmd=invoices&list={$currentlist}&showall=true"  class="tload2" id="backto">
                <strong>&laquo; {$lang.backto} {$currentlist} {$lang.invoices}</strong>
            </a>
        {/if}
        {if !$invoice.readonly}
            &nbsp;
            {if $invoice.status == 'CreditnoteDraft'}
                <a class="acceptCreditNote menuitm menu-auto" id="hd2" onclick="return confirm('{$lang.accept_creditnote_confirm}')"
                   href="?cmd=invoices&action=menubutton&make=acceptcreditnote&id={$invoice.id}&security_token={$security_token}">
                    <span>{$lang.accept}</span>
                </a>
            {/if}

            {if $invoice.status!='Draft' && $invoice.status!='Recurring' && $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft'}
                <a class="setStatus menuitm menu-auto" name="markpaid" id="hd1"  >
                    <span class="morbtn">{$lang.Setstatus}</span>
                </a>
                <a class="addPayment menuitm menu-auto {if $invoice.status=='Draft'}disabled{/if}" name="markunpaid"  href="#" >
                    <span class="addsth">{$lang.addpayment}</span>
                </a>
            {/if}
            {if !$forbidAccess.deleteInvoices}
                {if $isCanDelete}
                <a class="deleteInvoice menuitm menu-auto {if $block_invoice}disabled{/if}" name="delete">
                    <span style="color:#FF0000">{$lang.Delete}</span>
                </a>
                {else}
                <a class="menuitm menu-auto">
                    <span style="color:#AAAAAA">{$lang.Delete} ไม่ได้</span>
                </a>
                {/if}
            {/if}

            <span class="menu-auto-reset">&nbsp;</span>

            {if $invoice.status!='Draft' && $invoice.status!='Recurring'}
                <a class="menuitm setStatus menu-auto" id="hd2" onclick="return false;" href="#" >
                    <span class="morbtn">{$lang.Actions}</span>
                </a>
                <a class="menuitm setStatus menu-auto" id="hd3" onclick="return false;" href="#" >
                    <span class="morbtn">{$lang.Notify}</span>
                </a>
                <a class="menuitm setStatus menu-auto" id="hd4" onclick="return false;" href="#" >
                    <span class="morbtn">{$lang.Print}</span>
                </a>
            {/if}

            {if $invoice.status=='Recurring'}
                <a class="menuitm menu-auto-reset" name="send"  href="?action=download&invoice={$invoice.id}" >
                    <span >{$lang.previewinvoice}</span>
                </a>
                {if $invoice.recurring.recstatus!='Finished'} {$lang.generatenewinvoices}
                    <a class="menuitm menu-auto {if $invoice.recurring.recstatus!='Stopped'}activated{/if} recstatus recon" href="#" >
                        <span >On</span>
                    </a>
                    <a class="menuitm menu-auto {if $invoice.recurring.recstatus=='Stopped'}activated{/if} recstatus recoff" href="#" >
                        <span >Off</span>
                    </a>
                {/if}
            {/if}


            {if $type != 'bottom'}
                <ul id="hd1_m" class="ddmenu">
                    <li class="act-status off-paid">
                        <a href="Paid">{$lang.Paid}</a>
                    </li>
                    <li  class="act-status off-unpaid ">
                        <a href="Unpaid">{$lang.Unpaid}</a>
                    </li>
                    <li  class="act-status off-cancelled ">
                        <a href="Cancelled">{$lang.Cancelled}</a>
                    </li>
                    {if $invoice.status!='Receiptpaid' && $invoice.status!='Receiptunpaid' && $invoice.status!='Receiptcanceled'}
                    <li  class="act-status off-collections ">
                        <a href="Collections">{$lang.Collections}</a>
                    </li>
                    <li  class="act-status off-refunded">
                        <a href="Refunded">{$lang.Refunded}</a>
                    </li>
                    {if "config:CNoteIssueForUnpaid"|checkcondition}
                        <li  class="act-status off-credited">
                            <a href="Credited">{$lang.Credited}</a>
                        </li>
                    {/if}
                    {/if}
                </ul>

            <ul id="hd2_m" class="ddmenu">
                    <li {if $block_invoice}class="disabled"{/if}>
                        <a href="EditDetails">{$lang.editdetails}</a>
                    </li>
                    {if $proforma && $invoice.paid_id!='' && !$invoice.bulkinvoice}
                        <li class="{if $block_invoice}disabled{else}act-status on-paid on-creditnote{/if}">
                            <a href="EditNumber">{$lang.editnumber}</a>
                        </li>
                    {/if}
                    {if $proforma && $invoice.paid_id=='' && !$invoice.bulkinvoice}
                        <li class="act-status  {if ($invoice.status!='Paid' && "config:FinalInvoiceOnPayment:on"|checkcondition) || ( $invoice.datepaid!='' &&  $invoice.datepaid!='0000-00-00 00:00:00')}disabled{/if}">
                            <a href="GenerateFinalId">Generate Final ID</a>
                        </li>
                    {/if}
                    <li>
                        <a href="?action=download&invoice={$invoice.id}"  class="directly">{$lang.downloadpdf}</a>
                    </li>

                    {if $invoice.status!='Creditnote' && $enableFeatures.xmlinvoices}
                    <li>
                        <a href="?action=download&xmlinvoice={$invoice.id}"  class="directly">{$lang.downloadxmlubf}</a>
                    </li>
                    {/if}
                    {if $invoice.status=='Creditnote' && $enableFeatures.xmlcreditnote}
                        <li>
                            <a href="?action=download&xmlcreditnote={$invoice.id}"  class="directly">{$lang.downloadxmlubf}</a>
                        </li>
                    {/if}
                    <li class="act-status on-unpaid {if $block_invoice}disabled{/if}">
                        <a href="{if $invoice.locked}UnlockInvoice{else}LockInvoice{/if}">{if $invoice.locked}Unlock{else}Lock{/if} invoice</a>
                    </li>
                    {if count($currencies)>1}
                        <li class="act-status off-paid">
                            <a href="ChangeCurrency" {if $block_invoice}class="disabled"{/if}>{$lang.ChangeCurrency}</a>
                        </li>
                    {/if}
                    {if $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft'}
                        <li class="act-status on-paid">
                            <a href="IssueRefund">{$lang.issuerefund}</a>
                        </li>
                        {if "config:CNoteIssueForUnpaid"|checkcondition}
                            <li class="act-status on-unpaid">
                                <a href="IssueCreditNote"
                                >Issue Credit Note</a>
                            </li>
                        {/if}
                    {/if}
                    <li class="act-status on-unpaid">
                        <a href="MergeInvoices">{$lang.MergeInvoices}</a>
                    </li>
                    {if "config:AllowBulkPayment:on"|checkcondition}
                        <li class="act-status on-unpaid">
                            <a href="CreateBulkPayment">{$lang.CreateBulkPayment}</a>
                        </li>
                    {/if}
                    {if $invoice.taxexempt}
                        <li>
                            <a href="?cmd=invoices&action=removetaxexempt&id={$invoice.id}&security_token={$security_token}" class="directly">Remove Tax Exempt</a>
                        </li>
                    {/if}
                    <li>
                        <a href="?cmd=invoices&action=duplicate&id={$invoice.id}&security_token={$security_token}" class="directly">{$lang.CreateSimilar}</a>
                    </li>
                    <li>
                        <a href="CreateInvoice">{$lang.createnewinvoice}</a>
                    </li>
                </ul>
                <ul id="hd3_m" class="ddmenu">
                    <li>
                        <a class="sendInvoice" name="send" href="#" >{$lang.Send}</a>
                    </li>
                    {if $invoice.status!='Creditnote' && $invoice.status!='CreditnoteDraft'}
                        <li class="act-status on-cancelled">
                            <a  href="SendCancelNotice" >Send cancel notice</a>
                        </li>
                        <li class="act-status on-unpaid">
                            <a href="SendReminder">{$lang.sendreminder}</a>
                        </li>
                        <li class="act-status on-unpaid">
                            <a href="SendOverdue">{$lang.sendoverduenotice}</a>
                        </li>
                    {/if}
                    <li>
                        <a href="SendMessage">{$lang.SendMessage}</a>
                    </li>
                </ul>
                <ul id="hd4_m" class="ddmenu">
                    <li>
                        <a href="?action=download&invoice={$invoice.id}"  class="directly">{$lang.downloadpdf}</a>
                    </li>
                    <li>
                        <a href="AddPrintQueue" {if ($invoice.flags & 4) || ($invoice.flags & 8)}style="display: none;"{/if} class="invoice_flag flag1">{$lang.AddPrintQueue}</a>
                    </li>
                    <li>
                        <a href="RemovePrintQueue" {if !($invoice.flags & 4)}style="display: none;"{/if} class="invoice_flag flag2">{$lang.RemovePrintQueue}</a>
                    </li>
                    <li>
                        <a href="MarkAsPrinted" {if ($invoice.flags & 8)}style="display: none;"{/if} class="invoice_flag flag3">{$lang.MarkAsPrintedSubmenu}</a>
                    </li>
                    <li>
                        <a href="MarkAsNotPrinted" {if !($invoice.flags & 8)}style="display: none;"{/if} class="invoice_flag flag4">{$lang.MarkAsNotPrintedSubmenu}</a>
                    </li>
                </ul>
            {/if}

            {adminwidget module="invoices" section="invoiceheader"}
        {/if}
    </div>
</div>

<script>

{literal}

if (typeof InvoiceAction === 'undefined') {
class InvoiceAction {

    constructor ()
    {
        this.id         = '{/literal}{$invoice.id}{literal}';
        this.status     = '{/literal}{$invoice.status}{literal}';

        this.isCollection   = (this.status == 'Collections') ? 1 : 0;
    }

    hideAddPayment ()
    {
        $('.addPayment').hide();
    }

    addUnpaidButton ()
    {
        $('<a onclick="invoiceAction.setStatusUnpaid()" class="menuitm menu-auto"><span style="color:#000000">Set status to Unpaid</span></a>').insertBefore('.addPayment');
    }

    setStatusUnpaid ()
    {
        $('.menubar').addLoader();
        $.post('?cmd=invoices&action=changething&make=setstatus', {
            id  : invoiceAction.id,
            status   : 'Unpaid',
        }, function (data) {
            parse_response_json(data);
            $('#preloader').remove();
            document.location = '?cmd=invoices&action=edit&id='+ invoiceAction.id;
        });
    }

}
var invoiceAction     = new InvoiceAction ();
}

$(document).ready( function () {

    if (typeof invoiceAction == 'object') {
        if (invoiceAction.isCollection) {
            invoiceAction.hideAddPayment();
            invoiceAction.addUnpaidButton();
        }
    }

});

{/literal}

</script>