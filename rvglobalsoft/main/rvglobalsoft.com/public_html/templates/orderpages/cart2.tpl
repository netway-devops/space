{php}
$templatePath   = $this->get_template_vars('template_path');
include(dirname($templatePath) . '/orderpages/cart2.tpl.php');
{/php}


<!-- Modal -->
<div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <h3 id="myModalLabel">Already Customer</h3>
  </div>
  <div class="modal-body">
    <form action="index.php/cart/&step=2" method="post">
        {include file="ajax.login.tpl"}
    </form>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>

<link href="{$orderpage_dir}default/cart.css" rel="stylesheet" type="text/css"/>
    {literal}
        <script type="text/javascript">
        
        $(document).ready(function(){
            var cid = $('#contactsRegistrant').val();
            if (parseInt(cid)) {
                insert_singupform($('#contactsRegistrant').get(0));
            }
            
            $('#cart3').submit(function () {
                if (validateDomainContact()) {
                    return true;
                }
                return false;
            });
            
        });
        
        function validateDomainContact ()
        {
            var valid = true;
            $('.sing-up').find('input[type=text]').each( function() {
                var val     = $(this).val();
                if (val != '') {
                    // http://stackoverflow.com/questions/10456315/validating-alpha-numeric-values-with-all-special-characters
                    if (!val.match(/^[a-zA-Z_0-9@!#\$\^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>\? ]+$/)) {
                        $(this).focus().parent().parent().addClass('error');
                        valid = false;
                    } else {
                        $(this).parent().parent().removeClass('error');
                    }
                }
            });
            if (!valid) {
                alert('กรุณาระบุข้อมูล contact address เป็นภาษาอังกฤษ');
            }
            return valid;
        }


            function remove_domain(domain) {
                var row =  $('.domain-row-' + domain),
                    len = $('.domain-row input[name="domkey[]"]').length;

                row.addClass('shownice');
                if (confirm("{/literal}{$lang.itemremoveconfirm}{literal}")) {
                    if (len > 1) {
                        row.remove();
                    }

                    $('#cartSummary').addLoader();
                    $.post('?cmd=cart&step=2&do=removeitem&target=domain', {target_id: domain}, function(data){
                        $('#cartSummary').html(parse_response(data));
                        if(len <= 1){ //
                            window.location = '?cmd=cart';
                        }
                    });
                    return false;
                }

                row.removeClass('shownice');
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
            var cid  = el.value;
                $.get('?cmd=signup&contact&domaincontact=true&private', {'cid':cid}, function (resp) {
                    resp = parse_response(resp);
                    var pref = $(el).attr('name');
                    //$(el).removeAttr('name').attr('rel', pref);
                    $(resp).find('input, select, textarea').each(function () {
                        $(this).attr('name', pref + '[' + $(this).attr('name') + ']');
                    }).end().appendTo($(el).siblings('.sing-up'));
                    
                    if (parseInt(cid)) {
                        $('.sing-up:first').find('input, select, textarea').each(function(){$(this).attr('disabled', 'disabled')});
                    }
                    
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
    </script>
    <style>
        .lh28{
            line-height: 30px    
        }
    </style>
{/literal}
<div class="default-cart">
    <form action="" method="post" id="cart3" >
        <input type="hidden" name="make" value="domainconfig" />
        {foreach from=$domain item=doms key=kk name=domainsloop}
            {if $doms.action=='transfer' && $doms.product.epp!='1'}
                <input name="epp[{$kk}]"  type="hidden" value="not-required"/>
            {/if}
        {/foreach}

        <div class="wbox">
            <div class="wbox_header">
                <strong>{$lang.productconfig2}</strong>
            </div>
            <div class="wbox_content">
                <table class="checker domain-config-table form-horizontal" cellspacing="0" cellpadding="0" border="0">
                    <thead>
                        <tr>
                            <th width="60%">{$lang.domain}</th>
                            <th width="30%">{$lang.period}</th>
                            <th width="10%">&nbsp; </th>
                        </tr>
                    </thead>

                    {foreach from=$domain item=doms key=kk name=domainsloop}
                        <tbody>
                            <tr class="domain-row-{$kk} domain-row {if $smarty.foreach.domainsloop.index%2==0}even{/if}">
                                <td class="name">
                                    <strong title="{$doms.name}">{$doms.name}</strong>
                                    <input type="hidden" value="{$kk}" name="domkey[]" />
                                </td>
                                <td  class="period">
                                    <select name="period[{$kk}]" id="domain-period-{$kk}" class="dom-period" onchange="if (typeof (simulateCart) == 'function')
                                                simulateCart('#cart3')" >
                                        {foreach from=$doms.product.periods item=period key=p}
                                            <option value="{$p}" {if $p==$doms.period}selected="selected"{/if}>{$p} {$lang.years}</option>
                                        {/foreach}
                                    </select>
                                </td>
                                <td class="remove">
                                    <a href="#" class="btn btn-sm btn-small btn-danger" 
                                       onclick="return remove_domain('{$kk}')" title="{$lang.remove}">{$lang.remove}</a>
                                </td>
                            </tr>
                            {if $doms.product.description}
                                <tr><td colspan="3">{$doms.product.description}</td></tr>
                            {/if}

                            {if !$renewalorder && $doms.custom}
                                {foreach from=$doms.custom item=cf}
                                    {if $cf.items}
                                        <tr  class="domain-row-{$kk}  domain-row  {if $smarty.foreach.domainsloop.index%2==0}even{/if}">
                                            <td colspan="3" class="configtd" >
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
                            {if $doms.action=='transfer' && $doms.product.epp=='1'}
                                <tr  class="domain-row-{$kk}  domain-row  {if $smarty.foreach.domainsloop.index%2==0}even{/if}" >
                                    <td colspan="3"  style="border:none" class="configtd">
                                        <label for="epp{$kk}" class="styled"> 
                                            {$lang.eppcode}*
                                        </label>
                                        <input name="epp[{$kk}]"  id="epp{$kk}" value="{$doms.epp}" class="styled" />
                                    </td>
                                </tr>
                            {/if}
                        </tbody>
                    {/foreach}

                </table>
            </div>
        </div>
        {if !$renewalorder}
            <input type="hidden" name="usens" value="{if $usens=='1'}1{else}0{/if}" id="usens" />
            <div class="wbox" {if $usens && $product && !$periods}style="display:none"{/if}>
                <div class="wbox_header">
                    <strong>{$lang.edit_config}</strong>
                </div>
                <div class="wbox_content">
                    <table cellspacing="0" cellpadding="0" border="0" class="styled domain-config-table">
                        <colgroup class="firstcol"></colgroup>
                        <colgroup class="alternatecol"></colgroup>

                        <tr id="setnservers" {if $usens=='1'}style="display:none"{/if}>
                            <td width="180"><b>{$lang.cart2_desc4}</b> <span title="{$lang.cart2_desc3} " class="vtip_description"></span></td>
                            <td><a href="#" onclick="$(this).parents('tr').eq(0).hide();
                                    $('#usens').val(1);
                                    $('#nameservers').slideDown();
                                    return false">{$lang.iwantminens}</a></td>
                        </tr>

                        {if $periods}
                            <tr >
                                <td width="180"><b>{$lang.cart2_desc5}</b> <span title="{$lang.cart2_desc2}" class="vtip_description"></span></td>
                                <td><select onchange="bulk_periods(this)">
                                        {foreach from=$periods item=period key=p}
                                            <option value="{$p}">{$p} {$lang.years}</option>
                                        {/foreach}
                                    </select></td>
                            </tr>

                        {/if}

                        {if !$product}
                            <tr>
                                <td><b>{$lang.nohosting}</b> <span title="{$lang.cart2_desc1}" class="vtip_description"></span></td>
                                <td><a href="{$ca_url}cart&step=0&addhosting=1">{$lang.clickhere1}</a></td>
                            </tr>
                        {/if}
                    </table>
                </div>
            </div>
            <div class="wbox" id="nameservers" {if !$usens}style="display:none"{/if}>
                <div class="wbox_header">
                    <strong>{$lang.nameservers}</strong>
                </div>
                <div class="wbox_content">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled domain-config-table">
                        <colgroup class="firstcol"></colgroup>
                        <colgroup class="alternatecol"></colgroup>
                        {section loop=11 step=1 start=1 name=ns }
                            {assign value="ns`$smarty.section.ns.index`" var=nsi}
                            {assign value="nsip`$smarty.section.ns.index`" var=nsipi}
                            {if $domain[0][$nsi] || $smarty.section.ns.index < 3}
                                <tr>
                                    <td width="20%"><strong>{$lang.nameserver} {$smarty.section.ns.index}</strong></td>
                                    <td><input name="{$nsi}" data-id="{$smarty.section.ns.index}" value="{$domain[0][$nsi]}" class="styled"/>
                                        {if ($smarty.section.ns.index) != 10}
                                            <script>$('.more_' + {$smarty.section.ns.index-1}).remove();</script>
                                            <a class="add_ns more_{$smarty.section.ns.index}" style="font-size: 11px;" href="#" onclick="add_ns(this); return false;">Add more</a>
                                        {elseif $domain[0][$nsi]}
                                            <script>$('.more_' + {$smarty.section.ns.index-1}).remove();</script>
                                        {/if}
                                    </td>
                                </tr>
                                {if $domain[0].nsips}
                                    <tr>
                                        <td width="20%"><strong>{$lang.nameserver} IP {$smarty.section.ns.index}</strong></td>
                                        <td><input name="{$nsipi}" value="{$domain[0][$nsipi]}" class="styled"/></td>
                                    </tr>
                                {/if}
                            {/if}
                        {/section}
                    </table>

                    <a href="#" onclick="$('#nameservers').slideUp();
                            $('#setnservers').show();
                            $('#usens').val(0);
                            return false">{$lang.useourdefaultns}</a>

                </div></div>

            <input type="hidden" name="contactsenebled" value="1"  />
            <div class="wbox" >
                <div class="wbox_header">
                    <strong>{$lang.domcontacts}</strong>
                </div>
                <div class="wbox_content contacts">
                    {include file="common/contacts.tpl"}
                </div>
            </div>
        {/if}
        <div class="orderbox"><div class="orderboxpadding"><center><input type="submit" value="{$lang.continue}" style="font-size:12px;font-weight:bold"  class="padded btn  btn-primary"/></center></div></div>
    </form>
</div>