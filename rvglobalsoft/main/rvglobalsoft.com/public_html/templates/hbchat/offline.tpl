<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name} </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="text/javascript" src="{$template_dir}js/jquery.js?v={$hb_version}"></script>
        <link href="{$template_dir}media/popup.css?v={$hb_version}" rel="stylesheet" media="all" />
    </head>

    {* THIS TEMPLATE IS DISPLAYED IF NO DEPARTMENTS ARE ONLINE, AND THERE IS NO DEPARMENT WITH "LEAVE MESSAGE" OPTION *}

    <body class="hbpopup">
        <div id="chatshelf">
            <h1>{$business_name}</h1>
        </div>
        <div class="clear" ></div>
        <div id="chatcontainer">
            <div class="tab" id="tab_email">
                <div id="headershelf">
                    <div class="left">{$lang.chat_offline_title}</div>
                    <div class="clear"></div>
                </div>
                <div id="pickdept_container" class="form"><br/> <br/>
                    <strong>{$lang.chat_offline_status}</strong>
                </div>
            </div>

        </div>
        <div class="clear"></div>

        {if $gb}<div class="hblogo">
            Powered by <a href="https://hostbillapp.com/" target="_blank">HostBill</a>
        </div>{/if}

    </body>
</html>