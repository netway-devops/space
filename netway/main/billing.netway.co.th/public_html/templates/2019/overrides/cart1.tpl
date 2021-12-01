{include file="`$template_path`components/cart/cart.head.tpl"}
<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
<h3 class="my-5">{$lang.productconfig1_desc}</h3>

<script type="text/javascript">
    {literal}
    function on_submit() {
        var data = {
            layer: 'ajax',
            product_id: $('#product_id').val(),
            product_cycle: $('#product_cycle').val()
        };
        if ($("input[value='illregister']").is(':checked')) {
            //own
            data.sld = $('#sld_register').val();
            data.tld = $('.tld_register:checked').serializeArray().map(function (a) {
                return a.value;
            });
            ajax_update('?cmd=checkdomain&action=checkdomain', data, '#updater', true);
        } else if ($("input[value='illtransfer']").is(':checked')) {
            //transfer
            data.sld = $('#sld_transfer').val();
            data.tld = $('#tld_transfer').val();
            ajax_update('?cmd=checkdomain&action=checkdomain&transfer=true', data, '#updater', true);
        } else if ($("input[value='illupdate']").is(':checked')) {
            if ($('#iwantupdate_cart').is(':checked')) {
                var item = $('.iwantupdate_cart_select option:selected');
                var sld = item.attr('data-sld');
                var tld = item.attr('data-tld');
                $('input[name="sld_update"]').val(sld);
                $('input[name="tld_update"]').val(tld);
            } else if ($('#iwantupdate_myaccount').is(':checked')) {
                var item = $('.iwantupdate_myaccount_select option:selected');
                var wipe = /^[-\.]+|[-\.]+$|^((?!xn).{2})--|[!@#$€%^&*()<>=+`~'"\[\\\/\],;| _]|^w{1,3}$|^w{1,3}\./g;
                var domain = item.attr('data-domain').trim().toLowerCase().replace(wipe, '$1');
                var dot = (domain + '.').indexOf('.');
                var parts = [domain.slice(0, dot), domain.slice(dot + 1)];
                var sld = parts[0];
                var tld = parts[1] ? '.' + parts[1].replace(wipe, '') : '';
                $('input[name="sld_update"]').val(sld);
                $('input[name="tld_update"]').val(tld);
            }
            return true;
        } else if ($("input[value='illsub']").is(':checked')) {
            return true;
        }
        return false;
    }
    function suggestnames(ssld,ttld,catid,target) {
        ajax_update('?cmd=checkdomain&action=suggest', {sld:ssld,tld:ttld,domain_cat:catid}, target);
        return false;
    }
    function toggleCard(item) {
        $('.owndomain_card_toggler').not(item).prop('checked', false);
        $('.items .item-body').hide();
        if ($(item).is(':checked')) {
            $(item).closest('.item').find('.item-body').show();
        }
    }
    {/literal}
</script>
<div class="default-cart">
    <form action="" method="post" onsubmit="return on_submit();" name="domainpicker">
        <input type="hidden" value="{$cart_contents[0].id}" id="product_id" name="product_id"/>
        <input type="hidden" value="{$cart_contents[0].recurring}" id="product_cycle" name="product_cycle"/>
        <input type="hidden" name="make" value="checkdomain"/>
        {if $allowregister}
            <div class="domain-action domain-action-register">
                <input class="" type="radio" name="domain" value="illregister" onclick="$('#options').find('div.slidme').hide();
                        $('#illregister').show();" checked="checked" id="illregister_input"/>
                <label class="form-check-label" for="illregister_input">{$business_name|string_format:$lang.iwantregister}</label>
            </div>
        {/if}
        {if $allowtransfer}
            <div class="domain-action domain-action-transfer">
                <input class="" type="radio" onclick="$('#options').find('div.slidme').hide();
                        $('#illtransfer').show();" value="illtransfer" name="domain" id="illtransfer_input"/>
                <label class="form-check-label" for="illtransfer_input">{$business_name|string_format:$lang.iwanttransfer}</label>
            </div>
        {/if}
        {if $allowown}
            <div class="domain-action domain-action-own">
                <input class="" type="radio" onclick="$('#options').find('div.slidme').hide();
                        $('#illupdate').show();" value="illupdate" name="domain" id="illupdate_input"/>
                <label class="form-check-label" for="illupdate_input">{$lang.iwantupdate}</label>
            </div>
        {/if}
        {if $subdomain}
            <div class="domain-action domain-action-sub">
                <input class="" type="radio" onclick="$('#options').find('div.slidme').hide();
                       $('#illsub').show();" value="illsub" name="domain" id="illsub_input"/>
                <label class="form-check-label" for="illsub_input">{$lang.iwantsub}</label>
            </div>
        {/if}
        <br/>
        <div id="options" class="form-horizontal">
            {if $allowregister}
                <div id="illregister" class="t1 slidme">
                    <div class="domain-box d-flex flex-column flex-sm-row my-3">
                        <textarea name="sld_register" id="sld_register" class="form-control domain-sld"></textarea>
                        <div class="domain-tld-bulk domain-tld bordered-section pt-1 pb-3 px-0 ml-0 ml-sm-3 my-3 my-sm-0">
                            <input type="text" class="form-control form-control-sm domain-tld-search" placeholder="{$lang.search}">
                            <div class="domain-tld-checkbox-all w-100 py-1 px-3 my-2">{$lang.checkunall}</div>
                            {foreach from=$tld_reg item=tldname name=ttld}
                                <div class="domain-tld-checkbox-item w-100 py-1 px-3 {if $smarty.foreach.ttld.first}checked{/if}" data-tld="{$tldname}">
                                    <i class="material-icons size-sm text-muted domain-tld-checkbox-icon">done</i>
                                    <input type="checkbox" name="tld[]" value="{$tldname}" {if $smarty.foreach.ttld.first}checked="checked"{/if} class="tld_register" style="display: none;"/>
                                    <span class="ml-2">{$tldname}</span>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
            {/if}
            {if $allowtransfer}
                <div id="illtransfer" style="display: none;" class="slidme form-row form-inline">
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text rounded-0">www.</div>
                            </div>
                            <input type="text" value="" size="40" name="sld_transfer" id="sld_transfer" class="form-control" placeholder="example"/>
                            <div class="input-group-append">
                                <select name="tld_transfer" id="tld_transfer" class="form-control rounded-0">
                                    {foreach from=$tld_tran item=tldname}
                                        <option>{$tldname}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
            {if $allowown}
                <div id="illupdate" style="display: none;" class="slidme">
                    <div class="d-flex flex-column items">
                        {if $allowownoutside}
                            <div class="mb-3 w-100 card item">
                                <div class="card-body d-flex flex-column">
                                    <div class="form-check cursor-pointer d-flex flex-row justify-content-start align-items-center">
                                        <input id="iwantupdate_outside" type="radio" class="owndomain_card_toggler" checked="checked" onclick="toggleCard($(this));" />
                                        <label for="iwantupdate_outside" class="form-check-label">{$lang.iwantupdate_outside|sprintf:$business_name}</label>
                                    </div>
                                    <div class="item-body form-group">
                                        <hr>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text rounded-0">www.</div>
                                            </div>
                                            <input type="text" value="" size="40" name="sld_update" id="sld_update" class="form-control" placeholder="example"/>
                                            <div class="input-group-append">
                                                <input type="text" value="" size="7" name="tld_update" id="tld_update" class="form-control domain-tld rounded-0 rounded-top-right rounded-bottom-right " placeholder="com"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {else}
                            <input type="hidden" name="sld_update" id="sld_update"/>
                            <input type="hidden" name="tld_update" id="tld_update"/>
                        {/if}
                        {foreach from=$shoppingcart item=order}
                            {foreach from=$order.domains item=domenka}
                                {if $domenka.action === 'register' || $domenka.action === 'transfer'}
                                    {assign var=showcartdomainselect value=true}
                                    {break}
                                {/if}
                            {/foreach}
                        {/foreach}
                        {if $showcartdomainselect}
                            <div class="mb-3 w-100 card item">
                                <div class="card-body">
                                    <div class="form-check cursor-pointer d-flex flex-row justify-content-start align-items-center">
                                        <input id="iwantupdate_cart" type="radio" class="owndomain_card_toggler" onclick="toggleCard($(this));" />
                                        <label for="iwantupdate_cart" class="form-check-label">{$lang.iwantupdate_cart}</label>
                                    </div>
                                    <div class="item-body" style="display: none">
                                        <select class="form-control mt-3 iwantupdate_cart_select">
                                            {foreach from=$shoppingcart item=order key=k}
                                                {foreach from=$order.domains item=domenka key=kk}
                                                    {if $domenka.action === 'register' || $domenka.action === 'transfer'}
                                                        {assign var=showdomenka value=true}

                                                        {foreach from=$shoppingcart item=order2}
                                                            {if $order2.product.domain === $domenka.name}
                                                                {assign var=showdomenka value=false}
                                                                {break}  {* domain is already used by other hosting *}
                                                            {/if}
                                                        {/foreach}

                                                        {if $showdomenka}
                                                            <option data-sld="{$domenka.sld}" data-tld="{$domenka.tld}">{$domenka.name}</option>
                                                        {/if}
                                                    {/if}
                                                {/foreach}
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                        {/if}
                        <div class="mb-3 w-100 card item">
                            <div class="card-body">
                                <div class="form-check cursor-pointer d-flex flex-row justify-content-start align-items-center">
                                    <input id="iwantupdate_myaccount" type="radio" class="owndomain_card_toggler" onclick="toggleCard($(this));" />
                                    <label for="iwantupdate_myaccount" class="form-check-label">{$lang.iwantupdate_myaccount}</label>
                                </div>
                                <div class="item-body" style="display: none">
                                    {if $logged=="1"}
                                        {clientservices}
                                        {if $client_domains}
                                            <select class="form-control mt-3 iwantupdate_myaccount_select">
                                                {foreach from=$client_domains item=domenka key=kk}
                                                    {if $domenka.status === 'Active' || $domenka.status === 'Pending Registration' || $domenka.status === 'Pending Transfer'}
                                                        <option data-domain="{$domenka.name}">{$domenka.name}</option>
                                                    {/if}
                                                {/foreach}
                                            </select>
                                        {else}
                                            <div class="mt-3 text-left">
                                                <span>{$lang.youdonthaveactivedomain}</span>
                                            </div>
                                        {/if}
                                    {else}
                                        <div class="mt-3 text-left">
                                            <span>{$lang.pleaseloginyouraccount}</span>.
                                            <a href="?cmd=login">{$lang.login}</a>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
            {if $subdomain}
                <div id="illsub" style="display: none;" class="slidme form-row form-inline">
                    <div class="form-group col-12">
                        <div class="input-group mr-3">
                            <div class="input-group-prepend">
                                <div class="input-group-text">www.</div>
                            </div>
                            <input type="text" value="" size="40" name="sld_subdomain" id="sld_subdomain" class="form-control"/>
                            <div class="input-group-append">
                                <div class="input-group-text">{$subdomain}</div>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
        <div class="clearfix"></div>
        <div class="d-flex flex-row justify-content-center my-5">
            <button class="btn btn-primary btn-lg w-25" type="submit">{$lang.continue}</button>
        </div>
    </form>

    <form method="post" action="">
        <div id="updater">
            {include file="ajax.checkdomain.tpl"}
        </div>
    </form>
</div>
{include file="`$template_path`components/cart/cart.foot.tpl"}