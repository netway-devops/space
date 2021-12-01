<div class="bordered-section article">
    <h2 >{$lang.report_reply_to_manager}</h2>
    <div class="brcrm">
        <span class="left">{$lang.report_reply_note}</span>
        <div class="clear"></div>
    </div>
    <form method="post" action="">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tbody>
            <tr>
                <td style="padding: 0 20px;">
                    <div class="com-con">
                        <div class="avatar left">
                            <span class="iconfont-user iconfont-size1 red"></span>
                        </div>
                        <div class="byline left" rel="tooltip" rel="tooltip" title="{$lang.staff}"><strong class="red">{$reply.name}</strong> {$reply.date|dateformat:$date_format}</div>
                        <div class="clear"></div>
                        <div class="comment" style="padding-bottom: 20px;"><div id="r{$reply.id}">{$reply.body|httptohref|nl2br}</div>
                            <div class="clear"></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="15" style="border-top: solid 1px #d6d6d6;"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="?cmd=tickets&action=view&num={$ticket_number}" class="btn btn-default" style="margin: 5px"><i class="icon-chevron-left"></i> {$lang.back}</a>
                    <button type="submit" name="submit" value="1" class="btn btn-success" style="margin: 5px 1.5% 5px 5px" onclick="return confirm('{$lang.report_reply_question}');">
                        <i class="icon-comment icon-white"></i> {$lang.submit}
                    </button>
                </td>
            </tr>
            </tbody>
        </table>
        {securitytoken}
    </form>
</div>