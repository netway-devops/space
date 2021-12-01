<section class="section-knowledgebase">
    <h1>{$lang.report_ticket_to_manager}</h1>
    <h5 class="my-5">{$lang.report_ticket_note}</h5>
    <div class="row">
        <div class="col-lg-12 col-md-12 col-xs-12 col-12">
            <form method="post" action="">
                <div class="clear my-2"></div>
                <div class="mb-2">
                    <h3>{$rticket.subject}</h3>
                    <textarea name="reason" placeholder="{$lang.report_ticket_reason}" style="min-width: 98%; min-height: 150px; margin: 10px 0;"></textarea>
                </div>
                <div class="clear"></div>
                <div class="right" style="text-align: right">
                    <a href="?cmd=tickets&action=view&num={$rticket.ticket_number}" class="btn btn-secondary" style="margin: 5px;">{$lang.back}</a>
                    <button type="submit" name="submit" value="1" class="btn btn-success" style="margin: 5px 1.5% 5px 5px" onclick="return confirm('{$lang.report_ticket_question}');">
                        {$lang.submit}
                    </button>
                </div>
                {securitytoken}
            </form>
        </div>
    </div>
</section>
