
<a href="?cmd=transactionhandle&action=listRelateInvoice">ดูว่า transaction นี้จ่ายให้ invoice ใหน</a> <br />

<table>
<tr>

<td>
<h2>ดูว่า transaction นี้จ่ายให้ invoice ใหน</h2>
<form action="?cmd=transactionhandle&action=listRelateInvoice" method="POST">
<label>
Transaction list 1 transaction id ต่อ 1 บรรทัด:<br />
<textarea name="transaction" cols="50"  rows="10">{$transaction}</textarea><br />
<input type="submit" name="submit" value="ค้นหาว่า transaction นี้จ่ายให้ invocie ใหน" />
</label>
</form>
</td>

<td>
<h2>ดูความเกี่ยวข้องของ Transaction</h2>
<form action="?cmd=transactionhandle&action=listRelateData" method="POST">
<label>
Transaction list 1 transaction id ต่อ 1 บรรทัด:<br />
<textarea name="transaction" cols="50"  rows="10">{$transaction}</textarea><br />
<input type="submit" name="submit" value="ค้นหาว่า transaction นี้ผ่านอะไรบ้าง" />
</label>
</form>
</td>

<td>
<h2>ดูความเกี่ยวข้องของ Transaction แบบลำดับเหตุการณ์</h2>
<form action="?cmd=transactionhandle&action=listActivityData" method="POST">
<label>
Transaction list 1 transaction id ต่อ 1 บรรทัด:<br />
<textarea name="transaction" cols="50"  rows="10">{$transaction}</textarea><br />
<input type="submit" name="submit" value="ค้นหาว่า transaction นี้ผ่านอะไรบ้าง" />
</label>
</form>
</td>

</tr>
</table>

{if count($aDatas)}
<table border="1" cellpadding="5">
<tr>
<td>transactionid</td>
<td>invoiceid</td>
<td>desc</td>
<td>total</td>
</tr>
{foreach from=$aDatas item=aData key=tid}
<tr>
<td><a href="?cmd=transactions&action=edit&id={$tid}" target="_blank">{$aData.transId}</a></td>
<td><a href="?cmd=invoices&action=edit&id={$aData.id}" target="_blank">{$aData.id}</a></td>
<td>{$aData.description}</td>
<td>{$aData.grandtotal}</td>
</tr>
{/foreach}
</table>
{/if}

{if count($aRelateDatas)}
{foreach from=$aRelateDatas item=aData key=transId}
<h3>Transaction ID: {$transId}</h3>
{foreach from=$aData item=aTransaction}

    {assign var="aReference" value=$aTransaction.aReference}


    <table border="1" cellpadding="5" class="table glike hover table-fixed">
    <tr>
    <td>transaction_id</td>
    <td>payer</td>
    <td>transaction_subject</td>
    <td>paypal_reference_id</td>
    <td>transaction_event_code</td>
    <td>transaction_initiation_date</td>
    <td>transaction_amount</td>
    <td>paypal_account</td>
    </tr>
    <tr>
    <td><a href="?cmd=transactions&action=edit&id={$aReference.tid}" target="_blank">{$aReference.transaction_id}</a></td>
    <td><a href="?cmd=clients&action=show&id={$aReference.client_id}" target="_blank">{$aReference.email}</a></td>
    <td>{$aReference.transaction_subject}</td>
    <td>{$aReference.paypal_reference_id}</td>
    <td>{$aEventCode[$aReference.transaction_event_code]}</td>
    <td>{$aReference.transaction_initiation_date}</td>
    <td>{$aReference.transaction_amount}</td>
    <td>{$aReference.paypal_account}</td>
    </tr>
    </table>

    <table border="1" cellpadding="5" class="table table-fixed">
    <tr>
    <td>date</td>
    <td>in</td>
    <td>out</td>
    <td>description</td>
    <td>transaction_id</td>
    <td>invoice_id</td>
    </tr>
    <tr>
    <td colspan="6">client credit log ในเวลาใกล้เคียง ({$aTransaction.creditRangeDate})</td>
    </tr>
    {foreach from=$aTransaction.aClientCredits item=aClientCredit}
    <tr>
    <td>{$aClientCredit.date}</td>
    <td>{$aClientCredit.in}</td>
    <td>{$aClientCredit.out}</td>
    <td>{$aClientCredit.description}</td>
    <td>{$aClientCredit.transaction_id}</td>
    <td><a href="?cmd=invoices&action=edit&id={$aClientCredit.invoice_id}" target="_blank">{$aClientCredit.invoice_id}</a></td>
    </tr>
    {/foreach}
    <tr>
    <td colspan="6">credit log อื่นๆ ในเวลาใกล้เคียง ({$aTransaction.creditRangeDate})</td>
    </tr>
    {foreach from=$aTransaction.aCredits item=aCredit}
    <tr>
    <td>{$aCredit.date}</td>
    <td>{$aCredit.in}</td>
    <td>{$aCredit.out}</td>
    <td>{$aCredit.description}</td>
    <td>{$aCredit.transaction_id}</td>
    <td><a href="?cmd=invoices&action=edit&id={$aCredit.invoice_id}" target="_blank">{$aCredit.invoice_id}</a></td>
    </tr>
    {/foreach}
    </table>


    <table border="1" cellpadding="5" class="table table-fixed">
    <tr>
    <td>date</td>
    <td>invoice_id</td>
    <td>description</td>
    <td>subtotal</td>
    </tr>
    <tr>
    <td colspan="4">client invoice ที่เกี่ยวข้อง ({$aTransaction.invoiceRangeDate})</td>
    </tr>
    {foreach from=$aTransaction.aClientInvoices item=aClientInvoice}
    {foreach from=$aClientInvoice item=aInvoice}
    <tr>
    <td>{$aInvoice.date}</td>
    <td><a href="?cmd=invoices&action=edit&id={$aInvoice.invoice_id}" target="_blank">{$aInvoice.invoice_id}</a></td>
    <td>{$aInvoice.description}</td>
    <td>{$aInvoice.subtotal}</td>
    </tr>
    {/foreach}
    {/foreach}
    </table>


