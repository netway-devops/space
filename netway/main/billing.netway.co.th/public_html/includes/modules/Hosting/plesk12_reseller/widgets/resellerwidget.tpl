
{if $iframe }
    <iframe src="{$iframe}" frameborder="0" scrolling="yes"  border="0" width="100%" id="reseller-frame" style="height:100%" onload="iframeLoaded()"></iframe>
    <script type="text/javascript" src="{$widgetdir_url}../widget.js"></script>

{else}
    <div class="wbox">
        <div class="wbox_header">
            {$lang.logindetails}
        </div>
        <div class="wbox_content" style="border:0px">

            <p style="text-align: center">Something went wrong, please use button below to attempt to re-login</p>
            <center>
                <a href="{$widget_url}&relogin=true" class="btn btn-success">Retry login</a>
            </center>
        </div>
    </div>
{/if}
