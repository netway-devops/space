
<div >
    <div id="billing_info" class="wbox">
        <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
        <div class="wbox_content">
            <form autocomplete="off" action="{$widget_url}&act={$act}" method="post">
                <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                    {counter start=1 skip=1 assign=even}
                    <thead>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                            <td align="right">{$lang.subdomain}</td>
                            <td align="center"> {$lang.homedirectory}</td>
                            <td align="center">{$lang.managementfunctions}</a></td>
                        </tr>
                    </thead>
                    <tbody id="updater">

                        {foreach from=$listentrys item=entry key=index} 
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="right">{$entry.name}</td>
                                <td align="left">/{$entry.basedir}</td>
                                <td align="center" class="management_links">
                                    <a href="{$widget_url}&act={$act}&changepass"><small>{$lang.changedirectory}</small></a> |
                                    <a href="{$widget_url}&act={$act}&del={$entry.id}&security_token={$security_token}" 
                                       onclick="return confirm('{$lang.plesk_del_subdomain}')">
                                        <small>{$lang.delete}</small>
                                    </a> 
                                </td>
                            </tr>
                            <tr {if $even % 2 !=0}class="even"{/if} style="display:none">
                                <td align="right" ><input type="submit" name="savechange" value="{$lang.shortsave}" class="btn btn-primary"></td>
                                <td align="right"  colspan="2">	{$lang.homedirectory}: 						
                                    <input type="hidden" name="change[{$index}][sub]" value="{$entry.id}">
                                    <input autocomplete="off" type="text" name="change[{$index}][dir]" value="{$entry.basedir}" class="span4">
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
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">{$lang.addsubdomain}</td></tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                            <td style="border:none" colspan="4" align="center" class="form-inline">
                                <table style="float:left" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.subdomain}: </td>
                                        <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="sub" id="subdomain" ><span id="domain">.{*}
                                                {*}{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.homedirectory}: </td>
                                        <td style="text-align:left;border:none"> <input autocomplete="off" type="text" name="dir" class="span4" id="dir"></td>
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
            var dir = $('#dir'),
                domain = $('#domain').text();

            $('#subdomain').bind('keyup input change', function() {
                var val = $(this).val(),
                    text = '';
                if (val)
                    text = '/' + val + domain;

                dir.prop('placeholder', text);
            })
        })
    </script>
{/literal}
<script type="text/javascript" src="{$widgetdir_url}../widget.js"></script>
<link rel="stylesheet" type="text/css" href="{$widgetdir_url}../widget.css"  media="all">