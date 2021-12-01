<div class="wbox">
    <div class="wbox_header">{$lang.servicelabel}</div>
    <div id="cartSummary" class="wbox_content">
        <form class="form" method="post" action="">
            <label class="control-label" for="inputLabel">{$lang.servicelabeldscr}</label><br/>
            <input type="hidden" name="id" value="{$service.id}">
            <input type="text" id="inputLabel" name="servicelabel" value="{$service.label}" placeholder="{$lang.label}"><br/><br/>

            <input type="submit" style="font-weight:bold" value="{$lang.shortsave}" class="btn btn-info padded">
            <span class="fs11">{$lang.or}</span>
            <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" class="fs11 btn btn-default">{$lang.cancel}</a>
            {securitytoken}
        </form>
    </div>
</div>