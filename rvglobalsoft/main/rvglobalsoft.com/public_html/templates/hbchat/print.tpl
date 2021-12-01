<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name} </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="{$template_dir}media/print.css?v={$hb_version}" rel="stylesheet" media="all" />
    </head>
    <body class="hbpopup" onload="window.print()">
        <div class="msg_wrapper msg_Status">
                    <div class="clear"></div>
                    <span class="msg left"><b>{$lang.department}: {$chat.deptname}</b></span>
                    <div class="right"><a class="printit" onclick="window.print()" href="javascript:void()">Print</a></div>
                    <div class="clear"></div>
            </div>
        {foreach from=$chat.messages item=m}
             <div class="msg_wrapper msg_{$m.type}">
                    <span class="msg_who {$m.type}">{$m.submitter_name}:</span>
                    <span class="msg_date">{$m.date|dateformat:$date_format}</span>
                    <div class="clear"></div>
                    <span class="msg">{$m.message}</span>
                    <div class="clear"></div>
            </div>
            {/foreach}
    </body>
</html>