<style>
    {literal}
        #facebox .unblock-options tr:nth-child(2n) td{
            padding-bottom: 10px
        }
        #facebox .unblock-options input,
        #facebox .unblock-options textarea{
            vertical-align: middle;
            float: none;
            margin: 0;
        }
    {/literal}
</style>

<table style="width: 100%" class="unblock-options">
    <tr>
        <td> <strong>{$lang.cpanel_opt_widget_desc}</strong></td>
    </tr>
    <tr>
        <td>
            <textarea name="config[wdescription]" class="inp" style="width: 90%"
                      placeholder="">{$widget.config.wdescription}</textarea>
        </td>
    </tr>
    <tr>
        <td>
            <strong>{$lang.cpanel_opt_max_recent}</strong>
        </td>
    </tr>
    <tr>
        <td>
            {$lang.cpanel_opt_limit}
            <input type="text" name="config[limit]" value="{$widget.config.limit|default:"1"}" class="inp" style="width: 50px;"/>
            {$lang.cpanel_opt_in}
            <input type="text" name="config[period]" value="{$widget.config.period|default:"5"}" class="inp" style="width: 50px;"/>
            {$lang.cpanel_opt_minute}
        </td>
    </tr>


    <tr>
        <td> <strong>{$lang.cpanel_opt_custom}</strong></td>
    </tr>
    <tr>
        <td>
            <input type="checkbox" name="config[anyaddress]" value="1" {if $widget.config.anyaddress}checked="checked"{/if} class="inp" style=""/>
            {$lang.cpanel_opt_allow}
        </td>
    </tr>

    <tr>
        <td> <strong>{$lang.cpanel_opt_custom2}</strong></td>
    </tr>
    <tr>
        <td>
            <input type="checkbox" name="config[allowwhitelist]" value="1" {if $widget.config.allowwhitelist}checked="checked"{/if} class="inp" style=""/>
            {$lang.cpanel_opt_allow2}
        </td>
    </tr>


    <tr>
        <td> <strong>{$lang.cpanel_opt_protect}</strong></td>
    </tr>
    <tr>
        <td>
            <input type="checkbox" name="config[protect]" value="1" {if $widget.config.protect}checked="checked"{/if} class="inp" style=""/>
            {$lang.cpanel_opt_not_allow}
            <input type="text" name="config[denycomment]" value="{$widget.config.denycomment|default:"do not delete"}"
                   class="inp" style="width: 200px;"/>
            {$lang.cpanel_opt_deny}
        </td>
    </tr>

</table>