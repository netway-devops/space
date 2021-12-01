{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">

        <h2>
            <span id="pageHeading">Redirects</span>
        </h2>

        <div class="body-content">
            <p class="description">
                A redirect allows you to make one domain redirect to another domain, 
                either for a website or a specific web page. For example, create
                a redirect so that <strong>www.example.com</strong> automatically
                redirects users to <strong>www.example.net</strong>. 
            </p>       
            <div class="section">
                <h3>Current Redirects</h3>
                <table id="redirecttbl" class="sortable table table-striped">
                    <thead>
                        <tr>
                            <th class=" clickable">Domain</th>
                            <th class=" clickable">Directory</th>
                            <th class=" clickable">Redirect</th>
                            <th class=" clickable">Type</th>
                            <th class=" clickable">www</th>
                            <th class=" clickable">Wildcard</th>
                            <th nonsortable="true">Remove</th>
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
                                       class="cp-btn" onclick="return confirm('Do You really want to delete this entry?')">
                                        <span class="fa fa-trash" title="Remove"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td class="errors" colspan="8">There are no redirects configured for your account.</td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="section">
                <h3>Add Redirect</h3>
                <p class="description">
                    A permanent redirect will notify the visitor’s brow-fluidser to update any bookmarks that are linked to the page that is being redirected. Temporary redirects will not update the visitor’s bookmarks.
                </p>
                <ul>
                    <li>Checking the <strong>Wild Card Redirect</strong> Box will redirect all files within a directory to the same filename in the redirected directory.</li>
                    <li>You cannot use a Wild Card Redirect to redirect your main domain to a different directory on your site.</li>
                </ul>

                <br />

                <form action="{$widget_url}&act=add" name="mainform" method="POST" id="mainform">
                    <div class="control-group">
                        <label for="ddlType">
                            Type
                        </label>
                        <div class="row-fluid">
                            <div class="span6">
                                <select class="form-control" name="type" id="ddlType">
                                    <option value="permanent">Permanent (301)</option>
                                    <option value="temp">Temporary (302)</option>
                                </select>
                            </div>
                            <div class="span6">
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="ddlDomains">
                            http://<span id="wwwtxt">(www.)?</span>
                        </label>
                        <div class="row-fluid">
                            <div class="span6">
                                <select class="form-control" name="domain" id="ddlDomains">
                                    <option value=".*" selected="">** All Public Domains **</option>
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
                            redirects to
                        </label>
                        <div class="row-fluid">
                            <div class="span6">
                                <input type="text" size="45" class="form-control" name="url" id="url">
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label>
                            www. redirection:
                        </label>

                        <div id="radios">
                            <div class="radio">
                                <input type="radio" disabled="disabled" onclick="$('#wwwtxt').text('www.');" name="rdwww" alue="2" id="rbtnWithWWW">
                                Only redirect with www.
                            </div>
                            <div class="radio">
                                <input type="radio" disabled="disabled" checked="checked" onclick="$('#wwwtxt').text('(www.)?');" name="rdwww" value="0" id="rbtnOptionalWWW">
                                Redirect with or without www.
                            </div>
                            <div class="radio">
                                <input type="radio" disabled="disabled" onclick="$('#wwwtxt').text('');" name="rdwww" value="1" id="rbtnWithoutWWW">
                                Do Not Redirect www.
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="checkbox">
                            <input type="checkbox" id="wildcard" name="wildcard" value="1">
                            <label>Wild Card Redirect</label>
                        </div>
                    </div>
                    <div class="control-group">
                        <input type="submit" value="Add" class="btn btn-flat-primary btn-primary" id="submit-button">
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
