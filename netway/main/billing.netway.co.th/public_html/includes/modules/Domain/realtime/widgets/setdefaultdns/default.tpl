<div class="wbox">
    <div class="wbox_header">{$lang.realtime_set_template}</div>
    <div  class="wbox_content">
        <form action="" method="post" onclick="return confirm('{$lang.realtime_set_template_confirm}');">
            <input type="submit" value="{$lang.realtime_set_template}" class="btn btn-primary"/>
            {if $dns_has_been_set}
                <div class="alert alert-success" style="margin-top: 20px;" role="alert">{$lang.realtime_dns_template_has_been_set}</div>
            {/if}
            <p style="margin-top: 20px;">{$lang.realtime_set_dns_template}</p>
            {securitytoken}
            <input type="hidden" name="save" value="1">
        </form>
    </div>
</div>