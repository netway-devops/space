<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
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
        <td valign="top" class="bordered">
            <div id="bodycont" style="">
                {include file="configuration/nav.tpl" picked_tab='6'}
                <div class="nicerblu" id="reasonbody" style="padding: 0;">
                    {if $action == 'add' || $action == 'edit'}
                        <div style="padding: 15px;">
                            <div class="row">
                                <div class="col-sm-12">
                                    <form action="?cmd=cancellationreasons&action={if $reason.id}edit{else}add{/if}" method="post">
                                        <div class="form-group col-sm-8">
                                            <label>Reason</label>
                                            <input type="text" name="reason[reason]" value="{$reason.reason}" class="form-control" id="reason" required>
                                            <div class='l_editor' id='l_editor_reason'>
                                                <span class='translations'>
                                                    <span style="{if !$reason.tags}display: none;{/if}" class='taag'>
                                                        Tags:
                                                        {foreach from=$reason.tags item=tag key=tagid}
                                                            <a href="?cmd=langedit&action=bulktranslate&key={$tagid}" target="_blank">{$tag}</a>
                                                        {/foreach}
                                                    </span>
                                                </span>
                                                <a class='fs11 editbtn l_adder' href='#' onclick='return HBInputTranslate.addTranslation("reason");'>Add translation</a>
                                                <div class='clear'></div>
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-2">
                                            <label>Target</label>
                                            <select class="form-control" name="reason[target]">
                                                <option value="all" {if $reason.target == 'all' || !$reason.target}selected{/if}>All</option>
                                                <option value="service" {if $reason.target == 'service'}selected{/if}>Service</option>
                                                <option value="domain" {if $reason.target == 'domain'}selected{/if}>Domain</option>
                                            </select>
                                        </div>
                                        <div class="form-group col-sm-2">
                                            <label>&nbsp;</label><br>
                                            <button type="submit" class="btn btn-success">{if $reason.id}{$lang.Edit}{else}{$lang.Add}{/if}</button>
                                            <a href="?cmd=cancellationreasons" class="btn btn-primary">{$lang.Back|default:"Back"}</a>
                                        </div>
                                        {if $reason.id}
                                            <input type="hidden" name="reason[id]" value="{$reason.id}">
                                        {/if}
                                        {securitytoken}
                                    </form>
                                </div>
                            </div>
                        </div>
                    {else}
                        {if $reasons}
                            <form id="serializeit" method="post">
                                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                                    <tbody>
                                    <tr>
                                        <th width="20"></th>
                                        <th>Reason</th>
                                        <th width="100">Target</th>
                                        <th width="100">Counter</th>
                                        <th width="100">&nbsp;</th>
                                    </tr>
                                    </tbody>
                                </table>
                                <ul id="grab-sorter" style="width:100%">
                                    {include file="ajax.cancellationreasons.tpl"}
                                </ul>
                                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
                                    <tbody>
                                    <tr>
                                        <th width="20"></th>
                                        <th>
                                            <a class="btn btn-sm btn-success" href="?cmd=cancellationreasons&action=add">{$lang.add_reason}</a>
                                        </th>
                                    </tr>
                                    </tbody>
                                </table>
                                {securitytoken}
                            </form>
                        {else}
                            <div class="blank_state blank_services">
                                <div class="blank_info">
                                    <h1>{$lang.cancel_reason_blank}</h1>
                                    <a class="new_add new_menu" href="?cmd=cancellationreasons&action=add" style="margin-top:10px">
                                        <span>{$lang.add_reason}</span></a>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        {/if}
                    {/if}
                </div>
            </div>
        </td>
    </tr>
</table>