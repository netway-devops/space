{include file="$tplPath/admin/header.tpl"}

{literal}
<style type="text/css">
table.dataList td {border-bottom: 1px dotted #000000;}
</style>
{/literal}

<table cellpadding="2" cellspacing="2" border="0" class="dataList">
<thead>
<tr>
    <th width="100" align="left">#</th>
    <th width="100" align="left">Order</th>
    <th width="100" align="left">Invoice</th>
    <th align="left">Item</th>
</tr>
</thead>
{foreach from=$aDatas item="aData" key="orderId"}
<tbody>
<tr valign="top">
    <td>{$aData.id}</td>
    <td><a href="?cmd=orders&action=edit&id={$aData.id}" target="_blank">{$aData.status}</a></td>
    <td><a href="?cmd=invoices&action=edit&id={$aData.invoiceId}" target="_blank">{$aData.invoiceStatus}</a></td>
    <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
        {foreach from=$aData.item item="aItem"}
        <tr valign="top">
            <td width="50">{$aItem.type}</td>
            <td width="300">{$aItem.desc}</td>
            <td width="50">{$aItem.orderType}</td>
            <td width="50"><a href="{$aItem.url}" target="_blank">{$aItem.status}</a></td>
            {if $aData.id != $aItem.orderId}
            <td width="50"><a href="?cmd=orders&action=edit&id={$aItem.orderId}" target="_blank">{$aItem.orderId}</a></td>
            <td width="50">{$aItem.xOrderStatus}</td>
            <td width="50"><a href="?cmd=invoices&action=edit&id={$aItem.xInvocieId}" target="_blank">{$aItem.xInvocieStatus}</a></td>
            <td width="500">{$aItem.xInvocieDesc}</td>
            {/if}
        </tr>
        {/foreach}
        </table>
    </td>
</tr>
</tbody>
{/foreach}
</table>

{include file="$tplPath/admin/footer.tpl"}
