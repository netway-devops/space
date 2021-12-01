<div class="bordered-section article">
    <h2 >{$lang.report_ticket_to_manager}</h2>
    <div class="brcrm">
        <span class="left">{$lang.report_ticket_note}</span>
        <div class="clear"></div>
    </div>
    <form method="post" action="">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tbody>
            <tr>
                <td style="padding: 0 20px;">
                    <div class="com-con">
                        <h3>{$rticket.subject}</h3>
                        <textarea name="reason" placeholder="{$lang.report_ticket_reason}" style="min-width: 98%; min-height: 150px; margin: 10px 0;"></textarea>
                </td>
            </tr>
            <tr>
                <td height="15" style="border-top: solid 1px #d6d6d6;"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="?cmd=tickets&action=view&num={$rticket.ticket_number}" class="btn btn-default" style="margin: 5px"><i class="icon-chevron-left"></i> {$lang.back}</a>
                    <button type="submit" name="submit" value="1" class="btn btn-success" style="margin: 5px 1.5% 5px 5px" onclick="return confirm('{$lang.report_ticket_question}');">
                        <i class="icon-comment icon-white"></i> {$lang.submit}
                    </button>
                </td>
            </tr>
            </tbody>
        </table>
        {securitytoken}
    </form>
</div>