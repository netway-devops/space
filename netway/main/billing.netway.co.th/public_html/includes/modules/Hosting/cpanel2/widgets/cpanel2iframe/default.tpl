<div class="wbox_content">
    {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
</div>
{if $iframe_url}


    <iframe src="{$iframe_url}"
            id="cpaneliframe"
            width="100%"
            border="0"
            style="border:none;min-height:800px; height:100%"></iframe>


    {literal}
        <script>
            $(window).on('load resize', function () {
                $window = $('#cpaneliframe').parent().parent();
                var geth = function () {
                    return $window.height();
                };
                $('#cpaneliframe').parent().height(geth);
                $('#cpaneliframe').height(geth);
            });
        </script>
    {/literal}
{/if}
