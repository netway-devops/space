<div class="wbox">
    <div class="wbox_header">
        {if $lang[$widget.name]}{$lang[$widget.name]}
        {elseif $widget.fullname}{$widget.fullname}
        {else}{$widget.name}
        {/if}
    </div>
    <div class="wbox_content">
        {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
    </div>
    <div class="wbox_content">
        {if $next_invoice}
            <p class="alert alert-info">{$lang.autorenewinvoice} {$next_invoice|dateformat:$date_format}</p>
        {/if}
        <form action="" method="post">
            <div class="form-group">
                <label for="peymethod"><strong>{$lang.autorenew}</strong></label>
                <div class="">
                    <select id="autorenew" name="renew">
                        <option value="0" {if $service.autorenew==0}selected{/if}>{$lang.Off}</option>
                        <option value="1" {if $service.autorenew==1}selected{/if}>{$lang.On}</option>
                    </select>
                </div>
                <div class="help-block">
                    <p>
                        {$lang.sautorenew_enabled}
                    </p>
                    <p>
                        {$lang.sautorenew_disabled}
                    </p>
                </div>
            </div>

            {if $gates}
                <div class="form-group">
                    <label for="peymethod"><strong>{$lang.sautorenew_paymethod}</strong></label>
                    <div class="">
                        <select id="peymethod" name="gate">
                            {foreach from=$gates item=gate key=gateid}
                                <option value="{$gateid}"
                                        {if  $service.payment_module==$gateid}selected{/if}>{$gate}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            {/if}
            <p>
                {$lang.sautorenew_renewal}
            </p>
            <button type="submit" name="make" value="save" class="btn btn-primary" >
                {$lang.savechanges}
            </button>
            {securitytoken}
        </form>
    </div>
</div>

