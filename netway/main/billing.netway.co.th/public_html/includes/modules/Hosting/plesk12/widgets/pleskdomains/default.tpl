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
                            <td align="center"> {$lang.homedirectory}</td>
                            <td align="center">{$lang.managementfunctions}</a></td>
                        </tr>
                    </thead>
                    <tbody id="updater">

                        {foreach from=$listentrys item=entry key=index} 
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="right" style="white-space: nowrap">{$entry.name}</td>
                                <td align="left">/{$entry.basedir}</td>
                                <td align="center"  style="white-space: nowrap">
                                    <a href="{$widget_url}&act={$act}&del={$entry.id}&security_token={$security_token}"
                                       onclick="return confirm('{$lang.plesk_del_domain}')">
                                        <small>{$lang.delete}</small>
                                    </a> 
                                </td>
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
                                <h4>{$lang.addnewpldomain}</h4>
                            </td>
                        </tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                            <td style="border:none" colspan="4" align="center" class="form-inline">
                                <table style="" cellspacing="0" cellpadding="0" width="100%">
                                    {if $hbdomains}

                                        <tr><td style="text-align:right;">{$lang.selectdomain}</td><td><select name="domain_id" class="span3"><option value="0"></option>
                                                {foreach from=$hbdomains item=dom}
                                                    <option value="{$dom.id}">{$dom.name}</option>
                                                {/foreach} </select></td></tr>
                                    {/if}
                                    <tr>
                                        <td style="text-align:right;border:none">{if $hbdomains}{$lang.or}  {/if}{$lang.plmanualdomain} </td>
                                        <td style="text-align:left; border:none"> <input autocomplete="off" type="text" name="name" class="span4" id="subdomain" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.homedirectory}: </td>
                                        <td style="text-align:left;border:none"> <input autocomplete="off" type="text" name="dir" class="span4" id="dir"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><input class="btn btn-primary" type="submit" name="save" value="{$lang.add}"> </td>
                                    </tr>
                                </table>
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