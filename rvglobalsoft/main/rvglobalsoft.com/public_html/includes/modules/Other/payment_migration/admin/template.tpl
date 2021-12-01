<div id="newshelfnav" class="newhorizontalnav" style="margin-top: 0px; position: relative;">
    <h1 style="margin: 10px;">{$modname}</h1>
</div>

{if $migrated}
    <div class="well well-sm" role="alert">Migrated successfully</div>
{/if}

<div style="margin-top: 20px;">
    <form action="?cmd=module&module={$moduleid}&action=migrate" method="post">
        <div class="lighterblue" style="padding:5px">
            <table cellpadding="6" cellspacing="" >
                <tr>
                    <td width="200" align="right"><strong>Current gateway</strong></td>
                    <td>
                        <select name="pgateway_from" class="config_val">
                            {foreach from=$payments item=payment}
                                <option value="{$payment.id}">{$payment.module}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="200" align="right"><strong>Set to new gateway</strong></td>
                    <td>
                        <select name="pgateway_to" class="config_val">
                            {foreach from=$payments item=payment}
                                <option value="{$payment.id}">{$payment.module}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>

            </table></div>

        <div class="blu">
            {securitytoken}
            <input type="hidden" name="make" value="migrate" />
            <input type="submit" value="Migrate" class="btn btn-sm btn-primary" style="font-weight:bold"/>
        </div>
        {securitytoken}</form>
</div>