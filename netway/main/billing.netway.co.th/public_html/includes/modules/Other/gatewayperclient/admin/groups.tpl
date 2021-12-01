{include file="navbar.tpl"}

<script src="{$moduleurl}js/scripts.js"></script>

<link rel="stylesheet" href="{$moduleurl}css/style.css">

{if $action == 'groups' || $action == 'default'}
    <table class="glike hover" width="100%" cellspacing="0" cellpadding="3" border="0">
        <tr>
            <th>ID</th>
            <th>Groups</th>
            <th>Gateways</th>
            <th style="width: 100px;"></th>
        </tr>
        {foreach from=$configs item=config name=fff}
            <tr>
                <td>{$config.id}</td>
                <td>
                    {foreach from=$config._groups item=item}
                        <a href="?cmd=clients&action=editgroup&id={$item.id}" class="isclient isclient-{$item.id}">{$item.name}</a>
                        <br>
                    {/foreach}
                </td>
                <td>
                    {foreach from=$config._gateways item=gtw}
                        #{$gtw.id} {$gtw.name}
                        <br>
                    {/foreach}
                </td>
                <td style="white-space: nowrap;">
                    <a href="?cmd={$modulename}&action=removeconfig&id={$config.id}&security_token={$security_token}&page=groups" onclick="return confirm('Are you sure you want to remove this config?')" style="color: red">Remove</a>
                </td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="3">Nothing found</td>
            </tr>
        {/foreach}
    </table>
{elseif $action == 'addgroups'}
    <div style="padding:15px;">
        <form action="?cmd=gatewayperclient&action=addgroups" method="POST">
            <table id="tableform" cellpadding="5" style="width: 100%">
                <tbody>
                <tr>
                    <td>
                        <label for="">Groups</label>
                    </td>
                    <td>
                        <select class="form-control chosenproducts" name="items[]" multiple>
                            {foreach from=$groups item=group}
                                <option value="{$group.id}">#{$group.id} {$group.name}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                </tbody>
                <tbody>
                <tr>
                    <td>
                        <label><b>Enabled Payment Gateways</b></label>
                        <p class="small-descr">
                            Select payment gateways that will be available for these client groups
                        </p>
                    </td>
                    <td>
                        {include file="moduleconfig.tpl"}
                    </td>
                </tr>
                </tbody>
            </table>
            <input type="hidden" name="type" value="group">
            <input type="hidden" name="make" value="add">
            <button type="submit" class="btn btn-success" style="margin-top: 20px;">{$lang.savechanges}</button>
            {securitytoken}
        </form>
    </div>
{/if}