
<div class="text-block clear clearfix">
    <h5>{$lang.account}</h5>

    <div class="clear clearfix">
        <div class="account-box">

        {include file='clientarea/leftnavigation.tpl'}

            <div class="account-content">
            <div class="content-padding">
                <h6>{$lang.addfunds}</h6>
                <p>{$lang.addfunds_d}</p>
                <span class="underline"></span>

                <form class="form-horizontal" method="post" action="">
                <input type="hidden" name="make" value="addfunds" />
                    <div class="control-group">
                        <label class="control-label">{$lang.trans_amount}:</label>
                        <div class="controls">
                            <input class="span2" type="text" name="funds" value="{$mindeposit}">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">{$lang.trans_gtw}:</label>
                        <div class="controls">
                            <select name="gateway" class="span2">
                            {foreach from=$gateways key=gatewayid item=paymethod}
                            	{if $paymethod != 'Credit'}
                                <option value="{$gatewayid}">{$paymethod}</option>
                                {/if}
                            {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="control-label">
                        <div class="alert alert-info">
                            <p><strong>{$lang.MinDeposit}:</strong> {$mindeposit|price:$currency}</p>
                            <p><strong>{$lang.MaxDeposit}:</strong> {$maxdeposit|price:$currency}</p>
                        </div>
                    </div>

                    <div class="control-group">
                        <button type="submit" class="clearstyle green-custom-btn btn custom-large-btn">+ {$lang.addfunds}</button>
                    </div>
                    {securitytoken}
                </form>

            </div>

        </div>


    </div>
 </div>
 </div>