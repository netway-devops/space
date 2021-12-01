{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'resetpasswordcustom.tpl.php');

{/php}

<div class="container-box">
    <div>
        <div id="infos" style="margin-bottom: 431px;">
            <div class="notifications alert alert-info" style="display:block">
                <button type="button" class="close" data-dismiss="alert">×</button>
                <span>Your new password was sent to the email you provided. Please check your mailbox.</span>
            </div>
        </div>
    
    </div>
</div>
