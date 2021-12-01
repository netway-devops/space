{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
    <div >
        <div id="billing_info" class=" form-inline">
            <h2>{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</h2>
            <div class="section">
                <form autocomplete="off" action="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}" method="post">
                    <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                        {counter start=1 skip=1 assign=even}
                        <thead>
                            <tr  >
                                <td align="right">Subdomain</td>
                                <td align="center"> {$lang.homedirectory}</td>
                                <td align="center">{$lang.managementfunctions}</a></td>
                            </tr>
                        </thead>
                        <tbody id="updater">
                            {if $listentrys}
                                {foreach from=$listentrys item=entry key=index} 
                                    <tr >
                                        <td align="right">{$entry.domain}</td>
                                        <td align="left">/{$entry.basedir}</td>
                                        <td align="center" class="management_links">
                                            <div class="cp-btn-group">
                                                <a href="{$widget_url}&act={$act}&changepass" data-manage class="cp-btn" tittle="Change Directory">
                                                    <i class="fa fa-pencil"></i> Change Directory
                                                </a>
                                                <a href="{$widget_url}&act={$act}&del={$entry.domain}&securitytoken={$security_token}" 
                                                   class="cp-btn" tittle="{$lang.delete}" 
                                                   onclick="return confirm('Do You really want to delete this FTP account?')">
                                                    <i class="fa fa-trash"></i> {$lang.delete}
                                                </a> 
                                            </div>

                                        </td>
                                    </tr>
                                    <tr style="display:none">
                                        <td align="right" ><input type="submit" name="save" value="{$lang.shortsave}" class="btn"></td>
                                        <td align="right"  colspan="2">	{$lang.homedirectory}: 						
                                            <input type="hidden" name="rootchange[{$index}][sub]" value="{$entry.subdomain}">
                                            <input autocomplete="off" type="text" name="rootchange[{$index}][dir]" class="">
                                        </td>
                                    </tr>
                                {/foreach}
                            {/if}
                        </tbody>
                        <tfoot>
                            <tr ><td colspan="4">&nbsp;</td></tr>
                            <tr ><td colspan="4">Add new sub-domain</td></tr>
                            <tr >
                                <td style="border:none" colspan="4" align="center" class="form-inline">
                                    <table style="float:left" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td style="text-align:right;border:none">Subdomain: </td>
                                            <td style="text-align:left; border:none"> <input class="" autocomplete="off" type="text" name="sub" >.{*}
                                                {*}{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
                                            </td>
                                        </tr>
                                    </table>
                                    <div style="float:left;padding:0 0 0 10px;vertical-align:middle">{$lang.homedirectory}:<br> <input autocomplete="off" type="text" name="dir" class=""></div>
                                    <div style="float:left; padding:15px 6px;vertical-align:middle"><input class="btn" type="submit" name="save" value="{$lang.shortsave}"> </div>
                                </td></tr>
                        </tfoot>
                    </table>
                </form>
            </div>
        </div>
    </div>
                                
    <script src="{$widgetdir_url}../js/script.js" type="text/javascript"></script>
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
    <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
{/if}