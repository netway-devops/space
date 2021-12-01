<div class="orderpage orderpage-cart_2019wizard">
    {include file='cart_2019wizard/header.tpl'}
    <div class="row">
        <div class="col-12 col-md-8">
            <form action="" method="post" id="cart3" >
                <input type="hidden" name="make" value="domainconfig" />
                {foreach from=$domain item=doms key=kk name=domainsloop}
                    {if $doms.action=='transfer' && $doms.product.epp!='1'}
                        <input name="epp[{$kk}]"  type="hidden" value="not-required"/>
                    {/if}
                {/foreach}
                <div class="table-responsive card shadow mb-4 p-4">
                    <h3 class="mb-4 text-primary pb-3 border-bottom">{$lang.mydomains} </h3>
                    <table class="table stackable layout-fixed px-0">
                        <tbody>
                            <tr>
                                <td class="text-muted">{$lang.domain}</td>
                                <td class="text-muted" width="200px">{$lang.period}</td>
                                <td class="text-muted" width="20%"></td>
                            </tr>
                        </tbody>
                        {foreach from=$domain item=doms key=kk name=domainsloop}
                            <tbody>
                            <tr class="domain-row-{$kk} domain-row {if $smarty.foreach.domainsloop.index%2==0}even{/if}">
                                <td data-label="" class="name">
                                    <strong class="break-word" title="{$doms.name}">{$doms.name}</strong>
                                    <input type="hidden" value="{$kk}" name="domkey[]" />
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
                                <td data-label=""  class="period">
                                    {price domain=$doms}
                                    <select name="period[{$kk}]" id="domain-period-{$kk}"
                                            class="form-control-sm"
                                            onchange="if (typeof (simulateCart) == 'function') simulateCart('#cart3')" >
                                        <option value="@@cycle" @@selected>@@line</option>
                                    </select>
                                    {/price}
                                </td>
                                <td data-label="" class="remove">
                                    <a href="#" class="btn btn-outline-danger btn-sm" onclick="return remove_domain('{$kk}')" title="{$lang.remove}">{$lang.remove}</a>
                                </td>
                            </tr>

                            {if $doms.custom}
                                {foreach from=$doms.custom item=cf}
                                    {if $cf.items}
                                        <tr  class="domain-row-{$kk}  domain-row  {if $smarty.foreach.domainsloop.index%2==0}even{/if}">
                                            <td data-label="" colspan="3" class="configtd" >
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
                            {/if}
                            </tbody>
                        {/foreach}
                    </table>
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
                                            <select class="form-control" onchange="bulk_periods(this)">
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
                                                    <a class="add_ns more_{$smarty.section.ns.index}" style="font-size: 11px;" href="#" onclick="add_ns(this); return false;">{$lang.add_more}</a>
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
                            {include file="common/contacts.tpl"}
                        </div>
                    </div>
                {/if}
            </form>
        </div>
        <div class="col-12 col-md-4">
            <div class="order-summary-box cart-summary p-4 shadow card" id="cartSummary">
                {include file='cart_2019wizard/cart.summary.tpl'}
            </div>
        </div>
    </div>
</div>