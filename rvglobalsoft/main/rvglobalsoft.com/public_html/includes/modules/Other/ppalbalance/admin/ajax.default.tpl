{if $error}
    <span class="pp-error">Unable to connect to api, check configuration ({$error})</span>
{elseif $act=='getBalance'}
    <h3>Balance:</h3>
    {foreach from=$balance item=value}
        <div class="pp-amount">
            <span class="pp-amt">{$value.amt}</span> 
            <span class="pp-code">{$value.code}</span>
        </div>
    {/foreach}
    <div class="pp-right">
        <a class="pp-btn pp-refresh" href="#"> Refresh</a> 
        <a class="pp-btn pp-transactions" href="#"> Show Last Transactions</a> 
    </div>

    <div id="pptransactions"></div>
{elseif $act=='getTransactions'}

    <table class="whitetable" width="100%" border="0" cellspacing="0" cellpadding="3" style="">
        <tr style="font-weight:bold">
            <td width="15%" style="">Date</td>
            <td width="20%">Name/Email</td>
            <td width="20%">Payment Status</td>
            <td>Gross</td>
            <td>Fee</td>

            <td>Net Amount</td>
        </tr>
        {foreach from=$tranactions item=val}
            <tr>
                <td>{$val.TIMESTAMP}</td>
                <td>{if $val.EMAIL}{$val.EMAIL}{else}{$val.NAME}{/if}</td>
                <td>{$val.STATUS}</td>
                <td>{$val.AMT}{$val.CURRENCYCODE}</td>
                <td>{$val.FEEAMT}{$val.CURRENCYCODE}</td>
                <td>{$val.NETAMT}{$val.CURRENCYCODE}</td>
            </tr>
        {foreachelse}
            <tr>
                <td colspan="6">{$lang.nothing}</td>
            </tr>
        {/foreach}
    </table>
{/if}




