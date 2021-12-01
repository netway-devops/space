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
            <span id="pageHeading">{$lang.cpanel_aliases}</span>
        </h2>
        <div class="body-content">
            <p class="description" id="descAliases">
                {$lang.cpanel_aliases_desc}
            </p>
            <div class="section">
                <h3 id="hdrRemoveAliases">
                    {$lang.cpanel_remove_aliases}
                </h3>
                <p class="description" id="descAliasesMore">
                    {$lang.cpanel_aliases_relative}
                </p>
                <table class="sortable table table-striped" id="parkeddomaintbl">
                    <thead>
                        <tr>
                            <th class=" clickable">{$lang.cpanel_domain}</th>
                            <th class=" clickable">{$lang.cpanel_domain_root}</th>
                            <th nonsortable="true">{$lang.cpanel_redirect_to}</th>
                            <th nonsortable="true">{$lang.cpanel_actions}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$list item=entry}
                            <tr>
                                <td >{$entry.domain}</td>
                                <td >{$entry.basedir}</td>
                                <td >{if $entry.status == 'not redirected'}{$lang.cpanel_not_redirected}{else}{$entry.status}{/if}</td>
                                <td >
                                    <a href="{$widget_url}&act=del&name={$entry.domain}&security_token={$security_token}"
                                       class="cp-btn" onclick="return confirm('{$lang.cpanel_delete_entry_q}')">
                                        <span class="fa fa-trash" title="Remove"></span>
                                    </a>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr>
                                <td class="errors" colspan="5">
                                    {$lang.cpanel_no_aliases}
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                    <tfoot></tfoot>
                </table>
            </div>
            <div class="section">
                <h3 id="hdrCreate">
                    {$lang.cpanel_create_alias}
                </h3>
                <div class="parked-domain">
                    <form id="domainform" action="{$widget_url}&act=add" method="POST">
                        <div class="form-group">
                            <label for="domain" id="lblDomain">
                                {$lang.cpanel_domain}
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
                            <input type="submit" value="{$lang.cpanel_add_domain}" name="go" id="domain_submit" class="btn btn-flat-primary btn-primary">
                        </div>
                        {securitytoken}
                    </form>
                </div>
                <p class="note" id="descNoteDomain">
                    <strong>{$lang.cpanel_note}</strong> {$lang.cpanel_domains_registered_desc}
                </p>
            </div>
        </div>
    </div>
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
{/if}