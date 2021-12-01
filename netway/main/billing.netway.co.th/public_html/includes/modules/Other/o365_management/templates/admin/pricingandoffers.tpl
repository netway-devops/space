{include file="$tplPath/admin/header.tpl"}

{assign var=keyOfferDisplayName value="Offer Display Name"}
{assign var=keyDurableOfferID value="Durable Offer ID"}
{assign var=keyDuration value="Duration"}
{assign var=keyBillingFrequency value="Billing Frequency"}
{assign var=keyMinSeatCount value="Min Seat Count"}
{assign var=keyMaxSeatCount value="Max Seat Count"}
{assign var=keyOfferLimit value="Offer Limit"}
{assign var=keyOfferLimitScope value="Offer Limit Scope"}
{assign var=keyDependsOn value="DependsOn"}
{assign var=keyCanConvertTo value="CanConvertTo"}
{assign var=keyOfferURI value="OfferURI"}
{assign var=keyLearnMoreLink value="LearnMoreLink"}
{assign var=keyOfferDisplayDescription value="Offer Display Description"}
{assign var=keyAllowedCountries value="Allowed Countries"}
{assign var=keyPricing value="Pricing"}
{assign var=keyACDU value="A/C/D/U"}
{assign var=keyValidFromDate value="Valid-From Date"}
{assign var=keyValidToDate value="ValidToDate"}
{assign var=keyOfferID value="Offer ID"}
{assign var=keyLicenseAgreementType value="License Agreement Type"}
{assign var=keyPurchaseUnit value="Purchase Unit"}
{assign var=keySecondaryLicenseType value="Secondary License Type"}
{assign var=keyEndCustomerType value="End Customer Type"}
{assign var=keyListPrice value="List Price"}
{assign var=keyERPPrice value="ERP Price"}
{assign var=keyMaterial value="Material"}
{assign var=keyBillingCycle value="Billing Cycle"}
{assign var=dataRowStyle value="background-color:#fff;"}

{if $timestampLastUpdateData}
<div class="gbox1" style="padding: 0px 15px 0px 15px;">
    <p><b>Pricing and offers on: {$msPricingOn}</b></p>
</div>
{/if}

<table cellpadding="2" cellspacing="2" width="100%">
<tr>
    <th><h1>Pricing information for Office 365, Enterprise Mobility + Security E3, and Dynamics 365.</h1></th>
</tr>
<tr>
    <td>
        <table cellpadding="2" cellspacing="2" border="1" width="100%">
            <tr style="text-align:center;">
                <th style="text-align:center;" colspan="7">Microsoft Office 365 Products</th>
                <th style="text-align:center;" colspan="2">Hostbill Products</th>
            </tr>
            <tr style="text-align:center;">
                <th style="text-align:center;" rowspan="2">Offer Display Name</th>
                <th style="text-align:center;" rowspan="2">Durable Offer ID</th>
                <th style="text-align:center;" colspan="4">Based Pricing</th>
                <th style="text-align:center;" rowspan="2">Billing Frequency</th>
                <th style="text-align:center;" rowspan="2">Product ID</th>
                <th style="text-align:center;" rowspan="2">Price</th>
            </tr>
            <tr style="text-align:center;">
                <th style="text-align:center;">Valid-From Date</th>
                <th style="text-align:center;">Purchase Unit</th>
                <th style="text-align:center;">List Price</th>
                <th style="text-align:center;">ERP Price</th>
            </tr>
{foreach from=$aOfferPricingList item="aOfferItem" key="indexOfferItem"}
    {foreach from=$aOfferItem[$keyBillingFrequency] item="aBillingFrequencyItem" key="indexBillingFrequencyItem"}
            {if $aBillingFrequencyItem.$keyBillingCycle == 'Unsupported'}
                {assign var=dataFontStyle value="color:#ff0000;"}
            {else}
                {assign var=dataFontStyle value="color:#000;"}
            {/if}
            <tr style="{$dataRowStyle}{$dataFontStyle}">
        {if $indexBillingFrequencyItem == 0}
                <td style="padding: 0 0 0 10px; vertical-align: text-top;" rowspan="{$aOfferItem.$keyBillingFrequency|@count}">{$aOfferItem.$keyOfferDisplayName}</td>
                <td style="padding: 0 0 0 10px; vertical-align: text-top;" rowspan="{$aOfferItem.$keyBillingFrequency|@count}">{$aOfferItem.$keyDurableOfferID}</td>
                <td style="padding: 0 10px 0 10px; text-align:left; vertical-align: text-top;" rowspan="{$aOfferItem.$keyBillingFrequency|@count}">{$aOfferItem.Pricing.$keyValidFromDate}</td>
                <td style="padding: 0 10px 0 10px; text-align:right; vertical-align: text-top;" rowspan="{$aOfferItem.$keyBillingFrequency|@count}">{$aOfferItem.Pricing.$keyPurchaseUnit}</td>
                <td style="padding: 0 10px 0 10px; text-align:right; vertical-align: text-top;" rowspan="{$aOfferItem.$keyBillingFrequency|@count}">{$aOfferItem.Pricing.$keyListPrice} USD</td>
                <td style="padding: 0 10px 0 10px; text-align:right; vertical-align: text-top;" rowspan="{$aOfferItem.$keyBillingFrequency|@count}">{$aOfferItem.Pricing.$keyERPPrice} USD</td>
        {/if}
                <td style="text-align:center; vertical-align: text-top;">{$aBillingFrequencyItem.$keyBillingCycle|ucfirst}</td>
                <td style="text-align:center; vertical-align: text-top;">
        {if count($aBillingFrequencyItem.HostbillProducts) > 0}
            {foreach from=$aBillingFrequencyItem.HostbillProducts item=hbProductItem key=indexHBProductItem }
                    {if $indexHBProductItem > 0}, {/if}{$hbProductItem.id}
                    <a style="padding: 0 2px;" class="btn btn-sm" href="?cmd=services&action=product&id={$hbProductItem.id}" target="_blank" title="{$hbProductItem.product_cat}/{$hbProductItem.product_name}"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            {/foreach}
        {else}
                    -
        {/if}
                </td>
                <td style="text-align:center; vertical-align: text-top;">
                {if count($aBillingFrequencyItem.HostbillProducts) > 0}
            {foreach from=$aBillingFrequencyItem.HostbillProducts item=hbProductItem key=indexHBProductItem }
                    {if $indexHBProductItem > 0}, {/if}{$hbProductItem.price}
            {/foreach}
        {else}
                    -
        {/if}
                </td>
            </tr>
    {/foreach}
    {if $dataRowStyle == "background-color:#fff;"}
        {assign var=dataRowStyle value="background-color:#f4f4f4;"}
    {else}
        {assign var=dataRowStyle value="background-color:#fff;"}
    {/if}
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