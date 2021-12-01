<div class="wbox">
    <div class="wbox_header">{assign var=widg_name value="`$widget.name`_widget"}{if $lang[$widg_name]}{$lang[$widg_name]}{elseif $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
    <div  class="wbox_content">

        {if $no_field}
            <p>{$lang.op_no_field}</p>
        {elseif $se_status == 'disabled' && (!$spam_expert || !$spam_expert.isActive)}
            <p>{$lang.op_no_service}</p>
            <a href="?cmd=openrovider&action=add_field&id={$service_id}" target="_blank">{$lang.uppckg}</a>
        {/if}
        {if $spam_expert}
            <h3>{$lang.se_details}</h3>
            <table class="table table-aff-center" border="0">
                <tbody>
                <tr>
                    <td style="width: 35%;"><label>{$lang.status}</label></td>
                    <td>
                        {if $spam_expert.isActive}
                            <span class="label label-success badge badge-pill badge-success">{$lang.Active}</span>
                        {else}
                            <span class="label label-warning badge badge-pill badge-warning">{$lang.se_inactive}</span>
                        {/if}
                    </td>
                </tr>
                {if $spam_expert.expirationDate}
                    <tr>
                        <td style="width: 35%;"><label>{$lang.se_expiration_date}</label></td>
                        <td>{$spam_expert.expirationDate|dateformat:$date_format}</td>
                    </tr>
                {/if}
                {if $spam_expert.userEmail}
                    <tr>
                        <td style="width: 35%;"><label>{$lang.se_user_email}</label></td>
                        <td>{$spam_expert.userEmail}</td>
                    </tr>
                {/if}
                {if $spam_expert.userPassword}
                    <tr>
                        <td style="width: 35%;"><label>{$lang.se_user_password}</label></td>
                        <td><span onclick="show_password(this);" style="cursor: pointer; color: red;">{$lang.se_show_password}</span><span style="display: none;">{$spam_expert.userPassword}</span></td>
                    </tr>
                {/if}
                {if $spam_expert.smtpPassword}
                    <tr>
                        <td style="width: 35%;"><label>{$lang.se_smtp_password}</label></td>
                        <td><span onclick="show_password(this);" style="cursor: pointer; color: red;">{$lang.se_show_password}</span><span style="display: none;">{$spam_expert.smtpPassword}</span></td>
                    </tr>
                {/if}
                </tbody>
            </table>
            <div class="content">
                <form action="{$widget_url}&do=recreate" method="post">
                    <div class="row">
                        <div class="col-md-9">
                            <div class="form-group">
                                <label>{$lang.se_mail_server}</label>
                                <input type="text" name="hostname" value="{$spam_expert.hostname}" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label>{$lang.se_port}</label>
                            <input type="number" min="1" name="port" value="{$spam_expert.port}" class="form-control">
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-sm-12">
                            <span class="badge badge-{if $spam_expert.products.incoming}success{else}danger{/if} label label-{if $spam_expert.products.incoming}success{else}danger{/if}">{$lang.se_incoming}</span>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-sm-12">
                            <span class="badge badge-{if $spam_expert.products.outgoing}success{else}danger{/if} label label-{if $spam_expert.products.outgoing}success{else}danger{/if}">{$lang.se_outgoing}</span>
                        </div>
                    </div>
                    {securitytoken}
                    <div class="row">
                        <div class="col-sm-12 text-left">
                            <button type="submit" name="edit" value="1" class="btn btn btn-primary">{$lang.se_edit}</button>
                            <a href="{$widget_url}&do=sso" target="_blank" class="btn btn btn-primary">{$lang.se_sso}</a>
                        </div>
                    </div>
                </form>
            </div>
        {/if}
    </div>
</div>
{literal}
    <script>
        $(function () {
            check_archiving();
            $('.se_check').on('change', function () {
                check_archiving();
            });

            function check_archiving() {
                var disable = true;
                $('.se_check').each(function () {
                    if ($(this).prop('checked'))
                        disable = false;
                });
                $('.se_archiving').prop('disabled', disable);
            }
        });
        function show_password(self) {
            $(self).hide().next().show();
        }
    </script>
{/literal}