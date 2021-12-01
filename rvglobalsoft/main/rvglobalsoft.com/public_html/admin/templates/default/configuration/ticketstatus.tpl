<link rel="stylesheet" media="screen" type="text/css" href="{$template_dir}js/colorpicker/css/colorpicker.css" />
<script type="text/javascript" src="{$template_dir}js/colorpicker/colorpicker.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/ticketstatuses.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            {include file='configuration/leftmenu.tpl'}
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="">
                {include file="configuration/nav.tpl" picked_tab='2' }
                <div class="nicerblu" id="ticketbody">
                    <table border="0" cellspacing="0" cellpadding="6" width="100%">
                        <tr>
                            <td width="33%" valign="top">
                                <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable" >
                                    <tbody>
                                        <tr>
                                            <th align="left" colspan="2"><b>Current ticket statuses</b></th>
                                        </tr>
                                    </tbody>
                                </table>

                                <form id="serializeit" action="" method="post">
                                    <input type="hidden" name="make" value="sortorder" />
                                    <ul id="grab-sorter">
                                        {foreach from=$statuses item=status name=scloop}
                                            {if !($status.options & 4)}
                                                <li>
                                                    <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd; border-top:none;" class="whitetable">
                                                        <tr >
                                                            <td width="20">
                                                                <a class="sorter-handle">move</a><input type="hidden" value="{$status.status}" name="sort[]">
                                                            </td>
                                                            <td><span {if !($status.options & 1)}style="color:#{$status.color}"{/if} class="{if !($status.options & 1)}ticket-status-{/if}{$status.status}">{$status.status}</span></td>
                                                            <td width="49" class="lastitm">
                                                                {if !($status.options & 1)}
                                                                    <div class="btn-group">
                                                                        <a onclick="return editTStatus('{$status.status}', '{$status.color}', {$status.options})" 
                                                                           class="btn btn-xs btn-primary" href="#"><i class="fa fa-pencil"></i></a>
                                                                        <a onclick="return confirm('Do you really want to delete this status?')" class="btn btn-xs btn-danger" 
                                                                           href="?cmd=configuration&action=ticketstatuses&make=delete&security_token={$security_token}&status={$status.status}"><i class="fa fa-times"></i></a>
                                                                    </div>
                                                                {/if}
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </li>
                                            {/if}
                                        {/foreach}
                                    </ul>
                                    {securitytoken}
                                </form>
                                <br/>
                                <div>
                                    <a href="#" onclick="newTStatus();
                                            return false" class=" new_control greenbtn"><span>Create custom status</span></a>
                                </div>

                            </td>
                            <td valign="top">
                                <div class="blank_state blank_news" id="blank_state" style="padding:0px 0px">
                                    <div class="blank_info">
                                        <h1>Add custom ticket statuses</h1>
                                        With HostBill you can create custom ticket statuses and re-arrange current ones - to best suit your company's support workflow.
                                        <div class="clear"></div>
                                    </div>
                                </div>
                                <div class="p6" id="new_status" style="display:none">

                                    <form id="serializeit" action="" method="post">
                                        <input type="hidden" name="make" value="addstatus" />
                                        <table width="60%" cellspacing="0" cellpadding="6" border="0">
                                            <tbody>
                                                <tr >
                                                    <td  align="right" width="150"><strong>Status</strong></td>
                                                    <td><input class="inp" id="ticketstatus" value="" name="status" /></td>
                                                </tr>
                                                <tr >
                                                    <td  align="right" width="150"><strong>Auto-close</strong></td>
                                                    <td>
                                                        <input type="checkbox" value="2" name="options[]" checked="checked"/>   
                                                        <a class="vtip_description" title="Tickets with auto-close enabled can be automatically closed by cron if non replied, depending on department settings"></a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  align="right" width="150">Status color</td>
                                                    <td>
                                                        <input id="colorSelector_i" type="hidden" class="w250" size="7" name="color" value="000000" style="margin-bottom:5px"/>
                                                        <div id="colorSelector" style="border: 2px solid #ddd; cursor: pointer; float: left; height: 15px;margin: 6px 0 5px 8px;position:relative; width: 40px; background: #000000;" onclick="$('#colorSelector_i').click()">
                                                            <div style="position:absolute; bottom:0; right: 0; color:white; background:url('{$template_dir}img/imdrop.gif') no-repeat 3px 4px #ddd; height:10px; width:10px"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  align="right" width="150"></td>
                                                    <td>
                                                        <input type="submit" class="submitme add" style="font-weight:bold" value="Add new ticket status">
                                                        <input type="submit" class="submitme edit" style="font-weight:bold" value="Update ticket status">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        {securitytoken}
                                    </form>
                                </div>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </td>
    </tr>
</table>