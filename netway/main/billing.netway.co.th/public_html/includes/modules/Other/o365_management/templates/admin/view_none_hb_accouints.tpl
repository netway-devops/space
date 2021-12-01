{include file="$tplPath/admin/header.tpl"}
{assign var=keyPurchaseUnit value="Purchase Unit"}
{assign var=keyListPrice value="List Price"}
{assign var=keyERPPrice value="ERP Price"}
{if $timestampLastUpdateData}
<div class="gbox1" style="padding: 0px 15px 0px 15px;">
    <p><b>ข้อมูลจาก MSP เมื่อวันที่ {$timestampLastUpdateData|date_format:'%d %b %Y'}</b></p>
</div>
{/if}

<table cellpadding="2" cellspacing="2" width="100%">
<tr>
    <th><h1>ข้อมูล Subscription ที่ไม่สามารถเชื่อมโยงกับ Hostbill account (Total: {$totalAccounts} Subscriptions)</h1></th>
</tr>
<tr>
    <th>
    <div class="imp_msg">
        <ul>
            <li>เอา Microsoft ID ที่ได้จาก Microsoft Partner Center มาเปรียบเทียบกับข้อมูลใน Hostbill account custom filed "Microsoft ID"</li>
            <li>เอา Domain name ที่ได้จาก Microsoft Partner Center มาเปรียบเทียบกับข้อมูล "Hostname" ใน Hostbill account.</li>
            <li>เอา Domain name ที่ได้จาก Microsoft Partner Center มาเปรียบเทียบกับข้อมูล Hostbill account custom filed "Domain name"</li>
        </ul>
    </div>
    </th>
</tr>
<tr>
    <td>
        <table cellpadding="2" cellspacing="2" border="1" width="100%">
        <tr style="text-align:center;">
            <th width="15%" style="text-align:center;">Subscription ID</th>
            <th width="15%" style="text-align:center;">Microsoft ID</th>
            <th style="text-align:center;">Domain</th>
            <th width="15%" style="text-align:center;">Offer ID</th>
            <th width="15%" style="text-align:center;">Offer Name</th>
            <th width="10%" style="text-align:center;">Billing Cycle</th>
            <th width="10%" style="text-align:center;">Quantity</th>
            <th width="10%" style="text-align:center;">Commitment End Date</th>
        </tr>
        {foreach from=$aSubscriptionsNoneHBAccount item="aData" key="k"}
        <tr>
            <td style="padding: 0 0 0 5px;">
                {$aData.subsctiptions}
                <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aData.cuntomerID}/subscriptions/{$aData.subsctiptions}" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">
                {$aData.cuntomerID}
                <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aData.cuntomerID}/subscriptions" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">{$aData.domain}</td>
            <td style="padding: 0 0 0 10px;">{$aData.offerId}</td>
            <td style="padding: 0 0 0 10px;">{$aData.offerName}</td>
            <td style="text-align:center;">{$aData.billingCycle}</td>
            <td style="text-align:center;">{$aData.quantity}</td>
            <td style="text-align:right;">{if $aData.commitmentEndDate}{$aData.commitmentEndDate|date_format:'%d %b %Y <br />%H:%M:%S GMT %Z'}{else}N/A{/if}</td>
        </tr>
        {/foreach}
        </table>
    </td>
</tr>
</table>

{if isset($aDebug)}
<pre>{$aDebug|@print_r}</pre>
{/if}
<script language="JavaScript">
{literal}

{/literal}
</script>

{include file="$tplPath/admin/footer.tpl"}