<br />
<br />
{/foreach}

<br />
{/foreach}
{/if}




{if count($aActivityDatas)}
{foreach from=$aActivityDatas item=aData key=transId}
<h3>Transaction ID: {$transId}</h3>
{foreach from=$aData item=aTransaction}

    {assign var="aReference" value=$aTransaction.aReference}
    {assign var="aActivity" value=$aTransaction.aActivity}


    <table border="1" cellpadding="5" class="table glike hover table-fixed">
    <tr>
    <td>transaction_id</td>
    <td>payer</td>
    <td>transaction_subject</td>
    <td>paypal_reference_id</td>
    <td>transaction_event_code</td>
    <td>transaction_initiation_date</td>
    <td>transaction_amount</td>
    <td>paypal_account</td>
    </tr>
    <tr>
    <td><a href="?cmd=transactions&action=edit&id={$aReference.tid}" target="_blank">{$aReference.transaction_id}</a></td>
    <td><a href="?cmd=clients&action=show&id={$aReference.client_id}" target="_blank">{$aReference.email}</a></td>
    <td>{$aReference.transaction_subject}</td>
    <td>{$aReference.paypal_reference_id}</td>
    <td>{$aEventCode[$aReference.transaction_event_code]}</td>
    <td>{$aReference.transaction_initiation_date}</td>
    <td>{$aReference.transaction_amount}</td>
    <td>{$aReference.paypal_account}</td>
    </tr>

    <tr>
    <td colspan="8">Activity</td>
    </tr>
    <tr>
    <td>Type</td>
    <td>ID</td>
    <td>Date</td>
    <td>Description</td>
    <td>Total</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    </tr>
    {foreach from=$aActivity item=aData}
    <tr>
    <td>{if $aData.grandtotal} Invoice {else} Credit log {/if}</td>
    <td>
        {if $aData.grandtotal} 
        <a href="?cmd=invoices&action=edit&id={$aData.invoice_id}" target="_blank">{$aData.invoice_id}</a>
        {else}
        <a href="?cmd=clientcredit&filter[client_id]={$aData.client_id}" target="_blank">{$aData.client_id}</a>
        {/if}
    </td>
    <td>{$aData.date}</td>
    <td>{$aData.description}</td>
    <td>{if $aData.grandtotal} {$aData.grandtotal} {else} {$aData.in} / {$aData.out} {/if}</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    </tr>
    {/foreach}
    </table>



<br />
<br />
{/foreach}

<br />
{/foreach}
{/if}
