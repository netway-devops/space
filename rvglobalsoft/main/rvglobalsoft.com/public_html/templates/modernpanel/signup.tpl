<article>
    <h2>
        <i class="icon-acc"></i> 
        {$lang.createaccount}
    </h2>
    <p>{$lang.kbwelcome}</p>
    <div class="padding">
        <form method="post" action="" name="signupform">
            {include file='ajax.signup.tpl'}

            <div class="form-actions">
                <center>
                    <button type="submit" class="btn c-green-btn" >
                        {$lang.submit}
                    </button>
                </center>
            </div>

            {securitytoken}
        </form>
    </div>
</article>
