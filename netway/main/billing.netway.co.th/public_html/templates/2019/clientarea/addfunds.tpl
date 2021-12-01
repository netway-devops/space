{include file="components/billing_header.tpl"}

{include file="clientarea/top_nav.tpl" nav_type="billing"}

<h5 class="my-5">{$lang.addfunds_d}</h5>

<section class="section-account">
    <form method="post" action="">
        <input type="hidden" name="make" value="addfunds" />
        <div class="row">
            <div class="col-12 col-md-6 py-3">
                <label>{$lang.trans_amount}</label>
                <input class="form-control" name="funds" type="text" value="{$mindeposit|price:$currency:false}">
            </div>
            <div class="col-12 col-md-6 py-3">
                <label>{$lang.trans_gtw}</label>
                <select class="form-control" name="gateway" >
                    {foreach from=$gateways key=gatewayid item=paymethod}
                        <option value="{$gatewayid}">{$paymethod}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-12 pt-1 pb-4">
                <div class="d-flex justify-content-between">
                    <div>
                        <button type="submit" class="btn btn-primary"><i class="material-icons icon-btn-color size-sm mg-right-10">add</i> {$lang.addfunds}</button>
                    </div>
                    <div class="d-flex flex-column align-items-end">
                        <span>{$lang.MinDeposit}: <strong>{$mindeposit|price:$currency}</strong></span>
                        <span>{$lang.MaxDeposit}: <strong> {$maxdeposit|price:$currency}</strong></span>
                    </div>
                </div>
            </div>
        </div>
        {securitytoken}
    </form>
    {if $showcreditvouchersform}
        <hr>
        <form method="post" action="?cmd=creditvouchers&action=redeem_voucher">
            <h4>{$lang.redeemvoucher}</h4>
            <div class="row">
                <div class="col-12 col-md-6 py-3">
                    <label>{$lang.vouchercode}:</label>
                    <input name="code" type="text" class="form-control"/>
                </div>
            </div>
            <div class="row">
                <div class="col-12 pt-1 pb-4">
                    <div class="d-flex justify-content-between">
                        <div>
                            <button type="submit" class="btn btn-primary"><i class="material-icons icon-btn-color size-sm mg-right-10">local_offer</i> {$lang.redeem}</button>
                        </div>
                    </div>
                </div>
            </div>
            {securitytoken}
        </form>
    {/if}

    {clientwidget module="addfunds" section="after"}

</section>

