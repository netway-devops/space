{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div style="margin: 10px 0; padding: 0 10px;">
        <h2>
            <span id="pageHeading">Aliases</span>
        </h2>
        <div class="body-content">
            <p class="description" id="descAliases">
                Domain aliases make your website available from another domain name. 
                For example, you can make <strong>www.example.net</strong> and <strong>www.example.org</strong> show content from <strong>www.example.com</strong>. 
            </p>
            <div class="section">
                <h3 id="hdrRemoveAliases">
                    Remove Aliases
                </h3>
                <p class="description" id="descAliasesMore">
                    Aliases are relative to your account’s home directory.
                </p>
                <table class="sortable table table-striped" id="parkeddomaintbl">
                    <thead>
                        <tr>
                            <th class=" clickable">Domain</th>
                            <th class=" clickable">Domain Root</th>
                            <th nonsortable="true">Redirects To</th>
                            <th nonsortable="true">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$list item=entry}
                            <tr>
                                <td >{$entry.domain}</td>
                                <td >{$entry.basedir}</td>
                                <td >{if $entry.status == 'not redirected'}not redirected{else}{$entry.status}{/if}</td>
                                <td >
                                    <a href="{$widget_url}&act=del&name={$entry.domain}&security_token={$security_token}"
                                       class="cp-btn" onclick="return confirm('Do You really want to delete this entry?')">
                                        <span class="fa fa-trash" title="Remove"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td class="errors" colspan="5">
                                    No aliases are present on your account.
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="section">
                <h3 id="hdrCreate">
                    Create a New Alias
                </h3>
                <div class="parked-domain">
                    <form id="domainform" action="{$widget_url}&act=add" method="POST">
                        <div class="form-group">
                            <label for="domain" id="lblDomain">
                                Domain
                            </label>
                            <div class="row-fluid">
                                <div class="span6">
                                    <input type="text" id="domain" name="domain" class="form-control">
                                </div>
                                <div class="span6 cjt_validation_error" id="domain_error" style="width: 16px; height: 16px;">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="submit" value="Add Domain" name="go" id="domain_submit" class="btn btn-flat-primary btn-primary">
                        </div>
                        {securitytoken}
                    </form>
                </div>
                <p class="note" id="descNoteDomain">
                    <strong>Note:</strong> Domains must be registered with a valid registrar and configured to point to your DNS servers before they can be used as an alias.
                </p>
            </div>
        </div>
    </div>
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
{/if}