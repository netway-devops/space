<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>{$lang.cpanel_name}</strong><br>
        {$lang.checkyourloginpassword}
        </di>
    {else}
        <div >
            <div id="billing_info" class="form-inline">
                <h2>{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</h2>
                <br />
                <div class="section">

                    <form autocomplete="off" action="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}" method="post">
                        <table class="checker table table-striped" style="table-layout: fixed" width="100%" cellspacing="0" cellpadding="0" border="0">
                            {counter start=1 skip=1 assign=even}
                            <thead>
                                <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                                    <td align="right">{$lang.account}</td>
                                    <td align="center">{$lang.usage}</td>
                                    <td align="center">{$lang.managementfunctions}</a></td>
                                </tr>
                            </thead>
                            <tbody id="updater">
                                {if $listentrys}
                                    {foreach from=$listentrys item=entry key=index} 
                                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                            <td align="right">{$entry.email}</td>
                                            <td align="center">
                                                <div>{$entry.diskused}/{$entry.diskquota|capitalize} MB</div>
                                                <div style="width:80%; height:8px; border:solid 1px #aaa; text-align:left; overflow:hidden">
                                                    <div style="height:100%; width:{$entry.diskusedpercent}%; background-color:{if $entry.diskusedpercent < 50}#8FFF00{elseif $entry.diskusedpercent < 80}yellow{else}#FF4F4F{/if}; border"></div>
                                                </div>
                                            </td>
                                            <td align="center" class="management_links">
                                                <div class="cp-btn-group">
                                                    <a class="cp-btn" data-manage="2" href="{$widget_url}&act={$act}#chang" title="{$lang.changepass}">
                                                        <i class="fa fa-lock"></i>
                                                    </a>
                                                    <a class="cp-btn" data-manage="1" href="{$widget_url}&act={$act}#chang" title="{$lang.changequota}">
                                                        <i class="fa fa-expand"></i>
                                                    </a>
                                                    <a class="cp-btn" href="{$widget_url}&act=redirect&user={$entry.email}&domain={$entry.domain}"
                                                       target="_blank"
                                                       title="Acces Webmail">
                                                        <i class="fa fa-inbox"></i>
                                                    </a>
                                                    <a class="cp-btn cp-danger" href="{$widget_url}&act={$act}&deluser={$entry.user}&domain={$entry.domain}" 
                                                       onclick="return confirm('{$lang.cpanel_delete_email_q}')" title="{$lang.delete}">
                                                        <i class="fa fa-trash"></i>
                                                    </a> 
                                                </div>
                                            </td>

                                        </tr>
                                        <tr style="display:none">

                                            <td align="right" colspan="3" class="manage-cnt">

                                                <input type="hidden" name="change[{$index}][user]" value="{$entry.user}">
                                                <input type="hidden" name="change[{$index}][domain]" value="{$entry.domain}">
                                                <input type="hidden" name="change[{$index}][oldquota]" value="{$entry.diskquota}">
                                                {$lang.quota}:
                                                <select name="change[{$index}][quota]" class="email_quota">
                                                    <option value="custom" >{$lang.custom}</option>
                                                    {if ($entry.diskquota != 20) && ($entry.diskquota != 50) && ($entry.diskquota != 100) && ($entry.diskquota != 250) && ($entry.diskquota != 'unlimited')}<option value="{$entry.diskquota}" selected="selected">{$entry.diskquota} MB</option>{/if}
                                                    <option value="20" {if $entry.diskquota == 20}selected="selected"{/if}>20 MB</option>
                                                    <option value="50" {if $entry.diskquota == 50}selected="selected"{/if}>50 MB</option>
                                                    <option value="100" {if $entry.diskquota == 100}selected="selected"{/if}>100 MB</option>
                                                    <option value="250" {if $entry.diskquota == 250}selected="selected"{/if}>250 MB</option>
                                                    <option value="0" {if $entry.diskquota == 'unlimited'}selected="selected"{/if}>{$lang.unlimited}</option>
                                                </select>
                                                <input type="submit" name="save" value="{$lang.shortsave}" class="btn">
                                            </td>
                                            <td class="manage-cnt" align="right" colspan="3" style="white-space: nowrap;">

                                                {$lang.password}:
                                                <input autocomplete="off" type="password" name="change[{$index}][passmain]" class="">&nbsp;&nbsp;&nbsp;
                                                {$lang.confirmpassword}:
                                                <input autocomplete="off" type="password" name="change[{$index}][passcheck]" class="">
                                                <input type="submit" name="save" value="{$lang.shortsave}" class="btn">
                                            </td>
                                        </tr>
                                    {/foreach}
                                {else}
                                    <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                        <td align="center" colspan="3">{$lang.nothing}</td>
                                    </tr>
                                {/if}
                            </tbody>
                            <tfoot>
                                <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                    <td colspan="3">&nbsp;</td>
                                </tr>
                                <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                    <td colspan="3">{$lang.addemailaccount}</td>
                                </tr>
                                <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                    <td style="border:none" colspan="3" align="center">
                                        <table style="float:left" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="text-align:right;border:none">{$lang.username}: </td>
                                                <td style="text-align:left; border:none"> <input class="" autocomplete="off" type="text" name="name" >@{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  style="text-align:right;border:none">{$lang.password}: </td>
                                                <td style="text-align:left;border:none"> <input class="" autocomplete="off" type="password" name="passmain" ></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align:right;border:none">{$lang.confirmpassword}: </td>
                                                <td style="text-align:left;border:none"> <input class="" autocomplete="off" type="password" name="passcheck" ></td>
                                            </tr>
                                        </table>
                                        <div style="float:left;padding:0 0 0 10px;vertical-align:middle">{$lang.quota}:<br> 
                                            <select name="quota" class="email_quota ">
                                                <option value="custom" >{$lang.custom}</option>
                                                <option selected="selected" value="20" >20 MB</option>
                                                <option value="50" >50 MB</option>
                                                <option value="100" >100 MB</option>
                                                <option value="250" >250 MB</option>
                                                <option value="0" >{$lang.unlimited}</option>
                                            </select>
                                        </div>
                                        <div style="float:left; padding:15px 6px;vertical-align:middle"><input type="submit" name="save" value="{$lang.shortsave}" class="btn"> </div>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </form>
                </div>

            </div>
        </div>
        <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/font-awesome.min.css">
        <link media="all" type="text/css" rel="stylesheet" href="{$widgetdir_url}../css/cp.css">
        <script type="text/javascript" src="{$widgetdir_url}../js/script.js"></script>
    {/if}
