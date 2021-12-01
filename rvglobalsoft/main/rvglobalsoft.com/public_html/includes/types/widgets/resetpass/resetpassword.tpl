<div class="wbox">
    <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
    <div id="cartSummary" class="wbox_content">
        <p >{$lang.resetpassconfirm}</p>
        <center>
            <form method="post" action="">
                <input type="hidden" value="resetpassword" name="make">

                <input type="submit" style="font-weight:bold" value="{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}" class="btn btn-info padded">
                <span class="fs11">{$lang.or}</span> <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" class="fs11">{$lang.cancel}</a>
            </form>
        </center>
        
    </div>
</div>