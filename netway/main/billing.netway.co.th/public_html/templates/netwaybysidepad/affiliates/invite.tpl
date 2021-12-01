
<div class="service-white-bg">
    <h1 class="aff-invite">{$lang.affiliates|capitalize}</h1>
    <h2 class="aff-invite">{$lang.ycm} {if $config.AffType=='Percent'}{$config.AffValue}%{else}{$config.AffValue|price:$currency}{/if} {$lang.persale}</h2>
    <p class="aff-invite">
        {$lang.notaffiliateyet}
        {if $config.AffBonus>0}
            <strong>{$lang.get} {$config.AffBonus|price:$currency} {$lang.justsign}</strong>
        {/if}
    </p>
    <br />

    <form action="" method="post">
        <input type="hidden" value="activateaffiliate" name="make" />
        <center>
            <button type="submit" class="clearstyle btn green-custom-btn l-btn" style="font-weight:bold;font-size:16px;padding:15px 10px;">{$lang.becomeaffiliate}</button>
        </center>
        {securitytoken}
    </form>
</div>

