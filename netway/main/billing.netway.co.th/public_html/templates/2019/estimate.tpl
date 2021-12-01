{include file="header.tpl"}
{if $estimate}
    <div class="mb-4">
        <a href="{$ca_url}clientarea/" class="btn-link my-5">
            <small>{$lang.backtoclientarea}</small>
        </a>
    </div>
    <div class="content-view-details d-flex flex-column flex-md-row align-items-left align-items-md-center justify-content-between">
        <div class="mb-3 mb-md-0">
            <span class="badge badge-{$estimate.status} py-2 px-3">{$lang[$estimate.status]}</span>
        </div>
        <div class="d-flex flex-row flex-wrap">
            <a class="btn btn-sm btn-secondary mr-2 my-2 my-md-0" href="#" onclick="printEst();return false;">
                <i class="material-icons icon-btn-color mr-2 size-sm">print</i>
                {$lang.print_invoice}
            </a>
            <a class="btn btn-sm btn-secondary mr-2 my-2 my-md-0" target="_blank" href="{$ca_url}&amp;action=download&amp;estimate={$estimate.hash}">
                <i class="material-icons icon-btn-color mr-2 size-sm">picture_as_pdf</i>
                {$lang.download_pdf}
            </a>
            {if $order_id}
                <a class="btn btn-sm btn-secondary my-2 my-md-0 confirm_js" href="{$ca_url}&amp;action=accept&amp;estimate={$estimate.hash}" data-confirm="{$lang.accept_estimate_q}">
                    <i class="material-icons icon-btn-color mr-2 size-sm">done</i>
                    {$lang.accept_estimate}
                </a>
            {/if}
        </div>
    </div>
    <div class="info-box">
        <div class="info-box-items">
            <div class="info-box-estimate" id="info-box-estimate">
                {$estiamatebody}
            </div>
        </div>
    </div>
    {literal}
        <script>
            function printEst() {
                var divToPrint = document.getElementById('info-box-estimate');
                var newWin = window.open('', 'Print-Window');
                newWin.document.open();
                newWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
                newWin.document.close();
                setTimeout(function () {
                    newWin.close();
                }, 10);
            }
        </script>
    {/literal}
{/if}
{include file="footer.tpl"}