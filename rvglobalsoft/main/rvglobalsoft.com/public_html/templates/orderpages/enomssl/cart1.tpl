<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}enomssl/style.css" />
<script type="text/javascript">
    {literal}
        $(document).ready(function () {


            $('#cn').keyup(function () {
                if ($(this).val() != '') {
                    EnableSubmit(true);
                } else {
                    EnableSubmit(false);
                }
            });

            $('#csrbox').change(function () {
                $(this).parent().addLoader();
                $('.close').click();
                $.post('?cmd=cart&do=checkcsr', {csr: $(this).val()}, function (data) {
                    $('#preloader').hide();
                    if (data.response.error) {
                        parse_response('<!-- ' +JSON.stringify({ERROR: [data.response.error], INFO: []}) + ' -->');
                        reBind();
                        $('#cn').val("");
                        EnableSubmit(false);
                    } else if (data.response.CN) {
                        $('#cn').val(data.response.CN);
                        for (var proper in data.response) {
                            if ($('#i_' + proper).length) {
                                $('#i_' + proper).val(data.response[proper]);

                            }
                        }

                        EnableSubmit(true);
                    }
                });
            });

            $('#nocsr .clicky').click(function () {
                var ee = $(this).parent().find('input');
                var ea = $('#nocsr input[name=yescsr]');
                if (ee.attr('name') == 'yescsr') {
                    ea = $('#nocsr input[name=nocsr]');
                }
                if (!ee.is(':checked')) {
                    if (ee.attr('name') == 'yescsr') {
                        ShowCsrBox(ee.is(':checked'));
                    } else {
                        ShowCsrBox(!ee.is(':checked'));
                    }
                    ee.attr('checked', 'checked');
                    ea.removeAttr('checked');
                }

            });
            $('#nocsr input').click(function () {
                var checked = $(this).is(':checked');
                if ($(this).attr('name') == 'yescsr') {
                    ShowCsrBox(!checked);
                    var sec = $('#nocsr input[name=nocsr]');
                } else {
                    ShowCsrBox(checked);
                    var sec = $('#nocsr input[name=yescsr]');
                }
                if (checked) {
                    sec.removeAttr('checked');
                } else {
                    sec.attr('checked', 'checked');
                }
            });
        });
        ShowCsrBox = function (show) {
            if (!show) {
                $('#csrplace').slideDown('slow', function () {
                    $('#csrbox').focus();
                });
                $('#wtcsr').slideUp();

            } else {
                $('#csrplace').slideUp('slow', function () {
                    $('#cn').focus();
                });
                $('#wtcsr').slideDown();

            }
        };
        EnableSubmit = function (so) {
            if (so) {
                $('#submiter').removeClass('disabled');
            } else {
                $('#submiter').addClass('disabled');
            }
        };

        function submitmform(el) {
            if ($(el).parent().hasClass('disabled'))
                return false;
            if (jQuery.trim($('#csrbox').val()) == '') {
                $('#nocsr input').attr('checked', 'checked');
            }

            $('#mform').submit();
            return false;
        }

    {/literal}
