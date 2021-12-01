{include file="$tplPath/admin/header.tpl"}

<table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
<thead>
    <tr>
        <th width="10%">Order#</th>
        <th width="10%">Authorize Date</th>
        <th width="10%">Amount</th>
        <th width="10%">Payment</th>
        <th width="10%">Authorize by</th>
    </tr>
</thead>
<tbody id="updater">
    {foreach from=$aDatas item="aData"}
    <tr>
        <td><a href="?cmd=orders&action=edit&id={$aData.id}" target="_blank">{$aData.id}</a></td>
        <td>{$aData.date_changed|dateformat:$date_format}</td>
        <td>{$aData.amount|price:$currency}</td>
        <td>{$aData.payment}</td>
        <td>{$aData.username}</td>
    </tr>
    {/foreach}
</tbody>
</table>

{include file="$tplPath/admin/footer.tpl"}
