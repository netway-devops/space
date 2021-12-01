{include file="$tplPath/admin/header.tpl"}
{if count($aSubscriptionsNoneHBProduct) > 0}
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
    <th><h1>List Microsoft subscription(s) ที่ไม่มี Hostbill product รองรับ</h1></th>
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
        </tr>
        {foreach from=$aSubscriptionsNoneHBProduct item="aData" key="k"}
        <tr>
            <td style="padding: 0 0 0 5px;">
                {$aData.subsctiptions}
                <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aData.cuntomerID}/subscriptions/{$aData.subsctiptions}" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">
                {$aData.cuntomerID}
                <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aData.cuntomerID}" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">{$aData.domain}</td>
            <td style="padding: 0 0 0 10px;">{$aData.offerId}</td>
            <td style="padding: 0 0 0 10px;">{$aData.offerName}</td>
            <td style="text-align:center;">{$aData.billingCycle}</td>
            <td style="text-align:center;">{$aData.quantity}</td>
        </tr>
        {/foreach}
        </table>
    </td>
</tr>
</table>
<p></p>
{/if}

{if count($aSubscriptionsNoneHBAccount) > 0}
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
    <th><h1>List Microsoft subscription(s) ที่ไม่สามารถเชื่อมข้อมูลกับ Hostbill account ได้</h1></th>
</tr>
<tr>
    <th>
    <div class="imp_msg">
        <strong>หมายเหตุ:</strong> การเชื่อมข้อมูล Microsoft subscription(s) กับ Hostbill account ใช้หลักการดังนี้</br>
        <ul>
            <li>เอา Microsoft ID ที่ได้จาก Microsoft Partner Center มาเปรียบเทียบกับข้อมูลใน Hostbill account custom filed "Microsoft ID"</li>
            <li>เอา Domain ที่ได้จาก Microsoft Partner Center มาเปรียบเทียบกับข้อมูล "Hostname" ใน Hostbill account.</li>
            <li>เอา Domain ที่ได้จาก Microsoft Partner Center มาเปรียบเทียบกับข้อมูล Hostbill account custom filed "ชื่อโดเมนที่แสดงใน Reseller Portal"</li>
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
        </tr>
        {foreach from=$aSubscriptionsNoneHBAccount item="aData" key="k"}
        <tr>
            <td style="padding: 0 0 0 5px;">
                {$aData.subsctiptions}
                <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aData.cuntomerID}/subscriptions/{$aData.subsctiptions}" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">
                {$aData.cuntomerID}
                <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aData.cuntomerID}" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">{$aData.domain}</td>
            <td style="padding: 0 0 0 10px;">{$aData.offerId}</td>
            <td style="padding: 0 0 0 10px;">{$aData.offerName}</td>
            <td style="text-align:center;">{$aData.billingCycle}</td>
            <td style="text-align:center;">{$aData.quantity}</td>
        </tr>
        {/foreach}
        </table>
    </td>
</tr>
</table>
<p></p>
{/if}

{if count($aSubscriptionsHasHBAccount) > 0}
<table cellpadding="2" cellspacing="2" width="100%">
<tr>
    <th><h1>List Microsoft subscription(s) กับ Hostbill account</h1></th>
</tr>
<tr>
    <td>
        <table cellpadding="2" cellspacing="2" border="1" width="100%">
        <tr style="text-align:center;">
            <th width="7%" style="text-align:center;">Account ID</th>
            <th width="15%" style="text-align:center;">Subscription ID</th>
            <th width="15%" style="text-align:center;">Microsoft ID</th>
            <th style="text-align:center;">Domain</th>
            <th width="15%" style="text-align:center;">Offer Name</th>
            <th width="10%" style="text-align:center;">Billing Cycle</th>
            <th width="10%" style="text-align:center;">Quantity (ms/HB)</th>
            <th width="10%" style="text-align:center;">Account Status</th>
            <th style="text-align:center;">Require value in component(s)</th>
        </tr>
        {foreach from=$aSubscriptionsHasHBAccount item="aData" key="k"}
        <tr style="{if (int)$aData.quantity != (int)$aData.accountInfo.seatQuantity}color: red;{/if}">
            <td style="padding: 0 5px 0 5px; text-align: right;">
                {$aData.accountInfo.account_id}
                <a style="padding: 0 2px;" class="btn btn-sm" href="?cmd=accounts&action=edit&id={$aData.accountInfo.account_id}&list=all" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">
                {$aData.subsctiptions}
                <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aData.cuntomerID}/subscriptions/{$aData.subsctiptions}" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">
                {$aData.cuntomerID}
                <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aData.cuntomerID}" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">{$aData.domain}</td>
            <td style="padding: 0 0 0 10px;">{$aData.offerName}</td>
            <td style="text-align:center;">{$aData.billingCycle}</td>
            <td style="text-align:center;">{$aData.quantity}/{$aData.accountInfo.seatQuantity}</td>
            <td width="10%" style="text-align:center;">{$aData.accountInfo.status}</td>
            <td width="10%" style="text-align:left;">{$aData.accountInfo.warning}</td>
        </tr>
        {/foreach}
        </table>
    </td>
</tr>
</table>
<p></p>
{/if}

{if isset($aDebug)}
<pre>{$aDebug|@print_r}</pre>
{/if}
<script language="JavaScript">
{literal}

{/literal}
</script>

{include file="$tplPath/admin/footer.tpl"}