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
    <td>
        <h1>รายงานข้อมูล Microsoft Offer 365 ที่มี Subscription active อยู่บน MSP แต่ยังไม่มี Hostbill Product มารองรับ</h1>
        <table cellpadding="2" cellspacing="2" border="1" width="100%">
        <tr style="text-align:center;">
            <th style="text-align:center;">Offer Display Name</th>
            <th width="20%" style="text-align:center;">Durable Offer ID</th>
            <th width="20%" style="text-align:center;">Monthly</th>
            <th width="20%" style="text-align:center;">Annually</th>
        </tr>
{foreach from=$aOfferNoneHbProduct item="aData" key="k"}
    {if $aData.offerName != 'Azure plan'}
        <tr>
            <td style="padding: 0 0 0 10px;">{$aData.offerName}</td>
            <td style="padding: 0 0 0 5px;">{$aData.offerId}</td>
            <td style="padding: 0 0 0 10px; text-align:center;">{if isset($aData.billingCycle.Monthly) && $aData.billingCycle.Monthly}<span style="color:red"><b>{$aData.billingCycle.Monthly} Subscription(s) active.</b></span>{else}-{/if}</td>
            <td style="padding: 0 0 0 10px; text-align:center;">{if isset($aData.billingCycle.Annually) && $aData.billingCycle.Annually}<span style="color:red"><b>{$aData.billingCycle.Annually} Subscription(s) active.</b></span>{else}-{/if}</td>
        </tr>
    {/if}
{/foreach}
    </table><br /><br />
    </td>
</tr>
<tr>
    <td>
        <h1>รายงานข้อมูล Subscription(s) ที่ไม่มี Hostbill product มารองรับ</h1>
        <table cellpadding="2" cellspacing="2" border="1" width="100%">
        <tr style="text-align:center;">
            <th width="15%" style="text-align:center;">Subscription ID</th>
            <th width="15%" style="text-align:center;">Microsoft ID</th>
            <th style="text-align:center;">Domain</th>
            <th width="15%" style="text-align:center;">Offer ID</th>
            <th width="15%" style="text-align:center;">Offer Name</th>
            <th width="10%" style="text-align:center;">Billing Cycle</th>
            <th width="10%" style="text-align:center;">Quantity</th>
            <th width="10%" style="text-align:center;">Effective Start Date</th>
            <th width="10%" style="text-align:center;">Commitment End Date</th>

        </tr>
        {foreach from=$aSubscriptionsNoneHBProduct item="aData" key="k"}
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
            <td style="text-align:right;">{if $aData.effectiveStartDate}{$aData.effectiveStartDate|date_format:'%d %b %Y <br />%H:%M:%S GMT %Z'}{else}N/A{/if}</td>
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