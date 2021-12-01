<div class="form-group">
    <label>From Name</label>

    <div class="radio">
        <label>
            <input type="radio" value="1" name="from-name" class="from-name"
                   {if !$submit.sendername}checked{/if}>
            Use Company Name and Department name for notifications
        </label>
    </div>
    <div class="radio">
        <label>
            <input type="radio" value="0" name="from-name" class="from-name"
                   {if $submit.sendername}checked{/if}>
            Custom name:
        </label>
    </div>
    <div class="form-group">
        <input type="text" name="sendername" value="{$submit.sendername}" class="form-control">
    </div>

</div>
<div class="form-group">
    <label>Email notifications</label>
    <select name="sendmethod" id="sendmethod" class="form-control">
        {foreach from=$sendmail_methods item=method}
            <option value="{$method.value}"
                    {if $submit.sendmethod==$method.value}selected{/if}>{$method.label}</option>
        {/foreach}
    </select>
</div>
<div class="form-group sendmailem"
     {if $submit.sendmethod=='1' || !$submit.sendmethod}style="display:none"{/if}>
    <label>{$lang.senderemail}</label>
    <input type="text" value="{$submit.senderemail}" size="50" name="senderemail"
           id="senderemail" class="form-control"/>
</div>
<div class="form-group sendmailform"
     {if $submit.sendmethod!='1' && $submit.sendmethod}style="display:none"{/if}>
    <a href="?cmd=configuration&picked_tab=4">{$lang.hbemailconf}</a>
</div>
<div class="form-group sendmailform" {if $submit.sendmethod!='2'}style="display:none"{/if}>
    <a class="btn btn-default btn-show-test" href="#">{$lang.sendtestmail}</a>
</div>

<div class="sendmailform" {if $submit.sendmethod!='3'}style="display:none"{/if}>
    <div class="smtpform clearfix row">
        <div class="form-group col-md-6">
            <label for="smtp_email">SMTP Email</label>
            <input type="text" id="smtp_email" value="{$submit.smtpemail}" name="smtpemail"
                   class="form-control search-fake"/>
        </div>
        <div class="form-group col-md-6">
            <label for="smtp_host">SMTP {$lang.Hostname}</label>
            <input type="text" id="smtp_host" value="{$submit.smtphost}" name="smtphost"
                   class="form-control search-fake"/>
        </div>
        <div class="form-group col-md-6">
            <label for="smtp_login">SMTP {$lang.loginname}</label>
            <input type="text" id="smtp_login" value="{$submit.smtplogin}" name="smtplogin"
                   class="form-control search-fake"/>
        </div>
        <div class="form-group col-md-6">
            <label for="smtp_pass">SMTP {$lang.Password}</label>
            <input type="password" id="smtp_pass" value="{$submit.smtppassword}" name="smtppassword"
                   autocomplete="off" class="form-control search-fake"/>
        </div>
        <div class="form-group col-md-6">
            <label for="smtp_port">SMTP {$lang.Port|capitalize}
                <a class="vtip_description"
                   title="Default ports:<br>&nbsp; 25 - SMTP<br>&nbsp; 465 - SMTP SSL<br>&nbsp; 587 - SMTP TLS"></a></label>
            <input type="text" id="smtp_port" value="{$submit.smtpport}" name="smtpport"
                   class="form-control search-fake"/>
        </div>
    </div>
    <div class="form-group">
        <a class="btn btn-default btn-show-test" href="#">
            {$lang.sendtestmail}
        </a>
    </div>

</div>
<div class="form-group sendmailform" {if $submit.sendmethod!='4'}style="display:none"{/if}>
    <a class="btn btn-default btn-show-test" href="#">{$lang.sendtestmail}</a>
</div>

<div style="display:none" id="email-testing"
     data-title="{$lang.sendtestmail}"
     data-btntitle="{$lang.Send}">
    <div class="form-group">
        <label>{$lang.enteremail}</label>
        <input type="text" name="address" class="form-control"/>
    </div>
    <div  id="send-test-result"></div>
</div>

<hr />
<div class="form-group">
    <label>Mobile notifications</label>

    {foreach from=$notify_methods item=method}
        <div class="checkbox">
            <label>
                <input type="checkbox" value="{$method.id}" name="notify[]"
                        {if $method.selected}checked{/if} />
                    {$method.modname}
            </label>
        </div>
    {/foreach}

</div>

{literal}
    <script type="text/javascript">
        $(function () {
            var email_method = $("#sendmethod");
            $(".sendmailform .btn-show-test").on('click', function () {
                var self = $(this).closest('.sendmailform'),
                    data = self.find('input, select, textarea').serializeForm(),
                    tpl = $('#email-testing');

                data.method = email_method.val();
                data.email = $('#senderemail').val();

                var dialog = bootbox.dialog({
                    message: tpl.html(),
                    title: tpl.data('title'),
                    backdrop: true,
                    onEscape: true,

                    buttons: {
                        close: {
                            label: "Close",
                            className: "btn-default",
                        },
                        success: {
                            label: tpl.data('btntitle'),
                            className: "btn-success",
                            callback: function (e) {
                                var result = dialog.find('#send-test-result');
                                data.address = dialog.find('input').val();

                                result.html('<div class="text-center"><img src="ajax-loading.gif" /></div>');
                                $.ajax('?cmd=ticketdepts&action=test_email', {
                                    data: data,
                                    type: 'post',
                                    error: function (xhr, status, error) {
                                        result.html(xhr.status + ' ' + error);
                                    },
                                    success: function (data) {
                                        if (!data || !data.length)
                                            return throwError(general_msg);
                                        result.html(parse_response(data));
                                    },
                                });
                                return false;
                            }
                        },
                    }
                });

                return false;
            });

            email_method.on('change', function () {
                $('.sendmailform').hide().eq(this.selectedIndex).show();
                $('.sendmailem').toggle($(this).val() > 1);
            }).trigger('change');

        });
    </script>
{/literal}