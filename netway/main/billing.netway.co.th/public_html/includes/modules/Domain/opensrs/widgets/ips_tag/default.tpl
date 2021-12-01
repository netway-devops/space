<div class="wbox">
    <div class="wbox_header">{$lang.set_ips_tag_title}</div>
    <div  class="wbox_content">
        <form action="" method="post">
            <div class="form-group">
                <label>{$lang.new_ips_tag}</label>
                <input type="text" name="tag" class="form-control">
            </div>
            <input type="submit" value="{$lang.set_ips_tag}" onclick="return confirm('{$lang.set_ips_confirm}');" class="btn btn-primary"/>
            {securitytoken}
            <input type="hidden" name="save" value="1">
        </form>
    </div>
</div>