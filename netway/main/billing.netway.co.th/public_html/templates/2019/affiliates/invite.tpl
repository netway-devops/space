<div class="spacing text-center">
    <h1>{$lang.affiliates|capitalize}</h1>
    <p>
        {$lang.ycm}
        {if $config.AffType=='Percent'}
            {$config.AffValue}%
        {else}
            {$config.AffValue|price:$currency}
        {/if}
        {$lang.persale}
    </p>
    <p>
        {$lang.notaffiliateyet}
        {if $config.AffBonus>0}
            <strong>{$lang.get} {$config.AffBonus|price:$currency} {$lang.justsign}</strong>
        {/if}
    </p>
    <br />
    <form action="" method="post" >
        <input type="hidden" value="activateaffiliate" name="make" />
        <div>
            <button type="submit" class="btn btn-lg btn-primary">
                <i class="material-icons">library_books</i>
                {$lang.becomeaffiliate}
            </button>
        </div>
        {securitytoken}
    </form>
</div>
