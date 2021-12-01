<section class="section-account-header d-flex flex-md-row flex-column justify-content-between align-items-start">
    <h1>{$lang.billing}</h1>
    <div class="d-flex flex-column flex-md-row align-items-left align-items-md-center">
        <div class="mr-0 mr-md-5 mt-4 mt-md-0">
            <div class="h2 mb-0 {if $dueinvoices > 0} text-danger {else} text-primary {/if}">
                {$acc_balance|price:$currency}
            </div>
            <small class=" mt-0 text-secondary ">{$lang.dueinvoices}</small>
        </div>
        <div class="mt-3 mt-md-0">
            <div class="h2 mb-0 text-success">
                {$acc_credit|price:$currency}
            </div>
            <small class=" mt-0 text-secondary">{$lang.availablecredit}</small>
        </div>
    </div>
</section>