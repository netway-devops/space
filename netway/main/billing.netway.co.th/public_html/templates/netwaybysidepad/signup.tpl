<div class="text-block clear clearfix" style="margin:25px 30px;">
    <h5 style="float:none;">{$lang.createaccount}</h5>
    <div class="pt15">
    <form method="post" action="" name="signupform">
        {include file='ajax.signup.tpl'}

        <div class="form-actions">
            <center><button rel="nofollow"  type="submit" class="clearstyle green-custom-btn btn h-btn" style="font-weight:bold">
            {$lang.submit}
            </button></center>
        </div>

        {securitytoken}
    </form>
    </div>
</div>
