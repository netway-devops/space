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
            <span id="pageHeading">{$lang.cpanel_forwarders}</span>
        </h2>
        <br />
        <div class="body-content">

            <div class="section">
                <h3>{$lang.cpanel_email_forwarders}</h3>

                <p class="description" id="txt_forwarders-description">
                    {$lang.cpanel_forwarders_desc}
                </p>

                <table id="mailtbl" class="sortable truncate-table table table-striped">
                    <thead>
                        <tr>
                            <th class=" clickable" id="tblHead_EmailAddress">{$lang.cpanel_email_address}</th>
                            <th class=" clickable" id="tblHead_ForwardTo">{$lang.cpanel_forward_to}</th>
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
                                       class="cp-btn" onclick="return confirm('{$lang.cpanel_delete_entry_q}')">
                                        <span class="fa fa-trash" title="{$lang.cpanel_remove}"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="3" class="errors">
                                    {$lang.cpanel_no_forwarders}
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <!-- end cpanelfeature forwarders -->
            <div class="section">
                <h3>{$lang.cpanel_forward_all}</h3>
                <p class="description" id="forwarders-domain-forward-description-text">
                    {$lang.cpanel_forward_all_desc}
                </p>
                <table id="dfwdmailtbl" class="sortable table table-striped">
                    <thead>
                        <tr>
                            <th class="cell-end clickable">{$lang.cpanel_domain}</th>
                            <th class="cell clickable">{$lang.cpanel_forward_to}</th>
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
                                        <span class="fa fa-trash" title="{$lang.cpanel_remove}"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="3" class="errors">
                                    {$lang.cpanel_no_domain_forwarders}
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tfoot>

                    </tfoot>
                </table>
            </div>

            <div class="pull-right">
                <a class="btn btn-flat-primary btn-primary" id="btn_AddForwarder" data-action="newfowarder">{$lang.cpanel_add_forwarder}</a>
                <a class="btn btn-flat-primary btn-primary" id="btn_AddDomainForwarder" data-action="newdomainfowarder" >{$lang.cpanel_add_domain_forwarder}</a>
            </div>
            <!--  -------------- -->

            <div style="display: none">
                <div class="modal hide fade" id="action-newfowarder">
                    <form action="{$widget_url}&act=addforwarder" method="POST" style="margin: 0">
                        <div class="modal-header">
                            <button type="button" class="close hide-modal" aria-hidden="true">×</button>
                            <h2 id="myModalLabel">{$lang.cpanel_add_new_forwarder}</h2>
                        </div>

                        <div class="modal-body">
                            <input type="hidden" size="40" value="" name="name" class="form-control _txt">
                            <div class="row-fluid">
                                <h3 class="span6">{$lang.cpanel_address}</h3>
                                <h3 class="span6">{$lang.cpanel_destination}</h3>
                            </div>
                            <div class="row-fluid">
                                <div class="control-group span6">
                                    <label for="email">
                                        {$lang.cpanel_address_to_forward}
                                    </label>
                                    <div class="input-append form-inline">
                                        <input type="text" name="email" id="email" autocomplete="off" autofill="off" class="form-control ">{*}
                                        {*}<span class="add-on">@</span>
                                    </div>
                                </div>
                                <div class="control-group span6">
                                    <label for="fwd_radio" class="radio">
                                        <input type="radio" checked="checked" value="fwd" id="fwd_radio" name="fwdopt">
                                        {$lang.cpanel_forward_to_email}
                                    </label>
                                    <div class="">
                                        <input type="text" class="form-control" id="fwdemail" name="fwdemail">
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="control-group span6">
                                    <label for="domain">
                                        {$lang.cpanel_domain}
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
                                        {$lang.cpanel_discard_error}
                                    </label>

                                    <div class="">
                                        <label for="failmsgs">
                                            {$lang.cpanel_failure_message}
                                        </label>
                                        <input type="text" value="{$lang.cpanel_no_such_person}" class="form-control" id="failmsgs" name="failmsgs">
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">      
                                <div class="control-group span6 offset6">
                                    <label for="fwdsystem_radio" class="radio">
                                        <input type="radio" value="system" name="fwdopt" id="fwdsystem_radio">
                                        {$lang.cpanel_forward_system_acc}</label>
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
                                        {$lang.cpanel_pipe} <a href="#" class="vtip_description" title="{$lang.cpanel_pipe_desc}"></a>
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
                                        {$lang.cpanel_discard}
                                    </label>
                                </div>
                            </div>
                        </div> 
                        <div class="modal-footer">
                            <span class="pull-right">
                                <button type="submit" class="default btn btn-flat-primary btn-primary">{$lang.cpanel_add_forwarder}</button>
                                <button type="button" class="default btn hide-modal">{$lang.cpanel_cancel}</button>
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
                            <h2 id="myModalLabel">{$lang.cpanel_add_domain_forwarder}</h2>
                        </div>

                        <div class="modal-body">
                            <input type="hidden" size="40" value="" name="name" class="form-control _txt">
                            <p class="description" id="descDomainFwder">
                                {$lang.cpanel_add_domain_forwarder_desc}
                            </p>
                            <div class="control-group">
                                <label for="domain" id="lblDomain">
                                    {$lang.cpanel_domain}
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
                                        {$lang.cpanel_to}
                                    </div>
                                    <div class="span6">
                                        <input type="text" id="forward" name="forward" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <div class="modal-footer">
                            <span class="pull-right">
                                <button type="submit" class="default btn btn-flat-primary btn-primary">{$lang.cpanel_add_dom_forwarder}</button>
                                <button type="button" class="default btn hide-modal">{$lang.cpanel_addon_create}</button>
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