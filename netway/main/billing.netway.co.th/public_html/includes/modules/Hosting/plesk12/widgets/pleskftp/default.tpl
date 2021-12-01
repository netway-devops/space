
<div >
    <div id="billing_info" class="wbox">
        <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
        <div class="wbox_content">
            <form autocomplete="off" action="{$widget_url}&act={$act}" method="post">
                <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                    {counter start=1 skip=1 assign=even}
                    <thead>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                            <td align="right">{$lang.username}</td>
                            <td align="left"> {$lang.homedirectory}</td>
                            <td align="center">{$lang.managementfunctions}</a></td>
                        </tr>
                    </thead>
                    <tbody id="updater">
                        
                            {foreach from=$listentrys item=entry key=index} 
                                <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                    <td align="right">{$entry.name}@{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}</td>
                                    <td align="left">{$entry.home}</td>
                                    <td align="center" class="management_links">
                                        <a href="{$widget_url}&act={$act}&changepass">{$lang.changepass}</a> |
                                        <a href="{$widget_url}&act={$act}&deluser={$entry.id}&security_token={$security_token}" 
                                           onclick="return confirm('{$lang.plesk_del_ftp}')">{$lang.delete}</a>
                                    </td>
                                </tr>
                                <tr {if $even % 2 !=0}class="even"{/if} style="display:none">
                                    <td align="right" ><input type="submit" name="save" value="{$lang.shortsave}" class="btn btn-primary"></td>
                                    <td align="right" >	{$lang.password}: 						
                                        <input type="hidden" name="change[{$index}][user]" value="{$entry.name}">
                                        <input class="span2" autocomplete="off" type="password" name="change[{$index}][passmain]">
                                    </td>
                                    <td align="right">{$lang.confirmpassword}: 
                                        <input class="span2" autocomplete="off" type="password" name="change[{$index}][passcheck]">
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
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">{$lang.addftpaccount}</td></tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                            <td style="border:none" colspan="4" align="center">
                                <table style="float:left" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.username}: </td>
                                        <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="name" >@{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  style="text-align:right;border:none">{$lang.password}: </td>
                                        <td style="text-align:left;border:none"> <input class="span2" autocomplete="off" type="password" name="passmain" ></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.confirmpassword}: </td>
                                        <td style="text-align:left;border:none"> <input class="span2" autocomplete="off" type="password" name="passcheck" ></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.homedirectory}: </td>
                                        <td style="text-align:left;border:none"> <input autocomplete="off" type="text" name="dir" class="span4" value="/"></td>
                                    </tr>
                                </table>
                                <div style="float:left; padding:15px 6px;vertical-align:middle"><input class="btn btn-primary" type="submit" name="save" value="{$lang.shortsave}"> </div>
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