<div >
    <div id="billing_info" class="wbox">
        <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
        <div class="wbox_content">
            {if $domains}
                <div style="width: 100%; margin: 15px 0; z-index: 100;">
                    <select name="domain" id="domains">
                        {foreach from=$domains item=domain}
                            <option value="{$domain.id}">{$domain.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div style="margin:0; padding: 0; overflow:hidden; {if $lets_encrypt == '1'}max-height: 600px;{/if}">
                    <iframe id="ssl_contetn" src="" frameborder="0"
                            style="overflow:hidden; height:100vh; width:100%; top: -35px; position: relative;" height="100%" width="100%" scrolling="no"></iframe>
                </div>
                {if $lets_encrypt == '1'}
                    <div style="margin:0; padding: 0; overflow:hidden; max-height: 1000px;">
                        <iframe id="ssl_lets" src="" frameborder="0"
                                style="overflow:hidden; height:100vh; width:100%; top: -35px; position: relative;" height="100%" width="100%" scrolling="no"></iframe>
                    </div>
                {/if}
            {else}
                <div class="center text-center" style="padding: 15px;">
                    <strong>{$lang.nothing}</strong>
                </div>
            {/if}
        </div>
    </div>
</div>
{literal}
<script>
    var url = {/literal}'{$iframe}'{literal},
        url_lets = {/literal}'{$iframe_lets}'{literal},
        domains = $('#domains'),
        iframe = $('#ssl_contetn'),
        iframe_lets = $('#ssl_lets');
    $(function () {
        update_iframe(domains);
    });
    domains.on('change', function () {
       update_iframe($(this));
    });

    function update_iframe(domain) {
        var id = $(domain).val();
        iframe.attr('src', url + id);
        iframe_lets.attr('src', url_lets + id);
    }
</script>
{/literal}