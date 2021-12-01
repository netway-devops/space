<section class="section-account-header d-flex flex-row justify-content-between align-items-start">
    <div>
        <h2>{$lang.rate_ticket} #{$ticket_details.ticket_number}</h2>
        <div class="mt-5 mb-3">
            <div class="mb-2">
                <span class="text-muted">{$lang.subject}:</span>
                <strong>{$ticket_details.subject|escape}</strong>
            </div>
            <div class="mb-2">
                <span class="text-muted">{$lang.department}:</span>
                <strong>{$ticket_details.deptname}</strong>
            </div>
        </div>
    </div>

    <a href="{$ca_url}tickets/" class="btn btn-sm btn-secondary">
        <i class="material-icons size-sm icon-btn-color">chevron_left</i>
        {$lang.back}
    </a>
</section>

<section class="section-ticket-rating">
    <div class="message-box message-box-file card">
        <div class="card-header">{$lang.cancel_describe}</div>
        <div class="card-body">
            <form action="" method="post">
                <div class="form-group mb-5">
                    {if $ratingscale == 3}
                        <div class="rating">
                            <span class="icon rating-icon cursor-pointer text-success" data-id="{$ticket_details.id}" {if $ticket_details.client_id==0}data-hash="{$ticket_details.acc_hash}"{/if} data-value="3">
                                <i class="material-icons size-lg">sentiment_very_satisfied</i>
                            </span>
                            <span class="icon rating-icon cursor-pointer text-warning" data-id="{$ticket_details.id}" {if $ticket_details.client_id==0}data-hash="{$ticket_details.acc_hash}"{/if} data-value="2">
                                <i class="material-icons size-lg">sentiment_satisfied</i>
                            </span>
                            <span class="icon rating-icon cursor-pointer text-secondary" data-id="{$ticket_details.id}" {if $ticket_details.client_id==0}data-hash="{$ticket_details.acc_hash}"{/if} data-value="1">
                                <i class="material-icons size-lg">sentiment_dissatisfied</i>
                            </span>
                        </div>
                    {else}
                        <div class="rating rating-box rating-box-big">
                            <input id="rating" type="number" max="10" data-id="{$ticket_details.id}"/>
                        </div>
                    {/if}
                </div>
                <div class="form-group">
                    <textarea class="form-control form-control-noborders textarea-autoresize" cols="60" rows="6" name="comment" id="ticketmessage" placeholder="{$lang.rate_ticket_desc}"></textarea>
                </div>
                <div class="d-flex flex-row align-items-center justify-content-start">
                    <input id="ticket_rate" type="hidden" name="rating" value="" required="required">
                    <input id="rating_scale" type="hidden" value="{$ratingscale}">
                    <button id="rate_ticket_btn" type="submit" name="submit" value="1" class="btn btn-success">{$lang.submit}</button>
                </div>
                {securitytoken}
            </form>
        </div>
    </div>
</section>
{literal}
    <script>
        $(function () {
            var rate = $('#ticket_rate'),
                emote = $('.rating .rating-icon');

            emote.off().on('click', function () {
                var self = $(this);
                rate.val(self.data('value'));
                {/literal}{if $ratingscale == 3}{literal}
                emote.each(function () {
                    $(this).css('opacity', '0.4');
                });
                self.css('opacity', '1');
                {/literal}{/if}{literal}
            });
            $('#rate_ticket_btn').on('click', function () {
                if (!rate.val()){
                    alert({/literal}"{$lang.rate_ticket_submit}"{literal});
                    return false;
                }
            });
        });
    </script>
{/literal}
<script type="text/javascript">
    var input =$(".rating-box input");
    input.max = {$ratingscale};
    input.rating(false);
</script>
{if $ratingscale != 3}
    <script>
        {literal}
            $(function () {
                var ticket_rate = $('#ticket_rate');
                $('.rating-input .icon').on('click', function () {
                    if (!ticket_rate.val()){
                        ticket_rate.val($(this).data('value'));
                        $(this).parent().find('input').val($(this).data('value')).end().off('mousemove mouseleave click');
                        return false;
                    }
                });
            });
        {/literal}
    </script>
{/if}
{if $rate}
    {literal}
        <script>
            $(function () {
                $('.rating-input').find("[data-value='{/literal}{$rate}{literal}']").mousemove().click();
                $('.rating').find("[data-value='{/literal}{$rate}{literal}']").click();
            })
        </script>
    {/literal}
{/if}