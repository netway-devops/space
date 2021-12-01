<div class="control-group" {if $act == 'clone_record'}style="display: none"{/if}>
    <label class="control-label"><b>{$lang.zonecontents}</b></label>
    <div class="controls">
        {if $act == 'add_domain'}
            <div class="dns-form-check">
                <input type="radio" name="postaction" value="none" id="import-none" checked/>
                <label for="import-none" title="{$lang.afteraddingzone|escape}">
                    {$lang.iwillentriesmanually}
                </label>
            </div>
        {/if}
        <div class="dns-form-check">
            <input type="radio" name="postaction" value="import-file" id="import-file"/>
            <label for="import-file">
                {$lang.importrecordsfromzonefile}
            </label>
        </div>
        <div class="dns-form-check">
            <input type="radio" name="postaction" value="import-axfr" id="import-axfr"/>
            <label for="import-axfr">
                {$lang.importrecordsfromaxfr}
            </label>
        </div>
        {if $user_domains}
            <div class="dns-form-check">
                <input type="radio" name="postaction" value="clone" id="import-clone"
                       {if $act == 'clone_record'}checked{/if} />
                <label for="import-clone" title="{$lang.newdomainzoneclone}">
                    {$lang.cloneentriesfromotherdomain}
                </label>
            </div>
        {/if}
        {if $dns_templates}
            <div class="dns-form-check">
                <input type="radio" name="postaction" value="premade" id="import-template"/>
                <label for="import-template" title="{$lang.usepremadednstemplatetooltip}">
                    {$lang.usepremadetemplate}
                </label>
            </div>
        {/if}
    </div>
</div>
<div id="import-options">
    <div class="sh_option" id="option-import-axfr" style="display:none">
        <div class="control-group">
            <label class="control-label"><b>{$lang.dnsnameserverip}</b></label>
            <div class="controls">
                <input type="text" name="axfr-server" value="" id="axfr-server" required
                       placeholder="{$lang.ipaddress}"/>
                <a class="btn" id="axfr-verify" data-url="{$service_url}&act=axfr_verify">{$lang.dns_axfr_verify}</a>
            </div>
        </div>
        <div id="axfr-result"></div>
        <div class="alert alert-warning">
            {$lang.dns_axfrnameserver_warn|sprintf:$local_ip}
        </div>
    </div>
    <div class="sh_option" id="option-import-file" style="display:none">
        <div class="control-group">
            <label class="control-label"><b>{$lang.dns_standardzonefile}</b></label>
            <div class="controls">
                <textarea name="zone-file" class="zone-file-input"
                          placeholder="$ORIGIN example.com&#10;$TTL 3600&#10;..." required></textarea>
            </div>
        </div>
    </div>
    {if $user_domains}
        <div class="sh_option" id="option-clone" style="display:none">
            <div class="control-group">
                <label class="control-label"><b>{$lang.clone_zone}</b></label>
                <div class="controls">
                    <select name="clone">
                        {foreach from=$user_domains item=domain}
                            <option value="{$domain.$domain_indent}">{$domain.domain}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="controls">
                    <div class="dns-form-check">
                        <input type="checkbox" name="clonenames" id="clonenames" value="1" cchecked/>
                        <label for="clonenames">{$lang.replacerecordcontent}
                            <a class="vtip_description" title="{$lang.clonedzonecontdescr}"
                               class="vtip_description"></a>
                        </label>
                    </div>
                </div>
            </div>
        </div>
    {/if}
    {if $dns_templates}
        <div class="sh_option" id="option-premade" style="display:none">
            <div class="control-group">
                <label class="control-label"><b>{$lang.dnstemplate}</b></label>
                <div class="controls">
                    <select name="dns_template" style="width: 180px;" id="dns-template">
                        {foreach from=$dns_templates item=template key=name}
                            <option value="{$template[0].id}">{$template[0].template}</option>
                        {/foreach}
                    </select>
                    <a href="#" class="btn btn-default btn-small"
                       id="dns-template-preview-btn">{$lang.preview}</a>
                </div>
            </div>
        </div>
        <div id="dns-template-preview" style="display:none">
            {foreach from=$dns_templates item=template key=tid name=floop}
                <div class="dns_id" id="dns_id_{$template[0].id}" style="display:none;">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%"
                           class="styled table table-striped table-condensed">
                        <thead>
                            <tr>
                                <th>{$lang.name}</th>
                                <th>TTL</th>
                                <th>{$lang.priority}</th>
                                <th>{$lang.type}</th>
                                <th>{$lang.content}</th>
                            </tr>
                        </thead>

                        <tbody>
                            {foreach from=$template item=record}
                                <tr>
                                    <td>{$record.name}</td>
                                    <td>{$record.ttl}</td>
                                    <td>{$record.priority}</td>
                                    <td>{$record.type}</td>
                                    <td>{$record.content}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            {/foreach}
        </div>
    {/if}
</div>
{literal}
    <script type="text/javascript">
        $(function () {
            var template = $('#dns-template'),
                templateBtn = $('#dns-template-preview-btn'),
                templatePreview = $('#dns-template-preview'),
                axfrVerify = $('#axfr-verify'),
                axfrResult = $('#axfr-result');

            template.on('change', function () {
                $('.dns_id').hide();
                $('#dns_id_' + template.val()).show();
            });

            templateBtn.on('click', function () {
                templateBtn.toggleClass('active')
                templatePreview.toggle(templateBtn.is('.active'));
                template.trigger('change');
                return false
            });

            axfrVerify.on('click', function () {
                var data = axfrVerify.closest('form').serializeArray();

                axfrVerify.closest('.wbox_content').addLoader();
                $.post(axfrVerify.data('url'), data, function (resp) {
                    $('#preloader').remove();
                    axfrResult.html('<div class="alert alert-'
                        + (resp.success ? 'success' : 'danger')
                        + '">' + resp.msg + '</div>')
                })
            });

            var contentOptions = $('.dns-form-check input[type=radio]');

            contentOptions.on('click', function () {
                var self = $(this);
                $('.sh_option').hide().find('input, textarea').prop('disabled', true);
                $('#option-' + self.val()).show().find('input, textarea').prop('disabled', false);

                if (self.val() !== 'premade' && templateBtn.is('.active')) {
                    templateBtn.trigger('click')
                }
            });

            var checkedCtOpt = contentOptions.filter('[checked]');
            if (!checkedCtOpt.length) {
                checkedCtOpt = contentOptions.eq(0);
                checkedCtOpt.prop('checked', true);
            }
            checkedCtOpt.trigger('click');

            if (typeof $.fn.tooltip === 'function') {
                $('.dns-form-check label[title]').tooltip()
            }

            template.trigger('change');
        })

    </script>
{/literal}