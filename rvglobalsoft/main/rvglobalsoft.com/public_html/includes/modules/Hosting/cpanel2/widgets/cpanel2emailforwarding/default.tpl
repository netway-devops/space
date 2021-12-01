{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">
        <h2>
            <span id="pageHeading">Forwarders</span>
        </h2>
        <br />
        <div class="body-content">

            <div class="section">
                <h3>Email Account Forwarders</h3>

                <p class="description" id="txt_forwarders-description">
                    Send a copy of any incoming email from one address to another. For example, 
                    forward <strong>joe@example.com</strong> to <strong>joseph@example.com</strong> 
                    so that you only have one inbox to check. 
                </p>

                <table id="mailtbl" class="sortable truncate-table table table-striped">
                    <thead>
                        <tr>
                            <th class=" clickable" id="tblHead_EmailAddress">Email Address</th>
                            <th class=" clickable" id="tblHead_ForwardTo">Forward To</th>
                            <th style="width: 40px;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$list item=entry}
                            <tr>
                                <td style="white-space: nowrap">{$entry.dest}</td>
                                <td >{$entry.forward|escape}</td>
                                <td >
                                    <a href="{$widget_url}&act=del&dest={$entry.uri_dest}&forward={$entry.uri_forward}&security_token={$security_token}"
                                       class="cp-btn" onclick="return confirm('Do You really want to delete this entry?')">
                                        <span class="fa fa-trash" title="Remove"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="3" class="errors">
                                    There are no forwarders configured for the current domain.
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <!-- end cpanelfeature forwarders -->
            <div class="section">
                <h3>Forward All Email for a Domain</h3>
                <p class="description" id="forwarders-domain-forward-description-text">
                    In addition to forwarding individual mail accounts, you can forward all email from one domain to another.
                </p>
                <table id="dfwdmailtbl" class="sortable table table-striped">
                    <thead>
                        <tr>
                            <th class="cell-end clickable">Domain</th>
                            <th class="cell clickable">Forward To</th>
                            <th style="width: 40px;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$dlist item=entry}
                            <tr>
                                <td style="white-space: nowrap">{$entry.dest}</td>
                                <td >{$entry.forward}</td>
                                <td >
                                    <a class="cp-btn" href="{$widget_url}&act=deldomain&domain={$entry.dest}&security_token={$security_token}">
                                        <span class="fa fa-trash" title="Remove"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="3" class="errors">
                                    There are no Domain Forwarders setup for this domain.
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tfoot>

                    </tfoot>
                </table>
            </div>

            <div class="pull-right">
                <a class="btn btn-flat-primary btn-primary" id="btn_AddForwarder" data-action="newfowarder">Add Forwarder</a>
                <a class="btn btn-flat-primary btn-primary" id="btn_AddDomainForwarder" data-action="newdomainfowarder" >Add Domain Forwarder</a>
            </div>
            <!--  -------------- -->

            <div style="display: none">
                <div class="modal hide fade" id="action-newfowarder">
                    <form action="{$widget_url}&act=addforwarder" method="POST" style="margin: 0">
                        <div class="modal-header">
                            <button type="button" class="close hide-modal" aria-hidden="true">×</button>
                            <h2 id="myModalLabel">Add a New Forwarder</h2>
                        </div>

                        <div class="modal-body">
                            <input type="hidden" size="40" value="" name="name" class="form-control _txt">
                            <div class="row-fluid">
                                <h3 class="span6">Address</h3>
                                <h3 class="span6">Destination</h3>
                            </div>
                            <div class="row-fluid">
                                <div class="control-group span6">
                                    <label for="email">
                                        Address to Forward
                                    </label>
                                    <div class="input-append form-inline">
                                        <input type="text" name="email" id="email" autocomplete="off" autofill="off" class="form-control ">{*}
                                        {*}<span class="add-on">@</span>
                                    </div>
                                </div>
                                <div class="control-group span6">
                                    <label for="fwd_radio" class="radio">
                                        <input type="radio" checked="checked" value="fwd" id="fwd_radio" name="fwdopt">
                                        Forward to email address
                                    </label>
                                    <div class="">
                                        <input type="text" class="form-control" id="fwdemail" name="fwdemail">
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="control-group span6">
                                    <label for="domain">
                                        Domain
                                    </label>
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <select class="form-control" name="domain" id="ddlDomain">
                                                {foreach from=$domains item=domain}
                                                    <option value="{$domain}">{$domain}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group span6">

                                    <label for="discard_radio" class="radio">
                                        <input type="radio" id="discard_radio" value="fail" name="fwdopt">
                                        Discard with error to sender (at SMTP time)
                                    </label>

                                    <div class="">
                                        <label for="failmsgs">
                                            Failure Message (seen by sender)
                                        </label>
                                        <input type="text" value="No such person at this address" class="form-control" id="failmsgs" name="failmsgs">
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">      
                                <div class="control-group span6 offset6">
                                    <label for="fwdsystem_radio" class="radio">
                                        <input type="radio" value="system" name="fwdopt" id="fwdsystem_radio">
                                        Forward to a system account</label>
                                    <div class="">
                                        <input type="text" value="hosting" class="form-control" name="fwdsystem" id="fwdsystem">
                                    </div>
                                    <div id="fwdsystem_error" class="span5 cjt_validation_error" style="width: 16px; height: 16px;"></div>
                                </div>
                            </div>
                            <div class="row-fluid" >
                                <div class="control-group span6 offset6">
                                    <label for="pipeit" class="radio">
                                        <input type="radio" value="pipe" id="pipeit" name="fwdopt">
                                        Pipe to a Program <a href="#" class="vtip_description" title="When piping to a program, you should enter a path relative to your home directory. If the script requires an interpreter such as Perl or PHP, you should omit the /usr/bin/perl or /usr/bin/php portion. Make sure that your script is executable and has the appropriate target at the top of the script."></a>
                                    </label>

                                    <div class=" yui-ac">
                                        <input type="text" id="pipefwd" name="pipefwd" size="30" class="form-control yui-ac-input" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">        
                                <div class="control-group span6 offset6">
                                    <label for="fwdopt_blackhole" class="radio">
                                        <input type="radio" id="fwdopt_blackhole" value="blackhole" name="fwdopt">
                                        Discard (Not Recommended)
                                    </label>
                                </div>
                            </div>
                        </div> 
                        <div class="modal-footer">
                            <span class="pull-right">
                                <button type="submit" class="default btn btn-flat-primary btn-primary">Add Forwarder</button>
                                <button type="button" class="default btn hide-modal">Cancel</button>
                            </span>
                        </div>
                        {securitytoken}
                    </form>
                </div>
                <!--  
                    DOMAIN FORWARDER MODAL
                -->   
                <div class="modal hide fade" id="action-newdomainfowarder">
                    <form action="{$widget_url}&act=adddomainforwader" method="POST" style="margin: 0">
                        <div class="modal-header">
                            <button type="button" class="close hide-modal" aria-hidden="true">×</button>
                            <h2 id="myModalLabel">Add a New Domain Forwarder</h2>
                        </div>

                        <div class="modal-body">
                            <input type="hidden" size="40" value="" name="name" class="form-control _txt">
                            <p class="description" id="descDomainFwder">
                                In addition to forwarding individual mail accounts, you can forward all email from one domain to another.
                                To send all email for a domain to a single email address, change the Default Address for that domain.
                            </p>
                            <div class="control-group">
                                <label for="domain" id="lblDomain">
                                    Domain
                                </label>
                                <div class="row-fluid">
                                    <div class="span5">
                                        <select class="form-control " name="domain">
                                            {foreach from=$domains item=domain}
                                                <option value="{$domain}">{$domain}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="span1" style="text-align: center">
                                        to
                                    </div>
                                    <div class="span6">
                                        <input type="text" id="forward" name="forward" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <div class="modal-footer">
                            <span class="pull-right">
                                <button type="submit" class="default btn btn-flat-primary btn-primary">Add Domain Forwarder</button>
                                <button type="button" class="default btn hide-modal">Cancel</button>
                            </span>
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