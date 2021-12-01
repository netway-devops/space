<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>{$lang.cpanel_name}</strong><br>
        {$lang.checkyourloginpassword}
    </div>
{else}

    <div id="billing_info" class="form-inline">
        <h2>
            {if $lang[$widget.name]}{$lang[$widget.name]}
            {elseif $widget.fullname}{$widget.fullname}
            {else}{$widget.name}
            {/if}
        </h2>
        <br />
        <div class="section">
            <form autocomplete="off" action="" method="post">
                <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">

                    <thead>
                        <tr  >
                            <td align="right">{$lang.username}</td>
                            <td align="center">{$lang.type}</td>
                            <td align="center"> {$lang.homedirectory}</td>
                            <td align="center">{$lang.managementfunctions}</a></td>
                        </tr>
                    </thead>
                    <tbody id="updater">
                        {if $listentrys}
                            {foreach from=$listentrys item=entry key=index} 
                                <tr >
                                    <td align="right">{$entry.user}</td>
                                    <td align="center">{$entry.type}</td>
                                    <td align="left">{$entry.homedir}</td>
                                    <td align="center" class="management_links">
                                        {if $entry.type == 'sub'}
                                            <div class="cp-btn-group">
                                                <a class="cp-btn" data-manage="1" href="{$widget_url}&act={$act}#change" title="{$lang.changepass}">
                                                    <i class="fa fa-lock"></i> {$lang.changepass}
                                                </a>
                                                <a class="cp-btn cp-danger" href="{$widget_url}&act={$act}&deluser={$entry.user}" 
                                                   onclick="return confirm('{$lang.cpanel_delete_ftp_q}')" title="{$lang.delete}">
                                                    <i class="fa fa-trash"></i> {$lang.delete}
                                                </a> 
                                            </div>
                                        {/if}
                                    </td>
                                </tr>
                                <tr style="display:none">
                                    <td align="right" >
                                        <input type="submit" name="save" value="{$lang.shortsave}" class="btn">
                                    </td>
                                    <td align="right"  colspan="2"  style="white-space: nowrap;">	
                                        {$lang.password}: 						
                                        <input type="hidden" name="passchange[{$index}][user]" value="{$entry.user}">
                                        <input class="" autocomplete="off" type="password" name="passchange[{$index}][passmain]">
                                    </td>
                                    <td align="right" style="white-space: nowrap;">
                                        {$lang.confirmpassword}: 
                                        <input class="" autocomplete="off" type="password" name="passchange[{$index}][passcheck]">
                                    </td>
                                </tr>
                            {/foreach}
                        {/if}
                        <tr >
                            <td colspan="4">&nbsp;</td>
                        </tr>
                        <tr >
                            <td align="left" colspan="4">
                                <strong>{$lang.specialaccounts}</strong>
                            </td>
                        </tr>
                        {foreach from=$listmainentrys item=entry}
                            <tr >
                                <td align="right">{$entry.user}</td>
                                <td align="center">{$entry.type}</td>
                                <td align="left">{$entry.homedir}</td>
                                <td align="center" class="management_links"></td>
                            </tr>
                        {/foreach} 
                    </tbody>
                    <tfoot>
                        <tr ><td colspan="4">&nbsp;</td></tr>
                        <tr ><td colspan="4">{$lang.addftpaccount}</td></tr>
                        <tr >
                            <td style="border:none" colspan="4" align="center">
                                <table style="float:left" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.username}: </td>
                                        <td style="text-align:left; border:none"> 
                                            <input class="" autocomplete="off" type="text" name="name" >@{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  style="text-align:right;border:none">{$lang.password}: </td>
                                        <td style="text-align:left;border:none"> 
                                            <input class="" autocomplete="off" type="password" name="passmain" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.confirmpassword}: </td>
                                        <td style="text-align:left;border:none"> 
                                            <input class="" autocomplete="off" type="password" name="passcheck" >
                                        </td>
                                    </tr>
                                </table>
                                <div style="float:left;padding:0 0 0 10px;vertical-align:middle">
                                    {$lang.homedirectory}:<br /> 
                                    <input autocomplete="off" type="text" name="dir" class=""></div>
                                <div style="float:left; padding:15px 6px;vertical-align:middle">
                                    <input class="btn" type="submit" name="save" value="{$lang.shortsave}"> 
                                </div>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </form>
        </div>
    </div>
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
    <script type="text/javascript" src="{$widgetdir_url}../js/script.js"></script>
{/if}