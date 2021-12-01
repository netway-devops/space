<div class="wbox">
    <div class="wbox_header">{assign var=widg_name value="`$widget.name`_widget"}{if $lang[$widg_name]}{$lang[$widg_name]}{elseif $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
    <div class="wbox_content">
        <div class="help-block">{$lang.idprotection_desc}</div>


        <form action="" method="post">
            <input type="hidden" name="widgetdo" value="updateIDProtection"/>
            <p class="form-group">
                <label for="idprotection-dropdown">
                    {$lang.privacyprotection}
                </label>
                <select name="idprotection" class="inp styled" id="idprotection-dropdown">
                    <option value="0"
                            {if $details && $details.idprotection==0}selected="selected"{/if}>{$lang.Off}</option>
                    <option value="1"
                            {if $details &&  $details.idprotection==1}selected="selected"{/if}>{$lang.On}</option>

                </select>
            </p>
            <input type="submit" value="{$lang.savechanges}" class="padded btn btn-primary"/>
            {securitytoken}
        </form>
    </div>
</div>
