<div class="wbox">
    <div class="wbox_header">
        {$lang.contracts|capitalize}
    </div>
    <div class="wbox_content">
        {include file="`$smarty.const.APPDIR`types/widgets/widget_description.tpl"}
    </div>
    <div class="wbox_content">
        {if $contracts}
            <section class="table-responsive table-borders table-radius">
                <table class="table position-relative">
                    <tr>
                        <td>{$lang.contracts_order_number}:</td>
                        <td>{$contract_order.number}</td>
                    </tr>
                    <tr>
                        <td>{$lang.contracts_order_date}:</td>
                        <td >{$contract_order.date_created|dateformat:$date_format}</td>
                    </tr>
                    <tr>
                        <td>{$lang.contracts_accepted_date}:</td>
                        <td >
                            {if $contract_order.accepted_at}
                                <div class="text-success">{$contract_order.accepted_at|dateformat:$date_format}</div>
                            {else}
                                <div class="text-default">-</div>
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td>{$lang.contracts_accepted_by}:</td>
                        <td >
                            {if $contract_order.accepted_by}
                                <div class="text-success">{$contract_order.accepted_by}</div>
                            {else}
                                <div class="text-default">-</div>
                            {/if}
                        </td>
                    </tr>
                </table>
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
                        <div class="info-box-items">
                            <script>
                                var contract{$smarty.foreach.ctr.iteration} = {$contract.body|@nl2br|@json_encode};
                            </script>
                            <iframe class="info-box-contract" style="width: 100%" frameborder="0" scrolling="no" onload="resizeIframe(this, contract{$smarty.foreach.ctr.iteration})"></iframe>
                            <hr>
                            {if $contract.public_notes}
                                <div class="py-2 px-3">
                                    <h4>{$lang.public_notes}</h4>
                                    <p>{$contract.public_notes}</p>
                                </div>
                                <hr>
                            {/if}
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
                                    <a target="_blank" href="?cmd=contracts&action=pdf&oid={$contract.order_id}&onumber={$contract.order_number}&ctid={$contract.template_id}&pid={$contract.product_id}&ptype={$contract.contract_target}&hash={$contract.pdf_hash|urlencode}">
                                        <i class="material-icons">picture_as_pdf</i>
                                        {$lang.contract_as_pdf}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </section>
        {else}
            <section class="py-4 text-center text-muted">
                {$lang.nothing}
            </section>
        {/if}
    </div>
</div>