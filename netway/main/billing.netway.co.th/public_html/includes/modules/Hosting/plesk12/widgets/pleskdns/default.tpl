{foreach from=$widgets item=wig}
    {if $widget.name == $wig.name}
        {assign value=$wig.location var=widgeturl}
    {/if}
{/foreach}
{literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $('.management_links div').each(function(i) {
                $(this).children().eq(0).click(function() {
                    $(this).parents('tr').hide().next().show().find('input, select').prop('disabled', false).removeAttr('disabled');
                    return false;
                });
            });
            
        });
    </script>
{/literal}
{if $domains}
    <div >
        <div id="billing_info" class="wbox">
            <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
            <div class="wbox_content">
                <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                    {counter start=1 skip=1 assign=even}
                    <thead>
                    <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                        <td align="left">{$lang.Domain}</td>
                        {if $hide_home_direcroty != '1'}
                            <td align="right">{$lang.Domain}</td>
                            <td align="center"> {$lang.homedirectory}</td>
                        {/if}
                        <td align="center"></td>
                    </tr>
                    </thead>
                    <tbody id="updater">
                    {foreach from=$domains item=entry key=index}
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                            <td align="left" style="white-space: nowrap">{$entry.name}</td>
                            {if $hide_home_direcroty != '1'}
                                <td align="right" style="white-space: nowrap">{$entry.name}</td>
                                <td align="left">/{$entry.basedir}</td>
                            {/if}
                            <td align="center"  style="white-space: nowrap">
                                <a href="{$widget_url}&domain_id={$entry.id}" class="btn btn-sm btn-primary"><small>{$lang.choose}</small></a>
                            </td>
                        </tr>
                        {foreachelse}
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                            <td align="center" colspan="4" style="text-overflow:ellipsis; overflow: hidden" >{$lang.nothing}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
{elseif $domain_id}
    <div >
        <div id="billing_info" class="wbox">
            <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
            <div class="wbox_content">
                <form autocomplete="off" action="{$widget_url}&act={$act}&domain_id={$domain_id}" method="post">
                    <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed">
                        {counter start=1 skip=1 assign=even}
                        <thead>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                            <th align="right"  width="30%">{$lang.name|capitalize}</th>
                            <th align="center" width="5%"> {$lang.class|capitalize}</th>
                            <th align="center" width="10%"> {$lang.priority|capitalize}</th>
                            <th align="center" width="10%"> {$lang.type|capitalize}</th>
                            <th align="center" width="30%"> {$lang.record|capitalize}</th>
                            <th width="15%"></th>
                        </tr>
                        </thead>
                        <tbody id="updater">
                        {foreach from=$listentrys item=entry key=index}
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="right" style="text-overflow:ellipsis; overflow: hidden" title="{$entry.host}">{$entry.host}</td>
                                <td align="left">{$entry.class}</td>
                                <td align="left">{$entry.opt}</td>
                                <td align="left">{$entry.type}</td>
                                <td align="left" style="text-overflow:ellipsis; overflow: hidden" title="{$entry.value}">{$entry.value}</td>
                                <td class="management_links">
                                    <a class="btn btn-mini"><img width="11" src="{$widgeturl}pencil.png"></a>
                                    <a class="btn btn-mini" href="{$widget_url}&act={$act}&del={$entry.id}&domain_id={$domain_id}&security_token={$security_token}"
                                       onclick="return confirm('{$lang.plesk_del_entry}')">
                                        <img width="11" src="{$widgeturl}cross.png">
                                    </a>
                                </td>
                            </tr>
                            <tr class="" style="display:none" {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td><input class="span2" name="records[{$entry.id}][name]" value="{$entry.host}" /></td>
                                <td><input class="span1" name="records[{$entry.id}][opt]" value="{$entry.opt}" /></td>
                                <td>{$entry.class}</td>
                                <td>
                                    <select class="span1" name="records[{$entry.id}][type]">
                                        <option {if $entry.type == 'A'}selected="selected"{/if}>A</option>
                                        <option {if $entry.type == 'AAAA'}selected="selected"{/if}>AAAA</option>
                                        <option {if $entry.type == 'NS'}selected="selected"{/if}>NS</option>
                                        <option {if $entry.type == 'MX'}selected="selected"{/if}>MX</option>
                                        <option {if $entry.type == 'CNAME'}selected="selected"{/if}>CNAME</option>
                                        <option {if $entry.type == 'TXT'}selected="selected"{/if}>TXT</option>
                                        <option {if $entry.type == 'PTR'}selected="selected"{/if}>PTR</option>
                                        <option {if $entry.type == 'SRV'}selected="selected"{/if}>SRV</option>
                                    </select>
                                </td>
                                <td><input class="span2" name="records[{$entry.id}][record]" value="{$entry.value}" /></td>
                                <td>
                                    <input type="submit" class="btn btn-sm" name="save" value="{$lang.shortsave}" />
                                </td>
                            </tr>
                            {foreachelse}
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="center" colspan="6" style="text-overflow:ellipsis; overflow: hidden" >{$lang.nothing}</td>
                            </tr>
                        {/foreach}
                        </tbody>
                        <tfoot>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="6">&nbsp;</td></tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="6">{$lang.addrecord}</td></tr>
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                            <td style="border:none" colspan="6" align="center" class="form-inline">
                                <table style="float:left" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.name}: </td>
                                        <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="name" >.{*}
                                            {*}{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.priority}: </td>
                                        <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="opt" ></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.type}: </td>
                                        <td style="text-align:left; border:none">
                                            <select class="span2" name="type" >
                                                <option>A</option>
                                                <option>CNAME</option>
                                                <option>NS</option>
                                                <option>MX</option>
                                                <option>TXT</option>
                                                <option>PTR</option>
                                                <option>AXFR</option>
                                                <option>SRV</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;border:none">{$lang.record}: </td>
                                        <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="record" ></td>
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
{/if}
<script type="text/javascript" src="{$widgetdir_url}../widget.js"></script>
<link rel="stylesheet" type="text/css" href="{$widgetdir_url}../widget.css"  media="all">