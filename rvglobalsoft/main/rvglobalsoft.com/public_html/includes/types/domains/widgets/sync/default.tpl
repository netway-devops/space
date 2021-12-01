<div class="wbox">
    <div class="wbox_header">
        {assign var=widg_name value="`$widget.name`_widget"}
        {if $lang[$widg_name]}{$lang[$widg_name]}
        {elseif $lang[$widget.name]}{$lang[$widget.name]}
        {elseif $widget.fullname}{$widget.fullname}
        {else}{$widget.name}
        {/if}
    </div>
    <div id="cartSummary" class="wbox_content">

        <p>
            {if $details.status == 'Pending Transfer'}
                {$lang.syncdomain_transfer}
            {else}
                {$lang.syncdomain_register}
            {/if}

        </p>
        <form method="post" action="" style="text-align: center">
            <input type="hidden" value="getEppCode" name="widgetdo" style="text-align: center">

            <button type="submit" name="widgetdo" value="sync"
                    class="padded btn btn-primary">
                {$lang.syncdomain}
            </button>
            <span class="fs11">{$lang.or}</span>
            <a href="{$ca_url}clientarea/domains/{if $details}{$details.id}/{$details.name}/{/if}"
               class="fs11">{$lang.cancel}</a>
        </form>
    </div>
</div>
