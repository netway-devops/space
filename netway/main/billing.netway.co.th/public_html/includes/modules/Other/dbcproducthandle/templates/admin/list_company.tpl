{include file="$tplPath/admin/header.tpl"}


<div class="box-body">
<table cellspacing="0" cellpadding="3" border="0" width="100%" class="table whitetable">
<thead>
<tr>
    <th>ID#</th>
    <th>Name</th>
</tr>
</thead>
<tbody>
{foreach from=$aCompany item=arr}
<tr>
    <td><b>{$arr.id}</b></td>
    <td>{$arr.name}</td>
</tr>
{/foreach}
</tbody>
</table>
</div>

{include file="$tplPath/admin/footer.tpl"}

