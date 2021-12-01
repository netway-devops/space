<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td>
            <h3>{$lang.securitysettings}</h3>
        </td>
        <td>

        </td>
    </tr>
    <tr>
        <td class="leftNav">

            {include file='configuration/leftmenu.tpl'}
            
        </td>
        <td valign="top" class="bordered">
            <div id="bodycont">
                <div id="newshelfnav" class="newhorizontalnav">
                    <div class="list-1">
                        <ul>
                            {if !$forbidAccess.ipAccess}
                                <li {if $action =='default'}class="active"{/if} >
                                    <a href="#default"><span>{$lang.allowedips}</span></a>
                                </li>
                            {/if}
                            {if !$forbidAccess.ipBanned}
                                <li {if $action =='ipban'}class="active"{/if} >
                                    <a href="#ipban"><span>{$lang.bannedips}</span></a>
                                </li>
                            {/if}
                            {if !$forbidAccess.emailsBanned}
                                <li {if $action =='emails'}class="active"{/if} >
                                    <a href="#emails"><span>{$lang.bannedemails}</span></a>
                                </li>
                            {/if}
                            {if !$forbidAccess.loginNotifications}
                                <li {if $action =='iplog'}class="active"{/if} >
                                    <a href="#iplog"><span>{$lang.loggingagent}</span></a>
                                </li>
                            {/if}
                            {if !$forbidAccess.apiManagement}
                                <li {if $action =='apiaccess'}class="active"{/if} >
                                    <a href="#apiaccess"><span>{$lang.apiaccess}</span></a>
                                </li>
                            {/if}
                            {if !$forbidAccess.passwordSettings}
                                <li {if $action =='password'}class="active"{/if} >
                                    <a href="#password"><span>{$lang.passwords}</span></a>
                                </li>
                            {/if}
                        </ul>
                    </div>
                </div>
                {* SECURITY *}
                {if !$forbidAccess.ipAccess}
                    <div class="sectioncontent s-default" style="padding:0px;">
                        <div class="p6" style="margin:10px">
                            <strong>{$lang.security}</strong><br/>
                            <form method="post" action="" onsubmit="return add_rule(this);">
                                <input name="make" value="add_rule" type="hidden"/>
                                <table>
                                    <tr>
                                        <td>{$lang.ipaddress_sub}</td>
                                        <td><input name="ipsub" size="30" class="inp"/></td>
                                        <td>{$lang.action}</td>
                                        <td>
                                            <select name="action_type" class="inp">
                                                <option value="1">{$lang.allow}</option>
                                                <option value="0">{$lang.deny}</option>
                                            </select>
                                        </td>
                                        <td>
                                            {$lang.Description}
                                        </td>
                                        <td>
                                            <input name="description" size="50" class="inp"/>
                                        </td>
                                        <td><input type="submit" value="{$lang.addsecurityrulle}"
                                                   style="font-weight: bold" class="btn btn-primary btn-sm"/></td>
                                    </tr>
                                </table>
                                {securitytoken}
                            </form>
                        </div>
                    </div>
                {/if}
                {if !$forbidAccess.ipBanned}
                    {* IPS *}
                    <div class="sectioncontent s-ipban" style="display:none;padding:0px;">
                        <div class="p6" style="margin:10px">
                            <strong>{$lang.addipbanned}</strong><br/>
                            <form name="" method="post" action="" onsubmit="return add_bannedip(this);">
                                <input name="make" value="add_banned_ip" type="hidden"/>
                                <table>
                                    <tr>
                                        <td>{$lang.banip}</td>
                                        <td><input name="ip" size="20" class="inp"/></td>
                                        <td>{$lang.banreason}</td>
                                        <td><input name="reason" size="50" class="inp"/></td>
                                        <td>{$lang.Expires}</td>
                                        <td>
                                            <select id="exp_email" name="expires_type" onchange="set_forever(this)"
                                                    class="inp">
                                                <option value="1">{$lang.never}</option>
                                                <option value="0">{$lang.pickdate}</option>
                                            </select>
                                        </td>
                                        <td class="expires" style="display: none">
                                            <input name="expires" value="{$expires|dateformat:$date_format}" size="15"
                                                    readonly="readonly"
                                                   class="haspicker inp"/>
                                            <input name="expirestime" value="{$expirestime}" size="5" class="inp"/>
                                        </td>
                                        <td><input type="submit" value="{$lang.banthisip}" style="font-weight: bold"
                                                   class="btn btn-primary btn-sm"/></td>
                                    </tr>
                                </table>
                                {securitytoken}
                            </form>
                        </div>
                    </div>
                {/if}
                {if !$forbidAccess.emailsBanned}
                    {* EMAILS *}
                    <div class="sectioncontent  nicerblu s-emails" style="display:none;padding:0px;">
                        <div class="p6" style="margin:10px">
                            <strong>{$lang.addemaildomain}</strong><br/>
                            <form method="post" action="" onsubmit="return add_bannedemail(this);">
                                <input name="make" value="add_banned_email" type="hidden"/>
                                <table>
                                    <tr>
                                        <td>{$lang.emaildomain}</td>
                                        <td><input name="email" size="20" class="inp"/></td>
                                        <td>{$lang.banreason}</td>
                                        <td><input name="reason" size="50" class="inp"/></td>
                                        <td>{$lang.expires}</td>
                                        <td>
                                            <select name="expires_type" onchange="set_forever(this)" class="inp">
                                                <option value="1">{$lang.never}</option>
                                                <option value="0">{$lang.pickdate}</option>
                                            </select>
                                        </td>
                                        <td class="expires" style="display: none">
                                            <input name="expires" value="{$expires|dateformat:$date_format}" size="15"
                                                   class="haspicker inp"/> <input name="expirestime"
                                                   readonly="readonly"
                                                                                  value="{$expirestime}" size="5"/>
                                        </td>
                                        <td><input type="submit" value="{$lang.banemaildomain}"
                                                   style="font-weight: bold" class="btn btn-primary btn-sm"/></td>
                                    </tr>
                                </table>
                                {securitytoken}
                            </form>
                        </div>
                    </div>
                {/if}
                {if !$forbidAccess.loginNotifications}
                    {* IP-LOGGING-DUMY *}
                    <div class="sectioncontent  nicerblu s-iplog" style="display:none;padding:0px;">
                        <div class="newhorizontalnav">
                            <div class="list-2">
                                <div class="haveitems">
                                    <ul>
                                        <li><a href="index.php?cmd=logs&action=adminactivity">Admin activity log</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                {if !$forbidAccess.apiManagement}
                    {* API *}
                    <div class="sectioncontent  nicerblu s-apiaccess" style="display:none;padding:0px;">
                        <div class="newhorizontalnav clear">
                            <div class="list-2">
                                <div class="haveitems">
                                    <ul>
                                        <li><a href="index.php?cmd=logs&action=apilog">API Usage log</a></li>
                                        <li><a href="http://api.hostbillapp.com/info/gettingStarted/" target="_blank">API
                                                Documentation</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="p6" style="margin:10px">

                            <strong>{$lang.addapiaccess}</strong> <br/>
                            <form method="post" action="" onsubmit="return addAPI(this);">
                                <input name="make" value="add_api" type="hidden"/>
                                <input name="action" value="apiaccess" type="hidden"/>
                                <table>
                                    <tr>
                                        <td>{$lang.ipaddress_sub}</td>
                                        <td><input name="ip" size="30" class="inp"/></td>
                                        <td>Name</td>
                                        <td><input name="name" size="10" class="inp"/></td>
                                        <td>Undeletable?<a href="" class="vtip_description"
                                                            title="When enabled this api key will be impossible to remove from UI, only db removal will be possible. This is to be used with mobile API clients"></a></td>
                                        <td><input name="flags" type="checkbox" value="1" /></td>

                                        <td width="60"></td>
                                        <td><input type="submit" value="{$lang.generateapiaccess}"
                                                   style="font-weight: bold" class="btn btn-primary btn-sm"/></td>
                                    </tr>
                                </table>
                                {securitytoken}
                            </form>
                        </div>
                    </div>
                {/if}
                {if !$forbidAccess.passwordSettings}
                    {* PASSWORD *}
                {literal}
                    <style type="text/css">
                        #passinput {
                            margin: 3px
                        }

                        #password_set {
                            line-height: 20px;
                        }

                        #password_set input {
                            vertical-align: middle
                        }
                    </style>
                {/literal}
                    <div class="sectioncontent s-password" >

                        <form method="post" action="" id="password_set" style="margin: 10px 0">

                                <div class="container-fluid clear">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label style="margin-bottom: 0;">Use following characters in random passwords:</label>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" name="lalpha" value="1"
                                                               {if $pass_set.lalpha}checked="checked"{/if} />
                                                        Lower-case letters (a-z)
                                                    </label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" name="ualpha" value="1"
                                                               {if $pass_set.ualpha}checked="checked"{/if} />
                                                        Upper-case letters (A-Z)
                                                    </label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" name="numbers" value="1"
                                                               {if $pass_set.numbers}checked="checked"{/if} />
                                                        Digits (0-9)
                                                    </label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" name="noalpha" value="1"
                                                               {if $pass_set.noalpha}checked="checked"{/if} onchange="$('.specialchars').toggle()" />
                                                        Special chars (!#$%^*_-+=?|:)
                                                    </label>
                                                </div>

                                            </div>

                                            <div class="form-group">
                                                <label style="margin-bottom: 0;">Minimum length:</label>
                                                <input type="text" name="length" value="{$pass_set.length}" size="4" class="form-control"/>
                                            </div>

                                            <div class="form-group specialchars" {if !$pass_set.noalpha}style="display: none" {/if}>
                                                <label style="margin-bottom: 0;">Minimum special chars count:</label>
                                                <input type="text" name="charlength" value="{$pass_set.charlength}" size="4" class="form-control"/>
                                            </div>

                                            <div class="form-group ">
                                                <label style="margin-bottom: 0;">
                                                    Disabled characters:</a>
                                                </label>
                                                <input type="text" name="PassDisabledChars" value="{$PassDisabledChars}" class="form-control"/>
                                                <p class="help-block">Characters set in this field will not be present in random generated password</p>
                                            </div>

                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label style="margin-bottom: 0;">Enforce current complexity settings for:</label>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" name="---" value="1"
                                                               checked="checked" disabled />
                                                        Random service passwords
                                                    </label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" name="PassEnforceClient" value="1"
                                                               {if $PassEnforceClient}checked="checked"{/if} />
                                                        Client profile password
                                                    </label>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" name="PassEnforceAdmin" value="1"
                                                               {if $PassEnforceAdmin}checked="checked"{/if} />
                                                        Admin profile password
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-12" style="margin-top: 15px;">
                                            <div style="text-align: center">
                                                <input type="submit" value="{$lang.savechanges}" class="btn btn-primary "
                                                       style="font-weight:bold" onclick="return changespass()"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {securitytoken}

                            </form>
                    </div>
                {/if}
                {* endof sectioncontent *}
                <form action="" method="post" id="testform" class="nicerblu">
                    <div class="right" style="margin:2px">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                    {securitytoken}
                </form>

                <a href="?cmd=security&action={$action}" id="currentlist" style="display:none" updater="#updater"
                   data-page="{$sorterpage}"></a>
                <table id="security" cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">

                    {if !$forbidAccess.ipAccess}
                        <thead id="default">
                            <tr>
                                <th width="15%">{$lang.rule}</th>
                                <th>{$lang.action}</th>
                                <th>{$lang.Description}</th>
                                <th width="440">Ban on failed login attempts <a href="" class="vtip_description"
                                                                                title="Automaticaly ban user that fail to provide corect admin area credentials multiple times. Enabled by default."></a>
                                </th>
                                <th width="20"></th>
                            </tr>
                        </thead>
                    {/if}
                    {if !$forbidAccess.ipBanned}
                        <thead id="ipban">
                            <tr>
                                <th>IP</th>
                                <th>{$lang.Expires}</th>
                                <th width="70%">{$lang.banreason}</th>
                                <th width="20"></th>
                            </tr>
                        </thead>
                    {/if}
                    {if !$forbidAccess.emailsBanned}
                        <thead id="emails">
                            <tr>
                                <th width="15%">{$lang.Domain}</th>
                                <th>{$lang.usagecount}</th>
                                <th>{$lang.Expires}</th>
                                <th width="60%">{$lang.banreason}</th>
                                <th width="20"></th>
                            </tr>
                        </thead>
                    {/if}
                    {if !$forbidAccess.loginNotifications}
                        <thead id="iplog">
                            <tr>
                                <th width="15%">{$lang.Administrators}</th>
                                <th>{$lang.email}</th>
                                <th width="20">{$lang.Status}</th>
                            </tr>
                        </thead>
                    {/if}
                    {if !$forbidAccess.apiManagement}
                        <thead id="apiaccess">
                            <tr>
                                <th width="200">Name</th>
                                <th width="200">IP</th>
                                <th width="200">API ID</th>
                                <th width="200">API Key</th>
                                <th>ACL</th>
                                <th></th>
                                <th align="right"></th>
                            </tr>
                        </thead>
                    {/if}
                    {if !$forbidAccess.passwordSettings}
                        <thead>
                        </thead>
                    {/if}

                    <tbody id="updater">

                        {include file='ajax.security.tpl'}
                    </tbody>
                </table>

                {if !$forbidAccess.ipAccess}
                    <div style="min-height:1em;padding:10px" class="sectionfoot nicerblu s-default">
                        <h3 id="legend" style="margin:5px 0 2px;cursor:pointer" class="btn btn-sm btn-default">Show
                            Legend<img src="{$template_dir}img/question-small-white.png"/></h3>
                        <ul style="list-style:inside;padding:0">
                            Rule formats:
                            <li><strong>all</strong> - keyword matching all IPs</li>
                            <li><strong>xxx.xxx.xxx.xxx</strong> - Single IP</li>
                            <li><strong>xxx.xxx.xxx.xxx/M</strong> - IP with Mask in CIDR format</li>
                            <li><strong>xxx.xxx.xxx.xxx/mmm.mmm.mmm.mmm</strong> - IP with Mask in dotted quad format
                            </li>
                        </ul>
                        <ul style="list-style:inside;padding:0">
                            Example rules:
                            <li><strong>120.123.123.57/28</strong> matches IP from 120.123.123.48 to 120.123.123.63</li>
                            <li><strong>120.123.123.57/24</strong> matches IP from 120.123.123.0 to 120.123.123.255</li>
                            <li><strong>120.123.123.57/16</strong> matches IP from 120.123.0.0 to 120.123.255.255</li>
                            <li><strong>120.123.123.57/8</strong> matches IP from 120.0.0.0 to 120.255.255.255</li>
                        </ul>
                        <p style="margin:5px 0 2px"><strong>Secenario #1</strong> Block access from 120.123.123.12 and
                            120.123.123.57
                        </p>
                        <table class="table glike hover" cellspacing="0" cellpadding="3" border="0" width="400">
                            <tr>
                                <th>{$lang.rule}</th>
                                <th>{$lang.action}</th>
                            </tr>
                            <tr>
                                <td>120.123.123.57</td>
                                <td>{$lang.deny}</td>
                            </tr>
                            <tr>
                                <td>120.123.123.12</td>
                                <td>{$lang.deny}</td>
                            </tr>
                        </table>
                        <p style="margin:2em 0 2px">Hostbill allways checks '{$lang.deny}' rules first<br/><strong>Secenario
                                #2</strong> Allow access only from 120.123.123.xxx
                        </p>
                        <table class="table glike hover" cellspacing="0" cellpadding="3" border="0" width="400">
                            <tr>
                                <th>{$lang.rule}</th>
                                <th>{$lang.action}</th>
                            </tr>
                            <tr>
                                <td>120.123.123.1/24</td>
                                <td>{$lang.allow}</td>
                            </tr>
                            <tr>
                                <td>all</td>
                                <td>{$lang.deny}</td>
                            </tr>
                        </table>
                    </div>
                {/if}
                {if !$forbidAccess.ipBanned}
                    <div style="display:none" class="sectionfoot"></div>
                {/if}
                {if !$forbidAccess.emailsBanned}
                    <div style="display:none" class="sectionfoot"></div>
                {/if}
                {if !$forbidAccess.loginNotifications}
                    <div style="display:none" class="sectionfoot"></div>
                {/if}
                {if !$forbidAccess.apiManagement}
                    <div style="min-height:1em;padding:10px;display:none" class="sectionfoot nicerblu">
                        <h3 style="margin:5px 0 2px;cursor:pointer;" class="btn btn-sm btn-default"
                            onclick="$('#sh1x').toggle();">Show Legend<img
                                    src="{$template_dir}img/question-small-white.png"/></h3>
                        <div id="sh1x" style="display:none">
                            <ul style="list-style:inside;padding:0">
                                IP Address/Subnet format:
                                <li><strong>all</strong> - keyword matching all IPs</li>
                                <li><strong>xxx.xxx.xxx.xxx</strong> - Single IP</li>
                                <li><strong>xxx.xxx.xxx.xxx/M</strong> - IP with Mask in CIDR format</li>
                                <li><strong>xxx.xxx.xxx.xxx/mmm.mmm.mmm.mmm</strong> - IP with Mask in dotted quad
                                    format
                                </li>
                            </ul>
                            <ul style="list-style:inside;padding:0">
                                Example entries:
                                <li><strong>120.123.123.57/28</strong> matches IP from 120.123.123.48 to 120.123.123.63
                                </li>
                                <li><strong>120.123.123.57/24</strong> matches IP from 120.123.123.0 to 120.123.123.255
                                </li>
                                <li><strong>120.123.123.57/16</strong> matches IP from 120.123.0.0 to 120.123.255.255
                                </li>
                                <li><strong>120.123.123.57/8</strong> matches IP from 120.0.0.0 to 120.255.255.255</li>
                            </ul>
                        </div>
                    </div>
                {/if}

                <!-- END END END -->
                <script type="text/javascript">
                    {literal}
                    bindEvents();
                    var sorterlink = $('#currentlist');
                    var pitb = {/literal}{if $picked_tab}{$picked_tab}{else}$('#newshelfnav li.active').index(){/if}{literal};

                    $(function () {
                        var page = sorterlink.data('page');
                        if (page)
                            $.fn.pagination.setPage(page - 1);

                        $('.haspicker').datePicker({startDate: startDate});
                        $('#newshelfnav').TabbedMenu({
                            elem: '.sectioncontent',
                            picker: '.list-1 li',
                            aclass: 'active',
                            picked: pitb
                        });
                        $('#legend').siblings().hide();
                        $('#legend').click(function () {
                            $(this).siblings().toggle();
                        });


                        var th = $('#security thead');
                        var tf = $('.sectionfoot');

                        th.hide();
                        tf.hide();
                        th.eq(pitb).show();
                        tf.eq(pitb).show();

                        function update(newact, back){
                            var head = th.filter('#' + newact);

                            newact = newact || 'default';
                            var uri = '?cmd=security&action=' + newact;
                            if(!back) {
                                window.history.pushState(newact, "", uri);
                            }

                            if (head.length) {
                                ajax_update(uri, {}, function (raw) {
                                    $('#updater').html(raw);
                                    th.hide(), head.show();
                                    tf.hide(), tf.filter('.s-' + newact).show();
                                    $('.pagination').show();
                                    bindEvents();
                                    sorterlink.attr('href', '?cmd=security&action=' + $('#newaction').val());
                                });
                            } else {

                                th.hide(), tf.hide(), $('.pagination').hide(), $('#updater').html('');
                            }
                        }

                        $('#newshelfnav .list-1 li').click(function (e, back) {
                            if(back) {
                                return;
                            }

                            var self = $(this),
                                newact = self.find('a').attr('href').substr(1);
                            update(newact);
                            return false;

                        });

                        $(window).on('popstate', function(e){

                            if(!e.state) {
                                var act = window.location.href.match(/action=([^&]])/);
                                e.state = act ? act[1] : 'default';
                            }

                            update(e.state || 'default', true);
                            $('#newshelfnav a[href="#'+e.state+'"]').parent().trigger('click', true);
                        });
                    })

                    function changestatus(id, st) {
                        updatepage('?cmd=security&action=iplog&make=log_change&status=' + st + '&id=' + id);
                        return false;
                    }

                    function add_rule(form) {
                        updatepage('?cmd=security&' + $(form).serialize());
                        return false;
                    }

                    function remove_rule(href) {
                        if (confirm('{/literal}{$lang.ruleconfirm}{literal}'))
                            updatepage(href);
                        return false;
                    }

                    function toggle_rule(elm) {
                        var self = $(elm);
                        if (self.data('enabled') != true && !confirm('Are you sure? Disabling this option for not trusted ip address wil increase security risk.')) {
                            return false;
                        }
                        updatepage(self.attr('href'));
                        return false;
                    }

                    function add_bannedip(form) {
                        updatepage('?cmd=security&action=ipban&' + $(form).serialize());
                        return false;
                    }

                    function remove_bannedip(href) {
                        if (confirm('{/literal}{$lang.banconfirm2}{literal}'))
                            updatepage(href);
                        return false;
                    }

                    function add_bannedemail(form) {
                        updatepage('?cmd=security&action=emails&' + $(form).serialize());
                        return false;
                    }

                    function remove_bannedemail(href) {
                        if (confirm('{/literal}{$lang.banconfirm1}{literal}'))
                            updatepage(href);
                        return false;
                    }

                    function removeAPI(href) {
                        if (confirm('{/literal}{$lang.apiremoveconfirm}{literal}'))
                            updatepage(href);
                        return false;
                    }

                    function addAPI(form) {
                        updatepage('?cmd=security&' + $(form).serialize());
                        return false;
                    }

                    function set_forever(typ) {
                        var value = $(typ).children(":selected").val();
                        if (value == 1) {
                            $(typ).parent().next('.expires').hide();
                        }
                        else {
                            $(typ).parent().next('.expires').show();
                        }
                    }

                    function updatepage(href) {
                        $('#updater').addLoader();

                        ajax_update(href, {}, function (raw) {

                            $('#updater').html(raw);
                            bindEvents();
                            sorterlink.attr('href', '?cmd=security&action=' + $('#newaction').val());
                        });
                        return false;
                    }

                    function passGenerate() {
                        ajax_update('?cmd=security&action=password&make=pass_test&' + $('#password_set').serialize(), {}, function (raw) {
                            $('#passinput').val(raw.substr(raw.lastIndexOf('-->') + 3));
                        });
                        return false;
                    }

                    function changespass() {
                        $('#password_set').addLoader();
                        ajax_update('?cmd=security&action=password&make=pass_settings&' + $('#password_set').serialize(), {}, function (a) {
                            $('#preloader').remove();
                        });
                        return false;
                    }
                    {/literal}
                </script>
            </div>
        </td>
    </tr>
</table>