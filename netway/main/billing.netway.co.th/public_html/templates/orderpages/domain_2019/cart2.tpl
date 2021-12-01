{include file='domain_2019/progress.tpl'}

<form action="" method="post" id="cart3" >
    <input type="hidden" name="make" value="domainconfig" />
    {foreach from=$domain item=doms key=kk name=domainsloop}
        {if $doms.action=='transfer' && $doms.product.epp!='1'}
            <input name="epp[{$kk}]"  type="hidden" value="not-required"/>
        {/if}
    {/foreach}
    <div class="card shadow p-4">
        <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.mydomains}</h3>
        <div class="card-body p-0">
            {foreach from=$domain item=doms key=kk name=domainsloop}
                <div class="table-responsive border rounded mb-4 table-result-row"  data-hostname="{$doms.name}">
                    <table class="table stackable layout-fixed px-0">
                        <tbody>
                            <tr>
                                <td class="text-muted">{$lang.domain}</td>
                                <td class="text-muted" width="200px">{$lang.period}</td>
                            </tr>
                        </tbody>
                        <tbody>
                        <tr class="domain-row-{$kk} domain-row {if $smarty.foreach.domainsloop.index%2==0}even{/if}">
                            <td class="name">
                                <input type="hidden" value="{$kk}" name="domkey[]" />
                                <strong class="break-word" title="{$doms.name}">{$doms.name}</strong>
                                {if $doms.product.description}
                                    <div class="text-small">
                                        {$doms.product.description}
                                    </div>
                                {/if}
                                {if $doms.action=='transfer' && $doms.product.epp=='1'}
                                    <div class="my-3">
                                        <label for="epp{$kk}" class="sr-only">{$lang.eppcode}*</label>
                                        <div class="input-group input-group-sm">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text text-secondary text-small">{$lang.eppcode}*</div>
                                            </div>
                                            <input name="epp[{$kk}]" id="epp{$kk}" value="{$doms.epp}" type="text" class="form-control form-control-sm">
                                        </div>
                                    </div>
                                {/if}
                            </td>
                            <td class="period">
                                {price domain=$doms}
                                    <select name="period[{$kk}]" id="domain-period-{$kk}" class="form-control-sm result-period " data-hostname="{$doms.name}" >
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                {/price}
                            </td>
                        </tr>
                        {foreach from=$doms.custom item=cf key=ck}
                            {if $cf.items}
                                <tr class="domain-form" data-id="{$ck}" data-hostname="{$doms.name}">
                                    <td data-label="" colspan="2" class="configtd" >
                                        <label for="custom[{$cf.id}]" class="styled">
                                            {$cf.name} {if $cf.options & 1}*{/if}
                                        </label>
                                        {if $cf.description!=''}
                                            <div class="fs11 descr" style="">{$cf.description}</div>
                                        {/if}
                                        {include file=$cf.configtemplates.cart}
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            {/foreach}
        </div>
    </div>

    {clientwidget module="cart" section="domain_config" wrapper="widget.tpl"}

    {if !$renewalorder}
        <input type="hidden" name="usens" value="{if $usens=='1'}1{else}0{/if}" id="usens" />
        <div class="card shadow p-4" {if $usens && $product && !$periods}style="display:none"{/if}>
            <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.edit_config}</h3>
            <div class="card-body p-0">
                <table class="table stackable domain-config-table px-0">
                    <tr id="setnservers" {if $usens=='1'}style="display:none"{/if}>
                        <td width="180">{$lang.cart2_desc4} <span title="{$lang.cart2_desc3} " class="vtip_description"></span></td>
                        <td>
                            <a href="#" onclick="$(this).parents('tr').eq(0).hide();$('#usens').val(1);$('#nameservers').slideDown();return false">{$lang.iwantminens}</a>
                        </td>
                    </tr>
                    {if $periods}
                        <tr >
                            <td width="180">{$lang.cart2_desc5} <span title="{$lang.cart2_desc2}" class="vtip_description"></span></td>
                            <td>
                                <select class="form-control bulk_period">
                                    {foreach from=$periods item=period key=p}
                                        <option value="{$p}">{$p} {$lang.years}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}
                    {if !$product}
                        <tr>
                            <td>{$lang.nohosting} <span title="{$lang.cart2_desc1}" class="vtip_description"></span></td>
                            <td><a href="{$ca_url}cart&step=0&addhosting=1">{$lang.clickhere1}</a></td>
                        </tr>
                    {/if}
                </table>
            </div>
        </div>
        <div class="card shadow p-4" id="nameservers" {if !$usens}style="display:none"{/if}>
            <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.nameservers}</h3>
            <div class="card-body p-0">
                <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table stackable domain-config-table">
                    {section loop=11 step=1 start=1 name=ns }
                        {assign value="ns`$smarty.section.ns.index`" var=nsi}
                        {assign value="nsip`$smarty.section.ns.index`" var=nsipi}
                        {if $domain[0][$nsi] || $smarty.section.ns.index < 3}
                            <tr>
                                <td width="20%">{$lang.nameserver} {$smarty.section.ns.index}</td>
                                <td><input name="{$nsi}" data-id="{$smarty.section.ns.index}" value="{$domain[0][$nsi]}" class="form-control"/>
                                    {if ($smarty.section.ns.index) != 10}
                                        <script>$('.more_' + {$smarty.section.ns.index-1}).remove();</script>
                                        <a class="add_ns small more_{$smarty.section.ns.index}" href="#">{$lang.add_more}</a>
                                    {elseif $domain[0][$nsi]}
                                        <script>$('.more_' + {$smarty.section.ns.index-1}).remove();</script>
                                    {/if}
                                </td>
                            </tr>
                            {if $domain[0].nsips}
                                <tr>
                                    <td width="20%">{$lang.nameserver} IP {$smarty.section.ns.index}</td>
                                    <td><input name="{$nsipi}" value="{$domain[0][$nsipi]}" class="form-control"/></td>
                                </tr>
                            {/if}
                        {/if}
                    {/section}
                </table>
                <a class="text-small" href="#" onclick="$('#nameservers').slideUp();$('#setnservers').show();$('#usens').val(0);return false">{$lang.useourdefaultns}</a>
            </div>
        </div>
        <input type="hidden" name="contactsenebled" value="1"  />
        <div class="card shadow p-4" >
            <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.domcontacts}</h3>
            <div class="card-body p-0 contacts">
                {include file="domain_2019/contacts.tpl"}
            </div>
        </div>
        {if $subproducts && 'config:ShopingCartMode'|checkcondition && !$contents[0]}
            <div class="card shadow p-4 sub-products" >
                <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.additional_services}</h3>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table stackable">
                            {foreach from=$subproducts item=pr}
                                <tbody>
                                <tr>
                                    <td>
                                        <strong class="break-word" title="{$pr.name}">{$pr.name}</strong>
                                    </td>
                                    <td class="text-right">
                                        <a href="#" class="btn btn-primary addsubproduct" data-id="{$pr.id}">{$lang.offer_claim_item}</a>
                                    </td>
                                </tr>
                                </tbody>
                            {/foreach}
                        </table>
                    </div>
                </div>
            </div>
        {/if}
        <div class="row">
            <div class="col-12 col-md-6 offset-md-6 promo">
                {if $subtotal.coupon}
                    <div class="d-flex flex-row justify-content-end my-3 w-100">
                        <div>{$lang.promotionalcode}: <strong>{$subtotal.coupon}</strong></div>
                        <div class="mx-3">- {$subtotal.discount|price:$currency}</div>
                        <a href="#" class="coupon-remove text-danger ml-3">{$lang.removecoupon}</a>
                    </div>
                {else}
                    <div class="d-flex flex-row justify-content-end my-3">
                        <a href="#" onclick="$(this).hide(); $('#promo').show(); return false;">{$lang.usecoupon}</a>
                    </div>
                    <div id="promo" style="display:none;">
                        <div class="input-group">
                            <input type="text" class="form-control" name="promocode" placeholder="{$lang.code}" aria-label="{$lang.code}">
                            <div class="input-group-append">
                                <a href="#" class="coupon-add btn btn-success">{$lang.submit}</a>
                            </div>
                        </div>
                    </div>
                {/if}
            </div>
        </div>
    {/if}
</form>

{include file="domain_2019/summary.tpl"}