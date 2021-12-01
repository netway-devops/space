<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name} </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="text/javascript" src="{$template_dir}js/jquery.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery.tipsy.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/jquery.jgrowl_minimized.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/scripts.js?v={$hb_version}"></script>
        <link href="{$template_dir}media/popup.css?v={$hb_version}" rel="stylesheet" media="all" />
        <link href="{$template_dir}media/jquery.jgrowl.css?v={$hb_version}" rel="stylesheet" media="all" />
        <link href="{$template_dir}media/tipsy.css?v={$hb_version}" rel="stylesheet" media="all" />
      
    </head>
    <body class="hbpopup">
        <div id="errors" style="display:none">{foreach from=$error item=blad}<span>{$blad}</span>{/foreach}</div>
        <div id="chatshelf">
            <h1>{$business_name}</h1>
        </div>
        <div class="clear" ></div>
        <div id="chatcontainer">
            <div class="tab" id="tab_email">
                <div id="headershelf">
                    <div class="left">{$lang.please_leave_message}</div>
                    <div class="clear"></div>
                </div>
                <div id="pickdept_container" class="form">
                    {if !$messagesent}
                    <form action="" method="post" onsubmit="return verify_form(this)">
                        <input type="hidden" name="make" value="leavemessage" />
                       {$lang.leave_message_status}<br/><br/>
                        <table border="0" width="100%" class="padded_table">
                            <tr>
                                <td>
                                    <label for="department_id" >{$lang.department}</label>
                                    <select name="department_id" id="department_id" >
                                        {foreach from=$depts item=dept}
                                        <option value="{$dept.id}">{$dept.name}</option>
                                        {/foreach}
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="visitor_name" >{$lang.chat_full_name}</label>
                                    <input type="text"  name="visitor_name" id="visitor_name" value="{$visitor_name}" errortext="{$lang.chat_error_1}" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="visitor_email" >{$lang.email}</label>
                                    <input type="text"  name="visitor_email" id="visitor_email" value="{$visitor_email}" errortext="{$lang.chat_error_2}" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="subject" >{$lang.chat_questionbar}</label>
                                    <textarea   name="subject" id="subject" style="height:80px;" errortext="{$lang.chat_error_3}"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <input type="submit" value="{$lang.chat_sendmail}" />
                                </td>
                            </tr>
                        </table>
                    {securitytoken}
                    </form>
                    {else}
                       <br/><br/><strong>{$lang.messagethankyou}</strong>

                    {/if}
                </div>
            </div>

        </div>
        <div class="clear"></div>
        <div id="jGrowl"  class="jGrowl bottom-right"></div>

        {if $gb}<div class="hblogo">
            Powered by <a href="https://hostbillapp.com/" target="_blank">HostBill</a>
        </div>{/if}

    </body>
</html>