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
    <th><h1>Hostbill Product(s) ที่ connection ด้วย module "o365"</h1></th>
</tr>
<tr>
    <td>
        <table cellpadding="2" cellspacing="2" border="1" width="100%">
        <tr style="text-align:center;">
            <th width="7%" style="text-align:center;" rowspan="2">Product ID</th>
            <th style="text-align:center;" rowspan="2">Category / Product Name</th>
            <th style="text-align:center;" colspan="4">Microsoft Office 365 Information</th>
            <th width="10%" style="text-align:center;" rowspan="2">HB Billing Cycle</th>
            <th width="10%" style="text-align:center;" rowspan="2">HB Price</th>
            <th style="text-align:center;" rowspan="2">Require Component(s)</th>
        </tr>
        <tr style="text-align:center;">
            <th style="text-align:center;"><span style="font-size:0.8em;">Durable Offer ID - Offer Display Name</span></th>
            <th style="text-align:center;"><span style="font-size:0.8em;">Purchase Unit</span></th>
            <th style="text-align:center;"><span style="font-size:0.8em;">List Price(USD)</span></th>
            <th style="text-align:center;"><span style="font-size:0.8em;">ERP Price(USD)</span></th>
        </tr>
        {foreach from=$aHBProductsO365 item="aData" key="k"}
        <tr style="{if !$aData.link2msOffer}color: red;{/if}">
            <td style="padding: 0 5px 0 5px; text-align: right;">
                {$aData.product_id}
                <a style="padding: 0 2px;" class="btn btn-sm" href="?cmd=services&action=product&id={$aData.product_id}" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></a>
            </td>
            <td style="padding: 0 0 0 10px;">{$aData.product_cat} / {$aData.product_name}</td>
            <td style="padding: 0 0 0 10px;">{if $aData.link2msOffer}{$aData.options.ms_offer_id} <span style="font-size:0.8em; color=#A9A9A9;"> - {$aData.offerName}</span>{/if}</td>
            <td style="text-align:center;">{if $aData.link2msOffer}<span style="font-size:0.8em; color=#A9A9A9;">{$aData.offerPriceDetails.$keyPurchaseUnit}</span>{/if}</td>
            <td style="text-align:center;">{if $aData.link2msOffer}<span style="font-size:0.8em; color=#A9A9A9;">${$aData.offerPriceDetails.$keyListPrice}</span>{/if}</td>
            <td style="text-align:center;">{if $aData.link2msOffer}<span style="font-size:0.8em;">${$aData.offerPriceDetails.$keyERPPrice}</span>{/if}</td>
            <td style="text-align:center;">{if $aData.link2msOffer}
                <table width="100%">
                {foreach from=$aData.prices item="prices" key="kCycle"}
                    <tr style="text-align:center;"><td>
                    {$kCycle}
                    </td></tr>
                {/foreach}
                </table>
            {/if}</td>
            <td style="text-align:center;">{if $aData.link2msOffer}
                <table width="100%">
                {foreach from=$aData.prices item="prices" key="kCycle"}
                    <tr style="text-align:center;"><td>
                    {if $kCycle == 'free'} Free {else} {$prices} {/if}
                    </td></tr>
                {/foreach}
                </table>
            {/if}</td>
            <td style="text-align:center;">{$aData.warning}</td>
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