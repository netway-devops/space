<section class="section-knowledgebase">
    <h1>{$lang.report_reply_to_manager}</h1>
    <h5 class="my-5">{$lang.report_reply_note}</h5>
    <div class="row">
        <div class="col-lg-12 col-md-12 col-xs-12 col-12 mt-4">
            <form method="post" action="">
                <div class="byline left" rel="tooltip" rel="tooltip" title="{$lang.staff}"><img class="align-self-start image size-ss mg-left mg-right" src="{$template_dir}dist/images/user.svg" alt="{$lang.Ticket} #{$ticket.ticket_number}"><strong class="red">{$reply.name}</strong> {$reply.date|dateformat:$date_format}</div>
                <div class="clear my-2"></div>
                <div class="mb-2" style="padding: 20px; border: .07rem solid #ebecf0; border-radius: .43rem;">
                    <div id="r{$reply.id}">{$reply.body|httptohref|nl2br}</div>
                </div>
                <div class="clear"></div>
                <div class="right" style="text-align: right">
                    <a href="?cmd=tickets&action=view&num={$ticket_number}" class="btn btn-secondary" style="margin: 5px;">{$lang.back}</a>
                    <button type="submit" name="submit" value="1" class="btn btn-success" style="margin: 5px 1.5% 5px 5px" onclick="return confirm('{$lang.report_reply_question}');">
                        {$lang.submit}
                    </button>
                </div>
                {securitytoken}
            </form>
        </div>
    </div>
</section>
