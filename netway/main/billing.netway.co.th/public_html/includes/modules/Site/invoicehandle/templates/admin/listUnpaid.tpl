<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
<tr>
    <td ><h3>List invoice unpaid</h3></td>
    <td  class="searchbox">
        {if isset($oClient->id)}
            <h3>#{$oClient->id} {$oClient->firstname} {$oClient->lastname}</h3>
        {/if}
    </td>
</tr>
<tr>
    <td class="leftNav">
        {include file="$tplPath/admin/leftmenu.tpl"}
    </td>
    <td valign="top" class="bordered">
    <div id="bodycont"> 
    
    <table class="glike hover" width="100%" cellspacing="0" cellpadding="3" border="0">
    <thead>
    <tr>
        <th>Invoice#</th>
        <th>Due date</th>
        <th>Description</th>
        <th>Qty</th>
        <th>Total</th>
    </tr>
    </thead>
    <tbody id="updater">
    {if count($aInvoices)}
    {foreach from=$aInvoices item=aInvoice}
    {if isset($aInvoiceServices[$aInvoice.id]) && count($aInvoiceServices[$aInvoice.id])}
    {assign var="row" value=$aInvoiceServices[$aInvoice.id]}
    {foreach from=$aInvoiceServices[$aInvoice.id] key=k item=aItem name=foo}
    <tr valign="top">
        {if $smarty.foreach.foo.first}
        <td rowspan="{$row|@count}"><a href="?cmd=invoices&action=edit&id={$aInvoice.id}" target="_blank">{$aInvoice.invoiceNo}</a></td>
        <td rowspan="{$row|@count}">{$aInvoice.duedate|date_format:'%d %b %Y'}</td>
        {/if}
        <td>{$aItem.description}</td>
        <td>{$aItem.qty}</td>
        <td>{$aItem.amount|price:$aInvoice.currency_id}</td>
    </tr>
    {/foreach}
    {/if}
    {/foreach}
    {/if}
    </tbody>
    </table>
    
    </div>
    </td>
  </tr>
</table>

<script type="text/javascript">

</script>