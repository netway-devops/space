{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div >
        <div id="billing_info" class="wbox form-inline">
            <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
            <div class="wbox_content">
                {literal}
                    <script type="text/javascript">
                        $(document).ready(function() {
                            $('.management_links').each(function(i) {
                                $(this).children().eq(0).click(function() {
                                    $(this).parents('tr').next().toggle();
                                    return false;
                                });
                            });
                        });
                    </script>
                {/literal}
                <form autocomplete="off" action="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}" method="post">
                    <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                        {counter start=1 skip=1 assign=even}
                        <thead>
                            <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                                <td align="right">Subdomain</td>
                                <td align="center"> {$lang.homedirectory}</td>
                                <td align="center">{$lang.managementfunctions}</a></td>
                            </tr>
                        </thead>
                        <tbody id="updater">
                            {if $listentrys}
                                {foreach from=$listentrys item=entry key=index} 
                                    <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                        <td align="right">{$entry.domain}</td>
                                        <td align="left">/{$entry.basedir}</td>
                                        <td align="center" class="management_links">
                                            <a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}&changepass"><small>Change Directory</small></a> |
                                            <a href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}&del={$entry.domain}&securitytoken={$security_token}" onclick="return confirm('Do You really want to delete this FTP account?')">
                                                <small>{$lang.delete}</small>
                                            </a> 
                                        </td>
                                    </tr>
                                    <tr {if $even % 2 !=0}class="even"{/if} style="display:none">
                                        <td align="right" ><input type="submit" name="save" value="{$lang.shortsave}" class="btn"></td>
                                        <td align="right"  colspan="2">	{$lang.homedirectory}: 						
                                            <input type="hidden" name="rootchange[{$index}][sub]" value="{$entry.subdomain}">
                                            <input autocomplete="off" type="text" name="rootchange[{$index}][dir]" class="span4">
                                        </td>
                                    </tr>
                                {/foreach}
                            {/if}
                        </tbody>
                        <tfoot>
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">&nbsp;</td></tr>
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">{$lang.addftpaccount}</td></tr>
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td style="border:none" colspan="4" align="center" class="form-inline">
                                    <table style="float:left" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td style="text-align:right;border:none">Subdomain: </td>
                                            <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="sub" >.{*}
                                                {*}{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
                                            </td>
                                        </tr>
                                    </table>
                                    <div style="float:left;padding:0 0 0 10px;vertical-align:middle">{$lang.homedirectory}:<br> <input autocomplete="off" type="text" name="dir" class="span4"></div>
                                    <div style="float:left; padding:15px 6px;vertical-align:middle"><input class="btn" type="submit" name="save" value="{$lang.shortsave}"> </div>
                                </td></tr>
                        </tfoot>
                    </table>
                </form>
            </div>
        </div>
    </div>
{/if}