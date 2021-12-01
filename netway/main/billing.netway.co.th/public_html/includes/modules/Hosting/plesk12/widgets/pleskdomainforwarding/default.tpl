
<div >
    <div id="billing_info" class="wbox">
        <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
        <div class="wbox_content">
            <form autocomplete="off" action="{$widget_url}&act={$act}" method="post">
                <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                    {counter start=1 skip=1 assign=even}
                    <thead>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                            <td align="right">{$lang.Domain}</td>
                            <td align="center"> {$lang.type}</td>
                            <td align="center"> {$lang.targeturl}</td>
                            <td align="center">{$lang.managementfunctions}</a></td>
                        </tr>
                    </thead>
                    <tbody id="updater">

                        {foreach from=$listentrys item=entry key=index} 
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="right" style="white-space: nowrap">{$entry.name}</td>
                                <td align="left">
                                    {if $entry.htype =='frm_fwd'}
                                        {$lang.plesk_frame}
                                    {else}
                                        {$lang.plesk_http}:{$entry.http_code}
                                    {/if}
                                </td>
                                <td align="left"><a href="{$entry.dest_url}">{$entry.dest_url|truncate:40:'...':false:true}</a></td>
                                <td align="center" class="management_links" style="white-space: nowrap">
                                    <a href="{$widget_url}&act={$act}&changepass"><small>{$lang.plesk_change_settings}</small></a> |
                                    <a href="{$widget_url}&act={$act}&del={$entry.id}&security_token={$security_token}" 
                                       onclick="return confirm('{$lang.plesk_del_domain_alias}')">
                                        <small>{$lang.delete}</small>
                                    </a> 
                                </td>
                            </tr>
                            <tr {if $even % 2 !=0}class="even"{/if} style="display:none">
                                <td align="right" ><input type="submit" name="savechange" value="{$lang.shortsave}" class="btn btn-primary"></td>
                                <td align="right" class="form-inline" colspan="{if $entry.htype =='frm_fwd'}3{else}2{/if}">						
                                    <input type="hidden" name="change[{$index}][sub]" value="{$entry.id}">
                                    {$lang.destinationaddress}:
                                    <input class="span4" autocomplete="off" type="text" name="change[{$index}][url]" value="{$entry.dest_url}" >
                                </td>
                                {if $entry.htype !='frm_fwd'}
                                    <td align="right" > {$lang.plesk_http} {$lang.code}:
                                        <select name="change[{$index}][code]" style="width: 80px;">
                                            <option value="301" {if $entry.http_code == '301'}selected="selected"{/if}>301</option>
                                            <option value="302" {if $entry.http_code == '302'}selected="selected"{/if}>302</option>
                                        </select>
                                    </td>
                                {/if}
                            </tr>
                        {foreachelse}
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="center" colspan="4" style="text-overflow:ellipsis; overflow: hidden" >{$lang.nothing}</td>
                            </tr>
                        {/foreach}

                    </tbody>
                    <tfoot>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">&nbsp;</td></tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">
                                {$lang.addredirect}
                            </td>
                        </tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                            <td style="border:none" colspan="4" align="center" class="form-inline">
                                <table style="float:left" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.Domain}: </td>
                                        <td style="text-align:left; border:none"> <input class="span4" autocomplete="off" type="text" name="name" id="subdomain" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">
                                            {$lang.forwardingtype}:
                                        </td>
                                        <td style="text-align:left; border:none">
                                            <select name="type" id="fwdtype">
                                                <option value="std_fwd">{$lang.standardforwarding} </option>
                                                <option value="frm_fwd">{$lang.frameforwarding} </option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">
                                            {$lang.plesk_http} {$lang.code}:
                                        </td>
                                        <td style="text-align:left; border:none">
                                            <select name="code" class="" id="httpcode">
                                                <option value="301">{$lang.movedpermanently} ({$lang.plesk_code} 301)</option>
                                                <option value="302">{$lang.movedtemporarily} ({$lang.plesk_code} 302)</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">
                                            {$lang.destinationaddress}:
                                        </td>
                                        <td style="text-align:left; border:none">
                                            <input class="span5" autocomplete="off" type="text" name="url" id="url" placeholder="http://example-url.com/site" >
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
{literal}
    <script type="text/javascript">
        $(function() {
            var httpcode = $('#httpcode');

            $('#fwdtype').bind('keyup input change', function() {
                var val = $(this).val();
                if (val != 'std_fwd')
                    httpcode.prop('disabled',true).attr('disabled','disabled').addClass('disabled');
                else
                    httpcode.prop('disabled',false).removeAttr('disabled').removeClass('disabled');
            })
        })
    </script>
{/literal}
<script type="text/javascript" src="{$widgetdir_url}../widget.js"></script>
<link rel="stylesheet" type="text/css" href="{$widgetdir_url}../widget.css"  media="all">