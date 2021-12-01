<div class="wbox">
    <div class="wbox_header">{assign var=widg_name value="`$widget.name`_widget"}{if $lang[$widg_name]}{$lang[$widg_name]}{elseif $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
    <div class="wbox_content">
        {if $cant_show_send_message}
            {$cant_show_send_message}
        {else}
            {if $EppCode}
                {if $send_epp}
                    <p>{$send_epp|string_format:$lang.epp_sent_to_registrar}</p>
                {elseif $send_epp_error}
                    <p>{$lang.epp_sent_to_registrar_error}</p>
                {else}
                    <b>{if isset($lang[$EppCode])}{$lang[$EppCode]}{else}{$EppCode}{/if}</b>
                {/if}
                <br/>
                <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/" class="fs11">{$lang.eppok}</a>
            {else}
                <p>{$lang.eppdescription}</p>
                <center>
                    <form method="post" action="">
                        <input type="hidden" value="getEppCode" name="widgetdo">
                        <input type="submit" style="font-weight:bold" value="{$lang.requestepp}"
                               class="padded  btn btn-primary">
                        <span class="fs11">{$lang.or}</span>
                        <a href="{$ca_url}clientarea/domains/{if $details}{$details.id}/{$details.name}/{/if}"
                           class="fs11">{$lang.cancel}</a>
                    </form>
                </center>
            {/if}
        {/if}
    </div>
</div>


