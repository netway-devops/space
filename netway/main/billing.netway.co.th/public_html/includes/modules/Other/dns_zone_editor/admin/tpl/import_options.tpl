<div class="form-group">
    <label>
        {$lang.zonecontents}
    </label>
    {if $section == 'addZone'}
        <div class="radio dns-import-option">
            <label for="import-none">
                <input type="radio" checked="checked" name="postaction" value="none" id="import-none">
                {$lang.iwillentriesmanually}
                <a class="vtip_description" title="{$lang.afteraddingzone}"></a>
            </label>
        </div>
    {/if}
    <div class="radio dns-import-option">
        <label for="import-file">
            <input type="radio" name="postaction" value="import-file" id="import-file"/>
            Import records from zone file
        </label>
    </div>
    <div class="radio dns-import-option">
        <label for="import-axfr">
            <input type="radio" name="postaction" value="import-axfr" id="import-axfr"/>
            Import records from a name server (AXFR)
        </label>
    </div>
    {if $domains}
        <div class="radio dns-import-option">
            <label for="import-clone">
                <input type="radio" name="postaction" value="clone" id="import-clone">
                {$lang.cloneentriesfromotherdomain}
                <a title="{$lang.newdomainzoneclone}" class="vtip_description"></a>
            </label>
        </div>
    {/if}
    {if $dns_templates}
        <div class="radio dns-import-option">
            <label for="import-template">
                <input type="radio" name="postaction" value="premade" id="import-template">
                {$lang.usepremadetemplate}
                <a title="{$lang.usepremadednstemplatetooltip}" class="vtip_description"></a>
            </label>
        </div>
    {/if}
</div>
<div id="import-options">
    <div class="sh_option" id="option-import-axfr" style="display:none">
        <div class="form-group ">
            <label>Nameserver IP</label>
            <div class="input-group col-md-4">
                <input type="text" name="axfr-server" value="" id="axfr-server" class="form-control"
                       required
                       placeholder="IP Address"/>
                <div class="input-group-btn">
                    <a class="btn btn-primary" id="axfr-verify"
                       data-url="?cmd={$modulename}&action=verifyaxfr&security_token={$security_token}">Verify</a>
                </div>
            </div>

        </div>
        <div id="axfr-result"></div>
        <div class="alert alert-warning">
            Specified nameserver has to allow zone transfer for IP {$local_ip}
            otherwise AXFR import will not work properly.
        </div>
    </div>
    <div class="sh_option" id="option-import-file" style="display:none">
        <div class="form-group">
            <label>Standard Zone File</label>
            <textarea name="zone-file" class="zone-file-input form-control"
                      placeholder="$ORIGIN example.com&#10;$TTL 3600&#10;..." required></textarea>
        </div>
    </div>
    {if $domains}
        <div id="option-clone" class="sh_option" style="display: none">
            <div class="form-group">
                <label>{$lang.clone_zone}</label>

                <select name="clone" class="form-control">
                    {foreach from=$domains item=domain key=id}
                        <option value="{$id}">{$domain}</option>
                    {/foreach}
                </select>

                <div class="checkbox">
                    <label for="clonenames">
                        <input type="checkbox" name="clonenames" id="clonenames" value="1" checked="checked">
                        {$lang.replacerecordcontent}
                        <a class="vtip_description" title="{$lang.clonedzonecontdescr}" ></a>
                    </label>
                </div>

            </div>

        </div>
    {/if}

    {if $dns_templates}
        <div id="option-premade" class="sh_option form-group" style="display: none">
            <label>{$lang.dnstemplate}</label>

            <div class="row">
                <div class="col-md-5">
                    <select name="dns_template" class="form-control" id="dns-template">
                        {foreach from=$dns_templates item=template key=id}
                            <option value="{$template[0].template_id}">
                                {$template[0].product_name} : {$template[0].template}
                            </option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-1">
                    <a id="dns-template-preview-btn" href="#" class="btn btn-default">{$lang.preview|ucfirst}</a>
                </div>
            </div>
        </div>

        <div id="dns-template-preview" class="form-group" style="display: none">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th class="col-sm-2">{$lang.Name}</th>
                            <th class="col-sm-2">TTL</th>
                            <th class="col-sm-1">{$lang.priority}</th>
                            <th class="col-sm-1">{$lang.Type}</th>
                            <th class="col-sm-4">{$lang.Content}</th>
                        </tr>
                    </thead>
                    {foreach from=$dns_templates item=template key=id}
                        <tbody  class="dns_id" id="dns_id_{$id}">
                            {foreach from=$template item=value}
                                <tr>
                                    <td>{$value.name}</td>
                                    <td>{$value.ttl}</td>
                                    <td>{$value.prio}</td>
                                    <td>{$value.type}</td>
                                    <td>{$value.content}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    {/foreach}
                </table>
            </div>
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

                axfrVerify.closest('form').addLoader();
                $.post(axfrVerify.data('url'), data, function (resp) {
                    $('#preloader').remove();
                    axfrResult.html('<div class="alert alert-'
                        + (resp.success ? 'success' : 'danger')
                        + '">' + resp.msg + '</div>')
                })
            });

            var contentOptions = $('.dns-import-option input[type=radio]');

            contentOptions.on('click', function (e) {
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