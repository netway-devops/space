<div class="page-header mb-2">
    {if $domain}
        <h4>
            {$lang.domain}: {$domain.domain}
            <div>
                <small class="small">{$lang.dns_progress_import}</small>
            </div>
        </h4>

    {else}
        <h4>{$title}</h4>
        <span>
            {foreach from=$domains item=dom name=dom}{$dom.domain}{if !$smarty.foreach.dom.last}, {/if}{/foreach}
        </span>
    {/if}
</div>
<div class="progress progress-striped active mb-4" data-done="{$lang.dns_progress_done}">
    <div class="bar progress-bar progress-bar-striped progress-bar-animated"
         style="width: {$percent}%;"></div>
</div>

{if $domain}
    <a class="btn btn-primary disabled progress-btn" href="{$service_url}&act=dns_manage&domain_id={$domain.domain_id}">
        {$lang.continue}
    </a>
{else}
    <a class="btn btn-primary disabled progress-btn" href="{$service_url}">
        {$lang.back}
    </a>
{/if}

{literal}
    <script type="text/javascript">
        $(function () {
            var progress = $('.progress'),p
                btn = $('.progress-btn');

            function update() {
                $.get(window.location.href, function (data) {
                    if (!data.hasOwnProperty('percent')) {
                        return;
                    }

                    var width = Math.max(2, data.percent);

                    progress.find('.bar')
                        .css('width', width + '%');

                    if (data.status > 2) {
                        progress.attr('class', 'progress progress-success text-center mb-2')
                            .find('.bar')
                            .attr('class', 'bar progress-bar bg-success')
                            .text(progress.data('done'));
                        btn.removeClass('disabled')
                    } else {
                        setTimeout(update, 100);
                    }
                })
            }

            update();
        })
    </script>
{/literal}
