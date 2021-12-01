{include file="`$template_path`components/cart/cart.head.tpl"}
<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
{literal}
    <script type="text/javascript">
        function remove_domain(domain) {
            var row = $('.domain-row-' + domain);
            if (confirm("{/literal}{$lang.itemremoveconfirm}{literal}")) {
                var len = $('.domain-row input[name="domkey[]"]').length;
                if (len >= 1)
                    row.remove();
                $('#cartSummary').addLoader();
                $.post('?cmd=cart&step=2&do=removeitem&target=domain', {target_id: domain}, function (data) {
                    $('#cartSummary').html(parse_response(data));
                    if (len <= 1)
                        window.location = '?cmd=cart';
                });
            }
            return false;
        }
        function bulk_periods(s) {
            $('.dom-period').each(function () {
                $(this).val($(s).val());
            });
            $('.dom-period').eq(0).change();

        }
        function change_period(domain) {
            var newperiod = 1;
            newperiod = $('#domain-period-' + domain).val();
            $('#cartSummary').addLoader();
            ajax_update('?cmd=cart&step=2&do=changedomainperiod', {key: domain, period: newperiod}, '#cartSummary');
            return false;
        }
        function insert_singupform(el) {
            $.get('?cmd=signup&contact&private', function (resp) {
                resp = parse_response(resp);
                var pref = $(el).attr('name');
                //$(el).removeAttr('name').attr('rel', pref);
                $(resp).find('input, select, textarea').each(function () {
                    $(this).attr('name', pref + '[' + $(this).attr('name') + ']');
                }).end().appendTo($(el).siblings('.sing-up'));
            });
        }
        function add_ns(elem) {
            var limit = 10,
                tr = $(elem).parents('tr').first(),
                button = $('.add_ns'),
                id = tr.children().last().children().first().data('id'),
                clone = tr.clone(),
                new_id = id + 1,
                ip = $('input[name="nsip' + id + '"]').parents('tr').first(),
                new_ip = $('input[name="nsip' + new_id + '"]').parents('tr').first();

            if (id < limit) {
                clone = prepare_ns(clone, id);
                if (new_id === limit)
                    clone.children().last().children().last().remove();
                tr.after(clone);
                button.remove();
                if (ip.length > 0 && new_ip.length <= 0) {
                    var cloneip = ip.clone();
                    cloneip = prepare_ns(cloneip, id);
                    ip.after(cloneip);
                }
            }
        }
        function prepare_ns(clone, id) {
            var input = clone.children().last().children().first(),
                text = clone.children().first().html(),
                new_id = id + 1,
                name = input.prop('name');
            input.data('id', new_id);
            input.prop('name', name.replace(id, new_id));
            input.prop('value', '');
            text = text.replace(id, new_id);
            clone.children().first().html(text);

            return clone;
        }
        function addsubproduct(product_id) {
            var html = '<input type="hidden" name="addsubproduct" value="'+product_id+'"/>';
            $('form#cart3').append(html).submit();
        }
    </script>
    <style>
        .lh28{
            line-height: 30px
        }
    </style>
{/literal}
<div class="default-cart">
    <form action="" method="post" id="cart3">
        <input type="hidden" name="make" value="domainconfig" />
        {foreach from=$domain item=doms key=kk name=domainsloop}
            {if $doms.action=='transfer' && $doms.product.epp!='1'}
                <input name="epp[{$kk}]"  type="hidden" value="not-required"/>
            {/if}
        {/foreach}
        <div class="table-responsive table-borders table-radius mb-4">
            <table class="table stackable layout-fixed">
                <thead>
                    <tr>
                        <th>{$lang.domain}</th>
                        <th width="200px">{$lang.period}</th>
                        <th width="20%"></th>
                    </tr>
                </thead>
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
                                <div class="mt-3">
                                    <label for="epp{$kk}" class="sr-only">{$lang.eppcode}*</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text text-secondary text-small">{$lang.eppcode}</div>
                                        </div>
                                        <input name="epp[{$kk}]" id="epp{$kk}" value="{$doms.epp_code}" type="text" class="form-control">
                                    </div>
                                </div>
                            {/if}
                        </td>
                        <td data-label=""  class="period">
                            {price domain=$doms}
                            <select name="period[{$kk}]" id="domain-period-{$kk}"
                                    class="form-control dom-period"
                                    onchange="if (typeof (simulateCart) == 'function') simulateCart('#cart3')" >
                                <option value="@@cycle" @@selected>@@line</option>
                            </select>
                            {/price}
                        </td>
                        <td data-label="" class="remove">
                            <a href="#" class="btn btn-danger" onclick="return remove_domain('{$kk}')" title="{$lang.remove}">{$lang.remove}</a>
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
            <div class="card" {if $usens && $product && !$periods}style="display:none"{/if}>
                <div class="card-header">
                    <strong>{$lang.edit_config}</strong>
                </div>
                <div class="card-body">
                    <table cellspacing="0" cellpadding="0" border="0" class="table stackable domain-config-table">
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
                    </table>
                </div>
            </div>
            <div class="card" id="nameservers" {if !$usens}style="display:none"{/if}>
                <div class="card-header">
                    <span>{$lang.nameservers}</span>
                </div>
                <div class="card-body">
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
            <div class="card" >
                <div class="card-header">
                    <strong>{$lang.domcontacts}</strong>
                </div>
                <div class="card-body contacts">
                    {include file="common/contacts.tpl"}
                </div>
            </div>

            {if $subproducts && 'config:ShopingCartMode'|checkcondition && !$contents[0]}
                <div class="card" >
                    <div class="card-header">
                        <strong>{$lang.additional_services}</strong>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table stackable">
                                {foreach from=$subproducts item=pr}
                                    <tbody>
                                        <tr>
                                            <td>
                                                <strong class="break-word" title="{$pr.name}">{$pr.name}</strong>
                                            </td>
                                            <td class="text-right">
                                                <a href="#" onclick="addsubproduct('{$pr.id}');return false;" class="btn btn-primary">{$lang.offer_claim_item}</a>
                                            </td>
                                        </tr>
                                    </tbody>
                                {/foreach}
                            </table>
                        </div>
                    </div>
                </div>
            {/if}
        {/if}
        <div class="d-flex flex-row justify-content-center my-5">
            <button class="btn btn-primary btn-lg btn-long" type="submit">{$lang.continue}</button>
        </div>
    </form>
</div>
{include file="`$template_path`components/cart/cart.foot.tpl"}