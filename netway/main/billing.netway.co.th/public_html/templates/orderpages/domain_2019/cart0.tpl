<section class="order-step" id="domains" data-limit="{$opconfig.rows_limit}">
    <div class="card shadow-lg rounded-lg bg-gradient-primary border-0">
        <div class="p-2 p-md-4">
            <div class="domain-search">
                <div class="my-4">
                    <h1 class="text-white mode mode-register">{$lang.findrightdomainname}</h1>
                    <h1 class="text-white mode mode-transfer">{$lang.transferyourdomain}</h1>
                </div>
                <div class="domain-input">
                    <section class="p-2 d-flex flex-column flex-md-row justify-content-between align-items-center bg-white mb-5 rounded-lg shadow border-0">
                            <textarea data-mode-register="{$lang.enteryourdesireddomainname}"
                                      data-mode-transfer="{$lang.enterdomaintotransfer}"
                                      class="form-control border-0 domain-textarea resize-none mb-3 mb-md-0"
                                      placeholder="{$lang.enteryourdesireddomainname}">{$searchtext}</textarea>
                        <button type="submit" class="d-block btn btn-success h-100 ml-2 domain-search-btn"><span class="p-3 text-small">{$lang.search}</span></button>
                    </section>
                </div>
                <div class="domain-modes {if $opconfig.disable_transfer && $opconfig.disable_bulk_transfer}domain-modes-1{elseif $opconfig.disable_transfer || $opconfig.disable_bulk_transfer}domain-modes-2{else}domain-modes-3{/if}">
                    <input type="radio" id="bulksearch" name="tab-control" checked>
                    <input type="radio" id="transdomain" name="tab-control">

                    {if $opconfig.disable_transfer && $opconfig.disable_bulk_transfer}
                    {else}
                        <div class="domain-modes-controls d-flex flex-column flex-md-row justify-content-center align-items-center">
                            <label for="bulksearch" role="button">
                                    <span href="#register" class="mode-register">
                                        <i class="material-icons size-md mr-2">search</i>
                                        {$lang.bulksearch}
                                    </span>
                            </label>

                            {if $opconfig.disable_transfer}
                            {else}
                                <label for="transdomain" role="button">
                                    <span href="#transfer" class="mode-transfer">
                                        <i class="material-icons size-md mr-2">swap_vert</i>
                                        {$lang.transdomain}
                                    </span>
                                </label>
                            {/if}

                            {if $opconfig.disable_bulk_transfer}
                            {else}
                                <label role="button">
                                    <span class="mode-bulk-transfer mode-notclick" onclick="$('#bulkdomaintransfer').modal('show');">
                                        <i class="material-icons size-md mr-2">fast_forward</i>
                                        {$lang.bulkdomaintransfer}
                                    </span>
                                </label>
                            {/if}
                        </div>
                        <div class="slider d-none d-md-block">
                            <div class="indicator"></div>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>

    {if $opconfig.disable_bulk_transfer}
    {else}
        {*bulk domain transfer modal*}
        <div id="bulkdomaintransfer" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="bulkdomaintransferLabel" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="bulkdomaintransferLabel">{$lang.bulkdomaintransfer}</h3>
            </div>

            <form action="?cmd=cart&action=bulk_domain_transfer" method="POST">
                <div class="modal-body">
                    <p>{$lang.bulkdomaintransferdesc}</p>
                    <textarea name="domains" rows="10" class="form-control" style="display: block;width: 100%;box-sizing: border-box;" placeholder="ex: example.com:AuthCode" required="required"></textarea>
                    {securitytoken}
                    <button type="submit" class="btn btn-primary mt-3 w-100">{$lang.submit}</button>
                </div>
            </form>
        </div>
    {/if}
    <section class="domain-search-results py-4"></section>

    <section class="result-more py-4" style="display:none;">
        <div class="d-flex flex-row aling-items-center justify-content-center">
            <a href="#" class="result-more-btn btn btn-primary px-4">
                <i class="material-icons size-md mr-3">autorenew</i>
                {$lang.loadmore}
            </a>
        </div>
    </section>

    {if $category.opconfig.spotlight}
        {include file="domain_2019/widgets/spotlight.tpl"}
    {/if}

    {if $category.opconfig.custdescription}
        {include file="domain_2019/widgets/description.tpl"}
    {/if}

    {if $category.opconfig.pricing}
        {include file="domain_2019/widgets/pricing.tpl"}
    {/if}
</section>

{include file="domain_2019/summary.tpl"}
{literal}
<script type="text/javascript">
$(document).ready(function() {  
   $("textarea.domain-textarea").change(function() {
        var searchDomain  = $("textarea.domain-textarea").val();
        if({/literal}{$category.id} == 121 {literal}){  //search international-domain page
            var engDomain    = searchDomain.match(/[a-zA-Z]/i);
            if(typeof engDomain  != null){                 
                window.location = '{/literal}{$system_url}{literal}checkdomain/domain-names?domain='+engDomain.input;
            }
        }
        else if({/literal}{$category.id} == 1 {literal}){  //search international-domain page
            var thaiDomain    = searchDomain.match(/[ก-ฮ]/i);
            if(typeof thaiDomain != null){                 
                window.location = '{/literal}{$system_url}{literal}checkdomain/--internationalized-domain-names?domain='+thaiDomain.input;
            }
        }
        
    });
});

</script>
{/literal}