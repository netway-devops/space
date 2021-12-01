<link rel="stylesheet" media="screen" type="text/css" href="{$template_dir}js/colorpicker/css/colorpicker.css?v={$hb_version}" />
<link href="{$moduledirurl}css/config.css?v={$hb_version}" rel="stylesheet" />

<script type="text/javascript" src="{$template_dir}js/colorpicker/colorpicker.js?v={$hb_version}"></script>
<script src="{$moduledirurl}js/config.js?v={$hb_version}"></script>

<form id="calendar-conf" action="" method="POST">
    <div class="config-section">
        <h3>Settings</h3>
        <div class="calendar-option">
            <label>Ticket depatment for Notifications</label>
            <select name="department">
                {foreach from=$detps item=dept}
                    <option value="{$dept.id}" {if $config.department == $dept.id}selected{/if}>{$dept.name}</option>
                {/foreach}
            </select>
        </div>
        <div class="calendar-option">
            <label>
                Display period for related items
                <small>in account, invoice, client pages  etc.</small>
            </label>

            <div class="opt">
                <select name="relperiodfrom">
                    <option value="" >0 days</option>
                    <option value="7 days" {if $config.relperiodfrom == '7 days'}selected{/if}>7 days</option>
                    <option value="14 days" {if $config.relperiodfrom == '14 days'}selected{/if}>14 days</option>
                    <option value="1 month" {if $config.relperiodfrom == '1 month'}selected{/if}>1 month</option>
                    <option value="2 months" {if $config.relperiodfrom == '2 months'}selected{/if}>2 months</option>
                    <option value="3 months" {if $config.relperiodfrom == '3 months'}selected{/if}>3 months</option>
                </select> before current date.
                <br />
                up to <select name="relperiodto">
                    <option value="7 days" {if $config.relperiodto == '7 days'}selected{/if}>7 days</option>
                    <option value="14 days" {if $config.relperiodto == '14 days'}selected{/if}>14 days</option>
                    <option value="1 month" {if $config.relperiodto == '1 month'}selected{/if}>1 month</option>
                    <option value="2 months" {if $config.relperiodto == '2 months'}selected{/if}>2 months</option>
                    <option value="3 months" {if $config.relperiodto == '3 months'}selected{/if}>3 months</option>
                </select> after current date.
            </div>
        </div>
        <h3>Default Event options</h3>
        <div class="calendar-option">
            <label>Visiblity </label>
            <div class="opt">
                <input type="radio" name="visible" value="0" {if $config.visible == '0'}checked{/if}> Private &nbsp;
                <input type="radio" name="visible" value="1" {if $config.visible == '1'}checked{/if}> Public
            </div>
        </div>
        <div class="calendar-option">
            <label>Editable by others </label>
            <div class="opt">
                <input type="hidden" name="editable" value="0">
                <input type="checkbox" name="editable" value="1" {if $config.editable == '1'}checked{/if}>
            </div>
        </div>

    </div>
    <div class="config-section" id="calendar-groups">
        <h3>Groups</h3>
        <ul class="group-list"></ul>
        <a href="#new" class="btn"> Add new group </a>
        <span class="right"> Click on <span class="group-style" style="margin: 0"><i class="fa fa-code"></i></span> to change group color </span>
    </div>
    <div>
        <a href="?cmd=calendar" class="btn"> &laquo; Back </a>
        <button class="btn" type="submit"> Save settings </button>
        {securitytoken}
    </div>
</form>

{literal}
    <script>
        var calendar_groups = {/literal}{$groups|@json_encode}{literal};
    </script>
{/literal}