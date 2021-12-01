{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">
        <h2>
            <span>Addon Domains</span>
        </h2>
        <br />
        <div class="body-content">
            <p class="description">
                An addon domain is an additional domain that is stored as a subdomain of your main site. 
                Use addon domains to host additional domains on your account without registering a new domain name. 
            </p>

            <div class="section">
                <table id="subdomaintbl" class="sortable table table-striped">
                    <thead>
                        <tr>
                            <th class=" clickable" style="white-space:nowrap;" nowrap="nowrap">
                                Addon Domains
                            </th>
                            <th class=" clickable">Document Root</th>
                            <th class=" clickable">Username</th>
                            <th class="cell-end sorttable_nosort">Actions</th>
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
                                       onclick="return confirm('Do You really want to delete this entry?')">
                                        <span class="fa fa-trash" title="Remove"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td id="errNoConfigured" colspan="6" class="errors">
                                    No addon domains are configured.
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
                        <h4 id="myModalLabel">Manage Redirection</h4>
                    </div>
                    <div class="modal-body">

                        <input type="hidden" id="domain" value="additional-name.com,additional-name_hosting-demo.com" name="domain">

                        <div class="control-group">
                            <label for="url" id="lblUrl">
                                Domain "<span class="_txt">example.com</span>" redirects to:
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
                            <button type="submit" class="default btn">Change</button>
                            <button type="button" class="default btn hide-modal">Cancel</button>
                        </span>
                    </div> 
                    {securitytoken}
                </form>
            </div>
            <div class="modal hide fade" id="action-root">
                <form action="{$widget_url}&act=root" method="POST" style="margin: 0">
                    <div class="modal-header">
                        <button type="button" class="close hide-modal" aria-hidden="true">×</button>
                        <h4 id="myModalLabel">Change Document root</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" size="40" value="" name="name" class="form-control _txt">
                        <div class="control-group">
                            Document Root for: <span style="word-wrap: break-word" class="_txt">example.org</span>
                        </div>
                        <div class="control-group">
                            <label for="change_docroot_dir">
                                Document Root
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
                            <button type="submit" class="default btn">Change</button>
                            <button type="button" class="default btn hide-modal">Cancel</button>
                        </span>
                    </div>
                    {securitytoken}
                </form>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span6">
                <h3>Create an Addon Domain</h3>
                <div class="section">
                    <form id="mainform" method="post" action="{$widget_url}&act=add" name="mainform">

                        <div class="control-group">
                            <label id="lblDomain" for="domain">
                                New Domain Name
                            </label>
                            <input id="domain" class="form-control" name="domain" type="text" required>
                        </div>
                        <div class="control-group">
                            <label id="lblUser" for="user">
                                Subdomain/FTP Username
                            </label>
                            <input id="user" class="form-control" name="user" type="text">
                        </div>
                        <div class="control-group yui-ac">
                            <label id="lblDir" for="dir">
                                Document Root <i id="docrootImg" class="fa fa-home"></i>/
                            </label>
                            <input autocomplete="off" class="form-control yui-ac-input" size="30" name="dir" id="dir" type="text">
                        </div>
                        <div class="control-group">
                            <label id="lblPassword1" for="password1">
                                Password
                            </label>
                            <input id="password1" name="pass" class="form-control" type="password">
                        </div>
                        <div class="control-group">
                            <label id="lblPassword2" for="password2">
                                Password (Again)
                            </label>
                            <input id="password2" name="pass2" class="form-control" type="password">
                        </div>
                        <div class="control-group">
                            <input id="submit_domain" name="go" class="btn btn-flat-primary btn-primary" value="Add Domain" type="submit">
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
