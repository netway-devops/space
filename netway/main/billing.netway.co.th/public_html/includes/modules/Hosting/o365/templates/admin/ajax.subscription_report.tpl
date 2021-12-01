{if count($aWarnings) > 0}
<div class="imp_msg">
    <strong>Warning:</strong> <br>
    <ul>
{foreach from=$aWarnings item="message" key="k"}
        <li>{$message}</li>
{/foreach}
    </ul>
</div>
{/if}

<table width="100%">
    <tr>
        <td>
            <table width="100%" style="padding: 0 0 0 5px;">
                <tr>
                    <td width="10%" style="text-align:right; padding: 0 5px 0 5px; font-weight: bold;">Microsoft ID(Customer ID):</td>
                    <td width="20%" style="text-align:left; padding: 0 0 0 5px;">
                        {$aAzCustomerInfo.customer_id} <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aAzCustomerInfo.customer_id}/subscriptions" target="_blank" title="ไปยังหน้าแสดงข้อมูลของ Customer บน CSP"><i class="fa fa-external-link" aria-hidden="true"></i></a>
                        {if !$hasDataMicrosoftIdInHB}
                            <br /><span id="txt_sync_ms_id_to_hb_account"></span><input id="bt_sync_ms_id_to_hb_account" type="button" value="ผูก ID นี้ เข้ากับ Hostbill Account" onclick="sync_ms_id_to_hb_account('{$module}', '{$account_id}');">
                        {/if}
                    </td>
                    <td width="10%" style="text-align:right; padding: 0 5px 0 5px; font-weight: bold;">Company name:</td>
                    <td width="20%" style="text-align:left; padding: 0 0 0 5px;">{$aAzCustomerInfo.company_name}</td>
                    <td width="10%" style="text-align:right; padding: 0 5px 0 5px; font-weight: bold;">Domain name:</td>
                    <td width="20%" style="text-align:left; padding: 0 0 0 5px;">{$aAzCustomerInfo.domain}</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr height="15px;"><td> </td></tr>
    <tr>
        <td style="padding: 0 10px 0 5px; font-weight: bold;">Subscription list:</td>
    </tr>
    <tr>
        <td>
            <table border="1" width="100%" style="padding: 0 0 0 5px;">
                <tr>   
                    <th width="20%" style="text-align:center;">Subscription ID</th>
                    <th width="15%" style="text-align:center;">Offer Name</th>
                    <th width="20%" style="text-align:center;">Offer ID</th>
                    <th width="10%" style="text-align:center;">Quantity</th>
                    <th width="10%" style="text-align:center;">Billing Cycle</th>
                    <th width="5%" style="text-align:center;">Status</th>
                    <th style="text-align:center;">Renews/Expire On</th>
                </tr>
                {foreach from=$aAzSubscription item="aData" key="k"}
                <tr style="{if $aData.status != 'active'}color: grey; text-decoration: line-through;{/if}{if $aData.quantity != $seatQuantity}color: red;{/if}">
                    <td style="text-align:left; padding: 0 0 0 10px;">{$aData.id} <a style="padding: 0 2px;" class="btn btn-sm" href="https://partner.microsoft.com/commerce/customers/{$aAzCustomerInfo.customer_id}/subscriptions/{$aData.id}" target="_blank" title="ไปยังหน้าแสดง Subscriptions ของ Customer บน CSP"><i class="fa fa-external-link" aria-hidden="true"></i></td>
                    <td style="text-align:left; padding: 0 0 0 10px;">{$aData.offerName}</td>
                    <td style="text-align:left; padding: 0 0 0 10px;">{$aData.offerId}</td>
                    <td style="text-align:center;">{$aData.quantity} {$aData.unitType}</td>
                    <td style="text-align:center;">{$aData.billingCycle|@ucfirst}</td>
                    <td style="text-align:center;">{$aData.status|@ucfirst}</td>
                    <td style="text-align:center;">
                        {if isset($aData.autoRenewEnabled) && $aData.autoRenewEnabled == true}
                            Auto renews on {$aData.commitmentEndDate|date_format:"%b %e, %Y %T GMT %Z"}
                        {else}
                            Expire on {$aData.commitmentEndDate|date_format:"%b %e, %Y %T GMT %Z"}
                        {/if}
                    </td>
                </tr>
                {/foreach}
            </table>
        </td>
    </tr>
</table>
<p></p>
{if isset($aDebug)}
<pre>{$aDebug|@print_r}</pre>
{/if}