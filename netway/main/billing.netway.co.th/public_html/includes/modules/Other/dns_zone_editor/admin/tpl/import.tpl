<form action="" method="post">
    <input type="hidden" name="zone_id" value="{$zone_id}" />
    <input type="hidden" name="domain" value="{$zone_name}" />
    <input type="hidden" name="server_id" value="{$server_id}" />

    {include file="tpl/import_options.tpl"}

    <button type="submit" name="submit" value="true" class="btn btn-success">{$lang.submit}</button>

    <a class="button"
       href="?cmd={$modulename}&action=show&zone_id={$params.domain_id}&server_id={$params.server_id}&security_token={$security_token}">
        Cancel
    </a>
    {securitytoken}

</form>
{literal}
    <script type="text/javascript">
        $(function () {
            var axfrVerify = $('#axfr-verify'),
                axfrResult = $('#axfr-result');

            axfrVerify.on('click', function () {
                var data = axfrVerify.closest('form').serializeArray();

                axfrVerify.closest('form').addLoader();
                $.post(axfrVerify.data('url'), data, function (resp) {
                    $('#preloader').remove();
                    axfrResult.html('<div class="alert alert-'
                        + (resp.success ? 'success' : 'danger')
                        + '">' + resp.msg + '</div>')
                })
            });

            var contentOptions = $('.dns-import-option input[type=radio]');

            contentOptions.on('click', function () {
                var self = $(this);
                $('.sh_option').hide().find('input, textarea').prop('disabled', true);
                $('#option-' + self.val()).show().find('input, textarea').prop('disabled', false);
            });

            var checkedCtOpt = contentOptions.filter('[checked]');
            if (!checkedCtOpt.length) {
                checkedCtOpt = contentOptions.eq(0);
                checkedCtOpt.prop('checked', true);
            }
            checkedCtOpt.trigger('click');
        })

    </script>
{/literal}