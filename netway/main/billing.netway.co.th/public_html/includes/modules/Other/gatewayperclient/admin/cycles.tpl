{include file="navbar.tpl"}

<script src="{$moduleurl}js/scripts.js"></script>

<link rel="stylesheet" href="{$moduleurl}css/style.css">

{if $action == 'cycles'}
    <table class="glike hover" width="100%" cellspacing="0" cellpadding="3" border="0">
        <tr>
            <th>ID</th>
            <th>Cycles</th>
            <th>Gateways</th>
            <th style="width: 100px;"></th>
        </tr>
        {foreach from=$configs item=config name=fff}
            <tr>
                <td>{$config.id}</td>
                <td>
                    {foreach from=$config._cycles item=item}
                        {$item}
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
                    <a href="?cmd={$modulename}&action=removeconfig&id={$config.id}&security_token={$security_token}&page=cycles" onclick="return confirm('Are you sure you want to remove this config?')" style="color: red">Remove</a>
                </td>
            </tr>
            {foreachelse}
            <tr>
                <td colspan="3">Nothing found</td>
            </tr>
        {/foreach}
    </table>
{elseif $action == 'addcycles'}
    <div style="padding:15px;">
        <form action="?cmd=gatewayperclient&action=addcycles" method="POST">
            <table id="tableform" cellpadding="5" style="width: 100%">
                <tbody>
                <tr>
                    <td>
                        <label for="">Cycles</label>
                    </td>
                    <td>
                        <select class="form-control chosenwithall" name="items[]" multiple>
                            <option value="h" >{$lang.Hourly}</option>
                            <option value="d" >{$lang.Daily}</option>
                            <option value="w" >{$lang.Weekly}</option>
                            <option value="m" >{$lang.Monthly}</option>
                            <option value="q" >{$lang.Quarterly}</option>
                            <option value="s" >{$lang.SemiAnnually}</option>
                            <option value="a" >{$lang.Annually}</option>
                            <option value="b" >{$lang.Biennially}</option>
                            <option value="t" >{$lang.Triennially}</option>
                        </select>
                    </td>
                </tr>
                </tbody>
                <tbody>
                <tr>
                    <td>
                        <label><b>Enabled Payment Gateways</b></label>
                        <p class="small-descr">
                            Select payment gateways that will be available for these cycles
                        </p>
                    </td>
                    <td>
                        {include file="moduleconfig.tpl"}
                    </td>
                </tr>
                </tbody>
            </table>
            <input type="hidden" name="type" value="cycle">
            <input type="hidden" name="make" value="add">
            <button type="submit" class="btn btn-success" style="margin-top: 20px;">{$lang.savechanges}</button>
            {securitytoken}
        </form>
    </div>
{/if}