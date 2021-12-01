<form action="{$form_action}" method="post">
    <div class="form-label-group mt-3">
        {assign var=unique_id_username value=0|mt_rand:50}
        <input type="email" id="username_{$unique_id_username}" name="username" autocomplete="email" class="form-control" placeholder="{$lang.email}" value="{$submit.username}" required autofocus>
        <label class="form-label-placeholder" for="username_{$unique_id_username}">{$lang.email}</label>
    </div>
    <div class="form-label-group mt-3">
        {assign var=unique_id_password value=51|mt_rand:100}
        <input type="password" id="password_{$unique_id_password}" name="password" autocomplete="current-password" class="form-control" placeholder="{$lang.password}" required>
        <label class="form-label-placeholder" for="password_{$unique_id_password}">{$lang.password}</label>
    </div>

    {if $enableFeatures.logincaptcha =='on'}
        <div class="form-group">
            <label for="captcha">{$lang.captcha}</label>
            <br>
            <small>{$lang.typethecharacters}</small>
            <div class="d-flex flex-row justify-content-start align-items-center">
                <img class="capcha" style="width: 120px; height: 60px;" onclick="return singup_image_reload();" src="?cmd=root&action=captcha#{$timestamp}" alt="Image" />
                <input type="text" placeholder="{$lang.captcha}" id="captcha" name="captcha" class="form-control" autocomplete="off" required>
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
        <span class="text-small">
            <a href="{$ca_url}root&amp;action=passreminder">{$lang.passreminder}</a>
            <br />
            <a href="{$ca_url}signup/">{$lang.createaccount}</a>
        </span>
        <button class="btn btn-primary btn-lg w-50" type="submit">{$lang.submit}</button>
    </div>
    <input type="hidden" name="action" value="login"/>
    {securitytoken}
</form>