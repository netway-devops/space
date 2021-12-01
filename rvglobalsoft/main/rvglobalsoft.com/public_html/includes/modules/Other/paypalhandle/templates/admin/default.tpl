
<table class="table">
<tr>
    <td>Account</td>
    <td>Access token</td>
</tr>
{foreach from=$aAccessToken item=aToken}
<tr>
    <td>{$aToken.account}</td>
    <td>{$aToken.token}</td>
</tr>
{/foreach}
</table>

{literal}
<script>
$(document).ready( function () {
    //setInterval(function () {
    //    $.get('?cmd=configuration&action=executetask&task=custom:117:call_Hourly&debug=0');
    //}, 30000);
});
</script>
{/literal}