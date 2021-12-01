{literal}
    <style type="text/css">
        .blank_state{
            background: url('{/literal}{$system_url}{literal}includes/modules/Other/manualccprocessing/admin/blank.png') no-repeat white;
            padding: 50px 0;
        }
    </style>
{/literal}

<h3>Paypal Subscription Log</h3>

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
<tr>
    <td>
        Manual Verification
    </td>
    <td class="searchbox">
        ส่วนแสดงผลข้อมูลเกี่ยวกับ paypal subscription เพื่อให้เลือก apply credit ให้ถูกกับ invoice
        <div style="display: block; float: right;">
            
        </div>
    </td>
</tr>
<tr>
    <td class="leftNav">
        {if $aTranLog.is_manual_verify}
        <b>ตรวจสอบแล้ว</b>
        {else}
        <a href="?cmd=paypalsubscriptionlog&action=verify&transactionId={$transactionId}" onclick="return confirm('ยืนยัน ว่าได้ apply credit ให้กับ invoice ที่ต้องการแล้ว และจบ transaction #{$transactionId} ?');" class="btn btn-success">ได้ Apply Credit แล้ว</a>
        {/if}
    </td>
    <td valign="top" class="bordered">
    <div id="bodycont"> 

    <table class="table whitetable">
    <tr>
        <td>Date</td>
        <td>
            {$aTran.date}
        </td>
        <td>Transaction #</td>
        <td>
            {$transactionId}<br />
            <a href="?cmd=transactions&action=edit&id={$aTran.id}" target="_blank">ดูรายละเอียด</a>
        </td>
        <td>Invoice #</td>
        <td>
            {$aTran.invoice_id}<br />
            <a href="?cmd=invoices&action=edit&id={$aTran.invoice_id}" target="_blank">ดูรายละเอียด</a>
        </td>
    </tr>
    </table>
    
    <div>&nbsp;</div>
    <div>&nbsp;</div>
    
    <table class="table whitetable">
    <caption>Invoice #<a href="?cmd=invoices&action=edit&id={$aInvoice.id}" target="_blank">{$aInvoice.id}</a></caption>
    <tr>
        <td>Date</td>
        <td>{$aInvoice.date}</td>
        <td>Status</td>
        <td>{$aInvoice.status}</td>
        <td>Due</td>
        <td>{$aInvoice.duedate}</td>
        <td>Total</td>
        <td>{$aInvoice.total}</td>
    </tr>
    </table>
    
    <table class="table whitetable">
    <caption>Invoice Items</caption>
    <tr>
        <td>Account#</td>
        <td>Description</td>
        <td>Amount</td>
    </tr>
    {foreach from=$aItems item=aItem}
    <tr>
        <td>
            {if $aItem.type == 'Hosting'}
            <a href="?cmd=accounts&action=edit&id={$aItem.item_id}" target="_blank">{$aItem.item_id}</a>
            {else}
            {$aItem.type}
            {/if}
        </td>
        <td>{$aItem.description}</td>
        <td>{$aItem.amount}</td>
    </tr>
    {/foreach}
    </table>
    
    <table class="table whitetable">
    <caption>Invoice Transaction</caption>
    <tr>
        <td>Date</td>
        <td>Trasaction</td>
        <td>Description</td>
        <td>Amount</td>
    </tr>
    {foreach from=$aTransactions item=aTransaction}
    <tr>
        <td>{$aTransaction.date}</td>
        <td><a href="?cmd=transactions&action=edit&id={$aTran.id}" target="_blank">{$aTransaction.trans_id}</a></td>
        <td>{$aTransaction.description}</td>
        <td>{$aTransaction.in}</td>
    </tr>
    {/foreach}
    </table>
    
    <div style="background-color: #EFEFEF; padding: 10px; border: 1px solid #CCCCCC;">
    
    <table class="table whitetable">
    <caption>Invoice #<a href="?cmd=invoices&action=edit&id={$aInvoice2.id}" target="_blank">{$aInvoice2.id}</a> ตั้งต้นของ {$transactionId}</caption>
    <tr>
        <td>Date</td>
        <td>{$aInvoice2.date}</td>
        <td>Status</td>
        <td>{$aInvoice2.status}</td>
        <td>Due</td>
        <td>{$aInvoice2.duedate}</td>
        <td>Total</td>
        <td>{$aInvoice2.total}</td>
    </tr>
    </table>
    
    <table class="table whitetable">
    <caption>Invoice Items</caption>
    <tr>
        <td>Account#</td>
        <td>Description</td>
        <td>Amount</td>
    </tr>
    {foreach from=$aItems2 item=aItem}
    <tr>
        <td>
            {if $aItem.type == 'Hosting'}
            <a href="?cmd=accounts&action=edit&id={$aItem.item_id}" target="_blank">{$aItem.item_id}</a>
            {else}
            {$aItem.type}
            {/if}
        </td>
        <td>{$aItem.description}</td>
        <td>{$aItem.amount}</td>
    </tr>
    {/foreach}
    </table>
    
    <table class="table whitetable">
    <caption>Invoice Transaction</caption>
    <tr>
        <td>Date</td>
        <td>Trasaction</td>
        <td>Description</td>
        <td>Amount</td>
    </tr>
    {foreach from=$aTransactions2 item=aTransaction}
    <tr>
        <td>{$aTransaction.date}</td>
        <td><a href="?cmd=transactions&action=edit&id={$aTran.id}" target="_blank">{$aTransaction.trans_id}</a></td>
        <td>{$aTransaction.description}</td>
        <td>{$aTransaction.in}</td>
    </tr>
    {/foreach}
    </table>
    
    </div>
    
    <div>&nbsp;</div>
    <div>&nbsp;</div>
    
    
    <table class="table whitetable">
    <caption>Credit (ถูกเพิ่มเข้า credit) <a href="index.php?cmd=clientcredit&filter[client_id]={$aInvoice.client_id}" target="_blank">ดู credit log</a></caption>
    {if $aCredit.id}
    <tr>
        <td>Date</td>
        <td>{$aCredit.date}</td>
        <td>TransID</td>
        <td>{$aCredit.transaction_id}</td>
        <td>Client</td>
        <td><a href="?cmd=clients&action=show&id={$aCredit.client_id}" target="_blank">{$aCredit.firstname} {$aCredit.lastname}</a></td>
        <td>Add</td>
        <td>{$aCredit.in}</td>
        <td>Balance (ขณะนั้น)</td>
        <td>{$aCredit.balance}</td>
        <td>Description</td>
        <td>{$aCredit.description}</td>
    </tr>
    {else}
    <caption class="imp_msg">ไม่พบว่ามีการนำเข้า credit โดยอ้างอิงจาก transaction {$transactionId} </caption>
    {if $aCredit2.id}
    <caption class="imp_msg">Credit log จาก Invoice#{$aInvoice.id}</caption>
    <tr>
        <td>Date</td>
        <td>{$aCredit2.date}</td>
        <td>TransID</td>
        <td>{$aCredit2.transaction_id}</td>
        <td>Client</td>
        <td><a href="?cmd=clients&action=show&id={$aCredit2.client_id}" target="_blank">{$aCredit2.firstname} {$aCredit2.lastname}</a></td>
        <td>Add</td>
        <td>{$aCredit2.in}</td>
        <td>Balance (ขณะนั้น)</td>
        <td>{$aCredit2.balance}</td>
        <td>Description</td>
        <td>{$aCredit2.description}</td>
    </tr>
    {/if}
    {/if}
    </table>
    
    <div>&nbsp;</div>
    
    <table class="table whitetable">
    <caption>Account</caption>
    <tr>
        <td>#</td>
        <td>Name</td>
        <td>Product</td>
        <td>Status</td>
        <td>Next due</td>
        <td>Next invoice</td>
    </tr>
    {foreach from=$aAccounts item=aAccount}
    {assign var="accId" value=$aAccount.id}
    <tr>
        <td><a href="?cmd=accounts&action=edit&id={$aAccount.id}" target="_blank">{$aAccount.id}</a></td>
        <td>{$aAccount.domainname}</td>
        <td>{$aAccount.name}</td>
        <td>{$aAccount.status}</td>
        <td>{$aAccount.next_due}</td>
        <td>{$aAccount.next_invoice}</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="5">
            
            <table class="table whitetable">
            {foreach from=$aAccountInvs[$accId] key=invId item=aInv}
            <tr>
                <th>Invoice#<a href="?cmd=invoices&action=edit&id={$invId}" target="_blank">{$invId}</a></th>
                <th>{$aInv.aInv.status}</th>
                <th>{$aInv.aInv.date}</th>
            </tr>
            {foreach from=$aInv.aInvItems item=aInvItem}
            <tr>
                <td colspan="2">{$aInvItem.description}</td>
                <td>{$aInvItem.amount}</td>
            </tr>
            {/foreach}
            {/foreach}
            </table>
            
        </td>
    </tr>
    {/foreach}
    </table>
    
    

    </div>
    </td>
  </tr>
</table>