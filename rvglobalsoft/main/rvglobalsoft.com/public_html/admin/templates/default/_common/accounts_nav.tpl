<table border="0" cellpadding="2" cellspacing="0">
    <tr>
        <td>
            <a href="?cmd=accounts&list={$currentlist}"><strong>&laquo; {$lang.backto} {$lang.accounts}</strong></a>&nbsp;
        </td>
        <td class="menubar">
        	{if isset($admindata.access.editAccounts)}
            <a class="menuitm" href="#" onclick="$('#formsubmiter').click();
                    return false"><span><strong>{$lang.savechanges}</strong></span></a>
 			{/if}

            {if !$forbidAccess.deleteServices}
                <a class=" menuitm menu-auto" href="#" onclick="confirm1();
                        return false;"><span style="color:#FF0000">{$lang.Delete}</span>
                </a>
            {/if}
            <a class="setStatus menuitm menu-auto" id="hd1" onclick="return false;" href="#">
                <span class="morbtn">{$lang.moreactions}</span>
            </a>
            {adminwidget module="accounts" section="accountheader"}
        </td>
    </tr>
</table>

{once}
    <input type="checkbox" name="manual" value="1" class="changeMode" id="changeMode" style="display:none;"
           {if $details.manual == '1'}checked="checked" {/if} />
    <input type="submit" name="save" value="{$lang.savechanges}"
           style="font-weight:bold;display:none" id="formsubmiter"/>
    <ul id="hd1_m" class="ddmenu">
        <li><a href="AdminNotes">{$lang.editadminnotes}</a></li>
        <li><a href="OverrideSuspension">Override Suspension</a></li>
        <li><a href="SetCommitmentPeriod">{$lang.set_commitment_period}</a></li>
        <li><a href="ChangeOwner">{$lang.changeowner}</a></li>
        <li><a href="?cmd=accounts&action=clone_account&id={$details.id}&client_id={$details.client_id}" style="color: #455a64" class="directly">Clone Service</a></li>
        <li {if $details.status != 'Active' && $details.status != 'Suspended'}class="disabled"{/if}><a href="RequestCancellation">{$lang.cancelrequest}</a></li>
    </ul>
    <div id="RequestCancellation" style="display:none;" bootbox data-title="{$lang.cancelrequest}"
         data-formaction="?cmd=accounts&action=add_cancellation&id={$details.id}">
        <link media="all" rel="stylesheet" href="{$template_dir}js/timepicker/jquery.timepicker.css" />
        <script type="text/javascript" src="{$template_dir}js/timepicker/jquery.timepicker.min.js?v={$hb_version}" ></script>
        <div class="request_cancellation_modal">
            <div class="form-group">
                <label>{$lang.SubmissionDate}</label>
                <div class="no-wrap">
                    <input type="text" name="submission_date" value="{$smarty.now|dateformat:$dateformat}" class="inp haspicker" placeholder="" style="width:90px">
                    <input type="text" name="submission_time" value="{$smarty.now|date_format:"%H:%M"}" class="timepicker inp" placeholder="" style="width:45px">
                    <div class="inp-controls">
                        <a class="btn btn-default btn-xs plus"><i class="fa fa-plus"></i></a>
                        <a class="btn btn-default btn-xs minus"><i class="fa fa-minus"></i></a>
                    </div>
                </div>
            </div>
        <div class="form-group">
            <label>{$lang.canceltype}</label>
            <select name="type" class="form-control" style="min-width:180px">
                <option value="Admin submitted">{$lang.adminsubmitted}</option>
                <option value="Immediate">{$lang.Immediate}</option>
                <option value="End of billing period">{$lang.endbillingperiod}</option>
            </select>
        </div>
        <div class="form-group">
            <label>{$lang.ProcessAutomatically}</label>
                <br>
                <input type="checkbox" name="process_automatically"> {$lang.ProcessAutomaticallyInfo}
        </div>
        <div class="form-group">
                <label>{$lang.ProcessAt}</label>
                <div class="no-wrap request_at">
                    <input type="text" name="process_date" class="inp haspicker" placeholder="" style="width:90px">
                    <input type="text" name="process_time" class="timepicker inp" placeholder="" style="width:45px">
                    <div class="inp-controls">
                        <a class="btn btn-default btn-xs plus"><i class="fa fa-plus"></i></a>
                        <a class="btn btn-default btn-xs minus"><i class="fa fa-minus"></i></a>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label>{$lang.Reason}</label>
                <textarea name="reason" class="form-control" style="min-height: 60px;"></textarea>
            </div>
        </div>
        {securitytoken}
        {literal}
            <style>
                .request_cancellation_modal .inp-controls {
                    display: inline-block;
                    vertical-align: top;
                    border: 1px solid #ccc;
                    border-left: none;
                    margin-left: -5px;
                    border-radius: 0 2px 2px 0;
                }
                .request_cancellation_modal .inp-controls .btn + .btn {
                    margin-top: 0;
                }
                .request_cancellation_modal .inp-controls .btn {
                    display: block;
                    line-height: 1em;
                    height: 1em;
                    border: none;
                    padding: 1px 4px;
                    border-radius: 0 2px 2px 0;
                }
            </style>
        {/literal}
    </div>
    <div id="ChangeOwner" style="display:none;" bootbox data-title="{$lang.changeowner}"
         data-formaction="?cmd=accounts&action=edit&id={$details.id}&submit=1&changeowner=1">
        <div class="form-group">
            <label>{$lang.newowner}</label>
            <select name="new_owner_id" class="form-control" style="min-width:180px"></select>
        </div>
        {securitytoken}
    </div>
    <div id="OverrideSuspension" style="display:none;" bootbox data-title="Override Suspension"
         data-formaction="?cmd=accounts&action=edit&id={$details.id}&submit=1&overridesuspension=1"
         data-btntitle="Override"
         {if $details.autosuspend}data-active="{$details.autosuspend_date|dateformat:$date_format}"{/if} >
        <p>
            This option allows you to disable account suspension for some time or until specific
            date.
        </p>

        {if $details.autosuspend}
            <p>
                Suspension override was previously set to
                <strong>{$details.autosuspend_date|dateformat:$date_format}</strong><br/>
            </p>
        {/if}

        <div class="form-group">
            <label>Prevent automated suspension</label>
            <select class="form-control">
                <option value="3d">{$lang.for_3_days}</option>
                <option value="7d">{$lang.for_7_days}</option>
                <option value="14d">{$lang.for_14_days}</option>
                <option value="1m">{$lang.for_1_month}</option>
                <option value="c">{$lang.custom_date}</option>
            </select>
        </div>
        <div class="form-group">
            <label>{$lang.Date}</label>
            <div class="clearfix">
                <input type="text" name="date" class="form-control haspicker"/>
            </div>
        </div>
        {securitytoken}
    </div>
    <div id="SetCommitmentPeriod" style="display:none;" bootbox data-title="{$lang.set_commitment_period}"
         data-formaction="?cmd=accounts&action=edit&id={$details.id}&submit=1&setcommitmentperiod=1"
         data-btntitle="{$lang.set_period}"
         {if $details.commitment_date != '0000-00-00'}data-active="{$details.commitment_date|dateformat:$date_format}"{/if} >
        <p>
            {$lang.set_commitment_period_desc}
        </p>

        {if $details.commitment_date != '0000-00-00'}
            <p>
                {$lang.commitment_period_set_to}
                <strong>{$details.commitment_date|dateformat:$date_format}</strong><br/>
            </p>
        {/if}

        <div class="form-group">
            <label>{$lang.prevent_cancellation_request}</label>
            <select class="form-control">
                <option value="3d">{$lang.for_3_days}</option>
                <option value="7d">{$lang.for_7_days}</option>
                <option value="14d">{$lang.for_14_days}</option>
                <option value="1m">{$lang.for_1_month}</option>
                <option value="c">{$lang.custom_date}</option>
            </select>
        </div>
        <div class="form-group">
            <label>{$lang.Date}</label>
            <div class="clearfix">
                <input type="text" name="date" class="form-control haspicker"/>
            </div>
        </div>
        {securitytoken}
    </div>

    <script type="text/javascript">
        {literal}
        function autosus(el) {
            if ($(el).is(':checked')) {
                $('#autosuspend_date').show();
            } else {
                $('#autosuspend_date').hide();
            }
        }

        function confirm1() {
            $('#confirm_ord_delete').trigger('show');
            return false;
        }

        function confirmsubmit2() {
            var add = '';
            if ($('#cc_hard').is(':checked'))
                add = '&harddelete=true';
            window.location.href = '?cmd=accounts&make=delete&action=edit&id=' + $('#account_id').val() + add + '&security_token=' + $('input[name=security_token]').val();
            return false;
        }

        function cancelsubmit2() {
            $('#confirm_ord_delete').hide().parent().css('position', 'inherit');
            return false;
        }

        function new_gateway(elem) {
            if ($(elem).val() == 'new') {
                window.location = "?cmd=managemodules&action=payment";
                $(elem).val(($("select[name='" + $(elem).attr('name') + "'] option:first").val()));
            }
        }

        function checkup() {
            if (!$('.changeMode').eq(0).is(':checked') && $('#product_id').eq(0).val() !={/literal}{$details.product_id}{literal} && $('select[name=status]').eq(0).val() != 'Pending' && $('select[name=status]').eq(0).val() != 'Terminated') {
                return confirm('{/literal}{$lang.upgrconf}{literal}');
            }
            return true;
        }

        function sh1xa(el, id) {
            $('#link_to_product').attr('href', '?cmd=services&action=product&id=' + id);
            if ($(el).eq(0).val() == id) {
                $('#upgrade_opt').hide();
            } else {
                $('#upgrade_opt').show();
            }
        }

        $('#ChangeOwner').bootboxform()
            .on('bootbox-form.shown', function (e, dialog) {
                $('select', dialog).chosensearch();
            });

        $('#RequestCancellation').bootboxform()
            .on('bootbox-form.shown', function (e, dialog) {
                $('button[data-bb-handler="confirm"]').on('click', function () {
                    if (isEmpty($('textarea[name="reason"]', dialog).val())) {
                        alert('{/literal}{$lang.empty_reason}{literal}');
                        return false;
                    }
                });
                var timepickers = $('.timepicker');
                var datepicker = $('.haspicker');
                datepicker.datePicker({
                    startDate: startDate
                });
                timepickers.timepicker({
                    timeFormat: 'H:i',
                    showDuration: true
                }).eq(0).on('changeDate change', function(x) {
                    timepickers.eq(1).timepicker('option', 'minTime', $(this).timepicker('getTime'))
                }).end().eq(1).on('changeDate change', function(x) {
                    var end = $(this).timepicker('getTime'),
                        start = timepickers.eq(0).timepicker('getTime');
                    if (end.getTime() - start.getTime() <= 0) {
                        var date = getFieldDate(datepicker.eq(1)),
                            date2 = getFieldDate(datepicker.eq(2)),
                            days = (date.getDate() + 1).toString(),
                            month = (date.getMonth() + 1).toString(),
                            format = Date.format;
                        if (!isNaN(date.getTime()) && (isNaN(date2.getTime()) || date.getTime() >= date2.getTime()))
                            datepicker.eq(2).val(
                                format.replace('d', days.length < 2 ? "0" + days : days)
                                    .replace('m', month.length < 2 ? "0" + month : month)
                                    .replace('Y', date.getFullYear())
                            );
                    }
                });
                datepicker.eq(1).change(function() {
                    datepicker.eq(2).dpSetStartDate($(this).val());
                });
                function getFieldDate(datepicker) {
                    var value = datepicker.val(),
                        format = Date.format, delim = format.replace(/[^-\/\.]/g, '').charAt(0), parts = value.split(delim),
                        formatparts = format.split(delim);
                    return new Date(parts[formatparts.indexOf('Y')], parts[formatparts.indexOf('m')] - 1, parts[formatparts.indexOf('d')])
                }
                $(dialog).find('.inp-controls a').on('click', function () {
                    var self = $(this),
                        inp = self.parent().prev(),
                        time = inp.timepicker('getTime'),
                        mod = self.is('.plus') ? 30 : -30;
                    time = new Date(time.getTime() + mod * 60000);
                    inp.timepicker('setTime', time);
                    return false;
                });
                $(dialog).find('select[name="type"]').on('init change', function () {
                    var self = $(this),
                        ipa = $(dialog).find('input[name="process_automatically"]');
                    if (self.val() === 'Admin submitted') {
                        ipa.closest('.form-group').show();
                    } else {
                        ipa.closest('.form-group').hide();
                        ipa.prop('checked', false);
                        ipa.trigger('change');
                    }
                }).trigger('init');
                $(dialog).find('input[name="process_automatically"]').on('init change', function () {
                    var self = $(this);
                    $(dialog).find('.request_at').closest('.form-group').toggle(self.is(':checked'));
                }).trigger('init');
            });

        var bootboxtpl = ['OverrideSuspension', 'SetCommitmentPeriod'];

        jQuery.each(bootboxtpl, function (i, item) {
            var suspovrtpl = $('#'+item);
            suspovrtpl.bootboxform()
                .on('bootbox-form.shown', function (e, dialog) {
                    var dateinp = $('input[name=date]', dialog);
                    $('select', dialog).on('init change', function () {
                        var val = this.value,
                            date = new Date();

                        if (val == 'c') {
                            dateinp.closest('.form-group').show();
                            return false;
                        }

                        dateinp.closest('.form-group').hide();
                        switch (val[val.length - 1]) {
                            case 'd':
                                date.setDate(date.getDate() + parseInt(val));
                                break;
                            case 'm':
                                date.setMonth(date.getMonth() + parseInt(val));
                        }
                        dateinp.val(date.asString()).trigger('change');
                        return false;
                    }).trigger('init');
                });

            if (suspovrtpl.data('active'))
                suspovrtpl.data().bootboxform.buttons['del'] = {
                    label: 'Disable',
                    className: 'btn-warning',
                    callback: function (e) {
                        $('input[name=date]', this).val('');
                        $('form', this).submit();
                        return false;
                    }
                };
        });

        {/literal}
    </script>
{/once}