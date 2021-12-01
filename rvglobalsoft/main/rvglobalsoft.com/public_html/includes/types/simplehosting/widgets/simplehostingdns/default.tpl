{if $cperror}
    <div style="border-radius: 6px 6px 6px 6px; background: url('icons/ico_warn.gif') no-repeat scroll 8px 8px #FFFBCC; border: 1px solid #E6DB55;color: #FF0000;font-weight: bold;margin-bottom: 8px;padding: 8px 8px 8px 30px;">
        {$lang.couldconectto} <strong>CPanel</strong>
        <br />
        {$lang.checkyourloginpassword}
    </di>
{else}
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
                        $(this).parents('tr').hide().next().show().find('input, select').prop('disabled',false).removeAttr('disabled');
                        return false;
                    });
                });
                $('.disab').find('input, select').prop('disabled',true).attr('disabled','disabled');
            });
        </script>
    {/literal}
    <div >
        <div id="billing_info" class="wbox form-inline">
            <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
            <div class="wbox_content">
                <form autocomplete="off" action="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}" method="post">
                    <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0" style="table-layout: fixed">
                        {counter start=1 skip=1 assign=even}
                        <thead>
                            <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                                <td align="right"  width="30%">{$lang.name}</td>
                                <td align="center" width="10%"> TTL</td>
                                <td align="center" width="5%"> {$lang.class}</td>
                                <td align="center" width="9%"> {$lang.type}</td>
                                <td align="center" width="40"> {$lang.record}</td>
                                <td width="5%"></td>
                            </tr>
                        </thead>
                        <tbody id="updater">
                            {if $listentrys}
                                {foreach from=$listentrys item=entry key=index} 
                                    <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                        <td align="right" style="text-overflow:ellipsis; overflow: hidden" title="{$entry.name}">{$entry.name}</td>
                                        <td align="left">{$entry.ttl}</td>
                                        <td align="left">{$entry.class}</td>
                                        <td align="left">{$entry.type}</td>
                                        <td align="left" style="text-overflow:ellipsis; overflow: hidden" title="{$entry.record}">{$entry.record}</td>
                                        <td class="management_links">
                                            <div class="btn-group" style="width: 50px">
                                                <a class="btn btn-mini"><img width="11" src="{$widgeturl}pencil.png"></a>
                                                <a class="btn btn-mini" href="?cmd={$cmd}&action={$action}&service={$service.id}&widget={$widget.name}&act={$act}&del={$entry.line}" onclick="return confirm('Do You really want to delete this entry?')"><img width="11" src="{$widgeturl}cross.png"></a> 
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="disab" style="display:none" {counter}{if $even % 2 !=0}class="even"{/if}>
                                        <td><input class="span2" name="records[{$entry.line}][name]" value="{$entry.name}" /></td>
                                        <td><input class="span1" name="records[{$entry.line}][ttl]" value="{$entry.ttl}" /></td>
                                        <td>{$entry.class}</td>
                                        <td>
                                            <select class="span1" name="records[{$entry.line}][type]">
                                                <option {if $entry.type == 'A'}selected="selected"{/if}>A</option>
                                                <option {if $entry.type == 'CNAME'}selected="selected"{/if}>CNAME</option>
                                                <option {if $entry.type == 'TXT'}selected="selected"{/if}>TXT</option>
                                            </select>
                                        </td>
                                        <td><input class="span2" name="records[{$entry.line}][record]" value="{$entry.record}" /></td>
                                        <td>
                                            <input type="submit" class="btn" name="save" value="{$lang.shortsave}" /> 
                                        </td>
                                    </tr>
                                {/foreach}
                            {/if}
                        </tbody>
                        <tfoot>
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">&nbsp;</td></tr>
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">{$lang.addrecord}</td></tr>
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td style="border:none" colspan="4" align="center" class="form-inline">
                                    <table style="float:left" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td style="text-align:right;border:none">Name: </td>
                                            <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="name" >.{*}
                                                {*}{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right;border:none">TTL: </td>
                                            <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="ttl" ></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right;border:none">Type: </td>
                                            <td style="text-align:left; border:none"> 
                                                <select class="span2" name="type" >
                                                    <option>A</option>
                                                    <option>CNAME</option>
                                                    <option>TXT</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align:right;border:none">Record: </td>
                                            <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="record" ></td>
                                        </tr>
                                    </table>
                                    <div style="float:left; padding:15px 6px;vertical-align:middle"><input class="btn" type="submit" name="save" value="{$lang.shortsave}"> </div>
                                </td></tr>
                        </tfoot>
                    </table>
                </form>
            </div>
        </div>
    </div>
{/if}