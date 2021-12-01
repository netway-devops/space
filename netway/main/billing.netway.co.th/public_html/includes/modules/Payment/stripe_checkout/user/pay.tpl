<script src="https://js.stripe.com/v3/"></script>

<div id="payform_card-element" style="display: none"></div>
<form action="?cmd=stripe_checkout&action=pay&invoice_id={$stripe.invoice}"
      method="POST" id="payform">
    <input type='hidden' name='stripeToken'>
</form>
<button class='btn btn-primary' id='payform_card-btn'>{$stripe.paynow}</button>
<div class="modal fade" style="display: none; ext-align: left" id="stripe-modal">
    <div class="modal-body">
        <button class='btn btn-primary' id='payform_card-modal-btn'>{$stripe.paynow}</button>
    </div>
</div>
{literal}
<style>
    #payform_card-element {
        margin-bottom: 30px;
        box-sizing: border-box;
        height: 40px;
        max-width: 600px;
        padding: 10px 12px;
        border: 1px solid transparent;
        border-radius: 4px;
        background-color: white;
        box-shadow: 0 1px 3px 0 #babec3;
    }
</style>

<script >
    (function(){
        var extraDetails = {/literal}{$stripe|@json_encode}{literal},
            modal = false,
            stripe, card;

        function init(){
            if(typeof Stripe === 'undefined'){
                setTimeout(init, 50);
                return;
            }

            var box = $('#payform_card-element');
            if(box.width() < 320 && box.closest('.modal').length === 0){
                modal = true;
                box.detach().prependTo('#stripe-modal .modal-body')
            }

            stripe = Stripe(extraDetails.pubkey);
            var elements = stripe.elements();

            card = elements.create('card', {
                iconStyle: 'solid',
                style: {
                    base: {
                        iconColor: '#8898AA',
                        fontSize: '15px'
                    },
                    invalid: {
                        iconColor: '#e85746',
                        color: '#e85746',
                    }
                }
            });

            card.mount('#payform_card-element');
            box.show();

        }

        function pay(btn){
            var form = $('#payform');
            var input = form.find('input[name="stripeToken"]');

            btn.prop('disabled', true);
            stripe.createToken(card, extraDetails).then(function(result) {
                btn.prop('disabled', false);
                input.val(result.token.id);
                form.submit();
            });
        }

        $('#payform_card-btn').on('click', function (e) {
            e.preventDefault();
            if (modal) {
                $('#stripe-modal').modal();
            } else {
                pay($(this));
            }
        });

        $('#payform_card-modal-btn').on('click', function (e) {
            pay($(this));
        })

        if(typeof $.fn.modal !== 'function'){
            $.getScript({/literal}'templates/{$template}/js/bootstrap.min.js'{literal}, function(){
                init();
            });
        } else{
            init();
        }

    })()
</script>
{/literal}