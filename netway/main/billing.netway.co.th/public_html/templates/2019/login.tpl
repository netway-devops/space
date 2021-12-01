{if $action=='passreminder'}
    <section class="section-passreminder">
        <div class="d-flex align-items-center flex-column form-credentials form-signin">
            <a href="{$ca_url}">
                <img src="{$template_dir}{themeconfig variable=logo_big default="dist/images/hb_logo.png"}" alt="{$business_name}" class="image size-lg">
            </a>
            <h1 class="h3 mb-4 font-weight-normal">{$lang.didyouforget}</h1>
            <small>{$lang.forgetintro}</small>
            {if !$thanks}
            <form name="" action="" method="post" >
                <div class="form-label-group mt-3">
                    <input type="email" id="email_remind" name="email_remind" class="form-control" placeholder="{$lang.email}" value="{$sub_email}" required autofocus>
                    <label class="form-label-placeholder" for="email_remind">{$lang.forgetenter}</label>
                </div>
                {if $enableFeatures.logincaptcha =='on'}
                    <div class="form-groups">
                        <label for="captcha">{$lang.captcha}</label>
                        <br>
                        <small>{$lang.typethecharacters}</small>
                        <div class="d-flex flex-row justify-content-start align-items-center">
                            <img class="capcha" style="width: 120px; height: 60px;" onclick="return singup_image_reload();" src="?cmd=root&action=captcha#{$timestamp}" alt="Image" />
                            <input type="text" id="captcha" name="captcha" class="form-control" autocomplete="off" required>
                        </div>
                        {literal}
                            <script>
                                function singup_image_reload() {
                                    var d = new Date();
                                    $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
                                    return false;
                                }
                            </script>
                        {/literal}
                    </div>
                {/if}
                <div class="d-flex justify-content-between align-items-center">
                    <a class="text-small" href="{$ca_url}clientarea/">{$lang.login}</a>
                    <button class="btn btn-primary" type="submit">{$lang.sendmepass}</button>
                </div>
                {securitytoken}
            </form>
            {/if}
        </div>
    </section>
{elseif $action=='passreset'}
    <section class="section-passreminder">
        <div class="d-flex align-items-center flex-column form-credentials form-signin">
            <a href="{$ca_url}">
                <img src="{$template_dir}{themeconfig variable=logo_big default="dist/images/hb_logo.png"}" alt="{$business_name}" class="image size-lg">
            </a>
            <h1 class="h4 mb-4 font-weight-normal">{$lang.providenewpassword}</h1>
            <form name="" action="" method="post" >
                <div class="form-label-group mt-3">
                    <input type="password" id="new_password" name="new_password" class="form-control" placeholder="{$lang.newpassword}" required autofocus>
                    <label class="form-label-placeholder" for="new_password">{$lang.newpassword}</label>
                </div>
                <div class="form-label-group mt-3">
                    <input type="password" id="new_password_confirmation" name="new_password_confirmation" class="form-control" placeholder="{$lang.newpasswordconfirm}" required autofocus>
                    <label class="form-label-placeholder" for="new_password_confirmation">{$lang.newpasswordconfirm}</label>
                </div>
                {if $enableFeatures.logincaptcha =='on'}
                    <div class="form-groups">
                        <label for="captcha">{$lang.captcha}</label>
                        <br>
                        <small>{$lang.typethecharacters}</small>
                        <div class="d-flex flex-row justify-content-start align-items-center">
                            <img class="capcha" style="width: 120px; height: 60px;" onclick="return singup_image_reload();" src="?cmd=root&action=captcha#{$timestamp}" alt="Image" />
                            <input type="text" id="captcha" name="captcha" class="form-control" autocomplete="off" required>
                        </div>
                        {literal}
                            <script>
                                function singup_image_reload() {
                                    var d = new Date();
                                    $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
                                    return false;
                                }
                            </script>
                        {/literal}
                    </div>
                {/if}
                <div class="d-flex justify-content-between align-items-center">
                    <a class="text-small" href="{$ca_url}clientarea/">{$lang.login}</a>
                    <button class="btn btn-primary" type="submit">{$lang.changepass}</button>
                </div>
                <input type="hidden" name="activate" value="{$activate}">
                {securitytoken}
            </form>
        </div>
    </section>
{else}
    <section class="section-signin">
        <div class="d-flex align-items-center flex-column form-credentials form-signin">
            <a href="{$ca_url}">
                <img src="{$template_dir}{themeconfig variable=logo_big default="dist/images/hb_logo.png"}" alt="{$business_name}" class="image size-lg">
            </a>
            <h1 class="h3 mb-4 font-weight-normal">{$lang.restricted}</h1>
            <small>{$lang.restrictedarea}</small>
            {include file="`$template_path`ajax.loginform.tpl"}
        </div>
    </section>
{/if}