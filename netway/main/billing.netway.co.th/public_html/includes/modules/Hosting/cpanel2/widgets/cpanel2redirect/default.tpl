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
            <span id="pageHeading">{$lang.cpanel_redirects}</span>
        </h2>

        <div class="body-content">
            <p class="description">
                {$lang.cpanel_redirects_desc}
            </p>       
            <div class="section">
                <h3>{$lang.cpanel_current_redirects}</h3>
                <table id="redirecttbl" class="sortable table table-striped">
                    <thead>
                        <tr>
                            <th class=" clickable">{$lang.cpanel_domain}</th>
                            <th class=" clickable">{$lang.cpanel_directory}</th>
                            <th class=" clickable">{$lang.cpanel_redirect}</th>
                            <th class=" clickable">{$lang.cpanel_type}</th>
                            <th class=" clickable">{$lang.cpanel_www}</th>
                            <th class=" clickable">{$lang.cpanel_wildcard}</th>
                            <th nonsortable="true">{$lang.cpanel_remove}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$list item=entry}
                            <tr>
                                <td style="white-space: nowrap">{$entry.urldomain}</td>
                                <td >{$entry.source}</td>
                                <td ><a href="{$entry.targeturl}">{$entry.targeturl|truncate:40:'...':false:true}</a></td>
                                <td >{if $entry.type=='permanent'}301{else}302{/if}</td>
                                <td >{if $entry.matchwww}<i class="fa fa-check"></i>{/if}</td>
                                <td >{if $entry.wildcard}<i class="fa fa-check"></i>{/if}</td>
                                <td >
                                    <a href="{$widget_url}&act=del&domain={$entry.domain}&path={$entry.source}&docroot={$entry.docroot}&security_token={$security_token}"
                                       class="cp-btn" onclick="return confirm('{$lang.cpanel_delete_entry_q}')">
                                        <span class="fa fa-trash" title="{$lang.cpanel_remove}"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td class="errors" colspan="8">{$lang.cpanel_no_redirects}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="section">
                <h3>{$lang.cpanel_add_redirect}</h3>
                <p class="description">
                    {$lang.cpanel_add_redirect_desc}
                </p>
                <ul>
                    <li>{$lang.cpanel_redirect_checking}</li>
                    <li>{$lang.cpanel_redirect_wildcard}</li>
                </ul>

                <br />

                <form action="{$widget_url}&act=add" name="mainform" method="POST" id="mainform">
                    <div class="control-group">
                        <label for="ddlType">
                            {$lang.cpanel_type}
                        </label>
                        <div class="row-fluid">
                            <div class="span6">
                                <select class="form-control" name="type" id="ddlType">
                                    <option value="permanent">{$lang.cpanel_permanent}</option>
                                    <option value="temp">{$lang.cpanel_temporary}</option>
                                </select>
                            </div>
                            <div class="span6">
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="ddlDomains">
                            http://<span id="wwwtxt">{$lang.cpanel_www_q}</span>
                        </label>
                        <div class="row-fluid">
                            <div class="span6">
                                <select class="form-control" name="domain" id="ddlDomains">
                                    <option value=".*" selected="">{$lang.cpanel_all_public_domains}</option>
                                    {foreach from=$domains item=domain}
                                        <option value="{$domain}">{$domain}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="span6">
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="urlpath">
                        </label>
                        <div class="row-fluid">
                            <div class="span6">
                                <div class="input-prepend form-inline">
                                    <span class="add-on">/</span><input type="text" id="urlpath" size="20"  name="path" style="width: 183px">
                                </div>
                            </div>
                            <div class="span6">
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="url">
                            {$lang.cpanel_red_to}
                        </label>
                        <div class="row-fluid">
                            <div class="span6">
                                <input type="text" size="45" class="form-control" name="url" id="url">
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label>
                            {$lang.cpanel_www_redirection}
                        </label>

                        <div id="radios">
                            <div class="radio">
                                <input type="radio" disabled="disabled" onclick="$('#wwwtxt').text('www.');" name="rdwww" alue="2" id="rbtnWithWWW">
                                {$lang.cpanel_only_redirect}
                            </div>
                            <div class="radio">
                                <input type="radio" disabled="disabled" checked="checked" onclick="$('#wwwtxt').text('(www.)?');" name="rdwww" value="0" id="rbtnOptionalWWW">
                                {$lang.cpanel_redirect_with}
                            </div>
                            <div class="radio">
                                <input type="radio" disabled="disabled" onclick="$('#wwwtxt').text('');" name="rdwww" value="1" id="rbtnWithoutWWW">
                                {$lang.cpanel_do_not_redirect}
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="checkbox">
                            <input type="checkbox" id="wildcard" name="wildcard" value="1">
                            <label>{$lang.cpanel_wildcard_redirect}</label>
                        </div>
                    </div>
                    <div class="control-group">
                        <input type="submit" value="{$lang.cpanel_add}" class="btn btn-flat-primary btn-primary" id="submit-button">
                    </div>
                    {securitytoken}
                </form>
            </div>
        </div>
    </div>
    <script src="{$widgetdir_url}script.js" type="text/javascript"></script>
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
{/if}
