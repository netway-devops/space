
{if $iframe }
    <iframe src="{$iframe}" frameborder="0" scrolling="yes"  border="0" width="100%" id="reseller-frame" style="min-height:700px; height:100%" ></iframe>
    <script type="text/javascript" src="{$widgetdir_url}../widget.js"></script>

{else}
    <div class="wbox">
        <div class="wbox_header">
            {$lang.logindetails}
        </div>
        <div class="wbox_content" style="border:0px">

            <p style="text-align: center">{$lang.somethingwentwrongpleasebuttonbelow}</p>
            <center>
                <a href="{$widget_url}&relogin=true" class="btn btn-success">{$lang.retrylogin}</a>
            </center>
        </div>
    </div>
{/if}
