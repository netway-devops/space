<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="assets/img/favicon.png">
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name}</title>
        {literal}
            <style>
                body, html {
                    margin:0px;
                    font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
                    height: 100%;
                    overflow: visible;
                    background-color:#f4f4f4;
                    line-height: 1.538;
                    color: #545454;
                    position:relative;
                }
                .maintance-wrapper {
                    width: 478px;
                    background: #fff;
                    padding: 17px;
                    border-radius: 2px;
                    text-align: center;
                    position: fixed;
                    left: 50%;
                    top: 50%;
                    margin-left: -256px;
                    margin-top: -200px;
                    overflow: hidden;
                    z-index: 99999;
                }
            </style>
        {/literal}
    <body >
        <div class="maintance-wrapper">
            <div class="main-content">
                <div class="msg-container">
                    <h1>{$business_name}</h1>
                    <div class="msg-description">
                        {$lang.under_maintenance}
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>