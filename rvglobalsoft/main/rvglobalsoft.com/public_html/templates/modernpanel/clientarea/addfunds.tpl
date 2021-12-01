<article>
    <h2><i class="icon-acc"></i> {$lang.account}</h2>
    <p>{$lang.account_descr}</p>
    <div class="account-info-box">
        {include file='clientarea/leftnavigation.tpl'}

        <div class="account-info-container">
            <div class="padding">
                <h2>{$lang.addfunds}</h2>
                <p>{$lang.addfunds_d}</p>
                <form class="m20" action='' method='post'>
                    <input type="hidden" name="make" value="addfunds" />
                    <fieldset>

                        <label for="funds">{$lang.trans_amount}:</label>
                        <input class="span2" type="text" name="funds" id="funds" value="{$mindeposit}">
                        
                        <label for="gateway">{$lang.trans_gtw}:</label>
                        <select name="gateway" class="span2" id="gateway">
                            {foreach from=$gateways key=gatewayid item=paymethod}
                                <option value="{$gatewayid}">{$paymethod}</option>
                            {/foreach}
                        </select>

                        <div class="well">
                            <div class="pull-right">
                                <button type="submit" class="btn c-green-btn"><i class="icon-add"></i> {$lang.addfunds}</button>
                            </div>
                            <div class="well-info">
                                <p>{$lang.MinDeposit}: <strong> {$mindeposit|price:$currency}</strong></p>
                                <p>{$lang.MaxDeposit}: <strong> {$maxdeposit|price:$currency}</strong></p>
                            </div>
                        </div>
                    </fieldset>
                    {securitytoken}
                </form>
            </div>
        </div>
    </div>     
</article>