
<div >
    <div id="billing_info" class="wbox">
        <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
        <div class="wbox_content">
            <form autocomplete="off" action="{$widget_url}&act={$act}" method="post">
                <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                    {counter start=1 skip=1 assign=even}
                    <thead>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                            <td align="right">{$lang.aliasname}</td>
                            <td align="center"> {$lang.targetdomain}</td>
                            <td align="center">{$lang.managementfunctions}</a></td>
                        </tr>
                    </thead>
                    <tbody id="updater">

                        {foreach from=$listentrys item=entry key=index} 
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="right">{$entry.name}</td>
                                <td align="left">{if $entry.site.name}{$entry.site.name}{else}{$domain}{/if}</td>
                                <td align="center" class="management_links">
                                    <a href="{$widget_url}&act={$act}&changepass"><small>{$lang.plesk_change_settings}</small></a> |
                                    <a href="{$widget_url}&act={$act}&del={$entry.id}&security_token={$security_token}" 
                                       onclick="return confirm('{$lang.plesk_del_domain_alias}')">
                                        <small>{$lang.delete}</small>
                                    </a> 
                                </td>
                            </tr>
                            <tr {if $even % 2 !=0}class="even"{/if} style="display:none">
                                <td align="right" ><input type="submit" name="savechange" value="{$lang.shortsave}" class="btn btn-primary"></td>
                                <td align="right"  colspan="2" class="form-inline">						
                                    <input type="hidden" name="change[{$index}][sub]" value="{$entry.id}">
                                    <label><input type="checkbox" name="change[{$index}][mail]" value="1" {if $entry.pref.mail=="true"}checked="checked"{/if}> {$lang.mailservice}</label> <br />
                                    <label><input type="checkbox" name="change[{$index}][web]" value="1" {if $entry.pref.web=="true"}checked="checked"{/if}> {$lang.webservice}</label> <br />
                                    <label><input type="checkbox" name="change[{$index}][manage-dns]" value="1" {if $entry.dns=="true"}checked="checked"{/if}> {$lang.synchronizezonewithprimarydomain}</label> <br />
                                    <label><input type="checkbox" name="change[{$index}][seo-redirect]" value="1" {if $entry.seo=="true"}checked="checked"{/if}> {$lang.redirectwithhttpcode}</label>
                                </td>
                            </tr>
                        {foreachelse}
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="center" colspan="3" style="text-overflow:ellipsis; overflow: hidden" >{$lang.nothing}</td>
                            </tr>
                        {/foreach}

                    </tbody>
                    <tfoot>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">&nbsp;</td></tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">
                                {$lang.adddomainaliasfor} {if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}<b>{$domain}</b>{/if}
                            </td>
                        </tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                            <td style="border:none" colspan="4" align="center" class="form-inline">
                                <table style="float:left" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.plesk_domain_name}: </td>
                                        <td style="text-align:left; border:none"> <input class="span4" autocomplete="off" type="text" name="name" id="subdomain" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">
                                            {$lang.options}:
                                        </td>
                                        <td style="text-align:left; border:none">
                                            <label><input type="checkbox" name="options[mail]" value="1" checked="checked"> {$lang.mailservice} </label> <br />
                                            <label><input type="checkbox" name="options[web]" value="1" checked="checked"> {$lang.webservice} </label> <br />
                                            <label><input type="checkbox" name="options[manage-dns]" value="1" checked="checked"> {$lang.synchronizezonewithprimarydomain} </label> <br />
                                            <label><input type="checkbox" name="options[seo-redirect]" value="1" checked="checked"> {$lang.redirectwithhttpcode} </label>
                                        </td>
                                    </tr>
                                </table>
                                <div style="float:left; padding:10px 6px;vertical-align:middle"><input class="btn btn-primary" type="submit" name="save" value="{$lang.shortsave}"> </div>
                            </td></tr>
                    </tfoot>
                </table>
                {securitytoken}
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="{$widgetdir_url}../widget.js"></script>
<link rel="stylesheet" type="text/css" href="{$widgetdir_url}../widget.css"  media="all">