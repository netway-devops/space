<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name} </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="text/javascript" src="{$template_dir}js/jquery.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/mustache.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/popup.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery.tipsy.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/sound.js"></script>
        <link href="{$template_dir}media/popup.css?v={$hb_version}" rel="stylesheet" media="all" />
        <link href="{$template_dir}media/jquery.jgrowl.css?v={$hb_version}" rel="stylesheet" media="all" />
        <link href="{$template_dir}media/tipsy.css?v={$hb_version}" rel="stylesheet" media="all" />

        {literal}
        <script type="text/javascript">
            $(document).ready(function() { {/literal}
                {if $chat.visitor_name!=''}
                HBVisitor.myname="{$chat.visitor_name}";
                {/if}
                HBVisitor.system_url="{$system_url}";
                HBVisitor.sound_swfpath="{$template_dir}media";
                HBVisitor.sound_newmsg =  "{$template_dir}media/newmsg.mp3";
                HBVisitor.init();
         {literal}   });
        </script>
        {/literal}
    </head>
    <body class="hbpopup">
        <div id="chatshelf">
            <div class="ico_container active left" onclick="HBVisitor.switch_tab('tab_chat',this);"><div id="chat" class="chat_icon showtipsy nw" title="{$lang.livechat}, {$chat.deptname}"></div></div>
            <div class="ico_container right" style="margin-right:-10px;"onclick="HBVisitor.close();"><div id="close" class="chat_icon showtipsy ne" title="{$lang.close}"></div></div>
            <div class="ico_container right" style="margin-right:20px;" onclick="HBVisitor.popupPrint();"><div id="print" class="chat_icon showtipsy ne" title="{$lang.chat_print}"></div></div>
            <div class="ico_container right" style="margin-right:20px;" onclick="HBVisitor.sendEmailTranscript(this);"><div id="email" class="chat_icon showtipsy ne" title="{$lang.email_transcript1}"></div></div>
        </div>
        <div class="clear" ></div>
        <div id="chatcontainer">
            <div class="tab" id="tab_chat">
                <div id="headershelf">
                    <div class="left">{$chat.deptname}</div>
                    <div class="right">
                        <span class="chat_sound_icon sound_on"  onclick="return HBVisitor.toggleChatSound()"></span>
                    </div>
                    <div class="clear"></div>
                </div>
                <div id="conversation_container">
                    <div class="messages">
                       
                    </div>
                </div>
            </div>
            {*
            <div class="tab" id="tab_email" style="display:none">
                <div id="headershelf">
                    <div class="left">{$lang.email_transcript}</div>
                    <div class="clear"></div>
                </div>
                <div id="email_container" class="form"></div>
            </div>
            *}
        </div>
        <div class="clear"></div>
        <div id="replycontainer">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <div id="inputbox"><textarea default="{$lang.chat_blank}" id="replybox">{$lang.chat_blank}</textarea></div>
                    </td>
                    <td width="60"><span class="sendbtn" id="sendbtn">{$lang.chat_send}</span></td>
                </tr>
            </table>
        </div>
        <div id="jGrowl"  class="jGrowl top-right"></div>
        {if $gb}<div class="hblogo">
            Powered by <a href="https://hostbillapp.com/" target="_blank">HostBill</a>
        </div>{/if}
        {literal}
        <div id="sound_newmsg"></div>
        <div id="hb_chat_template" style="display:none">
            <textarea id="message_template">
                <div class="msg_wrapper msg_{{type}}">
                    <span class="msg_who {{type}}">{{submitter_name}}:</span>
                    <span class="msg">{{{message}}}</span>
            </div>
            </textarea></div>
        {/literal}
    </body>
</html>