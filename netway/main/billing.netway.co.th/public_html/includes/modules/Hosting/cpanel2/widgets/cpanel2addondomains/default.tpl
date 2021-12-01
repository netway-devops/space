<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>{$lang.cpanel_name}</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">
        <h2>
            <span>{$lang.cpanel_addon_domain}</span>
        </h2>
        <br />
        <div class="body-content">
            <p class="description">
                {$lang.cpanel_addon_domain_desc}
            </p>

            <div class="section">
                <table id="subdomaintbl" class="sortable table table-striped">
                    <thead>
                        <tr>
                            <th class=" clickable" style="white-space:nowrap;" nowrap="nowrap">
                                {$lang.cpanel_addon_domain}
                            </th>
                            <th class=" clickable">{$lang.cpanel_addon_root}</th>
                            <th class=" clickable">{$lang.cpanel_addon_username}</th>
                            <th class="cell-end sorttable_nosort">{$lang.cpanel_actions}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$list item=entry}
                            <tr>
                                <td style="white-space:nowrap;" nowrap="nowrap">
                                    {$entry.domain}
                                </td>
                                <td>
                                    {$entry.basedir}

                                </td>
                                <td>{$entry.subdomain}</td>
                                <td>
                                    <a class="cp-btn" href="{$widget_url}&act=del&name={$entry.domain}&security_token={$security_token}"
                                       onclick="return confirm('{$lang.cpanel_delete_entry_q}')">
                                        <span class="fa fa-trash" title="{$lang.cpanel_remove}"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td id="errNoConfigured" colspan="6" class="errors">
                                    {$lang.cpanel_addon_no_addons}
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
                <!-- end subdomaintbl -->
            </div>
            <!-- end cpanelfeature addondomains -->
        </div><!-- end body-content -->
        <div style="display: none">
            <div class="modal hide fade" id="action-redirect">
                <form action="{$widget_url}&act=redirect" method="POST" style="margin: 0">
                    <div class="modal-header">
                        <button type="button" class="close hide-modal" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 id="myModalLabel">{$lang.cpanel_addon_manage}</h4>
                    </div>
                    <div class="modal-body">

                        <input type="hidden" id="domain" value="additional-name.com,additional-name_hosting-demo.com" name="domain">

                        <div class="control-group">
                            <label for="url" id="lblUrl">
                                {$lang.cpanel_addon_dom_redirect}
                            </label>
                            <div class="row-fluid">
                                <div class="span6">
                                    <input type="text" value="http://" size="35" id="url" name="url" class="form-control _val" >
                                </div>
                            </div>
                        </div>

                    </div> 
                    <div class="modal-footer">
                        <span class="btn-group pull-right">
                            <button type="submit" class="default btn">{$lang.cpanel_addon_change}</button>
                            <button type="button" class="default btn hide-modal">{$lang.cpanel_cancel}</button>
                        </span>
                    </div> 
                    {securitytoken}
                </form>
            </div>
            <div class="modal hide fade" id="action-root">
                <form action="{$widget_url}&act=root" method="POST" style="margin: 0">
                    <div class="modal-header">
                        <button type="button" class="close hide-modal" aria-hidden="true">×</button>
                        <h4 id="myModalLabel">{$lang.cpanel_addon_change_root}</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" size="40" value="" name="name" class="form-control _txt">
                        <div class="control-group">
                            {$lang.cpanel_addon_change_root_desc}
                        </div>
                        <div class="control-group">
                            <label for="change_docroot_dir">
                                {$lang.cpanel_addon_root}
                            </label>
                            <div class="row-fluid">
                                <div class="span6">
                                    <input type="text" size="40" value="" name="docroot" class="form-control _val">
                                </div>
                                <div class="span6"><div id="change_docroot_dir_error"></div></div>
                            </div>
                        </div>
                    </div> 
                    <div class="modal-footer">
                        <span class="btn-group pull-right">
                            <button type="submit" class="default btn">cpanel_addon_change</button>
                            <button type="button" class="default btn hide-modal">{$lang.cpanel_cancel}</button>
                        </span>
                    </div>
                    {securitytoken}
                </form>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span6">
                <h3>{$lang.cpanel_addon_create}</h3>
                <div class="section">
                    <form id="mainform" method="post" action="{$widget_url}&act=add" name="mainform">

                        <div class="control-group">
                            <label id="lblDomain" for="domain">
                                {$lang.cpanel_addon_new}
                            </label>
                            <input id="domain" class="form-control" name="domain" type="text" required>
                        </div>
                        <div class="control-group">
                            <label id="lblUser" for="user">
                                {$lang.cpanel_addon_ftp}
                            </label>
                            <input id="user" class="form-control" name="user" type="text">
                        </div>
                        <div class="control-group yui-ac">
                            <label id="lblDir" for="dir">
                                {$lang.cpanel_addon_root} <i id="docrootImg" class="fa fa-home"></i>/
                            </label>
                            <input autocomplete="off" class="form-control yui-ac-input" size="30" name="dir" id="dir" type="text">
                        </div>
                        <div class="control-group">
                            <label id="lblPassword1" for="password1">
                                {$lang.cpanel_addon_pass}
                            </label>
                            <input id="password1" name="pass" class="form-control" type="password">
                        </div>
                        <div class="control-group">
                            <label id="lblPassword2" for="password2">
                                {$lang.cpanel_addon_pass2}
                            </label>
                            <input id="password2" name="pass2" class="form-control" type="password">
                        </div>
                        <div class="control-group">
                            <input id="submit_domain" name="go" class="btn btn-flat-primary btn-primary" value="{$lang.cpanel_add_domain}" type="submit">
                        </div>
                        {securitytoken}

                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="{$widgetdir_url}script.js" type="text/javascript"></script>    
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">    
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
{/if}
