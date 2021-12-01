{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.configuration.tpl.php');
{/php}
{if $action=='pricepreview'}
    <span><b>{$testprice}</b></span>
{elseif $action=='gettask'}{if $task}
    <h2 style="margin-bottom:5px">{if $lang[$task.taskname]}{$lang[$task.taskname]}{else}{$task.taskname}{/if}</h2>
    {assign var="name" value="_desc"}
    {assign var="name2" value=$task.task}
    {assign var="baz" value="$name2$name"}
    {$lang.$baz}
    <form method="post" action=""><input type="hidden" name="make" value="updatetask"/>
        <input type="hidden" name="task" value="{$task.task}"/>
        <table border="0" width="100%">
            <tr>
                <td style="padding:6px" width=180>
                    <strong>{$lang.calledevery}</strong>:
                </td>
                <td style="padding:6px;">
                    {if $task.task=='sendCronResults'}{$lang.evd}
                        <input type="hidden" name="run_every" value="Time"/>
                    {else}
                        <input type="hidden" name="run_every" value="{$task.run_every}"/>
                        <b>{if $task.run_every=='Run'}{$lang.croncall}
                            {elseif $task.run_every=='Hour'}{$lang.evh}
                            {elseif $task.run_every=='Time'}{$lang.evd}
                            {elseif $task.run_every=='Week'}{$lang.evw}
                            {elseif $task.run_every=='Month'}{$lang.evm}{/if}</b>
                    {/if}
                </td>
                <td id="e_evd1" {if $task.run_every!='Time'}style="display:none"{/if} class="e_evd" style="padding:6px">
                    <input size="2" name="run_every_time_hrs" class="inp" value="{$task.run_every_time_hrs}"/> : <input
                            size="2" name="run_every_time_min" class="inp" value="{$task.run_every_time_min}"/></td>
                <td id="e_evd2" {if $task.run_every!='Week'}style="display:none"{/if} class="e_evd" style="padding:6px">
                    <select name="run_every_time_week" class="inp">
                        <option value="2" {if $task.run_every_time==2}selected="selected"{/if}>{$lang.monday}</option>
                        <option value="3" {if $task.run_every_time==3}selected="selected"{/if}>{$lang.tuesday}</option>
                        <option value="4"
                                {if $task.run_every_time==4}selected="selected"{/if}>{$lang.wednesday}</option>
                        <option value="5" {if $task.run_every_time==5}selected="selected"{/if}>{$lang.thursday}</option>
                        <option value="6" {if $task.run_every_time==6}selected="selected"{/if}>{$lang.friday}</option>
                        <option value="7" {if $task.run_every_time==7}selected="selected"{/if}>{$lang.saturday}</option>
                        <option value="1" {if $task.run_every_time==1}selected="selected"{/if}>{$lang.sunday}</option>
                    </select>
                </td>
                <td id="e_evd3" {if $task.run_every!='Month'}style="display:none"{/if} class="e_evd"
                    style="padding:6px">
                    <select name="run_every_time_month" class="inp">
                        {section name=foo loop=31}
                            <option {if $smarty.section.foo.iteration==$task.run_every_time}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                        {/section}
                    </select>
                </td>
            </tr>
            <tr>
                <td style="padding:6px">
                    <strong>Profile</strong>:
                </td>
                <td style="padding:6px" colspan="4">
                    <select name="profile_id" class="form-control">
                        {foreach from=$profiles item=cls }
                            <option value="{$cls.id}"
                                    {if $cls.id==$task.profile_id}selected="selected"{/if}>{$cls.name}</option>
                        {/foreach}
                    </select>
                </td>

            </tr>
            <tr>

                <td style="padding:6px" colspan="5">

                    <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class="btn btn-primary"/>
                </td>

            </tr>
        </table>{securitytoken}</form>
    <script type="text/javascript">{literal}
        function shia1(el) {

            var cls = $(el).find('option:selected').attr('class');
            $('.e_evd').hide();
            $('#e_evd' + cls).show();


        }
        {/literal}
    </script>
{/if}

{elseif $action == 'test_connection'}
    {if $result}
        <span style="font-weight: bold; color: {if $result.result == 'Success'}#009900{else}#990000{/if}">
            {if $lang[$result.result_text]}{$lang[$result.result_text]}{else}{$result.result_text}{/if}{if $result.error}: {$result.error}{/if}
        </span>
    {/if}

{elseif $action=='currency'}

    {if $curr}
        <td colspan="7" style="border:solid 2px #d6d6d6;border-top:0px;padding:5px;">
            <form action="" method="post">
                <input type="hidden" value="update" name="make"/>
                <input type="hidden" value="{$curr.id}" name="id"/>
                <table border="0" cellpadding="3" cellspacing="0" width="100%">
                    <tr>
                        <td width="130" style="border:none;">{$lang.currcode}</td>
                        <td style="border:none;"><input size="4" name="code" value="{$curr.code}"/></td>

                        <td width="130" style="border:none;">{$lang.currsign}</td>
                        <td style="border:none;"><input size="4" name="sign" value="{$curr.sign}"/></td>

                        <td width="130" style="border:none;">{$lang.currrate}</td>
                        <td style="border:none;"><input size="4" name="rate" value="{$curr.rate}"/></td>
                    </tr>
                    <tr>
                        <td width="130" style="border:none;">{$lang.curriso}</td>
                        <td style="border:none;"><input size="4" name="iso" value="{$curr.iso}"/></td>

                        <td width="130" style="border:none;">{$lang.currupdate}</td>
                        <td style="border:none;"><input type="checkbox" name="update" value="1"
                                                        {if $curr.update=='1'}checked="checked"{/if}/></td>

                        <td width="130" style="border:none;">{$lang.currdisplay}</td>
                        <td style="border:none;"><input type="checkbox" name="enable" value="1"
                                                        {if $curr.enable=='1'}checked="checked"{/if}/></td>
                    </tr>
                    <tr>
                        <td width="130" style="border:none;">{$lang.CurrencyFormat}</td>
                        <td style="border:none;">
                            <select name="format">
                                <option {if $curr.format=='1,234.56'}selected="selected"{/if}>1,234.56</option>
                                <option {if $curr.format=='1.234,56'}selected="selected"{/if}>1.234,56</option>
                                <option {if $curr.format=='1 234.56'}selected="selected"{/if} value="1 234.56">1
                                    234.56
                                </option>
                                <option {if $curr.format=='1 234,56'}selected="selected"{/if} value="1 234,56">1
                                    234,56
                                </option>
                            </select>
                        </td>

                        <td width="130" style="border:none;">Display Decimal Places</td>
                        <td style="border:none;" colspan="3">
                            <input size="4" name="decimal" value="{$curr.decimal}"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="border:none;">
                            <center><input type="submit" style="font-weight:bold" class=" btn btn-sm btn-primary"
                                           value="{$lang.submit}"/></center>
                        </td>
                    </tr>
                </table>
                {securitytoken}</form>
        </td>
    {/if}

{elseif $action=='ticketrelated'}
    <div class="blu">
        <form name="" action="?cmd=configuration&action=ticketrelated" method="post">
            <input name="make" type="hidden" value="save_configuration"/>
            {foreach from=$configuration item=v key=k}
                {assign var="name" value=$k}
                {assign var="descr" value='_descr'}
                {assign var="baz" value="$name$descr"}

                {if $v=='on' or $v=='off'}

                    {$lang.$k} :
                    <strong>On: </strong>
                    <input type="radio" name="{$k}" value="on" {if $v=='on'}checked="checked"{/if} />
                    <strong>Off: </strong>
                    <input type="radio" name="{$k}" value="off" {if $v=='off'}checked="checked"{/if}/>
                    {$lang.$baz}
                    <br/>
                {else}

                    {$lang.$k} :
                    <input name="{$k}" value="{$v}"/>
                    {$lang.$baz}
                    <br/>
                {/if}

            {/foreach}
            <input type="submit" value="submit"/>
            {securitytoken}</form>
    </div>
{elseif $action=='cron'}

    {include file='configuration/cron.tpl'}

{elseif $action=='cronprofiles'}

    {include file='configuration/cronprofiles.tpl'}

{elseif $action=='default'}
    <form name="" action="" method="post" id="saveconfigform" enctype="multipart/form-data">
        <input name="cmd" type="hidden" value="configuration"/>
        <input name="postform" type="hidden" value="save_configuration"/>
        {include file="configuration/nav.tpl" }


        <div class="nicerblu">

            <div id="newtab">


                <div class="sectioncontent">
                    <script src="templates/default/js/chosen/chosen.min.js"></script>
                    <link href="templates/default/js/chosen/chosen.css" rel="stylesheet" type="text/css"/>
                    <script type="text/javascript">{literal}
                        function c_reload(sel) {
                            switch ($(sel).val()) {
                                case '-1':
                                    $('#currency_edit').show();
                                    break;
                                case 'USD':
                                    $('#ISOCurrency').val('USD');
                                    $('#CurrencyFormat').val('1,234.56');
                                    $('#CurrencyCode').val('USD');
                                    $('#CurrencySign').val('$');
                                    break;
                                    break;
                                case 'GBP':
                                    $('#ISOCurrency').val('GBP');
                                    $('#CurrencyFormat').val('1,234.56');
                                    $('#CurrencyCode').val('GBP');
                                    $('#CurrencySign').val('£');
                                    break;
                                case 'EUR':
                                    $('#ISOCurrency').val('EUR');
                                    $('#CurrencyFormat').val('1,234.56');
                                    $('#CurrencyCode').val('EUR');
                                    $('#CurrencySign').val('€');
                                    break;
                                case 'BRL':
                                    $('#ISOCurrency').val('BRL');
                                    $('#CurrencyFormat').val('1,234.56');
                                    $('#CurrencyCode').val('');
                                    $('#CurrencySign').val('R$ ');
                                    break;
                                case 'INR':
                                    $('#ISOCurrency').val('INR');
                                    $('#CurrencyFormat').val('1,234.56');
                                    $('#CurrencyCode').val('INR');
                                    $('#CurrencySign').val('');
                                    break;
                                case 'CAD':
                                    $('#ISOCurrency').val('CAD');
                                    $('#CurrencyFormat').val('1,234.56');
                                    $('#CurrencyCode').val('CAD');
                                    $('#CurrencySign').val('$');
                                    break;
                                case 'ZAR':
                                    $('#ISOCurrency').val('ZAR');
                                    $('#CurrencyFormat').val('1 234.56');
                                    $('#CurrencyCode').val('ZAR');
                                    $('#CurrencySign').val('R');
                                    break;
                            }
                            return false;
                        }

                        function checkdefault(el) {
                            if ($(el).val() == 'default') {
                                alert("Please note: Default clientarea is DEPRECATED and left only for backwards compatibility");
                            }
                        }

                        function shx() {
                            $('.cart_d').hide().eq($('#template').eq(0).prop("selectedIndex")).show();
                        }

                        $(function () {
                            $(".chosen").chosen({});
                        });

                        /*
                        $(document).ready(function(){
                        $('a.colorbox').colorbox({width:"80%", height:"80%", iframe:true,opacity:0.5});
                        });*/

                        {/literal}
                    </script>
                    <table border="0" cellpadding="10" width="100%" cellspacing="0">
                        <tr class="bordme">
                            <td width="205" align="right">
                                <strong>{$lang.MaintenanceMode}</strong>
                            </td>
                            <td>
                                <input name="MaintenanceMode" type="checkbox" value="on"
                                       {if $configuration.MaintenanceMode=='on'}checked="checked"{/if} class="inp"/>
                                {$lang.MaintenanceMode_descr}
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td width="205" align="right"><strong>{$lang.BusinessName}</strong></td>
                            <td><input style="width:50%" name="BusinessName"
                                       value="{$configuration.BusinessName|escape}" class="inp"/></td>
                        </tr>
                        <tr class="bordme">
                            <td width="205" align="right"><strong>{$lang.UserTemplate}</strong></td>
                            <td>
                                <select style="width:40%" name="UserTemplate" class="inp"onchange="shx();checkdefault(this);" id="template">
                                    {foreach from=$templates item=t}
                                        <option {if $configuration.UserTemplate==$t}selected="selected"{/if}>{$t}</option>
                                    {/foreach}
                                </select>
                                {foreach from=$templates item=t}
                                    <span {if $configuration.UserTemplate!=$t}style="display:none"{/if} class="cart_d">
                                        <a href="{$system_url}?systemtemplate={$t}" target="_blank" class="btn btn-sm btn-default" title="{$t} template">{$lang.clicktopreview}</a>
                                        <a href="?cmd=theme_config&action=selecttemplate&template={$t}" target="_blank" class="btn btn-sm btn-info" title="{$t} template">Edit</a>
                                    </span>
                                {/foreach}
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td width="205" align="right"><strong>{$lang.UserLanguage}</strong></td>
                            <td>
                                <select style="width:40%" name="UserLanguage" class="inp">
                                    {foreach from=$user_languages item=t}
                                        <option {if $configuration.UserLanguage==$t}selected="selected"{/if}
                                                value="{$t}">{$t|ucfirst}</option>
                                    {/foreach}
                                </select>
                                <span><a href="?cmd=langedit" class="colorbox editbtn"
                                         title="{$lang.languages}">{$lang.languages}</a></span>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td width="205" align="right"><strong>{$lang.UserCountry}</strong></td>
                            <td>
                                <select style="width:50%" name="UserCountry" class="inp">
                                    {foreach from=$countries key=k item=v}
                                        <option value="{$k}" {if $k==$configuration.UserCountry} selected="selected"{/if}>{$v}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td width="205" align="right"><strong>{$lang.DefaultTimezone}</strong></td>
                            <td>
                                <select style="width:50%" name="DefaultTimezone" class="inp">
                                    {foreach from=$timezones item=zone key=code}
                                        <option value="{$code}"
                                                {if $code==$configuration.DefaultTimezone}selected="selected"{/if}>{$zone}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>{$lang.DateFormat}</strong></td>
                            <td><select style="width:50%" name="DateFormat" class="inp">
                                    <!--
                                    <option value="YYYY-MM-DD"
                                            {if $configuration.DateFormat=='YYYY-MM-DD'}selected="selected"{/if}>
                                        YYYY-MM-DD ({''|dateformat:'Y-m-d'})
                                    </option>
                                    <option value="YYYY.MM.DD"
                                            {if $configuration.DateFormat=='YYYY.MM.DD'}selected="selected"{/if}>
                                        YYYY.MM.DD ({''|dateformat:'Y.m.d'})
                                    </option>
                                    <option value="MM/DD/YYYY"
                                            {if $configuration.DateFormat=='MM/DD/YYYY'}selected="selected"{/if}>
                                        MM/DD/YYYY ({''|dateformat:'m/d/Y'})
                                    </option>
                                -->
                                    <option value="DD/MM/YYYY"
                                            {if $configuration.DateFormat=='DD/MM/YYYY'}selected="selected"{/if}>
                                        DD/MM/YYYY ({''|dateformat:'d/m/Y'})
                                    </option>
                                    <!--
                                    <option value="DD.MM.YYYY"
                                            {if $configuration.DateFormat=='DD.MM.YYYY'}selected="selected"{/if}>
                                        DD.MM.YYYY ({''|dateformat:'d.m.Y'})
                                    </option>
                                    -->
                                </select>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right"><strong>Logging Level</strong><a href="#" class="vtip_description"
                                                                               title="What data should go to main HostBill log file: {$logfile}"></a>
                            </td>
                            <td><select style="width:50%" name="LoggerLevel" class="inp">
                                    <option value="100" {if $configuration.LoggerLevel=='100'}selected="selected"{/if}>
                                        DEBUG
                                    </option>
                                    <option value="200" {if $configuration.LoggerLevel=='200'}selected="selected"{/if}>
                                        INFO
                                    </option>
                                    <option value="250" {if $configuration.LoggerLevel=='250'}selected="selected"{/if}>
                                        NOTICE
                                    </option>
                                    <option value="300" {if $configuration.LoggerLevel=='300'}selected="selected"{/if}>
                                        WARNING
                                    </option>
                                    <option value="400" {if $configuration.LoggerLevel=='400'}selected="selected"{/if}>
                                        ERROR
                                    </option>

                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="sectioncontent" style="display:none">

                <table border="0" cellpadding="10" width="100%" cellspacing="0">
                    <tr class="bordme">
                        <td width="205" align="right" style="vertical-align: top;">
                            <strong>{$lang.terms}</strong><br />
                            <small>{$lang.terms_accept}</small>
                        </td>
                        <td>
                            {include file='configuration/terms.tpl' terms=$configuration.ServiceTerms}
                        </td>
                    </tr>

                        <tr>
                            <td width="205" align="right" valign="top"><strong>Multi-Item Cart</strong></td>
                            <td>
                                <input type="radio" name="ShopingCartMode"
                                       value="1" {if $configuration.ShopingCartMode=='1'} checked="checked"{/if}/>
                                <strong>{$lang.Enable}</strong>, allow more than one service in cart<br/>
                                <input type="radio" name="ShopingCartMode"
                                       value="0" {if $configuration.ShopingCartMode=='0'} checked="checked"{/if}/>
                                <strong>{$lang.Disable}</strong>, only one service in cart<br/>
                            </td>
                        </tr>

                        <tr>
                            <td width="205" align="right" valign="top"><strong>{$lang.AfterOrderRedirect}</strong></td>
                            <td>

                                <input type="radio" name="AfterOrderRedirect"
                                       value="0" {if $configuration.AfterOrderRedirect=='0'} checked="checked"{/if}/> {$lang.AfterOrderRedirect0}
                                <br/>
                                <input type="radio" name="AfterOrderRedirect"
                                       value="1" {if $configuration.AfterOrderRedirect=='1'} checked="checked"{/if}/> {$lang.AfterOrderRedirect1}
                                <br/>
                                <input type="radio" name="AfterOrderRedirect"
                                       value="2" {if $configuration.AfterOrderRedirect=='2'} checked="checked"{/if}/> {$lang.AfterOrderRedirect2}
                                <br/>
                            </td>
                        </tr>

                        <tr>
                        <td width="205" align="right" valign="top"><strong>Out of stock products:</strong></td>
                        <td>
                            <input type="radio" name="OutOfStockProducts" value="hide" {if $configuration.OutOfStockProducts=='hide'} checked="checked"{/if}/>
                            <b>Hide</b> - do not show products that are out of stock in orderpages <br/>
                            <input type="radio" name="OutOfStockProducts" value="show" {if $configuration.OutOfStockProducts=='show'} checked="checked"{/if}/>
                            <b>Show</b> - show products, without ability to order them<br/>
                        </td>
                    </tr>

                        <tr>
                            <td width="205" align="right" valign="top">
                                <strong>{$lang.ServiceStatusesLimitCalculation}</strong>
                                <a title="{$lang.ServiceStatusesLimitCalculationDesc}" class="vtip_description"></a>
                            </td>
                            <td>
                                <select style="width: 550px;" multiple="multiple" name="ServiceStatusesLimitCalculation[]" class="chosen">
                                    <option {if in_array('Pending', $configuration.ServiceStatusesLimitCalculation)}selected="selected"{/if} value="Pending">{$lang.Pending}</option>
                                    <option {if in_array('Active', $configuration.ServiceStatusesLimitCalculation)}selected="selected"{/if} value="Active">{$lang.Active}</option>
                                    <option {if in_array('Suspended', $configuration.ServiceStatusesLimitCalculation)}selected="selected"{/if} value="Suspended">{$lang.Suspended}</option>
                                    <option {if in_array('Terminated', $configuration.ServiceStatusesLimitCalculation)}selected="selected"{/if} value="Terminated">{$lang.Terminated}</option>
                                    <option {if in_array('Cancelled', $configuration.ServiceStatusesLimitCalculation)}selected="selected"{/if} value="Cancelled">{$lang.Cancelled}</option>
                                    <option {if in_array('Fraud', $configuration.ServiceStatusesLimitCalculation)}selected="selected"{/if} value="Fraud">{$lang.Fraud}</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="sectioncontent" style="display:none">
                    <table border="0" cellpadding="10" width="100%" cellspacing="0">
                        <tr class="bordme">
                            <td align="right" width="205"><strong>{$lang.AllowedAttachmentExt}</strong></td>
                            <td>
                                <div id="extensions_tag" class="tag-form"
                                     data-tags="{$configuration.AllowedAttachmentExtJson|escape}"
                                     data-placeholder="{$lang.addext}"></div>
                                <input type="hidden" name="AllowedAttachmentExt"
                                       value="{$configuration.AllowedAttachmentExt}" id="extensions" class="inp"/>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>{$lang.MaxAttachmentSize}</strong></td>
                            <td>
                                <input style="width:30px" name="MaxAttachmentSize"
                                       value="{$configuration.MaxAttachmentSize}"
                                       class="inp"/>&nbsp;{$lang.MaxAttachmentSize_descr}
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>{$lang.CaptchaUnregTickets}</strong></td>
                            <td>
                                <input name="CaptchaUnregTickets" type="radio" value="on_all"
                                       {if $configuration.CaptchaUnregTickets=='on_all'}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong>, {$lang.CaptchaAllTickets_descr}<br/>
                                <input name="CaptchaUnregTickets" type="radio" value="on"
                                       {if $configuration.CaptchaUnregTickets=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong>, {$lang.CaptchaUnregTickets_descr}<br/>
                                <input name="CaptchaUnregTickets" type="radio" value="off"
                                       {if $configuration.CaptchaUnregTickets=='off'}checked="checked"{/if} />
                                <strong>{$lang.no}</strong>, {$lang.CaptchaUnregTickets_descr1}
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right"><strong>HTML in imported tickets</strong></td>
                            <td>
                                <input name="TicketHTMLTags" type="radio" value="on"
                                       {if $configuration.TicketHTMLTags=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong>, html tags will be displayed in ticket message <br/>
                                <input name="TicketHTMLTags" type="radio" value="off"
                                       {if $configuration.TicketHTMLTags=='off' || !$configuration.TicketHTMLTags }checked="checked"{/if} />
                                <strong>{$lang.no}</strong>, html tags will be removed completely from tickets
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Import "To" headers</strong>
                                <a class="vtip_description" title="List of headers to check for recipent email address when importing tickets. Headers are prioritized from left to right."></a>
                            </td>
                            <td>
                                <div id="import_to" class="tag-form import-headers"
                                     data-tags="{$configuration.TicketImportToHeadersJson|escape}"
                                     data-placeholder="Type in header name"></div>
                                <input type="hidden" name="TicketImportToHeaders" />
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Import "From" headers</strong>
                                <a class="vtip_description" title="List of headers to check for sender email address when importing tickets. Headers are prioritized from left to right."></a>
                            </td>
                            <td>
                                <div id="import_from" class="tag-form import-headers"
                                     data-tags="{$configuration.TicketImportFromHeadersJson|escape}"
                                    data-placeholder="Type in header name" data-sortable></div>
                                <input type="hidden" name="TicketImportFromHeaders" />
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right">
                                <strong>Import time difference</strong>
                                <a class="vtip_description" title="Set minimum number of seconds between two messages from single email address that will be accepted. Messages sent from single email with smaller time difference will be rejected. Set to low value for automated notifications. <br>Default: 5"></a>
                            </td>
                            <td>
                                <input style="width:30px" name="TicketImportTimeLimit"
                                       value="{$configuration.TicketImportTimeLimit}" class="inp"/> seconds
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>Notify Contacts</strong></td>
                            <td>
                                <input name="TicketNotifyContacts" type="radio" value="on"
                                       {if $configuration.TicketNotifyContacts=='on' || !$configuration.TicketNotifyContacts}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong>, Send all ticket notifications to all client contacts with
                                support access<br/>
                                <input name="TicketNotifyContacts" type="radio" value="off"
                                       {if $configuration.TicketNotifyContacts=='off'}checked="checked"{/if} />
                                <strong>{$lang.no}</strong>, Send ticket notifications only to contact assigned to
                                ticket<br/>
                                <input name="TicketNotifyContacts" type="radio" value="only_contact"
                                       {if $configuration.TicketNotifyContacts=='only_contact'}checked="checked"{/if} />
                                <strong>{$lang.no}</strong>, Send ticket notifications only to contact assigned to ticket (does not send notifications to the main account)<br/>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>Ticket visibility for contacts</strong></td>
                            <td>
                                <input name="TicketContactVisibility" type="radio" value="on"
                                       {if $configuration.TicketContactVisibility=='on' || !$configuration.TicketContactVisibility}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong>, Client contacts can view all tickets from client profile
                                <a href="#" class="vtip_description"
                                   title="Contacts will see tickets only if main client account enabled access to support section for them"></a><br/>
                                <input name="TicketContactVisibility" type="radio" value="off"
                                       {if $configuration.TicketContactVisibility=='off'}checked="checked"{/if} />
                                <strong>{$lang.no}</strong>, Contacts can access only tickets opened by them<br/>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>Reject imported emails where sender is within receiver list</strong></td>
                            <td>
                                <input name="RejectEmailsWithCC" type="radio" value="on"
                                       {if $configuration.RejectEmailsWithCC=='on' || !$configuration.RejectEmailsWithCC}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong><br/>
                                <input name="RejectEmailsWithCC" type="radio" value="off"
                                       {if $configuration.RejectEmailsWithCC=='off'}checked="checked"{/if} />
                                <strong>{$lang.no}</strong><br/>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>{$lang.VoteKnowledgebaseArticles}</strong></td>
                            <td>
                                <input name="VoteKnowledgebaseArticles" type="radio" value="on"
                                       {if $configuration.VoteKnowledgebaseArticles=='on' || !$configuration.VoteKnowledgebaseArticles}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong><br/>
                                <input name="VoteKnowledgebaseArticles" type="radio" value="off"
                                       {if $configuration.VoteKnowledgebaseArticles=='off'}checked="checked"{/if} />
                                <strong>{$lang.no}</strong><br/>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>Reply to public ticket</strong></td>
                            <td>
                                <input name="ReplyToPublicTicket" type="radio" value="reject"
                                       {if $configuration.ReplyToPublicTicket=='reject' || !$configuration.ReplyToPublicTicket}checked="checked"{/if} />
                                <strong>Reject replies</strong><br/>
                                <input name="ReplyToPublicTicket" type="radio" value="new"
                                       {if $configuration.ReplyToPublicTicket=='new'}checked="checked"{/if} />
                                <strong>Open new ticket</strong><br/>
                                <input name="ReplyToPublicTicket" type="radio" value="bounce"
                                       {if $configuration.ReplyToPublicTicket=='bounce'}checked="checked"{/if} />
                                <strong>Bounce message</strong><br/>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- invoices -->


                <div class="sectioncontent" style="display:none">
                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable">

                        <tr>
                            <td colspan="4" align="center">
                                <div style="width:70%">
                                    <div class="left"
                                         style="padding:5px;margin-right:5px;width:46%;border-right:solid 1px #c0c0c0;text-align:left">
                                        <input type="radio" name="InvoiceModel" value="default" checked="checked"
                                               onclick="$('.definvoices').show();$('.euinvoices').hide();"
                                               {if $configuration.InvoiceModel=='default'}checked="checked"{/if}
                                               id="nom_invmodel"/> <label for="nom_invmodel"
                                                                          style="font-size:16px !important;font-weight:bold">{$lang.def_invmethod}</label><br/>
                                        {$lang.def_invmethod_descr}

                                    </div>
                                    <div class="left" style="width:46%;padding:5px;margin-left:5px;text-align:left;">
                                        <input type="radio" name="InvoiceModel" value="eu"
                                               onclick="$('.definvoices').hide();$('.euinvoices').show();"
                                               {if $configuration.InvoiceModel=='eu'}checked="checked"{/if}
                                               id="eu_invmodel"/> <label for="eu_invmodel"
                                                                         style="font-size:16px !important;font-weight:bold">{$lang.eu_invmethod}</label><br/>
                                        {$lang.eu_invmethod_descr}
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </td>
                        </tr>

                        <tr class="bordme definvoices" {if $configuration.InvoiceModel=='eu'}style="display:none"{/if}>
                            <td align="right"><strong>{$lang.InvoiceNumerationFrom}</strong></td>
                            <td colspan="3"><input style="width:80px" name="InvoiceNumerationFrom"
                                                   value="{$configuration.InvoiceNumerationFrom}" class="inp"/></td>
                        </tr>


                        <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}>
                            <td align="right"><strong>{$lang.InvoiceNumerationFrom}</strong></td>
                            <td width="305"><input style="width:100px" name="InvoiceNumerationPaid"
                                                   value="{$configuration.InvoiceNumerationPaid}" class="inp"/></td>
                            <td align="right" width="205"><strong>{$lang.ProFormaNumerationFrom}</strong></td>
                            <td><input style="width:100px" name="InvoiceNumerationFrom_eu"
                                       value="{$configuration.InvoiceNumerationFrom}" class="inp"/></td>


                        </tr>

                        <tr class="bordme definvoices" {if $configuration.InvoiceModel=='eu'}style="display:none"{/if}>
                            <td align="right" width="205"><strong>{$lang.InvoicePrefix}</strong></td>
                            <td colspan="3">
                                <select class="inp" name="InvoicePrefix_list" id="InvoicePrefix_list"
                                        onchange="if($(this).val()=='0') $('#InvoicePrefix_custom').show(); else  $('#InvoicePrefix').val($(this).val());">
                                    <option value=""
                                            {if $configuration.InvoicePrefixdc==""}selected="selected"{/if}>{$lang.none}</option>
                                    <option value="{literal}{$m}{/literal}"
                                            {if $configuration.InvoicePrefixdc=="m"}selected="selected"{/if}>MM
                                    </option>
                                    <option value="{literal}{$y}{/literal}"
                                            {if $configuration.InvoicePrefixdc=="y"}selected="selected"{/if}>YYYY
                                    </option>
                                    <option value="{literal}{$y}{$m}{/literal}"
                                            {if $configuration.InvoicePrefixdc=="ym"}selected="selected"{/if}>YYYYMM
                                    </option>
                                    <option value="0"
                                            {if $configuration.InvoicePrefixdc!='' && $configuration.InvoicePrefixdc!='m' && $configuration.InvoicePrefixdc!='y' && $configuration.InvoicePrefixdc!='ym'}selected="selected"{/if}>{$lang.other}</option>

                                </select>
                                <a class="editbtn" href="#"
                                   onclick="$('#InvoicePrefix_custom').toggle();return false;">{$lang.customize}</a>
                                <div id="InvoicePrefix_custom" style="margin-top:10px;
                                        {if $configuration.InvoicePrefixdc!='' && $configuration.InvoicePrefixdc!='m' && $configuration.InvoicePrefixdc!='y' && $configuration.InvoicePrefixdc!='ym'}{else}display:none{/if}">
                                    <input style="width:100px" name="InvoicePrefix" id="InvoicePrefix"
                                           value="{$configuration.InvoicePrefix}" class="inp"/>
                                    <br/>
                                    <small>{$lang.InvoicePrefix_desc}</small>
                                </div>

                            </td>
                        </tr>

                        <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}>
                            <td align="right"><strong>{$lang.InvoiceNumerationFormat}</strong></td>
                            <td width="305">

                                <select class="inp" name="InvoiceNumerationFormat_list"
                                        id="InvoiceNumerationFormat_list"
                                        onchange="if($(this).val()=='0') $('#InvoiceNumerationFormat_custom').show(); else  $('#InvoiceNumerationFormat').val($(this).val());">
                                    <option value="{literal}{$number}{/literal}"
                                            {if $configuration.InvoiceNumerationFormatdc=="number"}selected="selected"{/if}>
                                        number
                                    </option>
                                    <option value="{literal}{$m}/{$number}{/literal}"
                                            {if $configuration.InvoiceNumerationFormatdc=="m/number"}selected="selected"{/if}>
                                        MM/number
                                    </option>
                                    <option value="{literal}{$y}/{$number}{/literal}"
                                            {if $configuration.InvoiceNumerationFormatdc=="y/number"}selected="selected"{/if}>
                                        YYYY/number
                                    </option>
                                    <option value="{literal}{$y}/{$m}/{$number}{/literal}"
                                            {if $configuration.InvoiceNumerationFormatdc=="y/m/number"}selected="selected"{/if}>
                                        YYYY/MM/number
                                    </option>
                                    <option value="0"
                                            {if $configuration.InvoiceNumerationFormatdc!='number' && $configuration.InvoiceNumerationFormatdc!='m/number' && $configuration.InvoiceNumerationFormatdc!='y/number' && $configuration.InvoiceNumerationFormatdc!='y/m/number'}selected="selected"{/if}>{$lang.other}</option>

                                </select>
                                <a class="editbtn" href="#"
                                   onclick="$('#InvoiceNumerationFormat_custom').toggle();return false;">{$lang.customize}</a>
                                <div id="InvoiceNumerationFormat_custom" style="margin-top:10px;
                                        {if $configuration.InvoiceNumerationFormatdc!='number' && $configuration.InvoiceNumerationFormatdc!='m/number' && $configuration.InvoiceNumerationFormatdc!='y/number' && $configuration.InvoiceNumerationFormatdc!='y/m/number'}{else}display:none{/if}">
                                    <input style="width:100px" name="InvoiceNumerationFormat"
                                           id="InvoiceNumerationFormat" value="{$configuration.InvoiceNumerationFormat}"
                                           class="inp"/>
                                    <br/>
                                    <small>{$lang.InvoicePrefix2_desc}</small>
                                </div>

                            </td>
                            <td align="right" width="205"><strong>{$lang.ProFormaPrefix}</strong></td>
                            <td>
                                <select class="inp" name="InvoicePrefix_eu_list" id="InvoicePrefix_eu_list"
                                        onchange="if($(this).val()=='0') $('#InvoicePrefix_eu_custom').show(); else  $('#InvoicePrefix_eu').val($(this).val());">
                                    <option value=""
                                            {if $configuration.InvoicePrefixdc==""}selected="selected"{/if}>{$lang.none}</option>
                                    <option value="{literal}{$m}{/literal}"
                                            {if $configuration.InvoicePrefixdc=="m"}selected="selected"{/if}>MM
                                    </option>
                                    <option value="{literal}{$y}{/literal}"
                                            {if $configuration.InvoicePrefixdc=="y"}selected="selected"{/if}>YYYY
                                    </option>
                                    <option value="{literal}{$y}{$m}{/literal}"
                                            {if $configuration.InvoicePrefixdc=="ym"}selected="selected"{/if}>YYYYMM
                                    </option>
                                    <option value="0"
                                            {if $configuration.InvoicePrefixdc!='' && $configuration.InvoicePrefixdc!='m' && $configuration.InvoicePrefixdc!='y' && $configuration.InvoicePrefixdc!='ym'}selected="selected"{/if}>{$lang.other}</option>

                                </select>
                                <a class="editbtn" href="#"
                                   onclick="$('#InvoicePrefix_eu_custom').toggle();return false;">{$lang.customize}</a>
                                <div id="InvoicePrefix_eu_custom" style="margin-top:10px;
                                        {if $configuration.InvoicePrefixdc!='' && $configuration.InvoicePrefixdc!='m' && $configuration.InvoicePrefixdc!='y' && $configuration.InvoicePrefixdc!='ym'}{else}display:none{/if}">
                                    <input style="width:100px" name="InvoicePrefix_eu" id="InvoicePrefix_eu"
                                           value="{$configuration.InvoicePrefix}" class="inp"/>
                                    <br/>
                                    <small>{$lang.InvoicePrefix_desc}</small>
                                </div>

                            </td>

                        </tr>


                        <tr class="bordme">
                            <td align="right"><strong>Edit Warning</strong></td>
                            <td colspan="3">
                                <input name="InvoiceEditWarning" type="checkbox" value="1"
                                       {if $configuration.InvoiceEditWarning}checked="checked"{/if} />
                                Show confirmation dialog before submitting changes to non-draft invoices.
                            </td>
                        </tr>

                        <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}>
                            <td align="right"><strong>{$lang.BlockFinalInvoiceEdits}</strong></td>
                            <td colspan="3">
                                <input name="BlockFinalInvoiceEdits" type="checkbox" value="1"
                                       {if $configuration.BlockFinalInvoiceEdits}checked="checked"{/if} />
                                {$lang.BlockFinalInvoiceEdits_desc}
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right"><strong>{$lang.InvoiceStoreClient}</strong></td>
                            <td colspan="3">
                                <input name="InvoiceStoreClient" type="radio" value="off"
                                       {if $configuration.InvoiceStoreClient=='off'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.no}, </strong> {$lang.InvoiceStoreClient_descr}<br/>
                                <input name="InvoiceStoreClient" type="radio" value="on"
                                       {if $configuration.InvoiceStoreClient=='on'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.yes}, </strong>{$lang.InvoiceStoreClient1_descr}

                            </td>
                        </tr>

                        <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}>
                            <td align="right"><strong>{$lang.InvoicePaidAutoReset}</strong></td>
                            <td colspan="3">
                                <input name="InvoicePaidAutoReset" type="radio" value="0"
                                       {if $configuration.InvoicePaidAutoReset=='0'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.no}, </strong> {$lang.InvoicePaidAutoReset_descr}<br/>
                                <input name="InvoicePaidAutoReset" type="radio" value="1"
                                       {if $configuration.InvoicePaidAutoReset=='1'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.yes}, </strong>{$lang.InvoicePaidAutoReset1_descr}<br/>
                                <input name="InvoicePaidAutoReset" type="radio" value="2"
                                       {if $configuration.InvoicePaidAutoReset=='2'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.yes}, </strong>{$lang.InvoicePaidAutoReset2_descr}

                            </td>
                        </tr>

                        <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}>
                            <td align="right"><strong>{$lang.FinalInvoiceOnPayment}</strong></td>
                            <td colspan="3">
                                <input name="FinalInvoiceOnPayment" type="radio" value="on"
                                       {if $configuration.FinalInvoiceOnPayment=='on'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.yes}, </strong> {$lang.FinalInvoiceOnPayment_on}<br/>
                                <input name="FinalInvoiceOnPayment" type="radio" value="off"
                                       {if $configuration.FinalInvoiceOnPayment=='off'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.no}, </strong>{$lang.FinalInvoiceOnPayment_off}
                            </td>
                        </tr>

                        <tr class="bordme ">
                            <td align="right"><strong>{$lang.ContinueInvoices}</strong></td>
                            <td colspan="3">
                                <input name="ContinueInvoices" type="radio" value="on"
                                       {if $configuration.ContinueInvoices=='on'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.yes}, </strong> {$lang.ContinueInvoices_descr}<br/>
                                <input name="ContinueInvoices" type="radio" value="off"
                                       {if $configuration.ContinueInvoices=='off'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.no}, </strong>{$lang.ContinueInvoices_descr1}
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right"><strong>{$lang.MergeInvoices}</strong></td>
                            <td colspan="3">
                                <input name="GenerateSeparateInvoices" type="radio" value="off" class="inp"
                                       {if $configuration.GenerateSeparateInvoices=='off'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong>
                                {$lang.MergeInvoicesCron}<br/>
                                <input name="GenerateSeparateInvoices" type="radio" value="due" class="inp"
                                       {if $configuration.GenerateSeparateInvoices=='due'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong>
                                {$lang.MergeInvoicesDue} <br/>
                                <input name="GenerateSeparateInvoices" type="radio" value="on" class="inp"
                                       {if $configuration.GenerateSeparateInvoices=='on'}checked="checked"{/if} />
                                <strong>{$lang.no}, </strong>
                                {$lang.MergeInvoiceNone}
                            </td>
                        </tr>

                        <tr class="bordme" id="GenerateSeparateInvoicesOff">
                            <td align="right"><strong>{$lang.MergeInvoiceOptions}</strong></td>
                            <td colspan="3">

                                <input name="MergeDomainRenewals" type="checkbox" value="on" class="inp"
                                       {if $configuration.MergeDomainRenewals=='on'}checked="checked"{/if} />
                                {$lang.MergeDomainRenewals}<br/>
                                <input name="GenerateSeparateTax" type="checkbox" value="on" class="inp"
                                       {if $configuration.GenerateSeparateTax=='on'}checked="checked"{/if} />
                                {$lang.GenerateSeparateTax}<br/>

                                {literal}
                                    <script>
                                        $('input[name=GenerateSeparateInvoices]').on('init change', function (e) {
                                            var self = $(this),
                                                toggle = e.type == 'init' ? 'toggle' : 'ToggleNicely';
                                            if (!self.is(':checked'))
                                                return;

                                            $('#GenerateSeparateInvoicesOff')[toggle](self.val() != 'on')
                                        }).trigger('init')
                                    </script>
                                {/literal}
                            </td>
                        </tr>

                        <tr class="bordme definvoices" {if $configuration.InvoiceModel=='eu'}style="display:none"{/if}>
                            <td align="right" width="205"><strong>{$lang.InvoiceDeliveryMethod}</strong>{if $memorywarn}<br/>
                                <b style="color:red">{$lang.memory_limit_low}</b>{/if}</td>
                            <td colspan="3">
                                <input name="AttachPDFInvoice" type="radio" value="on"
                                       {if $configuration.AttachPDFInvoice=='on'}checked="checked"{/if} class="inp"/>
                                {$lang.InvoiceDeliveryMethod_descr1}<br/>
                                <input name="AttachPDFInvoice" type="radio" value="off"
                                       {if $configuration.AttachPDFInvoice=='off'}checked="checked"{/if} class="inp"/>
                                {$lang.InvoiceDeliveryMethod_descr2}<br>
                                <input name="AttachPDFInvoice" type="radio" value="paper"
                                       {if $configuration.AttachPDFInvoice=='paper'}checked="checked"{/if} class="inp"/>
                                {$lang.InvoiceDeliveryMethod_descr3}<br>
                                <input name="AttachPDFInvoice" type="radio" value="paperpdf"
                                       {if $configuration.AttachPDFInvoice=='paperpdf'}checked="checked"{/if} class="inp"/>
                                {$lang.InvoiceDeliveryMethod_descr4}<br>
                            </td>
                        </tr>
                        <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}">
                        <td align="right" width="205"><strong>{$lang.AttachProFormaInvoice}</strong>{if $memorywarn}
                        <br/><b style="color:red">{$lang.memory_limit_low}</b>{/if}</td>
                        <td colspan="3">
                            <input name="AttachPDFInvoiceUnpaid" type="radio" value="on"
                                   {if $configuration.AttachPDFInvoice=='on'}checked="checked"{/if} class="inp"/>
                            <strong>{$lang.yes}, </strong>{$lang.AttachPDFInvoice_descr3}<br/>
                            <input name="AttachPDFInvoiceUnpaid" type="radio" value="off"
                                   {if $configuration.AttachPDFInvoice=='off'}checked="checked"{/if} class="inp"/>
                            <strong>{$lang.no}, </strong>{$lang.AttachPDFInvoice_descr4}
                        </td>
                        </tr>

                        <tr class="bordme euinvoices"
                            {if $configuration.InvoiceModel!='eu' || $configuration.InvoiceDelay=='on'}style="display:none"{/if}
                        id="attachpaid">
                        <td align="right" width="205"><strong>{$lang.InvoiceDeliveryMethod}</strong>{if $memorywarn}<br/><b
                                    style="color:red">{$lang.memory_limit_low}</b>{/if}</td>
                        <td colspan="3">
                            <input name="AttachPDFInvoicePaid" type="radio" value="on"
                                   {if $configuration.AttachPDFInvoicePaid=='on'}checked="checked"{/if} class="inp" onchange="$('.paper').fadeOut();"/>
                            {$lang.InvoiceDeliveryMethod_descr1}<br/>
                            <input name="AttachPDFInvoicePaid" type="radio" value="off"
                                   {if $configuration.AttachPDFInvoicePaid=='off'}checked="checked"{/if} class="inp" onchange="$('.paper').fadeOut();"/>
                            {$lang.InvoiceDeliveryMethod_descr2}<br>
                            <input name="AttachPDFInvoicePaid" type="radio" value="paper"
                                   {if $configuration.AttachPDFInvoicePaid=='paper'}checked="checked"{/if} class="inp" onchange="$('.paper').fadeIn();"/>
                            {$lang.InvoiceDeliveryMethod_descr3}<br>
                            <input name="AttachPDFInvoicePaid" type="radio" value="paperpdf"
                                   {if $configuration.AttachPDFInvoicePaid=='paperpdf'}checked="checked"{/if} class="inp" onchange="$('.paper').fadeIn();"/>
                            {$lang.InvoiceDeliveryMethod_descr4}
                        </td>
                        </tr>

                        </tr>
                        <tr class="bordme euinvoices paper" {if $configuration.InvoiceModel!='eu' ||
                        !in_array($configuration.AttachPDFInvoicePaid, array('paper', 'paperpdf'))}style="display:none"{/if}">
                        <td align="right" width="205"><strong>{$lang.AddToPrintQueue}</strong></td>
                        <td colspan="3">
                            <input name="AddToPrintQueue" type="radio" value="proforma"
                                   {if $configuration.AddToPrintQueue=='proforma'}checked="checked"{/if} class="inp"/>
                            {$lang.ProForma}<br/>
                            <input name="AddToPrintQueue" type="radio" value="final"
                                   {if $configuration.AddToPrintQueue=='final' || !$configuration.AddToPrintQueue}checked="checked"{/if} class="inp"/>
                            {$lang.FinalInvoice}
                        </td>
                        </tr>

                        <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}">
                        <td align="right" width="205"><strong>{$lang.InvoiceDelay}</strong></td>
                        <td colspan="3">
                            <input name="InvoiceDelay" type="radio" value="off" onclick="$('#attachpaid').fadeIn();"
                                   {if $configuration.InvoiceDelay=='off'}checked="checked"{/if} class="inp"/>
                            <strong>{$lang.no}, </strong>{$lang.InvoiceDelay_descr}<br/>
                            <input name="InvoiceDelay" type="radio" value="on" onclick="$('#attachpaid').fadeOut();"
                                   {if $configuration.InvoiceDelay=='on'}checked="checked"{/if} class="inp"/>
                            <strong>{$lang.yes}, </strong>{$lang.InvoiceDelay_descr1} <input class="inp"
                                                                                             value="{$configuration.InvoiceDelayDays}"
                                                                                             name="InvoiceDelayDays"
                                                                                             size="2"> {$lang.InvoiceDelay_descr2}
                        </td>
                        </tr>

                        <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}">
                        <td align="right" width="205"><strong>{$lang.StorePDFInvoice}</strong>{if $memorywarn}<br/><b
                                    style="color:red">{$lang.memory_limit_low}</b>{/if}</td>
                        <td colspan="3">
                            <input name="StorePDFInvoice" type="radio" value="on"
                                   {if $configuration.StorePDFInvoice=='on'}checked="checked"{/if} class="inp"/>
                            <strong>{$lang.yes}, </strong>{$lang.StorePDFInvoice_descr} <input class="inp"
                                                                                               value="{if $configuration.StorePDFPath}{$configuration.StorePDFPath}{else}{$maindir}{/if}"
                                                                                               name="StorePDFPath"
                                                                                               style="width:205px"> <a
                                    class="vtip_description" title="{$lang.StorePDFInvoice_descr2}"></a><br/>
                            <input name="StorePDFInvoice" type="radio" value="off"
                                   {if $configuration.StorePDFInvoice!='on'}checked="checked"{/if} class="inp"/>
                            <strong>{$lang.no}, </strong>{$lang.StorePDFInvoice_descr1}
                        </td>
                        </tr>
                        <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}">
                        <td align="right" width="205"><strong>{$lang.AttachPDFCopy}</strong></td>
                        <td colspan="3">
                            <input name="AttachPDFCopy" type="radio" value="on"
                                   {if $configuration.AttachPDFCopy=='on'}checked="checked"{/if} class="inp"/>
                            <strong>{$lang.yes}, </strong>{$lang.AttachPDFCopy_descr}<br/>
                            <input name="AttachPDFCopy" type="radio" value="off"
                                   {if $configuration.AttachPDFCopy=='off'}checked="checked"{/if} class="inp"/>
                            <strong>{$lang.no}, </strong>{$lang.AttachPDFCopy_descr1}
                        </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right"><strong>{$lang.BCCInvoiceEmails}</strong></td>
                            <td colspan="3"><input name="BCCInvoiceEmails_on" type="radio" value="off"
                                                   {if $configuration.BCCInvoiceEmails==''}checked="checked"{/if} /> {$lang.BCCInvoiceEmails1}
                                <br/>
                                <input name="BCCInvoiceEmails_on" type="radio" value="on"
                                       {if $configuration.BCCInvoiceEmails!=''}checked="checked"{/if} /> {$lang.BCCInvoiceEmails2}
                                <input class="inp" value="{$configuration.BCCInvoiceEmails}" name="BCCInvoiceEmails"
                                       style="width:160px"><br/>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right"><strong>{$lang.DontSendSubscrInvNotify}</strong></td>
                            <td colspan="3"><input name="DontSendSubscrInvNotify" type="radio" value="on"
                                                   {if $configuration.DontSendSubscrInvNotify=='on'}checked="checked"{/if} /> {$lang.DontSendSubscrInvNotify_descr}
                                <br/>
                                <input name="DontSendSubscrInvNotify" type="radio" value="off"
                                       {if $configuration.DontSendSubscrInvNotify=='off'}checked="checked"{/if} /> {$lang.DontSendSubscrInvNotify_descr1}
                                <br/>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>{$lang.LateFeeAsSeparateInvoice}</strong></td>
                            <td colspan="3">
                                <input name="LateFeeAsSeparateInvoice" type="radio" value="off"
                                       {if $configuration.LateFeeAsSeparateInvoice=='off' || !$configuration.LateFeeAsSeparateInvoice}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.no}, </strong>{$lang.LateFeeAsSeparateInvoiceNO}<br/>
                                <input name="LateFeeAsSeparateInvoice" type="radio" value="on"
                                       {if $configuration.LateFeeAsSeparateInvoice=='on'}checked="checked"{/if} class="inp"/>
                                <strong>{$lang.yes}, </strong>{$lang.LateFeeAsSeparateInvoiceYES}
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><strong>Auto-cancel invoices</strong></td>
                            <td colspan="3">
                                <input name="CancelInvoicesOnExpire" type="hidden" value="off"/>
                                <input name="CancelInvoicesOnTerminate" type="hidden" value="off"/>
                                <input name="CancelInvoicesOnExpire" type="checkbox" value="on"
                                       {if $configuration.CancelInvoicesOnExpire=='on'}checked="checked"{/if} /> Cancel
                                renew invoices when related domain expires<br/>
                                <input name="CancelInvoicesOnTerminate" type="checkbox" value="on"
                                       {if $configuration.CancelInvoicesOnTerminate=='on'}checked="checked"{/if} />
                                Cancel overdue invoices when related account gets terminated<br/>
                                <input name="CancelInvoicesOnDays" type="checkbox" value="on"
                                       {if $configuration.CancelInvoicesOnDays=='on'}checked="checked"{/if} /> Cancel
                                overdue invoices <input type="text" name="CancelInvoicesOnDaysValue"
                                                        value="{$configuration.CancelInvoicesOnDaysValue}" size=3/> days
                                after due date<br/>
                            </td>
                        </tr>
                    </table>


                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable"
                           style="display:none">


                        <tr class="bordme">
                            <td align="right" width="205"><strong>{$lang.SupportedCC}</strong></td>
                            <td colspan="3"><input class="inp" value="{$configuration.SupportedCC}" name="SupportedCC"
                                                   style="width:260px"/><br/>
                                <small>Provide comma separated list of accepted Credit Cards</small>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" valign="top"><strong>Allow Credit Card Storage</strong></td>
                            <td colspan="3">
                                <input type="radio" name="CCAllowStorage" value="on"
                                       {if $configuration.CCAllowStorage=='on'}checked="checked"{/if} />
                                <strong>Yes</strong>, allow saving credit card for later use<br/>

                                <input type="radio" name="CCAllowStorage" value="token"
                                       {if $configuration.CCAllowStorage=='token'}checked="checked"{/if} />
                                <strong>Yes</strong>, just last 4 digits - only if credit card is <strong>tokenized</strong> by
                                gateway<br/>

                                <input type="radio" name="CCAllowStorage" value="off"
                                       {if $configuration.CCAllowStorage=='off'}checked="checked"{/if} />
                                <strong>No</strong>, do not store credit card details in database<br/>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" valign="top"><strong>{$lang.CCAllowRemove}</strong></td>
                            <td colspan="3">
                                <input type="radio"
                                       name="CCAllowRemove"
                                       value="off"
                                       {if $configuration.CCAllowRemove=='off'}checked="checked"{/if} /><strong>{$lang.no}
                                    , </strong> {$lang.CCAllowRemove_dscr1}<br/>

                                <input type="radio" name="CCAllowRemove"
                                       value="on"
                                       {if $configuration.CCAllowRemove=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong> {$lang.CCAllowRemove_dscr2}
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" valign="top">
                                <strong>Credit Cards Update Limit</strong>
                            </td>
                            <td colspan="3">
                                <input type="radio" name="CCUpdateLimit" value="off"
                                       {if $configuration.CCUpdateLimit!='on'}checked="checked"{/if} /><strong>{$lang.no}
                                    , </strong>
                                There is no limit to credit card updates.
                                <br/>

                                <input type="radio" name="CCUpdateLimit" value="on"
                                       {if $configuration.CCUpdateLimit=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong>
                                Limit the amount of credit card updates to a client's account to
                                <input type="text" size="3" value="{$configuration.CCUpdateLimitTimes|default:3}"
                                       name="CCUpdateLimitTimes"/>
                                time(s) per
                                <select name="CCUpdateLimitPariod">
                                    <option {if $configuration.CCUpdateLimitPariod=='1'}selected="selected"{/if}
                                            value="1">Day
                                    </option>
                                    <option {if $configuration.CCUpdateLimitPariod=='7'}selected="selected"{/if}
                                            value="7">Week
                                    </option>
                                    <option {if $configuration.CCUpdateLimitPariod=='30'}selected="selected"{/if}
                                            value="30">Month
                                    </option>
                                </select>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" valign="top">
                                <strong>Block Credit Cards</strong>
                            </td>
                            <td colspan="3">
                                <input type="radio" name="CCBanDeclined" value="off"
                                       {if $configuration.CCBanDeclined!='on'}checked="checked"{/if} /><strong>{$lang.no}
                                    , </strong>
                                Process every credit card.
                                <br/>

                                <input type="radio" name="CCBanDeclined" value="on"
                                       {if $configuration.CCBanDeclined=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong>
                                Reject credit cards that were declined
                                <input type="text" size="3" value="{$configuration.CCBanDeclinedTimes|default:3}"
                                       name="CCBanDeclinedTimes"/>
                                time(s) or more.
                            </td>
                        </tr>

                        <tr>
                            <td align="right" valign="top"><strong>{$lang.CCChargeAuto}</strong></td>
                            <td colspan="3">
                                <input type="radio"
                                       name="CCChargeAuto"
                                       value="off"
                                       {if $configuration.CCChargeAuto=='off'}checked="checked"{/if}
                                       onclick="$('.chargefew').hide();"/>
                                <strong>{$lang.no}, </strong> {$lang.CCChargeAuto_dscr1}
                                <br/>

                                <input type="radio" name="CCChargeAuto"
                                       value="on"
                                       {if $configuration.CCChargeAuto=='on'}checked="checked"{/if}
                                       onclick="$('.chargefew').show();"/>
                                <strong>{$lang.yes}, </strong> {$lang.CCChargeAuto_dscr}
                                <input type="text" size="3" {if $configuration.CCChargeAuto!='on'}value="0"
                                       {else}value="{$configuration.CCDaysBeforeCharge}"{/if}
                                       name="CCDaysBeforeCharge"/> {$lang.CCChargeAuto2}
                                <br/>

                                <div class="chargefew" {if $configuration.CCChargeAuto!='on'}style="display:none"{/if}>
                                    <br/>
                                    <input type="radio" name="CCAttemptOnce" value="on"
                                           {if $configuration.CCAttemptOnce=='on'}checked="checked"{/if}/> {$lang.CCAttemptOnce}
                                    <br/>
                                    <input type="radio" name="CCAttemptOnce" value="off"
                                           {if $configuration.CCAttemptOnce=='off'}checked="checked"{/if}/> {$lang.CCAttemptOnce2}
                                    <input type="text" size="3" name="CCRetryForDays"
                                           value="{$configuration.CCRetryForDays}"/> {$lang.days}
                                </div>
                                <div class="chargefew" {if $configuration.CCChargeAuto!='on'}style="display:none"{/if}>
                                    <br/>
                                    <input type="radio" name="CCForceAttempt" value="off"
                                           {if !$configuration.CCForceAttempt || $configuration.CCForceAttempt=='off'}checked="checked"{/if}/>
                                    <strong>{$lang.no}</strong>, use payment module related to invoice to capture
                                    payment <br/>
                                    <input type="radio" name="CCForceAttempt" value="on"
                                           {if $configuration.CCForceAttempt=='on'}checked="checked"{/if}/>
                                    <strong>{$lang.Yes}</strong>, use credit card module if card is present and
                                    non-credit card gateway is related to invoice
                                </div>
                            </td>

                        </tr>

                    </table>
                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable"
                           style="display:none">

                        <tr class="bordme">
                            <td align="right" valign="top" width="205"><strong></strong></td>
                            <td colspan="3">
                                {$lang.ACHAdminInfo}
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" valign="top"><strong>Allow bank details storage</strong></td>
                            <td colspan="3">
                                <input type="radio" name="ACHAllowStorage" value="on"
                                       {if $configuration.ACHAllowStorage=='on'}checked="checked"{/if} />
                                <strong>Yes</strong>, allow saving bank details for later use<br/>

                                <input type="radio" name="ACHAllowStorage" value="off"
                                       {if $configuration.ACHAllowStorage=='off'}checked="checked"{/if} />
                                <strong>No</strong>, do not store bank account details in database<br/>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" valign="top"><strong>{$lang.ACHAllowRemove}</strong></td>
                            <td colspan="3">
                                <input type="radio"
                                       name="ACHAllowRemove"
                                       value="off"
                                       {if $configuration.ACHAllowRemove=='off'}checked="checked"{/if} /><strong>{$lang.no}
                                    , </strong> {$lang.ACHAllowRemove_dscr1}<br/>

                                <input type="radio" name="ACHAllowRemove"
                                       value="on"
                                       {if $configuration.ACHAllowRemove=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong> {$lang.ACHAllowRemove_dscr2}
                            </td>
                        </tr>


                        <tr>
                            <td align="right" valign="top"><strong>{$lang.ACHChargeAuto}</strong></td>
                            <td colspan="3">
                                <input type="radio"
                                       name="ACHChargeAuto"
                                       value="off"
                                       {if $configuration.ACHChargeAuto=='off'}checked="checked"{/if}
                                       onclick="$('.chargefew2').hide();"/>
                                <strong>{$lang.no}, </strong> {$lang.CCChargeAuto_dscr1}
                                <br/>

                                <input type="radio" name="ACHChargeAuto"
                                       value="on"
                                       {if $configuration.ACHChargeAuto=='on'}checked="checked"{/if}
                                       onclick="$('.chargefew2').show();"/>
                                <strong>{$lang.yes}, </strong> {$lang.ACHChargeAuto_dscr}
                                <input type="text" size="3" {if $configuration.ACHChargeAuto!='on'}value="0"
                                       {else}value="{$configuration.ACHChargeAutoDays}"{/if}
                                       name="ACHChargeAutoDays"/> {$lang.CCChargeAuto2}
                                <br/>

                                <div class="chargefew2"
                                     {if $configuration.ACHChargeAuto!='on'}style="display:none"{/if}><br/>
                                    <input type="radio" name="ACHReChargeAuto" value="on"
                                           {if $configuration.ACHReChargeAuto=='on'}checked="checked"{/if}/> {$lang.CCAttemptOnce}
                                    <br/>
                                    <input type="radio" name="ACHReChargeAuto" value="off"
                                           {if $configuration.ACHReChargeAuto=='off'}checked="checked"{/if}/> {$lang.ACHAttemptOnce2}
                                    <input type="text" size="3" name="ACHRetryForDays"
                                           value="{$configuration.ACHRetryForDays}"/> {$lang.days}
                                </div>
                            </td>

                        </tr>

                    </table>

                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable"
                           style="display:none">

                        <tr class="bordme">
                            <td align="right" width="205"><strong>{$lang.OfferDeposit}</strong></td>
                            <td colspan="3"><input name="OfferDeposit" type="radio" value="off"
                                                   {if $configuration.OfferDeposit=='off'}checked="checked"{/if}
                                                   onclick="$('.offerdeposit').hide();"/> <strong>{$lang.no}, </strong>{$lang.OfferDeposit_descr1}<br/>
                                <input name="OfferDeposit" type="radio" value="on"
                                       {if $configuration.OfferDeposit=='on'}checked="checked"{/if}
                                       onclick="$('.offerdeposit').show();"/> <strong>{$lang.yes}, </strong>{$lang.OfferDeposit_descr}<br/>

                                <div class="offerdeposit"
                                     {if $configuration.OfferDeposit!='on'}style="display:none"{/if}>
                                    {$lang.MinDeposit}: <input name="MinDeposit" class="inp"
                                                               value="{$configuration.MinDeposit}" size="4"/> &nbsp;&nbsp;
                                    {$lang.MaxDeposit}: <input name="MaxDeposit" class="inp"
                                                               value="{$configuration.MaxDeposit}" size="4"/>
                                </div>

                            </td>
                        </tr>


                        <tr class="bordme offerdeposit" {if $configuration.OfferDeposit!='on'}style="display:none"{/if}>
                            <td width="205" align="right" width="205"><strong>Credit Receipts</strong> <a href="#"
                                                                                                          class="vtip_description"
                                                                                                          title="This document is required in some EU countries to indicate customer adding funds. If credit receipts are disabled, regular invoice for add-funds will be issued."></a>
                            </td>
                            <td>
                                <input type="radio" name="ReceiptEnable" value="off"
                                       {if $configuration.ReceiptEnable !='on'}checked="checked"{/if} /> Disabled <br/>
                                <input type="radio" name="ReceiptEnable" value="on"
                                       {if $configuration.ReceiptEnable =='on'}checked="checked"{/if} /> Enabled
                            </td>
                        </tr>
                        <tr class="bordme offerdeposit" {if $configuration.OfferDeposit!='on'}style="display:none"{/if}>
                            <td width="205" align="right"><strong>Next credit receipt number</strong></td>
                            <td>
                                <input style="width:100px" name="ReceiptNumeration"
                                       value="{$configuration.ReceiptNumeration}" class="inp"/>
                            </td>
                        </tr>

                        <tr class="bordme offerdeposit" {if $configuration.OfferDeposit!='on'}style="display:none"{/if}>
                            <td width="205" align="right"><strong>Credit receipt numeration format</strong></td>
                            <td>
                                <select class="inp" name="ReceiptNumerationFormat_list"
                                        id="ReceiptNumerationFormat_list"
                                        onchange="if($(this).val()=='0') $('#ReceiptNumerationFormat_custom').show(); else  $('#ReceiptNumerationFormat').val($(this).val());">
                                    <option value="{literal}{$number}{/literal}"
                                            {if $configuration.ReceiptNumerationFormatdc=="number"}selected="selected"{/if}>
                                        number
                                    </option>
                                    <option value="{literal}{$number}/{$m}{/literal}"
                                            {if $configuration.ReceiptNumerationFormatdc=="number/m"}selected="selected"{/if}>
                                        number/MM
                                    </option>
                                    <option value="{literal}{$number}/{$y}{/literal}"
                                            {if  $configuration.ReceiptNumerationFormatdc=="number/y"}selected="selected"{/if}>
                                        number/YYYY
                                    </option>
                                    <option value="{literal}{$number}/{$m}/{$y}{/literal}"
                                            {if $configuration.ReceiptNumerationFormatdc=="number/m/y"}selected="selected"{/if}>
                                        number/MM/YYYY
                                    </option>
                                    <option value="0"
                                            {if $configuration.ReceiptNumerationFormatdc && $configuration.ReceiptNumerationFormatdc!='number' && $configuration.ReceiptNumerationFormatdc!='number/m'
                                            && $configuration.ReceiptNumerationFormatdc!='number/y' && $configuration.ReceiptNumerationFormatdc!='number/m/y'}selected="selected"{/if}>{$lang.other}</option>

                                </select>
                                <a class="editbtn" href="#"
                                   onclick="$('#ReceiptNumerationFormat_custom').toggle();return false;">{$lang.customize}</a>
                                <div id="ReceiptNumerationFormat_custom" style="margin-top:10px;
                                        {if $configuration.CNoteNumerationFormatdc && $configuration.CNoteNumerationFormatdc!='number' && $configuration.CNoteNumerationFormatdc!='number/m'
                                           && $configuration.CNoteNumerationFormatdc!='number/y' && $configuration.CNoteNumerationFormatdc!='number/m/y'}{else}display:none{/if}">
                                    <input style="width:100px" name="ReceiptNumerationFormat"
                                           id="ReceiptNumerationFormat" value="{$configuration.ReceiptNumerationFormat}"
                                           class="inp"/>
                                    <br/>
                                    <small>{$lang.InvoicePrefix2_desc}</small>
                                </div>

                            </td>
                        </tr>


                        <tr class="bordme">
                            <td align="right"><strong>{$lang.AllowBulkPayment}</strong></td>
                            <td colspan="3"><input name="AllowBulkPayment" type="radio" value="off"
                                                   {if $configuration.AllowBulkPayment=='off'}checked="checked"{/if} />
                                <strong>{$lang.no}, </strong>{$lang.AllowBulkPayment_descr1}<br/>
                                <input name="AllowBulkPayment" type="radio" value="on"
                                       {if $configuration.AllowBulkPayment=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong>{$lang.AllowBulkPayment_descr}<br/>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right"><strong>Credit on Downgrade</strong></td>
                            <td colspan="3"><input name="CreditOnDowngrade" type="radio" value="off"
                                                   {if $configuration.CreditOnDowngrade=='off'}checked="checked"{/if} />
                                <strong>{$lang.no}, </strong>do not credit customer pro-rated amount on package
                                downgrade<br/>
                                <input name="CreditOnDowngrade" type="radio" value="on"
                                       {if $configuration.CreditOnDowngrade=='on' || !$configuration.CreditOnDowngrade}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong> credit customer pro-rated amount on package
                                downgrade<br/>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right"><strong>Auto-apply credit</strong></td>
                            <td colspan="3">
                                <input name="CreditAutoApply" type="radio" value="off"
                                       {if $configuration.CreditAutoApply=='off' }checked="checked"{/if} />
                                <strong>{$lang.no}, </strong> {$lang.autocredit_no}
                                <br/>
                                <input name="CreditAutoApply" type="radio" value="on"
                                       {if $configuration.CreditAutoApply=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong> {$lang.autocredit_yes}
                                <br/>
                                <input name="CreditAutoApply" type="radio" value="delay"
                                       {if $configuration.CreditAutoApply=='delay'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong> apply available credit to new orders immediately, and to
                                recurring invoice
                                <input name="CreditDelayAutoApply" class="inp"
                                       value="{$configuration.CreditDelayAutoApply|default:0}" size="4"/>
                                days before due date.
                                <br/>
                                <input name="CreditAutoApply" type="radio" value="taxed"
                                       {if $configuration.CreditAutoApply=='taxed'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong> apply available credit only to invoices with taxed items
                                <br/>
                                {literal}
                                    <script>
                                        $(function () {

                                        })
                                    </script>
                                {/literal}
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow customer to control automatic credit aplication</strong>
                            </td>
                            <td>
                                <input name="CanSetCreditAuto" type="radio" value="on"
                                       {if $configuration.CanSetCreditAuto=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="CanSetCreditAuto" type="radio" value="off"
                                       {if $configuration.CanSetCreditAuto!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Require active order</strong>
                            </td>
                            <td>
                                <input name="AddFundsDontCheckOrders" type="radio" value="off" {if $configuration.AddFundsDontCheckOrders!='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong>, client needs to have at least one active order before being able to add funds
                                <br/>

                                <input name="AddFundsDontCheckOrders" type="radio" value="on" {if $configuration.AddFundsDontCheckOrders=='on'}checked="checked"{/if} />
                                <strong>{$lang.no}</strong>, client can add funds even if he doesn't have active orders

                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Pay before using voucher</strong>
                            </td>
                            <td>
                                <input name="PayBeforeVoucher" type="radio" value="on" {if $configuration.PayBeforeVoucher=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong>, client needs to submit at least one successful payment before using voucher
                                <br/>
                                <input name="PayBeforeVoucher" type="radio" value="off" {if $configuration.PayBeforeVoucher!='on'}checked="checked"{/if} />
                                <strong>{$lang.no}</strong>, client can use voucher as soon as he signs up
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable"
                           style="display:none">
                        <tr class="bordme">
                            <td width="205" align="right" width="205"><strong>Credit notes</strong> <a href="#"
                                                                                                       class="vtip_description"
                                                                                                       title="This document indicates money coming out/owed to customer. Its most commonly issued upon refund."></a>
                            </td>
                            <td>
                                <input type="radio" name="CnoteEnable" value="off"
                                       {if $configuration.CnoteEnable !='on'}checked="checked"
                                       {/if}onchange="c_note()"/>
                                Disabled <br/>
                                <input type="radio" name="CnoteEnable" value="on"
                                       {if $configuration.CnoteEnable =='on'}checked="checked"
                                       {/if}onchange="c_note()"/>
                                Enabled
                            </td>
                        </tr>
                        <tr class="bordme cnote" {if $configuration.CnoteEnable !='on'}style="display:none"{/if}>
                            <td width="205" align="right"><strong>{$lang.CNoteNumerationFrom}</strong></td>
                            <td>
                                <input style="width:100px" name="CNoteNumerationPaid"
                                       value="{$configuration.CNoteNumerationPaid}" class="inp"/>
                            </td>
                        </tr>

                        <tr class="bordme cnote" {if $configuration.CnoteEnable !='on'}style="display:none"{/if}>
                            <td width="205" align="right"><strong>{$lang.CNoteNumerationFormat}</strong></td>
                            <td>
                                <select class="inp" name="CNoteNumerationFormat_list" id="CNoteNumerationFormat_list"
                                        onchange="if($(this).val()=='0') $('#CNoteNumerationFormat_custom').show(); else  $('#CNoteNumerationFormat').val($(this).val());">
                                    <option value="{literal}{$number}{/literal}"
                                            {if $configuration.CNoteNumerationFormatdc=="number"}selected="selected"{/if}>
                                        number
                                    </option>
                                    <option value="{literal}{$number}/{$m}{/literal}"
                                            {if $configuration.CNoteNumerationFormatdc=="number/m"}selected="selected"{/if}>
                                        number/MM
                                    </option>
                                    <option value="{literal}{$number}/{$y}{/literal}"
                                            {if !$configuration.CNoteNumerationFormat || $configuration.CNoteNumerationFormatdc=="number/y"}selected="selected"{/if}>
                                        number/YYYY
                                    </option>
                                    <option value="{literal}{$number}/{$m}/{$y}{/literal}"
                                            {if $configuration.CNoteNumerationFormatdc=="number/m/y"}selected="selected"{/if}>
                                        number/MM/YYYY
                                    </option>
                                    <option value="0"
                                            {if $configuration.CNoteNumerationFormatdc && $configuration.CNoteNumerationFormatdc!='number' && $configuration.CNoteNumerationFormatdc!='number/m'
                                            && $configuration.CNoteNumerationFormatdc!='number/y' && $configuration.CNoteNumerationFormatdc!='number/m/y'}selected="selected"{/if}>{$lang.other}</option>

                                </select>
                                <a class="editbtn" href="#"
                                   onclick="$('#CNoteNumerationFormat_custom').toggle();return false;">{$lang.customize}</a>
                                <div id="CNoteNumerationFormat_custom" style="margin-top:10px;
                                        {if $configuration.CNoteNumerationFormatdc && $configuration.CNoteNumerationFormatdc!='number' && $configuration.CNoteNumerationFormatdc!='number/m'
                                           && $configuration.CNoteNumerationFormatdc!='number/y' && $configuration.CNoteNumerationFormatdc!='number/m/y'}{else}display:none{/if}">
                                    <input style="width:100px" name="CNoteNumerationFormat" id="CNoteNumerationFormat"
                                           value="{$configuration.CNoteNumerationFormat}" class="inp"/>
                                    <br/>
                                    <small>{$lang.InvoicePrefix2_desc}</small>
                                </div>

                            </td>
                        </tr>
                        <tr class="bordme cnote" {if $configuration.CnoteEnable !='on'}style="display:none"{/if}>
                            <td width="205" align="right"><strong>Unpaid invoices</strong></td>
                            <td>
                                <input type="checkbox" name="CNoteIssueForUnpaid" value="1"
                                       {if $configuration.CNoteIssueForUnpaid}checked{/if}/>
                                Allow credit notes for unpaid invoices
                            </td>
                        </tr>
                        <tr class="bordme cnote" {if $configuration.CnoteEnable !='on'}style="display:none"{/if}>
                            <td width="205" align="right"><strong>Credit note on downgrade</strong></td>
                            <td>
                                <input type="checkbox" name="CNoteDowngrade" value="on"
                                       {if $configuration.CNoteDowngrade=='on'}checked{/if}/>
                                Issue credit notes on downgrades
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable"
                           style="display:none">
                        <tr class="bordme">
                            <td width="205" align="right"><strong>Chargeback Auto-Handling</strong></td>
                            <td>
                                <input type="radio" name="ChargebackHandle" value="off"
                                       {if $configuration.ChargebackHandle !='on'}checked="checked"{/if} />
                                Disabled - don't take any action on chargebacks<br/>
                                <input type="radio" name="ChargebackHandle" value="on"
                                       {if $configuration.ChargebackHandle =='on'}checked="checked"{/if} />
                                Enabled - when chargeback is discovered, mark related invoice as unpaid.
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td width="205" align="right"><strong>{$lang.RedirectAfterPayment}</strong> <a href="#"
                                                                                                     class="vtip_description "
                                                                                                     title="{$lang.RedirectAfterPayment_desc}"></a>
                            </td>
                            <td>
                                <input type="checkbox" value="1"
                                       {if $configuration.GatewaySuccessURL!=''}checked="checked"{/if}
                                       onclick="check_i(this)"/>
                                <input style="width:50%" name="GatewaySuccessURL"
                                       value="{$configuration.GatewaySuccessURL}" class="config_val inp"
                                       {if $configuration.GatewaySuccessURL==''}disabled="disabled"{/if}/>
                            </td>

                        </tr>

                    </table>
                </div>

                <div class="sectioncontent" style="display:none">
                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable4">
                        <tr class="bordme">
                            <td width="205" align="right"><strong>{$lang.sendeme}</strong></td>
                            <td>

                                <input name="EmailSwitch" type="radio" value="on"
                                       {if $configuration.EmailSwitch=='on'}checked="checked"{/if}/>
                                <strong>{$lang.EmailSwitchd1}</strong><br/>

                                <input name="EmailSwitch" type="radio" value="off"
                                       {if $configuration.EmailSwitch=='off'}checked="checked"{/if}/>
                                <strong>{$lang.EmailSwitchd2}</strong>
                                <br/>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td width="205" align="right"><strong>{$lang.SystemMail}</strong></td>
                            <td><input style="width:50%" name="SystemMail" value="{$configuration.SystemMail}"
                                       class="inp"/></td>
                        </tr>


                        <tr>
                            <td width="205" align="right"><strong>{$lang.MailerMethod}</strong></td>
                            <td>
                                <div class="left"><input type="radio" name="MailUseSMTP" value="off"
                                                         {if $configuration.MailUseSMTP=='off'}checked="checked"{/if}
                                                         onclick="$('.smtp').hide();"/> <strong>{$lang.MailUsePHP}</strong><br/>

                                    <input type="radio" name="MailUseSMTP" value="on"
                                           {if $configuration.MailUseSMTP=='on'}checked="checked"{/if}
                                           onclick="$('.smtp').show();"/> <strong>{$lang.MailUseSMTP}</strong><br/>

                                    <input type="radio" name="MailUseSMTP" value="transactional"
                                           {if $configuration.MailUseSMTP=='transactional'}checked="checked"{/if}
                                           onclick="$('.smtp').hide();"/> <strong>{$lang.MailUseTransactional}</strong> <a href="#" class="vtip_description"
                                                                                                                           title="For this to work you'd need active one of transactional email modules"></a>
                                </div>
                                <div class="left" style="padding:10px 20px;">
                                    <a class="new_control" href="#"
                                       onclick="$(this).hide();$('#testmailsuite').show();return false;"><span
                                                class="wizard">{$lang.sendtestmail}</span></a>
                                    <div id="testmailsuite" style="display:none">
                                        <span id="testmailsuite2">
                                            Enter email address: <input type="text" name="testmail"
                                                                        id="testmailaddress"/> <a class="new_control"
                                                                                                  href="#"
                                                                                                  onclick="testConfiguration() ;return false;"><span><b>{$lang.Send}</b></span></a>
                                        </span><span id="testing_result"></span>
                                    </div>

                                </div>
                                <div class="clear"></div>
                            </td>
                        </tr>

                        <tr class="smtp" {if $configuration.MailUseSMTP!='on'}style="display:none"{/if}>
                            <td width="205" align="right">SMTP Email address</td>
                            <td><input class="inp" name="MailSMTPEmail" value="{$configuration.MailSMTPEmail}"
                                       style="width: 250px"/></td>
                        </tr>

                        <tr class="smtp" {if $configuration.MailUseSMTP!='on'}style="display:none"{/if}>
                            <td width="205" align="right">{$lang.MailSMTPHost}  <a href="#" class="vtip_description"
                                                                                   title="You can enforce tls protocol by adding 'tls://' to hostname"></a>
                            <td><input class="inp" name="MailSMTPHost" value="{$configuration.MailSMTPHost}"
                                       style="width: 250px"/>
                                {$lang.MailSMTPPort} <input class="inp" name="MailSMTPPort"
                                                            value="{$configuration.MailSMTPPort}" size="3"/></td>
                        </tr>

                        <tr class="smtp" {if $configuration.MailUseSMTP!='on'}style="display:none"{/if}>
                            <td width="205" align="right">{$lang.MailSMTPUsername}</td>
                            <td><input class="inp" name="MailSMTPUsername" value="{$configuration.MailSMTPUsername}"
                                       style="width: 250px"/></td>
                        </tr>

                        <tr class="smtp" {if $configuration.MailUseSMTP!='on'}style="display:none"{/if}>
                            <td width="205" align="right">{$lang.MailSMTPPassword}</td>
                            <td><input class="inp" name="MailSMTPPassword" value="{$configuration.MailSMTPPassword}"
                                       style="width: 250px" type="password" autocomplete="off"/></td>
                        </tr>

                        <tr class="bordme">
                            <td width="205" align="right"><strong>Limit mails per cron run </strong>
                                <a href="#" class="vtip_description"
                                   title="Set maximum number of email notifications HostBill should sent per one cron run"></a>
                            </td>
                            <td><input style="width:30px" name="EmailsPerCronRun"
                                       value="{$configuration.EmailsPerCronRun}" class="inp"/></td>
                        </tr>


                    </table>
                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable4"
                           style="display:none">
                        <tr>
                            <td width="205" align="right"><strong>{$lang.WrapPlainTextEmails}</strong><br/>
                                <small>(This will convert them to html)</small>
                            </td>
                            <td><input type="checkbox" name="ForceWraperOnPlaintext" value="on"
                                       {if $configuration.ForceWraperOnPlaintext=='on'}checked="checked"{/if} /></td>
                        </tr>
                        <tr class="bordme">
                            <td width="205" align="right" valign="top">
                                <strong>{$lang.htmlwrapper}</strong>
                                <br><br>
                                <a onclick="$(this).attr('href',$(this).attr('rel')+'&EmailHTMLWrapper='+$('#EmailHTMLWrapper').val());return true"
                                   class="new_control"
                                   href="?cmd=emailtemplates&action=preview&security_token={$security_token}&body=Your message will be placed here"
                                   rel="?cmd=emailtemplates&action=preview&security_token={$security_token}&body=Your message will be placed here"
                                   target="_blank">
                                    <span class="zoom">{$lang.Preview}</span>
                                </a>
                            </td>
                            <td>
                                <textarea style="width:50%;height:100px;" name="EmailHTMLWrapper" class="inp"
                                          id="EmailHTMLWrapper">{$configuration.EmailHTMLWrapper}</textarea><br/>
                                <small>{$lang.htmlwrapper_desc}</small>
                            </td>
                        </tr>

                    <tr class="bordme">
                        <td width="205" align="right" valign="top">
                            <strong>Inline CSS</strong>
                            <a href="#" class="vtip_description" title="With this option enabled style blocks in your email templates will be inlined before sending emails. This is required by some email clients that does not allow/parse style tag"></a>
                        </td>
                        <td>
                            <input type="checkbox" value="on" name="EmailInlineCSS" {if $configuration.EmailInlineCSS=='on'}checked="checked"{/if} />
                        </td>
                    </tr>
                 <tr class="bordme">
                     <td width="205" align="right" valign="top"><strong>{$lang.EmailSignature}</strong></td><td>
                         <textarea  style="width:50%;height:55px;" name="EmailSignature" class="inp">{$configuration.EmailSignature}</textarea><br />
                         <small>{$lang.EmailSignature_desc}</small>
                     </td>
                 </tr>

                    </table>
                </div>


                <div class="sectioncontent" style="display:none">
                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="list-3content"
                           id="currencyedittable">
                        <tr class="bordme">
                            <td width="205px" align="right">
                                <strong>{$lang.CurrencyName}</strong>
                            </td>
                            <td>
                                <select style="width:25%" class="inp" onchange="c_reload(this)">
                                    <option {if $configuration.ISOCurrency=='USD'}selected="selected"{/if}>USD</option>
                                    <option {if $configuration.ISOCurrency=='GBP'}selected="selected"{/if}>GBP</option>
                                    <option {if $configuration.ISOCurrency=='EUR'}selected="selected"{/if}>EUR</option>
                                    <option {if $configuration.ISOCurrency=='BRL'}selected="selected"{/if}>BRL</option>
                                    <option {if $configuration.ISOCurrency=='INR'}selected="selected"{/if}>INR</option>
                                    <option {if $configuration.ISOCurrency=='CAD'}selected="selected"{/if}>CAD</option>
                                    <option {if $configuration.ISOCurrency=='ZAR'}selected="selected"{/if}>ZAR</option>
                                    <option value="-1" {if
                                    !( $configuration.ISOCurrency=='USD' || $configuration.ISOCurrency=='GBP' ||  $configuration.ISOCurrency=='BRL'
                                    ||  $configuration.ISOCurrency=='EUR' ||  $configuration.ISOCurrency=='INR'||  $configuration.ISOCurrency=='CAD'  ||  $configuration.ISOCurrency=='ZAR')}selected="selected"{/if}>{$lang.other}
                                        ...
                                    </option>
                                </select>
                                <a class="editbtn" href="#"
                                   onclick="$('#currency_edit').toggle(); return false;">{$lang.customize}</a>
                            </td>
                        </tr>
                        <tbody id="currency_edit"
                               {if $configuration.ISOCurrency=='USD' || $configuration.ISOCurrency=='GBP' ||  $configuration.ISOCurrency=='BRL'
                               ||  $configuration.ISOCurrency=='EUR' ||  $configuration.ISOCurrency=='INR'||  $configuration.ISOCurrency=='CAD'  ||  $configuration.ISOCurrency=='ZAR'}style="display:none"{/if} >
                            <tr class="bordme">
                                <td width="205px" align="right">
                                    <strong>{$lang.Preview}</strong>
                                </td>
                                <td id="pricepreview">
                                    <span></span>
                                </td>

                            </tr>
                            <tr class="bordme">
                                <td width="205px" align="right">
                                    <strong>{$lang.CurrencyFormat}</strong>
                                </td>
                                <td>
                                    <select style="width:25%" name="CurrencyFormat" id="CurrencyFormat" class="inp">
                                        <option value="1,234.56"
                                                {if $configuration.CurrencyFormat=="1,234.56"}selected="selected"{/if}>
                                            1,234.56
                                        </option>
                                        <option value="1.234,56"
                                                {if $configuration.CurrencyFormat=="1.234,56"}selected="selected"{/if}>
                                            1.234,56
                                        </option>
                                        <option value="1 234.56"
                                                {if $configuration.CurrencyFormat=="1 234.56"}selected="selected"{/if}>1
                                            234.56
                                        </option>
                                        <option value="1 234,56"
                                                {if $configuration.CurrencyFormat=="1 234,56"}selected="selected"{/if}>1
                                            234,56
                                        </option>
                                    </select>
                                </td>
                            </tr>

                            <tr class="bordme">
                                <td width="205px" align="right">
                                    <strong>{$lang.ISOCurrency}</strong>
                                </td>
                                <td>
                                    <input style="width:50px" name="ISOCurrency" id="ISOCurrency"
                                           value="{$configuration.ISOCurrency}" class="inp"/>
                                </td>
                            </tr>
                            <tr class="bordme">
                                <td width="205px" align="right">
                                    <strong>{$lang.CurrencyCode}</strong>
                                </td>
                                <td>
                                    <input style="width:50px" name="CurrencyCode" id="CurrencyCode"
                                           value="{$configuration.CurrencyCode}" class="inp"/>
                                </td>
                            </tr>
                            <tr>
                                <td width="205px" align="right">
                                    <strong>{$lang.CurrencySign}</strong>
                                </td>
                                <td>
                                    <input style="width:50px" name="CurrencySign" id="CurrencySign"
                                           value="{$configuration.CurrencySign}" class="inp"/>
                                </td>
                            </tr>
                        </tbody>
                        <tbody>
                            <tr class="bordme">
                                <td align="right">
                                    <strong>Storage Decimal Places <a href="#" class="vtip_description"
                                                                      title="Number of decimal places you can use to setup pricing in admin area."></a></strong>
                                </td>
                                <td><span>{$configuration.DecimalPlaces} - <a class="editbtn" href="#"
                                                                              onclick="return confirm('Note: Decreasing Decimal Places value will result in truncating all prices to fit new format.') && $(this).parent().hide() && $('#DecimalPlaces').show();">edit</a></span>
                                    {*}<select style="width:25%; display: none;" name="DecimalPlaces" id="DecimalPlaces" class="inp">
                                        <option value="0" {if $configuration.DecimalPlaces=="0"}selected="selected"{/if}>0</option>
                                        <option value="2" {if $configuration.DecimalPlaces=="2"}selected="selected"{/if}>2</option>
                                        <option value="3" {if $configuration.DecimalPlaces=="3"}selected="selected"{/if}>3</option>
                                        <option value="4" {if $configuration.DecimalPlaces=="4"}selected="selected"{/if}>4</option>
                                    </select>
                                    {*}
                                    <input style="display: none;" size="3" type="number" name="DecimalPlaces" max="20"
                                           id="DecimalPlaces" class="inp" value="{$configuration.DecimalPlaces}"
                                           onkeyup="if(parseInt($(this).val().replace(/\D/g,'')) > 20) $(this).val(20);"/>
                                </td>
                            </tr>
                            <tr class="bordme">
                                <td align="right">
                                    <strong>Display Decimal Places <a href="#" class="vtip_description"
                                                                      title="Number of decimal places to display, prices will be rounded up to selected precision when ordering or generating invoices."></a></strong>
                                </td>
                                <td><span>{$configuration.DisplayDecimalPlaces} - <a class="editbtn" href="#"
                                                                                     onclick="return $(this).parent().hide() && $('#DisplayDecimalPlaces').show();">edit</a></span>
                                    {*}<select style="width:25%; display: none;" name="DisplayDecimalPlaces" id="DisplayDecimalPlaces" class="inp">
                                        <option value="0" {if $configuration.DisplayDecimalPlaces=="0"}selected="selected"{/if}>0</option>
                                        <option value="2" {if $configuration.DisplayDecimalPlaces=="2"}selected="selected"{/if}>2</option>
                                        <option value="3" {if $configuration.DisplayDecimalPlaces=="3"}selected="selected"{/if}>3</option>
                                        <option value="4" {if $configuration.DisplayDecimalPlaces=="4"}selected="selected"{/if}>4</option>
                                    </select>{*}
                                    <input style="display: none;" size="3" type="number" name="DisplayDecimalPlaces"
                                           max="20" id="DisplayDecimalPlaces" class="inp"
                                           value="{$configuration.DisplayDecimalPlaces}"
                                           onkeyup="if(parseInt($(this).val().replace(/\D/g,'')) > 20) $(this).val(20);"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <script type="text/javascript">
                        {literal}
                        function pricepreview() {

                            var sign = $('#CurrencySign').val();
                            var format = $('#CurrencyFormat option:selected').val();
                            var dp = $('#DecimalPlaces option:selected').val();
                            var code = $('#CurrencyCode').val();
                            ajax_update('?cmd=configuration&action=pricepreview', {
                                format: format,
                                sign: sign,
                                dp: dp,
                                code: code,
                                decimal: $('#DisplayDecimalPlaces').val()
                            }, '#pricepreview');
                        }

                        $(document).ready(function () {
                            pricepreview();
                            nwConfigSaveFirst();
                            $('input,select', '#currencyedittable').change(function () {
                                pricepreview();

                            });
                        });

                        {/literal}
                    </script>
                    <div class="list-3content" style="display: none;">

                        <div class="blu">
                            <input type="button" value="{$lang.addnewcurrency}" class="btn btn-xs btn-success"
                                   onclick="$('#newcurr').toggle(); makeadd();"/> &nbsp;&nbsp;
                            <!--{$lang.ISOCurrency}: <strong>{$main.iso}</strong> {$lang.CurrencyCode}: <strong>{$main.code}</strong> {$lang.CurrencySign}: <strong>{$main.sign}</strong>-->
                        </div>
                        <div class="well" style="padding:5px;display:none;" id="newcurr">
                            <input type="hidden" value="" name="make"/>

                            <table border="0" cellpadding="3" cellspacing="0" width="100%">
                                <tr>
                                    <td width="130"><strong>{$lang.currcode}</strong></td>
                                    <td><input size="4" name="code"/><br/>
                                        <small>{$lang.ccodedescr}</small>
                                    </td>

                                    <td width="130"><strong>{$lang.currsign}</strong></td>
                                    <td><input size="4" name="sign"/><br/>
                                        <small>{$lang.csigndescr}</small>
                                    </td>

                                    <td width="130"><strong>{$lang.currrate}</strong></td>
                                    <td><input size="4" name="rate" value="1.0000"/><br/>
                                        <small>{$lang.cratedescr}{$currency.code}</small>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="130" style="border:none;"><strong>{$lang.curriso}</strong></td>
                                    <td style="border:none;"><input size="4" name="iso"/></td>

                                    <td width="130"><strong>{$lang.currupdate}</strong></td>
                                    <td><input type="checkbox" name="update" value="1"/></td>

                                    <td width="130"><strong>{$lang.CurrencyFormat}</strong></td>
                                    <td>
                                        <select name="format">
                                            <option>1,234.56</option>
                                            <option>1.234,56</option>
                                            <option>1 234.56</option>
                                            <option>1,234</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>

                                    <td colspan="6">
                                        <center><input type="submit" style="font-weight:bold" value="{$lang.submit}"
                                                       class="btn btn-sm btn-primary"/> <input type="button"
                                                                                               value="{$lang.Cancel}"
                                                                                               onclick="$('#newcurr').hide()"
                                                                                               class="btn btn-sm btn-default"/>
                                        </center>
                                    </td>
                                </tr>
                            </table>


                        </div>
                        {if $currencies}
                            <table class="table glike" cellpadding="3" cellspacing="0" width="100%">
                                <tr>
                                    <th>{$lang.curriso}</th>
                                    <th>{$lang.currsign}</th>
                                    <th>{$lang.currcode}</th>
                                    <th>{$lang.currrate}</th>
                                    <th>{$lang.currlastupdate}</th>
                                    <th>{$lang.currdisplay}</th>

                                    <th width="60"></th>
                                </tr>
                                {foreach from=$currencies item=curr}
                                    <tr id="curr_{$curr.id}">
                                        <td><strong>{$curr.iso}</strong></td>
                                        <td>{$curr.sign}</td>
                                        <td>{$curr.code}</td>
                                        <td>{$curr.rate}</td>
                                        <td>{$curr.last_changes|dateformat2:$date_format}</td>
                                        <td><input type="checkbox" value="1" name="enable"
                                                   {if $curr.enable}checked="checked"{/if}
                                                   onclick="updateEnable(this,{$curr.id})"/></td>

                                        <td><a href="?cmd=configuration&action=currency&getdetails={$curr.id}"
                                               class="editbtn" onclick="return showeditform(this,{$curr.id});"
                                               s>{$lang.Edit}</a>
                                            <a href="?cmd=configuration&action=currency&make=delete&id={$curr.id}&security_token={$security_token}"
                                               class="delbtn"
                                               onclick="return confirm('{$lang.confirmCurrRemove}');">{$lang.remove}</a>
                                        </td>
                                    </tr>
                                {/foreach}
                            </table>
                        {/if}
                        <script type="text/javascript"> {literal}
                            function makeadd() {
                                var make = $('#newcurr input[name=make]').val();
                                if (make == '') {
                                    $('#newcurr input[name=make]').val('add')
                                } else {
                                    $('#newcurr input[name=make]').val('')
                                }
                            }

                            function updateEnable(el, id) {
                                var vis = ($(el).is(':checked')) ? '1' : '0';
                                ajax_update('?cmd=configuration&action=currency&make=upenable&enable=' + vis + '&id=' + id, false);
                                return false;
                            }

                            function showeditform(el, id) {
                                ajax_update($(el).attr('href'), false, '#curr_' + id);
                                return false;
                            }
                            {/literal}
                        </script>
                    </div>
                </div>
                <div class="sectioncontent" style="display:none">

                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectiontable7">
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Logout inactive clients after</strong>
                            </td>
                            <td>
                                <input name="ClientLogoutAfter" type="text" value="{$configuration.ClientLogoutAfter}"
                                       size="3"/> minutes
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>{$lang.EnableProfiles}</strong>
                            </td>
                            <td>
                                <input name="EnableProfiles" type="radio" value="on"
                                       {if $configuration.EnableProfiles=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="EnableProfiles" type="radio" value="off"
                                       {if $configuration.EnableProfiles=='off'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>{$lang.EnableClientScurity}</strong>
                            </td>
                            <td>
                                <input name="EnableClientScurity" type="radio" value="on"
                                       {if $configuration.EnableClientScurity=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="EnableClientScurity" type="radio" value="off"
                                       {if $configuration.EnableClientScurity=='off'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>{$lang.EnableClientScuritySSHKey}</strong>
                            </td>
                            <td>
                                <input name="EnableClientScuritySSHKey" type="radio" value="on"
                                       {if $configuration.EnableClientScuritySSHKey!='off'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="EnableClientScuritySSHKey" type="radio" value="off"
                                       {if $configuration.EnableClientScuritySSHKey=='off'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow canceling service with unpaid invoice</strong>
                            </td>
                            <td>
                                <input name="CanCancelUnpaidService" type="radio" value="on"
                                       {if $configuration.CanCancelUnpaidService=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="CanCancelUnpaidService" type="radio" value="off"
                                       {if $configuration.CanCancelUnpaidService!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow canceling unpaid invoice for new order</strong>
                            </td>
                            <td>
                                <input name="CanCancelUnpaidInvoice" type="radio" value="on"
                                       {if $configuration.CanCancelUnpaidInvoice=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="CanCancelUnpaidInvoice" type="radio" value="off"
                                       {if $configuration.CanCancelUnpaidInvoice!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow upgrading service with unpaid invoice</strong>
                            </td>
                            <td>
                                <input name="CanUpgradeUnpaidService" type="radio" value="on"
                                       {if $configuration.CanUpgradeUnpaidService=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="CanUpgradeUnpaidService" type="radio" value="off"
                                       {if $configuration.CanUpgradeUnpaidService!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow client to remove unpaid "add funds" and "bulk payment" invoices</strong>
                            </td>
                            <td>
                                <input name="CanRemoveUnpaidInvoices" type="radio" value="on"
                                       {if $configuration.CanRemoveUnpaidInvoices=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="CanRemoveUnpaidInvoices" type="radio" value="off"
                                       {if $configuration.CanRemoveUnpaidInvoices!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow customer to control invoice merge settings</strong>
                            </td>
                            <td>
                                <input name="CanSetMergeInvoice" type="radio" value="on"
                                       {if $configuration.CanSetMergeInvoice=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="CanSetMergeInvoice" type="radio" value="off"
                                       {if $configuration.CanSetMergeInvoice!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow cancelling invoice for domain renewal</strong>
                            </td>
                            <td>
                                <input name="CanCancelDomainRenewalInvoice" type="radio" value="on"
                                       {if $configuration.CanCancelDomainRenewalInvoice=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="CanCancelDomainRenewalInvoice" type="radio" value="off"
                                       {if $configuration.CanCancelDomainRenewalInvoice!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>{$lang.AllowSignupWithoutPurchase}</strong>
                            </td>
                            <td>
                                <input name="AllowSignupWithoutPurchase" type="radio" value="on"
                                       {if $configuration.AllowSignupWithoutPurchase!='off'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="AllowSignupWithoutPurchase" type="radio" value="off"
                                       {if $configuration.AllowSignupWithoutPurchase=='off'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Grant access to domain contacts</strong>
                            </td>
                            <td>
                                <input name="GrantDomainAccessToContacts" type="radio" value="1"
                                       {if $configuration.GrantDomainAccessToContacts}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong>,
                                add domain management privileges to contacts used for registration or transfer.
                                <br/>
                                <input name="GrantDomainAccessToContacts" type="radio" value="0"
                                       {if !$configuration.GrantDomainAccessToContacts}checked="checked"{/if} />
                                <strong>{$lang.no}</strong>, do not add domain access privileges to domain contacts.
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Notify domain contacts</strong>
                            </td>
                            <td>
                                <input name="NotifyDomainContacts" type="radio" value="1"
                                       {if $configuration.NotifyDomainContacts}checked="checked"{/if} />
                                <strong>{$lang.yes}</strong>,
                                send sign-up email to contacts created for domain registration or transfer.
                                <br/>
                                <input name="NotifyDomainContacts" type="radio" value="0"
                                       {if !$configuration.NotifyDomainContacts}checked="checked"{/if} />
                                <strong>{$lang.no}</strong>, do not send welcome email to new domain contacts.
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow client to receive portal notifications</strong>
                            </td>
                            <td>
                                <input name="EnablePortalNotifications" type="radio" value="on"
                                       {if $configuration.EnablePortalNotifications=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="EnablePortalNotifications" type="radio" value="off"
                                       {if $configuration.EnablePortalNotifications!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow client to view credit log</strong>
                            </td>
                            <td>
                                <input name="AllowClientViewCreditLog" type="radio" value="on" {if $configuration.AllowClientViewCreditLog=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="AllowClientViewCreditLog" type="radio" value="off" {if $configuration.AllowClientViewCreditLog!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow to see Canceled/Terminated services</strong>
                            </td>
                            <td>
                                <input name="AllowSeeCanceledServices" type="radio" value="on" {if $configuration.AllowSeeCanceledServices=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="AllowSeeCanceledServices" type="radio" value="off" {if $configuration.AllowSeeCanceledServices!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>{$lang.AllowControlInvoiceDelivery}</strong>
                            </td>
                            <td>
                                <input name="AllowControlInvoiceDelivery" type="radio" value="on" {if $configuration.AllowControlInvoiceDelivery=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="AllowControlInvoiceDelivery" type="radio" value="off" {if $configuration.AllowControlInvoiceDelivery!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Allow immediate service owner change</strong>
                            </td>
                            <td>
                                <input name="ImmediateServiceOwnerChange" type="radio" value="on" {if $configuration.ImmediateServiceOwnerChange=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong>after client change service to new order it will be transferred immediately
                                <br/>
                                <input name="ImmediateServiceOwnerChange" type="radio" value="off" {if $configuration.ImmediateServiceOwnerChange!='on'}checked="checked"{/if} />
                                <strong>{$lang.no}, </strong>each request needs to be approved by new owner
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectiontable7"
                           style="display:none">
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>{$lang.RecordsPerPage}</strong>
                            </td>
                            <td>
                                <select name="RecordsPerPage" class="inp">
                                    <option value="25" {if $configuration.RecordsPerPage=='25'}selected="selected"{/if}>
                                        25
                                    </option>
                                    <option value="50" {if $configuration.RecordsPerPage=='50'}selected="selected"{/if}>
                                        50
                                    </option>
                                    <option value="75" {if $configuration.RecordsPerPage=='75'}selected="selected"{/if}>
                                        75
                                    </option>
                                    <option value="100"
                                            {if $configuration.RecordsPerPage=='100'}selected="selected"{/if}>100
                                    </option>
                                </select>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Password restore method</strong>
                            </td>
                            <td>
                                <input name="PasswordRestoreMethod" type="radio" value="email" {if $configuration.PasswordRestoreMethod=='email'}checked="checked"{/if} />
                                <strong>Email</strong> - send random password over email after confirming password change<br/>

                                <input name="PasswordRestoreMethod" type="radio" value="manual" {if $configuration.PasswordRestoreMethod=='manual'}checked="checked"{/if} />
                                <strong>Manual</strong> - request entering new password after confirming password change
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>{$lang.EnableClientCaptchaLogin}</strong>
                            </td>
                            <td>
                                <input name="EnableClientCaptchaLogin" type="radio" value="on"
                                       {if $configuration.EnableClientCaptchaLogin=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="EnableClientCaptchaLogin" type="radio" value="off"
                                       {if $configuration.EnableClientCaptchaLogin=='off'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>


                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Force HTTPS in links <a
                                            title="When enabled, all HostBill-generated/parsed links will use HTTPS protocol"
                                            class="vtip_description" href="#"></a></strong>
                            </td>
                            <td>
                                <input name="ForceHTTPS" type="radio" value="on"
                                       {if $configuration.ForceHTTPS=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="ForceHTTPS" type="radio" value="off"
                                       {if $configuration.ForceHTTPS!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>


                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Verify Session IP address <a
                                            title="When enabled, customer/admin IP will be verified against original IP that was used to login. This is to prevent from hijacking session data on servers with weak security configuration. If your customers IPs change often they may be logged out because of this setting enabled."
                                            class="vtip_description" href="#"></a></strong>
                            </td>
                            <td>
                                <input name="VerifySessionIP" type="radio" value="on"
                                       {if $configuration.VerifySessionIP=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="VerifySessionIP" type="radio" value="off"
                                       {if $configuration.VerifySessionIP!='on'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>


                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Ban client IP after </strong>
                            </td>
                            <td>
                                <input name="BanClientIPLogin" type="text" value="{$configuration.BanClientIPLogin}"
                                       size="5"/> unsuccessful login attempts for
                                <input name="BanClientIPLoginTime" type="number" value="{$configuration.BanClientIPLoginTime}" min="0" style="width:70px;"/>
                                 minutes
                                <a title="Set 0 to disable."
                                   class="vtip_description" href="#"></a>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" width="205" valign="top">
                                <strong>Trusted proxies</strong>
                                <a title="If you use loadbalancer, proxy, NAT, cloudflare etc. enter IP address/subnets that your traffic will be forwarded from to get real IP addresses<br>List shoudl be separated by comma (,) eg: <br/> 192.168.1.10,<br> 172.10.10.0/24"
                                   class="vtip_description" href="#"></a>
                            </td>
                            <td>
                                <textarea name="TrustedProxies" class="inp" placeholder="example: 192.168.1.0/24"
                                          style="width:500px;">{$configuration.TrustedProxies}</textarea>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205" valign="top">
                                <strong>{$lang.SEOUrlMode}</strong>
                            </td>
                            <td>
                                <input name="SEOUrlMode" type="radio" onclick="$('#htacode').slideUp();"
                                       value="index.php?/"
                                       {if $configuration.SEOUrlMode=='index.php?/'}checked="checked"{/if} class="left"
                                       id="seo_1"/> <label class="w150 left" for="seo_1">Default</label>
                                <div class="code left">{$system_url}index.php?/cart/</div>
                                <br/>
                                <div class="clear"></div>
                                <input name="SEOUrlMode" type="radio" onclick="$('#htacode').slideUp();"
                                       value="index.php/"
                                       {if $configuration.SEOUrlMode=='index.php/'}checked="checked"{/if} class="left"
                                       id="seo_2"/> <label class="w150 left" for="seo_2">Basic</label>
                                <div class="code left">{$system_url}index.php/cart/</div>
                                <br/>
                                <div class="clear"></div>
                                <input name="SEOUrlMode" type="radio" onclick="$('#htacode').slideUp();" value="?/"
                                       {if $configuration.SEOUrlMode=='?/'}checked="checked"{/if} class="left"
                                       id="seo_3"/> <label class="w150 left" for="seo_3">Advanced</label>
                                <div class="code left">{$system_url}?/cart/</div>
                                <br/>
                                <div class="clear"></div>
                                <input name="SEOUrlMode" type="radio" onclick="$('#htacode').slideDown();" value=""
                                       {if $configuration.SEOUrlMode==''}checked="checked"{/if} class="left"
                                       id="seo_4"/> <label class="w150 left" for="seo_4">Apache Mod Rewrite</label>
                                <div class="code left">{$system_url}cart/</div>
                                <br/>
                                <div class="clear"></div>
                                <div id="htacode" class="code"
                                     style="{if $configuration.SEOUrlMode!=''} display:none;{/if}font-size:10px;width:500px;margin:5px 0px;-moz-box-shadow: inset 0 0 2px #888;-webkit-box-shadow: inset 0 0 2px #888;box-shadow: inner 0 0 2px #888;padding:10px;">
                                    ## create .htaccess file in main HostBill directory with contents below<br>
                                    &lt;IfModule mod_rewrite.c&gt;<br>
                                    RewriteEngine On <br>
                                    RewriteBase {$rewritebase}<br>
                                    RewriteRule ^downloads/?$ ?cmd=downloads [NC,L]<br>
                                    {literal}RewriteCond %{REQUEST_FILENAME} !-f
                                        <br>
                                        RewriteCond %{REQUEST_FILENAME} !-d
                                        <br>
                                        RewriteRule ^(.*)$ index.php?/$1 [L]
                                        <br>
                                        &lt;/IfModule&gt;{/literal}
                                </div>
                            </td>
                        </tr>
                    </table>

                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectiontable7"
                           style="display:none">

                        <tr class="bordme">
                            <td width="205" align="right"><strong>Admin Area template</strong></td>
                            <td>
                                <select style="width:40%" name="AdminTemplate" class="inp">
                                    {foreach from=$admin_templates item=t}
                                        <option {if $configuration.AdminTemplate==$t}selected="selected"{/if}>{$t}</option>
                                    {/foreach}
                                </select>

                            </td>
                        </tr>


                        <tr class="bordme">
                            <td width="205" align="right"><strong>Path to logo</strong></td>
                            <td><input style="width:50%" name="AdminLogoPath"
                                       value="{$configuration.AdminLogoPath|escape}" class="inp"/></td>
                        </tr>

                        <tr class="bordme">
                            <td width="205" align="right"><strong>Path to favicon</strong></td>
                            <td><input style="width:50%" name="AdminFavicon"
                                       value="{$configuration.AdminFavicon|escape}" class="inp"/></td>
                        </tr>


                        <tr class="bordme">
                            <td width="205" align="right"><strong>Custom admin title</strong></td>
                            <td><input style="width:50%" name="AdminCustomTitle"
                                       value="{$configuration.AdminCustomTitle|escape}" class="inp"/></td>
                        </tr>

                        <tr class="bordme">
                            <td width="205" align="right"><strong> Document Editor preference</strong></td>
                            <td>
                                <input name="DocumentEditor" type="radio" value="code"
                                       {if $configuration.DocumentEditor=='code'}checked="checked"{/if} />
                                <strong>Source Code editor  </strong><br/>
                                <input name="DocumentEditor" type="radio" value="wysiwyg"
                                       {if $configuration.DocumentEditor=='wysiwyg'}checked="checked"{/if} />
                                <strong> WYSIWYG Editor </strong>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td width="205" align="right"><strong> Email template editor preference</strong></td>
                            <td>
                                <input name="TemplateEditor" type="radio" value="code"
                                       {if $configuration.TemplateEditor=='code'}checked="checked"{/if} />
                                <strong>Source Code editor  </strong><br/>
                                <input name="TemplateEditor" type="radio" value="wysiwyg"
                                       {if $configuration.TemplateEditor=='wysiwyg'}checked="checked"{/if} />
                                <strong> WYSIWYG Editor </strong>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Income Forecast for Suspended accounts</strong>
                            </td>
                            <td>
                                <input name="IncomeForecastSuspended" type="radio" value="on"
                                       {if $configuration.IncomeForecastSuspended!='off'}checked="checked"{/if} />
                                <strong>{$lang.yes} </strong><br/>
                                <input name="IncomeForecastSuspended" type="radio" value="off"
                                       {if $configuration.IncomeForecastSuspended=='off'}checked="checked"{/if} />
                                <strong>{$lang.no} </strong>
                            </td>
                        </tr>

                        <tr class="bordme">
                            <td width="205" align="right" valign="middle">
                                <h3>Smart Search settings</h3>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Search in ticket messages <a href="#" class="vtip_description"
                                                                     title="Searching in messages can slow down search on large databases"></a></strong>
                            </td>
                            <td>
                                <input name="SearchTicketReplies" type="radio" value="on"
                                       {if $configuration.SearchTicketReplies=='on'}checked="checked"{/if} />
                                <strong>{$lang.yes}, </strong> When using smart search search in ticket messages<br/>
                                <input name="SearchTicketReplies" type="radio" value="off"
                                       {if $configuration.SearchTicketReplies!='on'}checked="checked"{/if} />
                                <strong>{$lang.no}, </strong>Search only in ticket subjects
                            </td>
                        </tr>


                        <tr class="bordme">
                            <td width="205" align="right"><strong>Results per category</strong></td>
                            <td><input size="4" name="SearchResults" value="{$configuration.SearchResults|escape}"
                                       class="inp"/></td>
                        </tr>
                    </table>


                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectiontable7"
                           style="display:none">
                        <tr class="bordme">
                            <td align="right" width="205" style="vertical-align: top">
                                <strong>Data Retention</strong>
                            </td>
                            <td>
                                <div class="form-group">
                                    <input name="ArchiveInactiveProfiles" type="checkbox" value="on"
                                           {if $configuration.ArchiveInactiveProfiles=='on'}checked="checked"{/if} />

                                    Automatically archive <strong>inactive</strong>
                                    <div class="vtip_description">
                                        <div>
                                            Client profile that <strong style="color:red">does have</strong> paid invoices on file,
                                            but <strong>does not</strong> have any active account/domain or
                                            unclosed support tickets.
                                            <br />
                                        </div>
                                    </div> client profiles after
                                    <input size="3" name="ArchiveInactiveProfilesDelay"
                                           type="input" value="{$configuration.ArchiveInactiveProfilesDelay}"/>
                                    months since last payment.
                                </div>

                                <div class="form-group">
                                    <input name="RemoveArchivedProfiles" type="checkbox" value="on"
                                           {if $configuration.RemoveArchivedProfiles=='on'}checked="checked"{/if} />

                                    Automatically remove <strong>archived</strong> client profiles after
                                    <input size="3" name="RemoveArchivedProfilesDelay"
                                           type="input" value="{$configuration.RemoveArchivedProfilesDelay}"/>
                                    months since it was archived.
                                </div>

                                <div class="form-group">
                                    <input name="RemoveEmptyClients" type="checkbox" value="on"
                                           {if $configuration.RemoveEmptyClients=='on'}checked="checked"{/if} />
                                    Automatically remove
                                    <strong>empty</strong>
                                    <span class="vtip_description">
                                        <div>
                                            Client profiles that does not have any of the following:
                                            <ul>
                                                <li>Paid invoices</li>
                                                <li>Active hosting account</li>
                                                <li>Registered domain</li>
                                                <li>Unclosed support ticket</li>
                                            </ul>
                                        </div>
                                    </span>
                                    client profiles after
                                    <input size="3" name="RemoveEmptyClientsDelay"
                                           type="input" value="{$configuration.RemoveEmptyClientsDelay}" />
                                    months since sign-up.
                                </div>
                                <div class="form-group">
                                    <input name="RemoveInactiveClients" type="checkbox" value="on"
                                           {if $configuration.RemoveInactiveClients=='on'}checked="checked"{/if} />

                                    Automatically remove <strong>inactive</strong>
                                    <div class="vtip_description">
                                        <div>
                                            Client profile that <strong style="color:red">does have</strong> paid invoices on file,
                                            but <strong>does not</strong> have any active account/domain or
                                            unclosed support tickets.
                                            <br>
                                            Note that this will delete invoice/billing data, you should
                                            enter at least the minimum number of months that it is required
                                            to retain billing data in your country.
                                        </div>
                                    </div>
                                    client profiles after
                                    <input size="3" name="RetainBillingMonths"
                                           type="input" value="{$configuration.RetainBillingMonths}"/>
                                    months since last payment.

                                </div>
                                <div class="form-group">
                                    <input name="RemoveTerminatedAccounts" type="checkbox" value="on"
                                           {if $configuration.RemoveTerminatedAccounts=='on'}checked="checked"{/if} />

                                    Automatically remove <strong>terminated</strong> accounts after
                                    <input size="3" name="RemoveTerminatedAccountsDelay"
                                           type="input" value="{$configuration.RemoveTerminatedAccountsDelay}"/>
                                    days since termination.

                                </div>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205" >
                                <strong>Deletion Handling</strong>
                                <div class="vtip_description">
                                    <div>
                                        When client requests deletion his account status will be changed to
                                        <u>{$lang.PendingRemoval}</u>, depending on your settings it will be removed immediately
                                        or after few days.
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="radio">
                                    <label>
                                        <input name="EnableClientSelfDelete" type="radio" value="off"
                                               {if $configuration.EnableClientSelfDelete != 'on'}checked="checked"{/if} />
                                        <strong>{$lang.No}</strong>, do not allow clients to delete their account
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input name="EnableClientSelfDelete" type="radio" value="on"
                                               {if $configuration.EnableClientSelfDelete == 'on'}checked="checked"{/if} />
                                        <strong>{$lang.Yes}</strong>, allow clients to delete their accounts
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205" >
                                <strong>Deletion Delay</strong>
                                <div class="vtip_description">
                                    <div>
                                        Number of days to wait before account with <u>{$lang.PendingRemoval}</u> status is closed.
                                        Set it to few days to give clients time to change their mind or the time
                                        to react if account deletion was started in error.
                                    </div>
                                </div>
                            </td>
                            <td>
                                Permanently remove client data after
                                <input size="3" name="ClientDeleteDelay"
                                       type="input" value="{$configuration.ClientDeleteDelay}" /> days (since last login)
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205"  style="vertical-align: top; padding-top: 20px;">
                                <strong>Export / report settings</strong>
                            </td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <input name="GDPRExport[]" type="checkbox" value="contacts"
                                               {if in_array('contacts', $configuration.GDPRExport)}checked="checked"{/if} />
                                        Contacts
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="GDPRExport[]" type="checkbox" value="services"
                                               {if in_array('services', $configuration.GDPRExport)}checked="checked"{/if} />
                                        Accounts / Services
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="GDPRExport[]" type="checkbox" value="domains"
                                               {if in_array('domains', $configuration.GDPRExport)}checked="checked"{/if} />
                                        Domains
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="GDPRExport[]" type="checkbox" value="log"
                                               {if in_array('log', $configuration.GDPRExport)}checked="checked"{/if} />
                                        Change log
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="GDPRExport[]" type="checkbox" value="transactions"
                                               {if in_array('transactions', $configuration.GDPRExport)}checked="checked"{/if} />
                                        Transactions
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="GDPRExport[]" type="checkbox" value="invoices"
                                               {if in_array('invoices', $configuration.GDPRExport)}checked="checked"{/if} />
                                        Invoices
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="GDPRExport[]" type="checkbox" value="tickets"
                                               {if in_array('tickets', $configuration.GDPRExport)}checked="checked"{/if} />
                                        Tickets
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right">
                                <strong>GDPR Details template</strong>
                            </td>
                            <td>
                                <a href="?cmd=configuration&action=gdprtemplate" class="btn btn-sm btn-default" target="_blank">Customize</a>
                            </td>
                        </tr>
                    </table>


                    <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectiontable7"
                           style="display:none">
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Export <a href="#" class="vtip_description"
                                                  title="Export will generate a JSON file containing general settings, taxes, currencies, document templates, ticket statuses, order scenarios. You can use this feature i.e.: to test some new options in General Settings and quickly reverting back to old state by using import."></a></strong>
                            </td>
                            <td colspan="2">
                                <a href="?cmd=configuration&action=export&export=true&security_token={$security_token}"
                                   class="btn btn-info">Export</a>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right" width="205">
                                <strong>Import <a href="#" class="vtip_description"
                                                  title="Its not advised to manually modify contents of JSON export file prior to importing"></a></strong>
                            </td>
                            <td width="100">
                                <input style="padding-top: 5px;" type="file" name="fileUpload"/>

                            </td>
                            <td>

                                <button type="submit" name="make" value="importconfig" class="btn-info btn">Import
                                </button>
                            </td>
                        </tr>
                    </table>

                </div>
                
                
                <div class="sectioncontent" style="display:none">
                    <table border="0" cellpadding="10" width="100%" cellspacing="0">
                        <tr class="bordme">
                            <td align="right" width="350">
                                <strong>Domain renewal term</strong>
                            </td>
                            <td>
                                โดเมนจะสามารถ renew ได้ต้องผ่านการทำ provisioning มาแล้ว
                                <input type="text" name="nwConfig[nwShortTermRenewal]" value="{$configuration.nwShortTermRenewal}" size="5" />
                                วัน (ถ้าต้องการ renew ทันทีให้ไปสร้าง order renew แทน)
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right">
                                <strong>Billing department</strong>
                            </td>
                            <td>
                                เมื่อมีการแจ้งยืนยันการชำระเงินผ่านแบบฟอร์มให้ส่ง ticket เข้าแผนก
                                <input type="text" id="nwBillingDepartmentId" name="nwConfig[nwBillingDepartmentId]" value="{$configuration.nwBillingDepartmentId}" size="5" readonly="readonly" />
                                เลือก
                                <select onchange="$('#nwBillingDepartmentId').val($(this).val())">
                                {foreach from=$aDepartments item=aDepartment}
                                <option value="{$aDepartment.id}" {if $aDepartment.id == $configuration.nwBillingDepartmentId}selected="selected"{/if}> {$aDepartment.name} </option>
                                {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td align="right">
                                <strong>Support department</strong>
                            </td>
                            <td>
                                รองรับการส่ง ticket เข้า department ??? เมื่อทำ provisioning กับระบบที่ไม่มี api
                                <input type="text" id="nwSupportDepartmentId" name="nwConfig[nwSupportDepartmentId]" value="{$configuration.nwSupportDepartmentId}" size="5" readonly="readonly" />
                                เลือก
                                <select onchange="$('#nwSupportDepartmentId').val($(this).val())">
                                {foreach from=$aDepartments item=aDepartment}
                                <option value="{$aDepartment.id}" {if $aDepartment.id == $configuration.nwSupportDepartmentId}selected="selected"{/if}> {$aDepartment.name} </option>
                                {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr class="bordme" valign="top">
                            <td align="right">
                                <strong>Default domain tech contact address</strong><br />ภาษาอังกฤษเท่านั้น
                            </td>
                            <td>
                                <table border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td width="200">Client contact ID#</td>
                                    <td>
                                        ดึงข้อมูลจาก <input type="text" id="nwTechnicalContactId" name="nwConfig[nwTechnicalContact][id]" value="{$aConfiguration.nwTechnicalContact.id}" size="40" readonly="readonly" /><br />
                                        เมื่อบันทึกข้อมูลระบบจะ update contact address id ที่ระบุด้วย (เพื่อใช้เป็น default tech contact address id)
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">Companyname</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactCompanyname" name="nwConfig[nwTechnicalContact][companyname]" value="{$aConfiguration.nwTechnicalContact.companyname}" size="40" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">Email</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactEmail" name="nwConfig[nwTechnicalContact][email]" value="{$aConfiguration.nwTechnicalContact.email}" size="40" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">Firstname</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactFirstname" name="nwConfig[nwTechnicalContact][firstname]" value="{$aConfiguration.nwTechnicalContact.firstname}" size="40" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">Lastname</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactLastname" name="nwConfig[nwTechnicalContact][lastname]" value="{$aConfiguration.nwTechnicalContact.lastname}" size="40" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">Address1</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactAddress1" name="nwConfig[nwTechnicalContact][address1]" value="{$aConfiguration.nwTechnicalContact.address1}" size="60" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">Address2</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactAddress2" name="nwConfig[nwTechnicalContact][address2]" value="{$aConfiguration.nwTechnicalContact.address2}" size="60" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">City</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactCity" name="nwConfig[nwTechnicalContact][city]" value="{$aConfiguration.nwTechnicalContact.city}" size="30" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">State</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactState" name="nwConfig[nwTechnicalContact][state]" value="{$aConfiguration.nwTechnicalContact.state}" size="30" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">Postcode</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactPostcode" name="nwConfig[nwTechnicalContact][postcode]" value="{$aConfiguration.nwTechnicalContact.postcode}" size="10" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">Country</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactCountry" name="nwConfig[nwTechnicalContact][country]" value="TH" size="10" readonly="readonly" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="200">Phonenumber</td>
                                    <td>
                                        <input type="text" id="nwTechnicalContactPhonenumber" name="nwConfig[nwTechnicalContact][phonenumber]" value="{$aConfiguration.nwTechnicalContact.phonenumber}" size="30" />
                                    </td>
                                </tr>
                                </table>
                                
                            </td>
                        </tr>
                    </table>
                </div>
            
                
            </div>
        </div>
        <div class="nicerblu" style="text-align:center">
            <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class="btn btn-primary"/>
        </div>
        {securitytoken}</form>
    <script type="text/javascript">
        {literal}

        $(document).ready(function () {
            $('#saveconfigform input[name^="nwConfig"]').bind('keypress', function(e) {
                if(e.keyCode==13){
                    nwConfigSaveFirst();
                    return false;
                }
            });
        });
        
        function nwConfigSaveFirst ()
        {
            $.post('?cmd=configurationhandle&action=update', $('#saveconfigform input[name^="nwConfig"]').serializeObject());
        }

        function loadMod(el) {

            $('#subloader').html('<center><img src="ajax-loading.gif" /></center>');
            ajax_update('index.php?cmd=productaddons&action=showparentmod&addon_id={/literal}{$addon.id}{literal}&parentid=' + $(el).val(), {}, '#loadable');

        }

        function changeFunction(el) {
            $('.mdesc').hide().eq(el.selectedIndex).ShowNicely();
            $('#subloader').html('<center><img src="ajax-loading.gif" /></center>');
            ajax_update('index.php?cmd=productaddons&action=showparentmod&addon_id={/literal}{$addon.id}{literal}&id=' + $(el).val(), {}, '#loadable');
            return false;
        }

        function switch_t3(el, id) {
            $('#automateoptions .billopt').removeClass('checked');
            $(el).addClass('checked');
            if (id == "on1")
                $(el).removeClass('bfirst');
            $('input[name=autosetup]').removeAttr('checked');
            $('input#' + id).attr('checked', 'checked');
            $('#off1_a').hide();
            $('#on1_a').hide();
            $(el).parents('tbody.sectioncontent').find('.savesection').show();
            $('#' + id + '_a').show();
            return false;
        }

        function check_i(element) {
            var td = $(element).parent();
            if ($(element).is(':checked'))
                $(td).find('.config_val').removeAttr('disabled');
            else
                $(td).find('.config_val').attr('disabled', 'disabled');
        }

        function check_fee(elem) {
            if ($(elem).val() == '0')
                $('#fee_amount').hide();
            else
                $('#fee_amount').show();
        }

        function add_extension() {
            var ext = prompt("{/literal}{$lang.enterext}{literal}", "");
            if (!ext)
                return false;
            if (ext.substr(0, 1) == '.')
                ext = ext.substr(1);
            $('#extensions').val($('#extensions').val() + ';.' + ext);
        }

        function testConfiguration() {
            $('#testing_result').html('<img style="height: 16px" src="ajax-loading.gif" />');
            ajax_update('?cmd=configuration&action=test_connection',
                {
                    'SystemMail': $('input[name="SystemMail"]').val(),
                    'testmailaddress': $('#testmailaddress').val(),
                    'MailUseSMTP': $('input[name="MailUseSMTP"]:checked').val(),
                    'MailSMTPHost': $('input[name="MailSMTPHost"]').val(),
                    'MailSMTPPort': $('input[name="MailSMTPPort"]').val(),
                    'MailSMTPEmail': $('input[name="MailSMTPEmail"]').val(),
                    'MailSMTPUsername': $('input[name="MailSMTPUsername"]').val(),
                    'MailSMTPPassword': $('input[name="MailSMTPPassword"]').val()
                }, '#testing_result', false);
        }

        function bindMe() {

            var picked = {/literal}{$picked_tab|default:0}{literal};
            var subpicked = {/literal}{$picked_subtab|default:0}{literal};

            $('#newshelfnav').TabbedMenu({
                elem: '.sectioncontent',
                picker: '.list-1elem',
                aclass: 'active',
                picked: picked
            });
            $('#newshelfnav').TabbedMenu({
                elem: '.subm1',
                picker: '.list-1elem',
                picked: picked
            });
            $('#newshelfnav').TabbedMenu({
                elem: '.sectioncontenttable',
                picker: '.list-2elem',
                picktab: true,
                picked: subpicked
            });
            $('#newshelfnav').TabbedMenu({
                elem: '.sectioncontenttable4',
                picker: '.list-4elem',
                picktab: true,
                picked: subpicked
            });
            $('#newshelfnav').TabbedMenu({
                elem: '.sectiontable7',
                picker: '.list-7elem',
                picktab: true,
                picked: subpicked
            });
            $('#newshelfnav').TabbedMenu({
                elem: '.list-3content',
                picker: '.list-3elem',
                picktab: true,
                picked: subpicked
            });

            $('#newsetup1').click(function () {
                $(this).hide();
                $('#newsetup').show();
                return false;
            });
            $('#recur_b .controls .editbtn').click(function () {
                var e = $(this).parent().parent().parent();
                e.find('.e1').hide();
                e.find('.e2').show();
                return false;
            });
            $('#recur_b .controls .delbtn').click(function () {
                var e = $(this).parent().parent().parent();
                e.find('.e2').hide();
                e.find('.e1').show();
                e.find('input').val('0.00');
                e.hide();
                var id = e.attr('id').substr(0, 1);
                if ($('#tbpricing select option:visible').length < 1) {
                    $('#addpricing').show();
                }
                $('#tbpricing select option[value=' + id + ']').show();

                return false;
            });

            $('.tag-form').hbtags({sortable: true});
            $('#extensions_tag').on('tags.before.add', function (e, tags) {
                for(var i =0; i<tags.length; i++){
                    if(tags[i]){
                        tags[i] = '.' + tags[i].replace(/(\.|\s)?(\w+)/g, '$2');
                    }
                }
            }).on('tags.refresh', function (e, hbtags) {
                $('#extensions').val(hbtags.tags.join(';'));
            });

            $('.import-headers').on('tags.refresh', function(e, hbtags){
                var self = $(this);
                self.next('input').val(hbtags.tags.join(','));
            })

        }

        function add_message(gr, id, msg) {
            var sel = $('#' + gr + '_msg select');
            sel.find('option:selected').removeAttr('selected');
            sel.prepend('<option value="' + id + '">' + msg + '</option>').find('option').eq(0).attr('selected', 'selected');
            return false;

        }

        appendLoader('bindMe');

        function addopt() {
            var e = $('#' + $('#tbpricing select').val() + 'pricing');
            e.find('.inp').eq(0).val($('#newprice').val());
            e.find('.inp').eq(1).val($('#newsetup').val());
            e.find('.pricer_setup').html($('#newsetup').val());
            if ($('#newsetup').val() != '0.00')
                e.find('.pricer_setup').parent().parent().show();
            e.find('.pricer').html($('#newprice').val());
            e.show();
            $('#tbpricing select option:selected').hide();
            if ($('#tbpricing select option:visible').length < 1) {

            } else {
                $('#tbpricing select option:visible').eq(0).attr('selected', 'selected');
                $('#addpricing').show();
            }
            $('#tbpricing').hide();
            $('#newprice').val('0.00');
            $('#newsetup').val('0.00').hide();
            $('#newsetup1').show();

            return false;
        }

        function switch_t2(el, id) {
            $('.billopt').removeClass('checked');
            $(el).addClass('checked');

            $('input[name=paytype]').removeAttr('checked').prop('checked', false);
            $('input#' + id).attr('checked', 'checked').prop('checked', true);
            $('#once_b').hide();
            $('#recur_b').hide();
            $('#' + id + '_b').show();
            $('#hidepricingadd').click();

            return false;
        }

        function c_note() {
            var val = $('input[name=CnoteEnable]:checked').val();
            if (val == 'on')
                $('.cnote').show()
            else
                $('.hide').show()
        }
        {/literal}
    </script>
{/if}