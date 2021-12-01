<p>
Total commission for {$date}: <b><font color="green">{$totalCommission|price}</font></b>
<table cellspacing="0" cellpadding="0" border="0" width="30%" class="display" style="margin-bottom:15px">
    <tr>
        <th>Total commission for VIP</th>
        <td class="acenter">{$aSummery.vip|price}</td>
    <tr>
    <tr>
        <th>Total commission for SSL</th>
        <td class="acenter">{$aSummery.ssl|price}</td>
    <tr>
</table>
</p>
{assign var="aSSLReports" value=$aReports[1]}
{assign var="aVIPReports" value=$aReports[2]}



<ul class="tabs_product">
<li><a href="javascript:showTable('1');">VIP</a></li>
<li><a href="javascript:showTable('2');">SSL</a></li>
</ul>

<div id="vip-report">
<table cellspacing="0" cellpadding="0" border="1" width="100%" class="display" style="margin-bottom:15px">
    <thead>
        <tr>
            <th colspan="6">Resorts for VIP</th>
        </tr>
        <tr>
            <th>Reseller</th>
            <th>Server</th>
            <th>Active Costommers</th>
            <th>Resold VIP accounts</th>
            <th>Total</th>
            <th>Payment status</th>
    </tr>
    </thead>
    <tbody>
        {if count($aVIPReports)}
        {foreach from="$aVIPReports" key="resellername" item="aData"}
            {assign var="aHistoryData" value=$aData.history}
            {foreach from="$aHistoryData" key="key" item="aHistoryRow"}
            <tr>
                <td style="padding-left:5px;">{if $key==0} {$resellername}{/if}</td>
                <td style="padding-left:5px;">{$aHistoryRow.servername}</td>
                <td class="acenter">{$aHistoryRow.active_customers}</td>
                <td class="acenter">{$aHistoryRow.resold_acct}</td>
                <td class="acenter">{$aHistoryRow.total_history|price}</td>
                <td class="acenter">{$aHistoryRow.payment_status}</td>
            </tr>
            {/foreach}
            <tr>
                <td colspan="4"></td>
                <td colspan="2" class="acenter">Total Commission <b>{$aData.commission|price}</b></td>
            </tr>
        {/foreach}
        {else}
            <tr>
                <td colspan="6"><b>No record.</b></td>
            </tr>
        {/if}
    </tbody>
</table>
</div>

<div id="ssl-report">

<table cellspacing="0" cellpadding="0" border="1" width="100%" class="display" style="margin-bottom:15px">
    <thead>
        <tr>
            <th colspan="5">Resorts for SSL</th>
        </tr>
        <tr>
            <th>Reseller</th>
            <th>Server</th>
            <th>Resold SSL Order</th>
            <th>Total</th>
            <th>Payment status</th>
    </tr>
    </thead>
    <tbody>
        {if count($aSSLReports)}
        {foreach from="$aSSLReports" key="resellername" item="aData"}
            {assign var="aHistoryData" value=$aData.history}
            {foreach from="$aHistoryData" key="key" item="aHistoryRow"}
            <tr>
                <td style="padding-left:5px;">{if $key==0} {$resellername}{/if}</td>
                <td style="padding-left:5px;">{$aHistoryRow.servername}</td>
                <td class="acenter">{$aHistoryRow.resold_acct}</td>
                <td class="acenter">{$aHistoryRow.total_history|price}</td>
                <td class="acenter">{$aHistoryRow.payment_status}</td>
            </tr>
            {/foreach}
            <tr>
                <td colspan="3"></td>
                <td colspan="2" class="acenter">Total Commission <b>{$aData.commission|price}</b></td>
            </tr>
        {/foreach}
        {else}
            <tr>
                <td colspan="5"><b>No record.</b></td>
            </tr>
        {/if}
    </tbody>
</table>
</div>

<script type="text/javascript">
{literal}
function showTable(id)
{
    if (id == '1') {
        $('#ssl-report').hide();
        $('#vip-report').show();
    } else {
        $('#vip-report').hide();
        $('#ssl-report').show();
    }
}
showTable('1');
{/literal}
</script>
