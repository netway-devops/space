{php}
    $templatePath   = $this->get_template_vars('template_path');
    include($templatePath . 'signup.tpl.php');
{/php}
<div class="text-block clear clearfix">
    <h5 style="float:none;">{$lang.createaccount}</h5>
    <div class="pt15">
    
    {if ! $isSecure}
    <script src='https://www.google.com/recaptcha/api.js'  async defer></script>
    <script>
    {literal}
    function recaptchaSubmit(data) {
        document.getElementById('validateForm').submit();
    }
    {/literal}
    </script>
    <form method="post" action="{$system_url}?cmd=signup" id="validateForm">
        <center>
        <p>
            We use cookies to ensure that we provide best user experience on our website. By using our website and products, 
            you acknowledge that you have read and agree to our <a href="https://rvglobalsoft.com/privacy_policy" target="_blank">Privacy Policy</a> and <a href="https://rvglobalsoft.com/terms_of_service" target="_blank">Terms of Service</a>.
        </p>
        <button class="g-recaptcha clearstyle green-custom-btn btn h-btn" style="font-weight:bold;"
        data-sitekey="6LeCWWcUAAAAAEtdZjBiJelJtbxnJi6DCGH5VchH"
        data-size="invisible"
        data-callback="recaptchaSubmit">
        Continue
        </button>
        </center>
    </form>
    <br />
    <br />
    <br />
    <br />
    <br />
    {/if}
    
    {if $isSecure}
    <form method="post" action="" name="signupform">
        {include file='ajax.signup.tpl'}

        <div class="form-actions">
            <center>
            Clicking Submit will mean you have read and agreed in our <a href="https://rvglobalsoft.com/privacy_policy" target="_blank">Privacy Policy</a>.<br />
            <button type="submit" class="clearstyle green-custom-btn btn h-btn" style="font-weight:bold">
            {$lang.submit}
            </button>
            </center>
        </div>

        {securitytoken}
    </form>
    {/if}
    
    </div>
</div>