</script>
<form id="mform" action="" method="post">
    <div id="celeft" style="position: relative;">
        <input type="hidden" name="make" value="continue" />
        <input type="hidden" name="organization[name]" value="{$customdata.organization.name}" id="i_O"/>
        <input type="hidden" name="organization[unit]" value="{$customdata.organization.unit}" id="i_OU"/>
        <input type="hidden" name="organization[address1]" value="{$customdata.organization.address1}" id="i_STREET" />
        <input type="hidden" name="organization[locality]" value="{$customdata.organization.locality}" id="i_L"/>
        <input type="hidden" name="organization[state]" value="{$customdata.organization.state}"  id="i_S"/>
        <input type="hidden" name="organization[postalcode]" value="{$customdata.organization.postalcode}" id="i_PostalCode"/>
        <input type="hidden" name="organization[country]" value="{$customdata.organization.country}" id="i_C"/>
        {include file='enomssl/cprogress.tpl'}
        {if !$nocsr}
            <h3>{$lang.en_step2}</h3>
            {$lang.en_step2intro}
            <div id="wtcsr" style="{if $customdata.nocsr=='1' || !$customdata}display:block;{else}display:none;{/if}margin:20px 0px;">
                <div class="table-responsive">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="position-relative stackable enomssl-table">
                        <tr>
                            <td valign="top" width="50%" style="padding-right:15px;">
                                <h3>{$lang.en_wtfcsr}</h3>
                                {$lang.en_wtfdescr}
                            </td>
                            <td valign="top">
                                <h3>{$lang.en_csrex}</h3>
                                <pre style="font-family: 'Courier New',Courier,monospace; font-size: 10px;">-----BEGIN CERTIFICATE REQUEST-----
    MIIWtjCCAR8CAQAwdjELMAkGA1UEBhMCVVMxDTALBgNVBAgTBFV0YWgxDzANBgNV
    BAcTBkxpbmRvbjEVMBMGA1UEChMMRGlnaUN123QgSW5jMREwDwYDVQQLEwhEaWdp
    Q2VydDEdMBsGA1UEAxMUZXhhbXBsZS5kaWdpY2VydC5jb20wg11wDQYJKoZIhvcN
    AQEBBQAD3f32MIGJAo24ALxG0R0gERgRkL2vTqcZfbCwlWBGVRjgaeJMaFCPQGri
    /DVvTeF9Yi8YZql54vewJIpLFwTDZcB+tRkcw+dFUrQa82cTjToJ+8yBDO2uwfUi
    iUfqbnGW1XpFA9rlaKBaakmGHasFIDprBFA6EH6nvJk122b302SYrtnNM68VNX3
    AgMBAAGgADANBgkqhkiG9w0BAQQFgAOBgQAphzI6acorHL3voml27jXheyvXnEuT
    v6xEUQHui1hEm1KG2ZNzGhZ4idznrHz+qzqQ962Nk7JATnEECO7DZ6xEQr5ycLcv
    MHzJgd0BkFYy2x0zvv6gVV6S9hu0b5NYCfW9q6lESMNcnjy0k/Dny/gcWPxDEUE8
    UjzGrVMUlZZcjA==
    -----END CERTIFICATE REQUEST-----</pre>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div style="margin-top:10px;{if $customdata.nocsr=='1' || !$customdata}display:none;{/if}" id="csrplace" >
                <div class="table-responsive">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="ntable position-relative stackable enomssl-table">
                    <tr>
                        {if $csr_servers}
                            <td valign="top" width="33%" style="padding:10px 0px;" id="nitems">
                                <strong>{$lang.en_servsoft}</strong>
                                <div class="nitem niselected" style="margin-top:5px;">
                                    <select size="2" id="servers_types" name="server_software">
                                        {foreach from=$csr_servers item=server key=pos name=csrsr}
                                            <option value="{$pos}" {if $smarty.foreach.csrsr.first}selected="selected"{/if}>{$server}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </td>
                        {/if}
                        <td valign="top" class="orderbox1 orderbox12" id="orderitems">
                            <strong>{$lang.en_pastecsr}</strong>
                            <textarea id="csrbox" style="margin-top:5px;" name="csr">{$customdata.csr}</textarea>
                        </td>
                    </tr>
                </table>
                </div>
            </div>
            <div  id="nocsr" class="greenbox">
                <div class="table-responsive">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="position-relative stackable enomssl-table">
                    {if !isset($customdata.options.nocsr) || $customdata.options.nocsr == true}
                        <tr class="border-0">
                            <td width="33%"></td>
                            <td><input type="checkbox" name="nocsr" value="1" {if $customdata.nocsr=='1' || !$customdata}checked="checked"{/if}/> <span class="clicky"><strong>{$lang.en_donthave}</strong></span></td>
                        </tr>
                    {/if}
                    <tr class="border-0">
                        <td  width="33%"></td>
                        <td><input type="checkbox" name="yescsr" value="1" {if $customdata.nocsr=='0'}checked="checked" {/if}/> <span class="clicky"><strong>{$lang.en_csrhave}</strong></span></td>
                    </tr>
                </table>
                </div>
            </div>
        {else}
            <h3>{$lang.en_step2nocsr}</h3>
            {$lang.en_step2intronocsr}
        {/if}{*nocsr*}
        </div>
        <div class="orderbox2 orderbox12" style="margin-bottom:10px;">
            <div class="table-responsive">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" class="position-relative stackable enomssl-table">
                <tr>
                    <td width="33%"></td>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="padding:20px 10px;"  width="70%">
                                    <strong>{$lang.en_commonname} </strong>*

                                    <input id="cn" name="cn" value="{$customdata.cn}" class="styled" size="30" style="font-weight:bold;"/>
                                </td>
                                <td class="csubmit {if $customdata.cn=='' || !$customdata.cn}disabled{/if}" id="submiter">
                                    <a href="#" onclick="return submitmform(this)">{$lang.continue}</a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            </div>
        </div>
        <small>*  {$lang.en_comdesc}</small>
    </form>
    <div class="clear"></div>

