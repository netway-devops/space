<div class="wbox">
    <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
    <div id="cartSummary" class="wbox_content">
        <center>
            <form method="post" action="">
                <input type="hidden" value="change" name="make">
				<div style="padding: 5px"><label style="width: 40%; text-align: right; display:block; float: left; margin-right: 5px">Current ip address: </label> <input class="left" type="text" disabled="disabled" value="{$oldip}" /><div class="clear"></div></div>
				<div style="padding: 5px"><label style="width: 40%; text-align: right; display:block; float: left; margin-right: 5px">New ip address: </label><input name="ipaddress" class="left" type="text"  value="" /><div class="clear"></div></div>

                <input class="btn btn-primary" type="submit" value="{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}">
                <span class="fs11">{$lang.or}</span> <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" class="fs11">{$lang.cancel}</a>
            </form>
        </center>
        
    </div>
</div>