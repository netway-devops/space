{*

Change password of profile contact

*}
<article>
    <h2><i class="icon-acc"></i> {$lang.account}</h2>
    <p>{$lang.account_descr}</p>
    <div class="account-info-box">
        {include file='clientarea/leftnavigation.tpl'}
        <div class="account-info-container">
            <div class="padding">
                <h2>
                    {$lang.changepass}
                </h2>
                <form class="m20" action='' method='post'>
                    <input type="hidden" name="make" value="changepassword" />
                    <fieldset>
                        <label for="oldpassword">{$lang.oldpass}:</label>
                        <input class="span4" type="password" id="oldpassword" name="oldpassword">
                        
                        <label for="password">{$lang.newpassword}:</label>
                        <input class="span4" type="password" id="password" name="password">
                        
                        <label for="password2">{$lang.confirmpassword}:</label>
                        <input class="span4" type="password" id="password2" name="password2">

                    </fieldset>
                    <div class="pull-right m15">
                        <button type="submit" class="btn c-green-btn"> {$lang.savechanges}</button>
                    </div>
                    {securitytoken}
                </form>
            </div>
        </div>
    </div>     
</article>
