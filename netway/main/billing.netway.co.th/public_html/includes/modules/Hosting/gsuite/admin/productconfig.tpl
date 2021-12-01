<tr>
    <td id="getvaluesloader">
        {if $test_connection_result}
            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
                {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}
                {else}{$test_connection_result.result}
                {/if}
                {if $test_connection_result.error}: {$test_connection_result.error}
                {/if}
            </span>
        {/if}
    </td>
    <td id="onappconfig_">
        <input type="hidden" id="saved_module" value="{if $default}1{else}0{/if}"/>
        <div id="">

            <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff"
                 id="onapptabcontainer">
                <div class="onapptab form" id="finish_tab">
                    <table border="0" cellspacing="0" width="100%" cellpadding="6">
                        <tr>
                            <td colspan="2" class="onapp-preloader" style=""><img
                                        src="templates/default/img/ajax-loader3.gif"> Fetching data from Google, please
                                wait...
                            </td>
                        </tr>
                        <tr>
                            <td width="160">
                                <label>Product </label>
                            </td>
                            <td>
                                <select name="options[skuid]" id="usertpl">
                                    {foreach from=$SKU item=skugroup key=skugn}
                                        <optgroup label="{$skugn}">
                                        {foreach from=$skugroup item=item key=sku}
                                            <option {if $default.skuid == $sku}selected="selected"{/if}
                                                    value="{$sku}">{$item}</option>
                                        {/foreach}
                                        </optgroup>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="160">
                                <label>Plan type </label>
                            </td>
                            <td>
                                <select name="options[plantype]" id="usertpl">
                                    {foreach from=$plantypes item=item key=key}
                                        <option {if $default.plantype == $key}selected="selected"{/if}
                                                value="{$key}">{$item}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td width="160">
                                <label>Number of Seats</label>
                            </td>
                            <td id="numberofseatscontainer"><input type="text" size="3" name="options[numberofseats]"
                                                                   value="{$default.numberofseats}" id="domainlim"/>
                                <span class="fs11"><input type="checkbox" class="formchecker" rel="numberofseats"/>Allow
                                    client to adjust with slider during order</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            {literal}
                <style type="text/css">
                    .nav-er {
                        margin: 20px 0px 7px;
                        text-align: center;
                    }

                    .nav-er a {
                        display: inline-block;
                        padding: 10px;
                        background-color: #F1F1F1;
                        background-image: -moz-linear-gradient(center top, #F5F5F5, #F1F1F1);
                        border: 1px solid #DDDDDD;
                        color: #444444;
                        border-radius: 4px;
                        text-decoration: underline;
                        margin: 0px 7px;
                    }

                    .nav-er a:hover {
                        color: #222;
                        text-decoration: none;
                        background: #F5F5F5;
                    }

                    h4.finish {
                        margin: 0px;
                        color: #262626;
                        font-weight: normal;
                        font-size: 20px;
                    }

                    .onapp-preloader {
                        display: none;
                        color: #7F7F7F;
                        padding-left: 178px;
                        font-size: 11px;
                        background: #EBEBEB;
                        font-weight: bold;
                    }

                    .pdx {
                        margin-bottom: 10px;
                    }

                    select.multi {
                        min-width: 120px;
                    }

                    .form select {
                        margin: 0px;
                    }

                    .paddedin {
                        margin: 2px 10px 20px 10px;
                    }

                    .odescr {
                        padding-left: 7px;
                    }

                    .onapp_opt:hover {
                        border: solid 1px #CCCCCC;
                        background: #f6fafd;
                    }

                    .opicker {
                        width: 25px;

                        -moz-border-radius-topleft: 3px;
                        -moz-border-radius-topright: 0px;
                        -moz-border-radius-bottomright: 0px;
                        -moz-border-radius-bottomleft: 3px;
                        -webkit-border-radius: 3px 0px 0px 3px;
                        border-radius: 3px 0px 0px 3px;
                    }

                    .onapp_opt {
                        border: solid 1px #DDDDDD;
                        padding: 4px;
                        margin: 15px;
                        -webkit-border-radius: 4px;
                        -moz-border-radius: 4px;
                        border-radius: 4px;
                    }

                    .onapp_active {
                        border: solid 1px #96c2db;
                        background: #f5f9fa;
                    }

                    .graylabel {
                        font-size: 11px;
                        padding: 2px 3px;
                        float: left;
                        clear: both;
                        background: #ebebeb;
                        color: #7f7f7f;
                        -webkit-border-radius: 3px;
                        -moz-border-radius: 3px;
                        border-radius: 3px;
                    }

                    #testconfigcontainer .dark_shelf {
                        display: none;
                    }

                    #acoslist {
                        list-style: none;
                        padding: 0;
                        margin: 0;
                        line-height: 26px;
                        width: 560px
                    }

                    #acoslist li {
                        border: 1px solid #ddd;
                        padding: 3px 5px;
                    }

                    #acoslist li + li {
                        border-top: none;
                    }

                    #acoslist input#acosselect {
                        width: 195px
                    }

                    #acoslist select#acosselect {
                        width: 200px;
                        margin: 0 3px 0 0;
                    }

                    #acoslist input[name] {
                        float: left;
                        width: 50px;
                    }

                    #acoslist .acosrem {
                        float: right;
                        width: 20px;
                        height: 20px;
                        background: url("templates/default/img/rm.png") no-repeat center center;
                        cursor: pointer
                    }

                    #acoslist .acosname {
                        display: block;
                        float: left;
                        overflow: hidden;
                        text-overflow: ellipsis;
                        white-space: nowrap;
                        width: 135px;
                    }

                    .disable_ select {
                        margin-right: 3px;
                    }
                </style>
                <script type="text/javascript">
                    function onapp_showloader() {
                        $('.onapptab:visible').find('.onapp-preloader').slideDown();
                    }

                    function onapp_hideloader() {
                        $('.onapptab:visible').find('.onapp-preloader').slideUp();
                    }

                    $(function () {
                        $('.clean-toggle').each(function () {
                            var self = $(this),
                                radio = self.find('input[type=radio]'),
                                input = self.find('input[type=text]');
                            radio.change(function () {
                                var r = $(this);
                                if (!r.is(':checked'))
                                    return false;
                                if (r.val() == '1')
                                    input.prop('disabled', false);
                                else
                                    input.prop('disabled', true);
                            }).change();
                        });
                        $('#cleanall').change(function () {
                            var self = $(this),
                                val = parseInt(self.val());
                            if (isNaN(val) || val < 30)
                                self.val(30);
                        })

                        function lookforsliders() {
                            var pid = $('#product_id').val(),
                                catid = $('#category_id').val();

                            $('.formchecker').click(function () {
                                var self = $(this),
                                    tr = self.parents('tr, .fchewrap').eq(0),
                                    rel = self.attr('rel').replace(/[^a-z_0-9-]/g, ''),
                                    sid = $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val();

                                if (!pid || pid == 'new' || !pid.length) {
                                    alert('Save your product first');
                                    return false;
                                }

                                if (!sid || sid == '0' || !sid.length) {
                                    alert('Please configure & select server first');
                                    return false;
                                }

                                if (!self.is(':checked')) {
                                    if (!confirm('Are you sure you want to remove related Form element? ')) {
                                        return false;
                                    }
                                    var conf = $('#configvar_' + rel.replace('acos_', ''));
                                    if (conf.length) {
                                        ajax_update('?cmd=configfields&make=delete', {
                                            id: conf.val(),
                                            product_id: pid
                                        }, '#configeditor_content');
                                    }
                                    //remove related form element
                                    tr.find('.tofetch').removeClass('fetched').removeClass('disabled');
                                    tr.find('input[id], select[id]').not(self).eq(0).removeAttr('disabled', 'disabled').show();
                                    tr.find('.formcheckerbox').show().find('input, select').prop('disabled', false);

                                    self.parents('span').eq(0).find('a.editbtn').remove();
                                } else {
                                    //add related form element

                                    tr.find('input[id], select[id]').not(self).eq(0).attr('disabled', 'disabled').hide();
                                    tr.find('.formcheckerbox').hide().find('input, select').prop('disabled', true);
                                    onapp_showloader();
                                    $.post('?cmd=services&action=product', {
                                        make: 'importformel',
                                        variableid: rel,
                                        cat_id: catid,
                                        other: $('input, select', '#onapptabcontainer').serialize(),
                                        id: pid,
                                        server_id: sid
                                    }, function (data) {
                                        var r = parse_response(data);
                                        if (r) {
                                            self.parents('span').eq(0).append(r);
                                            onapp_hideloader();
                                            ajax_update('?cmd=configfields', {
                                                product_id: pid,
                                                action: 'loadproduct'
                                            }, '#configeditor_content');
                                        }
                                    });
                                }
                            }).each(function () {
                                var self = $(this),
                                    rel = self.attr('rel').replace(/[^a-z_0-9-]|acos_/g, '');
                                if ($('#configvar_' + rel).length < 1)
                                    return 1;

                                var fid = $('#configvar_' + rel).val();
                                var tr = self.attr('checked', 'checked').trigger('change').parents('tr, .fchewrap').eq(0);
                                tr.find('input[id], select[id]').not(self).eq(0).attr('disabled', 'disabled').hide();
                                tr.find('.formcheckerbox').hide().find('input, select').prop('disabled', true);
                                tr.find('.tofetch').addClass('disabled');
                                self.parents('span').eq(0).append(' <a href="#" onclick="return editCustomFieldForm(' + fid + ',' + pid + ')" class="editbtn orspace">Edit related form element</a>');

                            });
                        }

                        lookforsliders();
                    })
                </script>
            {/literal}
        </div>
    </td>
</tr>