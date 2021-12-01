<div class="form-horizontal"> 
    <div class="control-group">
        <label class="control-label" for="inputEmail">{$lang.email}</label>
        <div class="controls">
            <input type="text" name="username" id="inputEmail" placeholder="{$lang.email}" value="{$submit.username}">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="inputPassword">{$lang.password}</label>
        <div class="controls">
            <input type="password" name="password" id="inputPassword" placeholder="{$lang.password}">
        </div>
    </div>
    {if $enableFeatures.logincaptcha =='on'}
        <div class="control-group">
            <label class="control-label" for="inputImage">{$lang.captcha}</label>


            <div class="controls">
                <p>
                    <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" id="logincaptcha"/> 
                </p>
                <p>
                    <input type="text" name="captcha" id="inputImage" />
                    <a href="#" onclick="return singup_image_reload2();" >{$lang.refresh}</a>
                </p>
            </div>
        </div>

    {/if}
    <div class="control-group">
        <div class="control-label">
            <div>
                <a href="index.php?/root&action=passreminder" class="list_item" target="_blank">{$lang.passreminder}</a>
            </div>
            <div>
                <a href="index.php?/signup/" id="signup" class="list_item">{$lang.createaccount}</a>
            </div>
        </div>
        <div class="controls">
                <button type="submit"  name="loginbtn" class="btn">{$lang.login}</button>
        </div>
    </div>
    <input type="hidden" name="action" value="login"/>
</div>

{literal}
    <script type="text/javascript">
    $('#signup').on('click', function (e) {
        e.preventDefault();
        $('#orderform').find('li.t1').click();
    });


    function singup_image_reload2() {
        var d = new Date();
        $('#logincaptcha').attr('src', '?cmd=root&action=captcha#' + d.getTime());
        return false;
    }
    </script>

{/literal}