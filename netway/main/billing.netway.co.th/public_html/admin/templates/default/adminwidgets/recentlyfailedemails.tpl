<style>
    .nav>li>a {ldelim}
        padding: 5px 15px;
        text-decoration: none;
    {rdelim}
</style>
<div class="content">
    <ul class="nav nav-tabs" style="margin-left: 15px;">
        <li role="presentation" class="recently_email_tab active"><a href="#" onclick="change_tab(this, 'emails'); return false;">Emails</a></li>
        <li role="presentation" class="recently_email_tab"><a href="#" onclick="change_tab(this, 'notifications'); return false;">Notifications</a></li>
    </ul>
</div>
<table cellspacing="0" cellpadding="3" border="0" width="100%" class="recently_table recently_emails table table-fixed whitetable" style="">
    <tbody>
    <tr>
        <th>Subject</th>
        <th>Send to</th>
        <th>Date</th>
        <th width="40">Status</th>
        <th width="60"></th>
    </tr>

    {if $unsentemails}
        {foreach from=$unsentemails item=email name=loop}
            <tr class="{if $smarty.foreach.loop.index%2==0}even{else}odd{/if}">
                <td><a href="?cmd=emails&action=show&id={$email.id}" target="_blank">{$email.subject}</a></td>
                <td title="{$email.email}" style="cursor: pointer;">{if $email.client_id == 0}{$email.email|truncate}
                    {else}{$email|@profilelink}{/if} {if $email.others} and {$email.others|truncate:30:'...':true}{/if}</td>
                <td>{$email.date|dateformat}</td>
                <td>{if $email.status}<span class="Successfull">{$lang.Sent}</span>{else}<span class="Failure">{$lang.Failed}</span>{/if}</td>
                <td><a href="javascript:void(0)" onclick="resend({$email.id}, '{$email.flag}')" class="editbtn">{$lang.resend}</a></td>
            </tr>
        {/foreach}
    {else}
        <tr class="odd">
            <td colspan="4" style="text-align: center;"><span>Nothing found</span></td>
        </tr>
    {/if}
    </tbody>
</table>
<table cellspacing="0" cellpadding="3" border="0" width="100%" class="recently_table recently_notifications table table-fixed whitetable" style="display: none;">
    <tbody>
    <tr>
        <th>Subject</th>
        <th>Send to</th>
        <th>Date</th>
        <th width="40">Status</th>
        <th width="60"></th>
    </tr>


    {if $unsentnotifications}
        {foreach from=$unsentnotifications item=notification name=loop2}
            <tr class="{if $smarty.foreach.loop2.index%2==0}even{else}odd{/if}">
                <td><a href="?cmd=emails&action=show&id={$notification.id}" target="_blank">{$notification.subject}</a></td>
                <td title="{$notification.email}" style="cursor: pointer;">{if $notification.client_id == 0}{$notification.email|truncate}
                    {else}{$notification|@profilelink}{/if} {if $notification.others} and {$notification.others|truncate:30:'...':true}{/if}</td>
                <td>{$notification.date|dateformat}</td>
                <td>{if $email.status}<span class="Successfull">{$lang.Sent}</span>{else}<span class="Failure">{$lang.Failed}</span>{/if}</td>
                <td><a href="javascript:void(0)" onclick="resend({$notification.id}, '{$notification.flag}')" class="editbtn">{$lang.resend}</a></td>
            </tr>
        {/foreach}
    {else}
        <tr class="odd">
            <td colspan="4" style="text-align: center;"><span>Nothing found</span></td>
        </tr>
    {/if}
    </tbody>
</table>
{literal}
    <script>
        function change_tab(self, type) {
            $('.recently_email_tab').removeClass('active');
            $('.recently_table').hide();
            $('.recently_' + type).show();
            $(self).parent().addClass('active');
        }

        function resend(mail_id, flag = 'email') {
            var url = '?cmd=emails&action=resend';
            if (flag !== 'email')
                url += '_' + flag;
            $.post(url, {
                selected: mail_id
            }, function (data) {
                var resp = parse_response(data);

            });
        }
    </script>
{/literal}