{if $custom_overrides.cart2}
    {include file=$custom_overrides.cart2}
{else}
{php}
$templatePath   = $this->get_template_vars('template_path');
include(dirname($templatePath) . '/orderpages/cart2.tpl.php');
{/php}
<link href="{$template_dir}css/fileuploader.css?v={$hb_version}" rel="stylesheet" media="all" />
<script src="{$template_dir}js/fileuploader.js"></script>

<!-- Modal -->
<div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <h3 id="myModalLabel">Already Customer</h3>
  </div>
  <div class="modal-body">
    <form action="index.php/cart/&step=2" method="post">
        {assign var="onlycustomer" value="1"}
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
            var newperiod = $('#domain-period-' + domain).val();
            $('#cartSummary').addLoader();
            $.post('?cmd=domainhandle&action=changeCartDomainIDN', {domainId:domain}, function (data) {
                cart2_ajax_update('?cmd=cart&step=2&do=changedomainperiod', {key: domain, period: newperiod}, '#cartSummary');
            });
            return false;
        }
        function change_id_protection(obj) {
            var value       = obj.is(':checked') ? 1 : 0;
            var name        = obj.attr('name');
            var id          = obj.attr('id');
            $.post('?cmd=domainhandle&action=changeCartIDProtection', {
                optionId    : id,
                optionName  : name,
                optionValue : value,
                }, function (data) {
                document.location = 'cart/&step=2';
            });
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
        function cart2_ajax_update(url, params, update, swirl) {
            if (swirl)
                $(update).html('<center><img src="ajax-loading.gif" /></center>');

            if (params != undefined && isEmpty(params)) {
                params = {
                    empty1m: 'param'
                };
            }

            $.post(url, params, function(data) {
                //$(update).html(data);
                document.location = 'cart/&step=2';
            });

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
    <form action="" method="post" id="cart3" >
        <input type="hidden" name="make" value="domainconfig" />
        {foreach from=$domain item=doms key=kk name=domainsloop}
            {if $doms.action=='transfer' && $doms.product.epp!='1'}
                <input name="epp[{$kk}]"  type="hidden" value="not-required"/>
            {/if}
        {/foreach}

        <div class="wbox" data-style="width: 73%;" >
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
                    
                    {assign var="countDomain" value=1}
                    {foreach from=$domain item=doms key=kk name=domainsloop}
                        <tbody>
                            <tr class="domain-row-{$kk} domain-row {if $smarty.foreach.domainsloop.index%2==0}even{/if}">
                                <td class="name">
                                    
                                    {if $countDomain == 1}
                                        {assign var=domainPrefix value=$doms.name}
                                    {/if}
                                    <div style="display: none">{$countDomain++}</div>
                                    
                                    <strong title="{$doms.name}">{$doms.name}</strong>
                                    <input type="hidden" value="{$kk}" name="domkey[]" />
                                </td>
                                <td  class="period">
                                    <select name="period[{$kk}]" id="domain-period-{$kk}" class="dom-period" 
                                        onchange="{literal} if (typeof (simulateCart) == 'function') { change_period({/literal}{$kk}{literal}); /*simulateCart('#cart3');*/ } {/literal}" >
                                        {foreach from=$doms.product.periods item=period key=p}
                                            <option value="{$p}" {if $p==$doms.period}selected="selected"{/if}>{$p} {$lang.years}
                                            
                                            {if isset($aDomains[$kk].product.periods[$p].discount)
                                                && $aDomains[$kk].product.periods[$p].discount > 0}
                                                ( ได้รับส่วนลดทันที {$aDomains[$kk].product.periods[$p].discount|price:$currency} ) 
                                            {/if}
                                            {if isset($aDomains[$kk].product.periods[$p].netprice)}
                                                เหลือเพียง {$aDomains[$kk].product.periods[$p].netprice|price:$currency} 
                                            {else}
                                                = {$aDomains[$kk].product.periods[$p].price|price:$currency} 
                                            {/if}
                                                
                                            </option>
                                        {/foreach}
                                    </select>
                                </td>
                                <td class="remove">
                                    <a href="#" class="btn btn-sm btn-small btn-danger" style="height:32px;"
                                       onclick="return remove_domain('{$kk}')" title="{$lang.remove}">{$lang.remove}</a>
                                </td>
                            </tr>
                            {if $doms.product.description}
                                <tr><td colspan="3">{$doms.product.description}</td></tr>
                            {/if}

                            {if $doms.custom}
                                {foreach from=$doms.custom item=cf}
                                    {if $cf.items}
                                        <tr  class="domain-row-{$kk}  domain-row  {if $smarty.foreach.domainsloop.index%2==0}even{/if}"  style="{if $cf.key == 'hide'}display:none;{/if}" >
                                            <td colspan="3" class="configtd" >
                                                <label for="custom[{$cf.id}]" class="styled">
                                                    {$cf.name} {if $cf.options & 1}*{/if}
                                                </label>
                                                {if $cf.description!=''}
                                                    <div class="fs11 descr" style="">{$cf.description}</div>
                                                {/if}
                                                {include file=$cf.configtemplates.cart}
                                                
                                                <script language="JavaScript">
                                                {literal}
                                                $(document).ready(function () {
                                                    {/literal}
                                                    {if isset($aIDNAutofill[$cf.id])}
                                                    $('#custom_field_{$cf.id}').val('{$aIDNAutofill[$cf.id]}');
                                                    {/if}
                                                    {literal}
                                                });
                                                {/literal}
                                                </script>
                                                
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
                                        <input name="epp[{$kk}]"  id="epp{$kk}" value="{$doms.epp_code}" class="styled" />
                                    </td>
                                </tr>
                            {/if}
                        </tbody>
                    {/foreach}

                </table>
                
                {if !$renewalorder}
                    {* start: more extension *}
                    {*
                    <div id="show-more-extension"></div>
                    <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
                        <tr>
                            <th width="45%" align="left">&nbsp;</th>
                            <th width="30%">&nbsp;</th>
                            <th width="25%" align="right"><div onclick="loadMoreExtension2();">แสดงชื่อสกุลอื่น&nbsp;&darr;</div></th>
                        </tr>
                    </table>
                    *}
                    {* start: more extension *}
                {/if}
                
            </div>
        </div>

        {clientwidget module="cart" section="domain_config" wrapper="widget.tpl"}

        {if !$renewalorder}
        
            <div class="wbox" id="additional" {if $isOrderAccount} style="display:none;" {/if}>
                <div class="wbox_header">
                    <strong>Hosting Plan/Google Apps</strong>
                </div>
                <div class="wbox_content">
                    <br />
                    <input type="radio" name="include_product_id" value="0" {if ! $currentAccountSelected} checked="checked" {/if} /> ไม่ต้องการ (มี hosting อยู่แล้ว) <br />
                    {if isset($aProductRecommend)}
                        {foreach from=$aProductRecommend key=k1 item=aProduct}
                            {if ! $aProduct.id}
                                {if $aProduct.name != 'compare'}
                                <br />
                                <strong>{$aProduct.name}</strong><br />
                                {else}
                                {*
                                &nbsp;&nbsp; <a href="javascript:void(0);" name="popOver{$k1}" class="comparePlan" title="เปรียบเทียบ hosting plan">เปรียบเทียบ hosting plan</a><br />
                                    <div id="popOver{$k1}" class="popOver">
                                        <button type="button" class="pull-right btn btn-link" data-dismiss="modal" aria-hidden="true" onclick="{literal}$('a[name=popOver{/literal}{$k1}{literal}]').popover('toggle');{/literal}"><span class="text-error" style="font-weight:bolder;">&times; Close</span></button>
                                        {include file="cart_hostingcompare/cart.tpl" products=$aProduct.lists}
                                    </div>
                                *}
                                {/if}
                            {else}
                                {if $aProduct.id == 'GApps'}
                                &nbsp;&nbsp; <label><input type="checkbox" name="free_google_apps" value="1" {if $withGoogelApps} checked="checked" {/if} /> {$aProduct.name} {if $aProduct.a}{$aProduct.a|price:$currency} / year{/if}</label><br />
                                {else}
                                &nbsp;&nbsp; <label><input type="radio" name="include_product_id" value="{$aProduct.id}" {if $currentAccountSelected == $aProduct.id} checked="checked" {/if} /> {$aProduct.name} {if $aProduct.a}{$aProduct.a|price:$currency} / year{/if}</label><br />
                                {/if}
                            {/if}
                        {/foreach}
                    {/if}
                    <br /><strong>Office 365</strong><br>
                    {foreach from=$aO365 item=aO365Product}
                        &nbsp;&nbsp; <label><input type="radio" name="o365Product" id="o365Radio{$aO365Product.id}" value="{$aO365Product.id}" onclick="choose({$aO365Product.id})"> {$aO365Product.name}</label>
                        <div id="conO365{$aO365Product.id}" style="display: none">
                            <br>
                            <label style="padding-left: 30px" >จำนวน: &nbsp;<input name="quantity{$aO365Product.id}" id="quantity{$aO365Product.id}" type="text" value="1" style="width: 35px"/> License</label><br>
                            <label style="padding-left: 30px" >Default Email: &nbsp;<input name="defaultEmail{$aO365Product.id}" id="defaultEmail{$aO365Product.id}" type="text" value="" style="width: 100px"/>@{$domainPrefix}</label>
                        </div><br>
                        {literal}
                        <script type="text/javascript">
                            
                            $('#quantity{/literal}{$aO365Product.id}{literal}').change(function(){
                                updateSession('quantity',$(this).val());
                            });
                            
                            $('#defaultEmail{/literal}{$aO365Product.id}{literal}').change(function(){
                                updateSession('defaultEmail',$(this).val());
                            });
                            
                        </script>
                        {/literal}
                    {/foreach}
                    &nbsp;&nbsp; <label><input type="radio" name="o365Product" checked="checked"> ไม่เลือก</label><br>
                </div>
            </div>
            <script language="JavaScript">
            {literal}
            $(document).ready( function () {
                $('.comparePlan').popover({
                    placement   : 'right',
                    html        : true,
                    content     : function() {
                        var elmName     = $(this).prop('name');
                        return $('#'+elmName+'').html();
                    },
                    callback    : function () {
                        $('div[class="arrow"]').hide();
                    }
                });
                $('.popOver').hide();
                
                $('input[name="include_product_id"]').click( function () {
                    var productId   = parseInt($(this).val());
                    if (productId) {
                        $.post('?cmd=cart&step=0&addhosting=1', {'action': 'add', 'id': productId, 'cycle': 'a'}, function () {
                            simulateCart();
                        });
                    } else {
                        $.post('?cmd=carthandle&action=nohosting', {}, function () {
                            simulateCart();
                        });
                    }
                });
                
                $('input[name="free_google_apps"]').click( function () {
                    var v   = $(this).is(':checked') ? 1 : 0;
                    $.post('?cmd=carthandle&action=freegoogleapps', {'status': v}, function () {});
                });
                
                $('input[name="o365Product"]').click( function () {
                    var productId   = parseInt($(this).val());
                    if (productId) {
                        if(productId == 684 || productId == 709){
                            $.post('?cmd=cart&step=0&addhosting=1', {'action': 'add', 'id': productId, 'cycle': 'a'}, function () {
                                simulateCart();
                            });
                       }else{
                            $.post('?cmd=cart&step=0&addhosting=1', {'action': 'add', 'id': productId, 'cycle': 'a'}, function () {
                                simulateCart();
                            });
                       }
                    }else {
                        $.post('?cmd=carthandle&action=nohosting', {}, function () {
                            simulateCart();
                        });
                    }
                });
                
                var url = '{/literal}{$domainPrefix}{literal}';
                var arr = url.split(".");
                var result = arr[0];
                
                updateSession('quantity',1);
                updateSession('defaultEmail',result);
                
                var contactRegistrant   = '{/literal}{$set_contacts.registrant}{literal}';
                if (contactRegistrant === '') {
                    $('#contactsRegistrant option:eq(1)').attr('selected', 'selected');
                }

            });
            
            function choose(data){
                
                var url = '{/literal}{$domainPrefix}{literal}';
                var arr = url.split(".");
                var result = arr[0];
                
                
                
                /*$("*[id*='conO365']").each(function() {
                    $(this).hide('slow');
                });
                
                $("*[id*='defaultEmail']").each(function() {
                    $(this).val('');
                });
                
                $('#defaultEmail'+data).val(result);
                $('#conO365'+data).show('slow');*/
                
            }
            
            function updateSession(method,value){
                //alert(method + '-' + value);
                $('#additional').addLoader();
                $.post('?cmd=carthandle&action=updateSession', { 'method':method , 'value':value }, function (data) {
                            //alert(data);
                            $('#preloader').remove();
                });
            }
            
            
            {/literal}
            </script>
        
            <input type="hidden" name="usens" value="{if $usens=='1'}1{else}0{/if}" id="usens" />
            <div class="wbox" {if $usens && $product && !$periods}data-style="display:none"{/if}>
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
                            <tr style="display: none;" >
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
                                            <a class="add_ns more_{$smarty.section.ns.index}" style="font-size: 11px;" href="#" onclick="add_ns(this); return false;">{$lang.add_more}</a>
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
                    {*include file="common/contacts.tpl"*}
                    
                    {if $logged!="1"}
                    <div class="row-fluid well well-small"> 
                        <span class="span9">
                            ถ้าเคยสั่งซื้อบริการ หรือเป็นลูกค้าอยู่แล้ว คุณสามารถ Login <br />เพื่อใช้ข้อมูล Registrant contact ที่มีอยู่แล้วได้ทันที <br />โดยไม่ต้องกรอกข้อมูลซ้ำ
                        </span>
                        <span class="span2">
                            <a href="javascript: return false;" class="btn btn-success" data-toggle="modal" data-target="#loginModal">Login</a>
                        </span>
                        <span class="span11">
                            <br />
                            <div class="dotted-separate"><div><span> &nbsp; หรือ &nbsp; </span></div></div>
                            <div align="center">สมาชิกใหม่กรุณากรอกข้อมูลด้านล่าง</div>
                        </span>
                    </div>      
                    {/if}
                    <span style="display:none;">
                    <input type="checkbox" name="contacts[usemy]" value="1" {foreach from=$cart_contents[2] item=doms}{if !$doms.extended}checked="checked"{else}{assign value=$doms.extended var=set_contacts}{/if}{break}{/foreach} onchange="if(!this.checked)$(this).next().slideDown('fast'); else $(this).next().slideUp('fast'); " />
                    {if $logged=="1"} {$lang.domcontact_loged}      
                    {else} {$lang.domcontact_checkout}
                    {/if}
                    </span>
                    <div {if !$set_contacts}style="display: none;"{/if}>
                        <div>
                            <select id="contactsRegistrant" {if $logged!="1" || !$contacts}style="display:none"{/if} class="right" onchange="{literal}if( $(this).val() == 'new') { $(this).siblings('.sing-up').html(''); insert_singupform(this); } else {  $(this).siblings('.sing-up').html(''); insert_singupform(this);  }{/literal}" name="contacts[registrant]">
                                <option value="new">{$lang.definenew}</option>
                                {if $logged=="1"}
                                    {foreach from=$contacts item=contact}
                                        {if ! in_array($contact.id, $aIsDomainContact)} {continue} {/if}
                                        <option {if $set_contacts.registrant == $contact.id}selected="selected"{/if} value="{$contact.id}">{if $contact.companyname}{$contact.companyname} ({$contact.firstname} {$contact.lastname}{else}{$contact.firstname} {$contact.lastname}({/if} {$contact.email})</option>
                                    {/foreach}
                                {/if}
                            </select>
                            <strong class="lh28">{$lang.registrantinfo}</strong>
                            <div class="sing-up">
                                {if is_array($set_contacts.registrant)}
                                    {include file="ajax.signup.tpl" submit=$set_contacts.registrant fields=$singupfields}
                                    {literal}
                                    <script type="text/javascript">
                                    $('.sing-up:first').find('input, select, textarea').each(function(){$(this).attr('name', 'contacts[registrant]['+$(this).attr('name')+']'); })
                                    $('#field_email, #field_firstname, #field_lastname, #field_address1, #field_city, #field_state, #field_postcode, #field_phonenumber').attr('required', 'required');
                                    $('#field_address1, #field_address2').attr('maxlength', '96');
                                    $('#field_postcode, #field_phonenumber').attr('placeholder', 'ระบุตัวเลขเท่านั้น').keyup(function () { this.value = this.value.replace(/[^0-9]/g,''); });
                                    </script>
                                    {/literal}
                                {elseif !is_numeric($set_contacts.registrant)}
                                    <script type="text/javascript">insert_singupform($('select[name="contacts[registrant]"]'));</script>
                                {elseif !count($aIsDomainContact)}
                                    <script type="text/javascript">insert_singupform($('select[name="contacts[registrant]"]'));</script>
                                {/if}
                            </div>
                        </div>
                        <div class="clear">
                            <select class="right" onchange="if( $(this).val() == 'new') insert_singupform(this); else $(this).siblings('.sing-up').html('');" name="contacts[admin]">
                                <option value="registrant">{$lang.useregistrant}</option>
                                <option {if is_array($fields.contacts.admin)}selected="selected"{/if} value="new">{$lang.definenew}</option>
                                {if $logged=="1"}
                                    {foreach from=$contacts item=contact}
                                        {if ! in_array($contact.id, $aIsDomainContact)} {continue} {/if}
                                        <option {if $set_contacts.admin == $contact.id}selected="selected"{/if} value="{$contact.id}">{if $contact.companyname}{$contact.companyname} ({$contact.firstname} {$contact.lastname}{else}{$contact.firstname} {$contact.lastname}({/if} {$contact.email})</option>
                                    {/foreach}
                                {/if}
                            </select>
                            
                            <strong class="lh28">{$lang.admininfo}</strong>
                            <div class="sing-up">
                                {if is_array($fields.contacts.admin)}
                                    {include file="ajax.signup.tpl" submit=$set_contacts.admin fields=$singupfields}
                                    {literal}<script type="text/javascript">$('.sing-up:eq(1)').find('input, select, textarea').each(function(){$(this).attr('name', 'contacts[admin]['+$(this).attr('name')+']'); })</script>{/literal}
                                {/if}
                            </div>
                        </div>
                        <div class="clear" style="display: none;">
                            <input type="hidden" name="contacts[tech]" value="{$nwTechnicalContact}">
                            <select class="right" onchange="if( $(this).val() == 'new') insert_singupform(this); else $(this).siblings('.sing-up').html('');" name="contacts[tech]" disabled="disabled">
                                <option value="{$nwTechnicalContact}">{$configBusinessName}</option>
                                <option value="registrant">{$lang.useregistrant}</option>
                                <option {if is_array($fields.contacts.tech)}selected="selected"{/if} value="new">{$lang.definenew}</option>
                                {if $logged=="1"}
                                    {foreach from=$contacts item=contact}
                                        <option {if $set_contacts.tech == $contact.id}selected="selected"{/if} value="{$contact.id}">{if $contact.companyname}{$contact.companyname} ({$contact.firstname} {$contact.lastname}{else}{$contact.firstname} {$contact.lastname}({/if} {$contact.email})</option>
                                    {/foreach}
                                {/if}
                            </select>
                            <strong class="lh28">{$lang.techinfo}</strong>
                            <div class="sing-up">
                                {if is_array($fields.contacts.tech)}
                                    {include file="ajax.signup.tpl" submit=$set_contacts.tech fields=$singupfields}
                                    {literal}<script type="text/javascript">$('.sing-up:eq(2)').find('input, select, textarea').each(function(){$(this).attr('name', 'contacts[tech]['+$(this).attr('name')+']'); })</script>{/literal}
                                {/if}
                            </div>
                        </div>
                        <div class="clear" style="display: none;">
                            <select class="right" onchange="if( $(this).val() == 'new') insert_singupform(this); else $(this).siblings('.sing-up').html('');" name="contacts[billing]">
                                <option value="registrant">{$lang.useregistrant}</option>
                                <option {if is_array($fields.contacts.billing)}selected="selected"{/if} value="new">{$lang.definenew}</option>
                                {if $logged=="1"}
                                    {foreach from=$contacts item=contact}
                                        <option {if $set_contacts.billing == $contact.id}selected="selected"{/if} value="{$contact.id}">{$contact.companyname} {$contact.firstname} {$contact.lastname} {$contact.email}</option>
                                    {/foreach}
                                {/if}
                            </select>
                            <strong class="lh28">{$lang.billinginfo}</strong>
                            <div class="sing-up">
                                {if is_array($fields.contacts.billing)}
                                    {include file="ajax.signup.tpl" submit=$set_contacts.billing fields=$singupfields}
                                    {literal}<script type="text/javascript">$('.sing-up:eq(3)').find('input, select, textarea').each(function(){$(this).attr('name', 'contacts[billing]['+$(this).attr('name')+']'); })</script>{/literal}
                                {/if}
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>

            {if $subproducts && 'config:ShopingCartMode'|checkcondition && !$contents[0]}
                <div class="wbox" >
                    <div class="wbox_header">
                        <strong>{$lang.additional_services}</strong>
                    </div>
                    <div class="wbox_content contacts">
                        <table class="table stackable">
                            {foreach from=$subproducts item=pr}
                                <tbody>
                                <tr>
                                    <td>
                                        <strong class="break-word" title="{$pr.name}">{$pr.name}</strong>
                                    </td>
                                    <td align="right">
                                        <a href="#" onclick="addsubproduct('{$pr.id}');return false;" class="btn btn-primary">{$lang.offer_claim_item}</a>
                                    </td>
                                </tr>
                                </tbody>
                            {/foreach}
                        </table>
                    </div>
                </div>
            {/if}

        {/if}
        <div class="orderbox"><div class="orderboxpadding"><center><input type="submit" value="{$lang.continue}" style="font-size:12px;font-weight:bold"  class="padded btn  btn-primary"/></center></div></div>
    </form>
</div>


<script>
{literal}
var tmp     = $.fn.popover.Constructor.prototype.show;
$.fn.popover.Constructor.prototype.show = function () {
tmp.call(this);
    if (this.options.callback) {
        this.options.callback();
    }
}
{/literal}
</script>

<style type="text/css">
{literal}

.dotted-separate {
    border-top: 3px dotted #ccc;
}
.dotted-separate div {
    font-size: 0.9em;
    font-weight: normal;
    line-height: 1.5em;
    text-transform: uppercase;
    margin-top: -0.75em;
    text-align: center;
}
.dotted-separate div span {
    background-color: #E6E6E6;
    padding: 0 5px;
}

.controls input {
    height: 34px;
}
.controls select {
    height: 34px;
}

{/literal}
</style>

{if !$renewalorder}
    {* start: rvcustomtemplate *}
        {if $rvcustomtemplate}
            {include file=$rvcustomtemplate}
        {/if}
    {* eof: rvcustomtemplate *}
{/if}

{/if}