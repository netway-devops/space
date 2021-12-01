{literal}
    <script>
        function change_tab(link) {
            $('.nav_sel.nav_sel').attr('href',link);
            $.post(link, {}, function (result) {
                $('.quicklist_logs').html(result);
            });
        }
    </script>
{/literal}
<div class="clearfix" style="padding-bottom: 5px;">
    <div class="col-sm-12">
        <div class="row">
            <div class="pull-right">
                {if $active == 'emails'}
                    {include file='ajax.filterquicktool.tpl' client_id=$client_id loadid='emailslist' href="?cmd=emails&action=getadvanced"}
                    <a href="?cmd=sendmessage&type=clients&selected={$client_id}" class="btn btn-primary btn-xs" target="_blank"><i class="fa fa-envelope-o"></i> {$lang.SendEmail}</a>
                {elseif $active == 'portal_notifications'}
                    {include file='ajax.filterquicktool.tpl' client_id=$client_id loadid='portal_notifications' href="?cmd=portal_notifications&action=getadvanced"}
                    <a href="?cmd=sendmessage&action=asnotification&type=clients&selected={$client_id}" class="btn btn-primary btn-xs" target="_blank"><i class="fa fa-envelope-o"></i> {$lang.SendNotification}</a>
                {elseif $active == 'clientactivity'}
                    {include file='ajax.filterquicktool.tpl' client_id=$client_id loadid='clientactivity' href="?cmd=clientactivity&action=getadvanced"}
                {/if}
            </div>
            <ul class="nav nav-tabs">
                <li {if $active == 'emails'} class="active" {/if}>
                    <a class="quick-list-subitem" href="#" style="padding: 5px 15px; text-decoration: none; border-radius: 3px 3px 0 0;" onclick="change_tab('?cmd=emails&action=clientemails&id={$client_id}');">Emails Sent</a>
                </li>
                {if 'config:EnablePortalNotifications:on'|checkcondition}
                    <li {if $active == 'portal_notifications'} class="active" {/if}>
                        <a class="quick-list-subitem" href="#" style="padding: 5px 15px; text-decoration: none; border-radius: 3px 3px 0 0;" onclick="change_tab('?cmd=portal_notifications&action=clientnotifications&id={$client_id}');">Notifications</a>
                    </li>
                {/if}
                <li {if $active == 'clientactivity'} class="active" {/if}>
                    <a class="quick-list-subitem" href="#" style="padding: 5px 15px; text-decoration: none; border-radius: 3px 3px 0 0;" onclick="change_tab('?cmd=clientactivity&action=cactivity&id={$client_id}');">Activity</a>
                </li>
            </ul>
        </div>
    </div>
</div>