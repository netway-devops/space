<div class="header-title">
    {if $agreement}
        <h2>{$lang.Agreement|capitalize}</h2>
    {else}
        <h2>{$lang.contracts|capitalize}</h2>
        <span>{$lang.contracts_desc}</span>
    {/if}
</div>
<div class="row flex-container bordered-section">
    <div class="span3 left-content flex-box-1">
        {if !$agreement}
            <div class="sidebar-block">
                <p><i class="icon-tag"></i> {$lang.contracts_order_number} <b>{$order.order_number}</b></p>
                <p><i class="icon-time"></i> {$lang.contracts_order_date} <b>{$order.order_date}</b></p>
                <p>
                    <i class="icon-time"></i>
                    {$lang.contracts_accepted_date}
                    {if $order.contract_accepted_date}
                        <b>{$order.contract_accepted_date}</b>
                    {else}<b>-</b>{/if}
                </p>
                <p>
                    <i class="iconfont-user"></i>
                    {$lang.contracts_accepted_by}
                    {if $order.contract_accepted_by && $order.accepted_by}
                        <b>{$order.accepted_by}</b>
                    {else}<b>-</b>{/if}
                </p>
            </div>
        {/if}
        <div class="sidebar-block">
            {if $mustaccept}
                <div class="text-center">
                    <input type="checkbox" id="acceptcontracts">
                    <label for="acceptcontracts">{$lang.contracts_info}</label>
                </div>
                <form method="post" action="">
                    <input type="hidden" name="make" value="accept">
                    <button type="submit" class="btn btn-success acceptcontracts_btn" disabled="disabled" style="width: 100%">
                        <i class="icon-ok icon-white"></i>
                        {$lang.contracts_accept}
                    </button>
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
        </div>
    </div>
    <div class="span9 right-content flex-box-1">
        <div class="p19">
            {foreach from=$contracts item=contract name=ctr}
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
                <script>
                    var contract{$smarty.foreach.ctr.iteration} = {$contract.body|@json_encode};
                </script>
                <div class="com-con">
                    <div class="cticket">
                        <a class="right btn btn-mini quoter" target="_blank" href="?cmd=contracts&action=pdf&oid={$contract.order_id}&onumber={$contract.order_number}&cid={$contract.id}&ctid={$contract.template_id}&pid={$contract.product_id}&ptype={$contract.contract_target}&hash={$contract.pdf_hash|urlencode}">
                            <i class="icon-file"></i>
                        </a>
                        <div class="clear"></div>
                        <div class="comment">
                            <iframe class="info-box-contract" style="width: 100%" frameborder="0" scrolling="no" onload="resizeIframe(this, contract{$smarty.foreach.ctr.iteration})"></iframe>
                            {if $contract.attachments}
                                <br/>
                                <strong>{$lang.contract_attachments}</strong>
                                <br/>
                                {foreach from=$contract.attachments item=file}
                                    <a href="{$ca_url}root&action=download&type=downloads&id={$file.id}" class="attach3">{$file.name|truncate:100:"..."} {if $file.size>0}({$file.size} KB){/if}</a>
                                    <br/>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>
{literal}
    <script>
        function resizeIframe(obj, body) {
            obj.contentWindow.document.write(body);
            obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
            obj.contentWindow.document.close();
        }
    </script>
{/literal}