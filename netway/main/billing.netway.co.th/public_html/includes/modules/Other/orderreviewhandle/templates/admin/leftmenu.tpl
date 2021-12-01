<a class="tstyled {if $action == '' || $action == 'default'}selected{/if}" href="?cmd=module&module=orderreviewhandle">Home</a>
<table border="0" cellpadding="2" cellspacing="2">
<tr>
    <td>Total</td>
    <td>Order</td>
    <td>Invoice</td>
    <td>Account</td>
</tr>
{foreach from=$aStatus item="arr"}
<tr {if $arr.status|in_array:$aError} bgcolor="#FFC9C9" {/if}>
    <td><a href="?cmd=module&module=orderreviewhandle&ostatus={$arr.ostatus}&istatus={$arr.istatus}&astatus={$arr.astatus}">{$arr.total}</a></td>
    <td>{$arr.ostatus}</td>
    <td>{$arr.istatus}</td>
    <td>{$arr.astatus}</td>
</tr>
{/foreach}
</table>