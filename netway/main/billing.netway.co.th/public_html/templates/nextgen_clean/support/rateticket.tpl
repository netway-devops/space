<link type="text/css" rel="stylesheet" href="{$template_dir}css/jRating.jquery.css" />
<div class="bordered-section article">
    <h2 >{$lang.rate_ticket} #{$ticket_details.ticket_number}</h2>
    <div class="brcrm">
        <span class="left">{$lang.subject}: <strong>{$ticket_details.subject}</strong></span>
        <a class="btn btn-mini right" href="{$ca_url}tickets/"><i class="icon-chevron-left"></i> {$lang.back}</a><br>
        <span class="left">{$lang.department}: <strong>{$ticket_details.deptname}</strong></span>

        <div class="clear"></div>
    </div>
    <form method="post" action="">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tbody>
                <tr>
                    <td height="40">
                        {if $ratingscale == 3}
                            <div style="margin: 10px 1.5%; height: 20px;" class="rating">
                                <div class="grow"><span class="icon icon-smile rating-icon rating-icon-smile" data-id="{$ticket_details.id}" {if $ticket_details.client_id==0}data-hash="{$ticket_details.acc_hash}"{/if} data-value="3"></span></div>
                                <div class="grow"><span class="icon icon-meh rating-icon rating-icon-meh" data-id="{$ticket_details.id}" {if $ticket_details.client_id==0}data-hash="{$ticket_details.acc_hash}"{/if} data-value="2"></span></div>
                                <div class="grow"><span class="icon icon-frown rating-icon rating-icon-frown" data-id="{$ticket_details.id}" {if $ticket_details.client_id==0}data-hash="{$ticket_details.acc_hash}"{/if} data-value="1"></span></div>
                            </div>
                        {else}
                            <div style="margin: 10px 1.5%; height: 20px;" class="rating-box" id="{$ticket_details.id}"></div>
                        {/if}
                        <input id="ticket_rate" type="hidden" name="rating" value="{$rate}" required="required">
                        <input id="rating_scale" type="hidden" value="{$ratingscale}">
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <textarea style="width: 96%; overflow: hidden; height: 108px;" cols="60" rows="6" name="comment" id="ticketmessage" placeholder="{$lang.rate_ticket_desc}"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <button id="rate_ticket_btn" type="submit" name="submit" value="1" class="btn btn-success  btn-large" style="margin: 5px 1.5%;"><i class="icon-comment icon-white"></i> {$lang.submit}</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
</div>
{literal}<script>
    $(function () {
        var rate = $('#ticket_rate'),
            emote = $('.rating .rating-icon');

        emote.off().on('click', function () {
            var self = $(this);
            rate.val(self.data('value'));
            emote.each(function () {
                $(this).css('opacity', '0.4');
            })
            self.css('opacity', '1');
        });
        $('#rate_ticket_btn').on('click', function () {
            if (!rate.val()){
                alert({/literal}"{$lang.rate_ticket_submit}"{literal});
                return false;
            }
        });
    });
</script>{/literal}
{if $ratingscale != 3}
    <script>{literal}
        $(function () {
            var scale = $('#rating_scale').val(),
                color = $('.jRatingColor'),
                one_star = ($('.jStar').width()/scale);

            color.css('width', '0px');
            $('.rating-box').on('click', function () {
                var rate = color.width()/one_star;
                $('#ticket_rate').val(Math.round(rate));
            });
            {/literal}
                {if $rate}
                    color.css('width', one_star*{$rate}+'px');
                {/if}
            {literal}
        });
        {/literal}</script>
{/if}
<script type="text/javascript" src="{$template_dir}js/jRating.jquery.js"></script>
<script type="text/javascript">$(".rating-box").jRating({literal}{{/literal}rateMax:{$ratingscale}, length:{$ratingscale}, phpPath:"?cmd=tickets&action=rate_ticket"{literal}}{/literal});</script>
{if $rate}
{literal}
    <script>
        $(function () {
            $('.rating').find("[data-value='{/literal}{$rate}{literal}']").click();
        })
    </script>
{/literal}
{/if}