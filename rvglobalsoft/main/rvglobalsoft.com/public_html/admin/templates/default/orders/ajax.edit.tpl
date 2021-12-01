{if $available_recipients}
    <td style="vertical-align: text-top;">{$lang.Notifications}</td>
    <td>
        {if $details.client_id}
            <div>
                <input type="checkbox" class="override" value="1" name="override_recipients" {if $details.metadata.recipients}checked="checked"{/if}/>
                <a href="#" class="override">{$lang.override_recipients}</a>
                <button type="button" id="send-notification" class="btn btn-default btn-sm"> {$lang.send_notification}</button>
            </div>
            {if $details.metadata.recipients}
                <div id="recipients-list" style="margin: 5px">
                    {foreach from=$details.metadata.recipients item=recipient}
                        <div>
                            <a href="?cmd=clients&action=show&id={$draft.client_id}">
                                {$recipient|client:'#%id - %name'}
                            </a>
                        </div>
                    {/foreach}
                </div>
            {/if}
        {/if}
    </td>
    <td>
    </td>
    <td>
        <div id="overriderecipients" class="modal-content" hidden bootbox data-title="{$lang.override_recipients}" data-btntitle="{$lang.Confirm}">
            <div>
                <form id="override-form" action="" method="post">
                    <div class="form-group">
                        <label class="control-label">{$lang.recipients}</label>
                        <select name="recipients[]" class="form-control chosen" multiple>
                            {foreach from=$available_recipients item=recipient}
                                <option value="{$recipient.id}" {if in_array($recipient.id, $details.metadata.recipients)}selected{/if}>
                                    {$recipient|@client:'#%id %firstname %lastname %companyname %email'}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                    {securitytoken}
                </form>
            </div>
        </div>
        {literal}
            <script>
                var overriderecipients = $('#overriderecipients'),
                    checkbox = $('input[name="override_recipients"]'),
                    recipients = $('#recipients-list');
                $('.override').on('click', function () {
                    if ($(this).is('a')) {
                        checkbox.prop('checked', true);
                        overriderecipients.trigger('show');
                    } else if (checkbox.prop('checked')){
                        overriderecipients.trigger('show');
                    }
                    if (checkbox.prop('checked'))
                        recipients.slideDown(); else recipients.slideUp();
                });
                $('#send-notification').on('click', function () {
                    if (confirm('{/literal}{$lang.areyousure}{literal}')) {
                        var data = [];
                        if (checkbox.prop('checked'))
                            data = $('select[name^=recipients]').val();
                        $.post('?cmd=orders&action=edit&make=send_notification&id=' + {/literal}{$details.id}{literal}, {recipients: data}, function (resp) {
                            parse_response(resp);
                        });
                        return false;
                    }
                });
                overriderecipients.bootboxform({
                    callback: function (e) {
                        var div = $('.div-recipients'),
                            data = [];

                        var opt = $('select[name^=recipients]',this).children(':selected').detach();
                        opt.each(function (k, v) {
                            data.push($(v).val());
                        });

                        div.addLoader();
                        $.post('?cmd=orders&action=edit&make=override_recipients&id=' + {/literal}{$details.id}{literal}, {
                            recipients: data
                        }, function (resp) {
                            resp = parse_response(resp);
                            div.html(resp);
                        });
                    }
                }).on('bootbox-form.shown', function (e, dialog) {
                    if (checkbox.prop('checked'))
                        recipients.slideDown(); else recipients.slideUp();
                    dialog.find('input, select, textarea').on('input',function () {
                        $(this).closest('.form-group').toggleClass('has-error', this.value.length === 0)
                    });
                    dialog.find('select').chosenedge({width: '100%'});
                });
            </script>
        {/literal}
    </td>
{/if}