<section class="section-contracts d-flex flex-md-row flex-column justify-content-between align-items-start">
    <div class="">
        {if $agreement}
            <h1>{$lang.Agreement|capitalize}</h1>
        {else}
            <h1>{$lang.contracts|capitalize}</h1>
            <h5 class="mt-5 mb-3">{$lang.contracts_desc}</h5>
        {/if}
    </div>
    {if !$agreement}
        <div class="d-flex flex-column flex-md-row align-items-left align-items-md-center">
            <div class="mr-0 mr-md-5 mt-4 mt-md-0">
                <div class="h2 mb-0 text-primary">
                    {$order.number}
                </div>
                <small class=" mt-0 text-secondary ">{$lang.contracts_order_number}</small>
            </div>
            <div class="mr-0 mr-md-5 mt-3 mt-md-0">
                <div class="h2 mb-0 text-default">
                    {$order.date|dateformat:$date_format}
                </div>
                <small class=" mt-0 text-secondary">{$lang.contracts_order_date}</small>
            </div>
            <div class="mr-0 mr-md-5 mt-3 mt-md-0">
                {if $order.contract_accepted_date}
                    <div class="h2 mb-0 text-success">{$order.contract_accepted_date|dateformat:$date_format}</div>
                {else}
                    <div class="h2 mb-0 text-default text-center">-</div>
                {/if}
                <small class=" mt-0 text-secondary">{$lang.contracts_accepted_date}</small>
            </div>
            <div class="mr-0 mr-md-5 mt-3 mt-md-0">
                {if $order.contract_accepted_by && $order.accepted_by}
                    <div class="h2 mb-0 text-success">{$order.accepted_by}</div>
                {else}
                    <div class="h2 mb-0 text-default text-center">-</div>
                {/if}
                <small class=" mt-0 text-secondary">{$lang.contracts_accepted_by}</small>
            </div>
        </div>
    {/if}
</section>

{literal}
    <script>
        function resizeIframe(obj, body) {
            obj.contentWindow.document.write(body);
            obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
            obj.contentWindow.document.close();
        }
    </script>
{/literal}

<section class="section-contracts-frames">
    {foreach from=$contracts item=contract name=ctr}
        <div class="info-box">
            {if $agreement}
                <form action="?cmd=contracts&action=sign_agreement&customer=change&agreement={$agreement}" method="post">
                    <div class="customer" {if $clientdata.id}style="display: none;"{/if}>
                        {include file="ajax.signup.tpl" submit=$customer fields=$singupfields}
                        <button type="submit" class="btn btn-primary">{$lang.submit}</button>
                    </div>
                    <div {if !$clientdata.id}style="display: none;"{/if}>
                        <button type="button" class="btn btn-primary" onclick="$('.customer').slideDown(); $(this).hide();">{$lang.change_customer}</button>
                    </div>
                    {securitytoken}
                </form>
            {/if}
            <div class="info-box-items">
                <script>
                    var contract{$smarty.foreach.ctr.iteration} = {$contract.body|@json_encode};
                </script>
                <iframe class="info-box-contract" style="width: 100%" frameborder="0" scrolling="no" onload="resizeIframe(this, contract{$smarty.foreach.ctr.iteration})"></iframe>
                <hr>
                <div class="d-flex flex-column flex-md-row justify-content-start justify-content-md-between align-items-center py-2 px-3">
                    {if $contract.attachments}
                        <div class="py-2">
                            <div class="d-flex flex-row justify-content-between align-items-center">
                                <h4>{$lang.contract_attachments}</h4>
                            </div>
                            {foreach from=$contract.attachments item=file}
                                <a href="{$ca_url}root&action=download&type=downloads&id={$file.id}" target="_blank" class="mr-4">
                                    <span class="text-small">{$file.name|truncate:100:"..."} {if $file.size>0}({$file.size} KB){/if}</span>
                                </a>
                            {/foreach}
                        </div>
                    {/if}
                    <div class="py-2">
                        {if !$agreement}
                            <a target="_blank" href="?cmd=contracts&action=pdf&oid={$contract.order_id}&onumber={$contract.order_number}&cid={$contract.id}&ctid={$contract.template_id}&pid={$contract.product_id}&ptype={$contract.contract_target}&hash={$contract.pdf_hash|urlencode}">
                                <i class="material-icons">picture_as_pdf</i>
                                {$lang.contract_as_pdf}
                            </a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    {/foreach}
</section>

{if $mustaccept}
    <div class="mt-5 text-center">
        <input type="checkbox" id="acceptcontracts">
        <label for="acceptcontracts">{$lang.contracts_info}</label>
    </div>
    <form method="post" action="">
        <div class="d-flex justify-content-center">
            <input type="hidden" name="make" value="accept">
            <button type="submit" class="btn btn-primary btn-lg my-4 w-25 acceptcontracts_btn" disabled="disabled" >{$lang.contracts_accept}</button>
        </div>
        {securitytoken}
    </form>
    {literal}
        <script>
            $(function () {
                $('#acceptcontracts').on('change', function () {
                    $('.acceptcontracts_btn').attr('disabled', !$(this).is(':checked'));
                });
            });
        </script>
    {/literal}
{/if}