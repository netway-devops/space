{if $service.status=='Active'}
{literal}
    <script type="text/javascript">
        $(function () {
            if ($('#cont').length) {
                var ch = $('#more_list').parents('#cont').height()
                while ($('#more_list').height() > ch)
                    $('#more_list').width($('#more_list').width() + 1);
            }

            $('.idchecker').on('change', function () {
                if ($('.idchecker:checked').length < 1)
                    unbind_ico();
                else
                    bind_ico();
            });

            $('.idchecker_all').on('change', function (e) {
                if ($(e.target).is(':checked')) {
                    $('.idchecker').prop('checked', true);
                    bind_ico();
                } else {
                    $('.idchecker').prop('checked', false);
                    unbind_ico();
                }
            });

            unbind_ico();

            $(document).click(function (event) {
                if ($('#more_list:visible').length && !$(event.target).parents('#more_icon').length && !$(event.target).is('#more_icon').length) {
                    $("#more_list").hide();
                }
            });
        });

        function switchRenew(el, id) {
            ajax_update("{/literal}{$service_url}{literal}", {
                did: id,
                make: 'renewstate',
                state: $(el).hasClass('off') ? 1 : 0
            }, function (a) {
                $(el).toggleClass('off');
            });
            return false;
        }

        function bind_ico() {
            $('.icons ul a.dns-action_js').unbind().click(function () {
                var ids = $('.idchecker:checked').serialize();
                if (ids == '') {
                    return false;
                }
                window.location = $(this).attr('href') + '&' + ids;
                return false;
            });
            $('.icons > ul > li > a:last').unbind().click(function () {
                $('#more_list').toggle();
            });
            $('.icons > ul > li').removeClass('disabled');
        }

        function unbind_ico() {
            $('.icons > ul > li > a:last').unbind().click(function () {
                return false
            });
            $('.icons ul a.dns-action_js').unbind().click(function () {
                return false
            });
            $('.icons > ul > li').addClass('disabled');
        }
    </script>
{/literal}
    {if $widget.appendtpl}
        {include file=$widget.appendtpl}
    {/if}

    {include file='../common/dnsmodules/upgrades.tpl'}
    <div class="icons">
        <div class="left dwarrow">{$lang.withdomains}</div>

        <ul class="right">
            {if $dns_templates}
                <li class="disabled">
                    <a class="dns-action_js" href="{$service_url}&act=dns_templates">
                        <img src="{$type_dir}icons/ico-renew.png" alt="">
                        <span>{$lang.dnstemplates}</span>
                    </a>
                </li>
            {/if}
            {if in_array('A', $supp_type)}
                <li class="disabled">
                    <a class="dns-action_js" href="{$service_url}&act=add_record&type=A">
                        <img src="{$type_dir}icons/ico_domains2.jpg" alt="">
                        <span>{$lang.addrecorda}</span>
                    </a>
                </li>
            {/if}
            {if in_array('MX', $supp_type)}
                <li class="disabled">
                    <a class="dns-action_js" href="{$service_url}&act=add_record&type=MX">
                        <img src="{$type_dir}icons/email_foward.png" alt="">
                        <span>{$lang.addentrymx}</span>
                    </a>
                </li>
            {/if}
            {if in_array('CNAME', $supp_type)}
                <li class="disabled">
                    <a class="dns-action_js" href="{$service_url}&act=add_record&type=CNAME">
                        <img src="{$type_dir}icons/foward.png" alt="">
                        <span>{$lang.addaliasname}</span>
                    </a>
                </li>
            {/if}
            <li class="disabled">
                <a class="dns-action_js" href="{$service_url}&act=clone_record">
                    <img src="{$type_dir}icons/ico_invoices2.jpg" alt="">
                    <span>{$lang.clonesettingsdns}</span>
                </a>
            </li>
            {foreach from=$supp_type item=stype}
                {if $stype != 'MX' && $stype != 'A' && $stype != 'CNAME'}
                    {assign var=more value=true}
                {/if}
            {/foreach}
            {if $more}
                <li class="disabled dropdown" id="more_icon">
                    <a class="" data-toggle="dropdown" href="#">
                        <img src="{$type_dir}icons/ico_resources.png" alt="">
                        <span>{$lang.more}</span>
                    </a>
                    <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="dLabel">
                        {foreach from=$supp_type item=stype}
                            {if $stype != 'MX' && $stype != 'A' && $stype != 'CNAME'}
                                <li>
                                    <a class="dropdown-item dns-action_js" href="{$service_url}&act=add_record&type={$stype}">{$lang.Add} {$stype} {$lang.record}</a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </li>
            {/if}

        </ul>
        <div class="clear"></div>
    </div>
    <form action="" method="POST">
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display dns-zones">
            <thead>
                <tr>
                    <th width="40">
                        <input type="checkbox" class="idchecker_all"/>
                    </th>
                    <th align="left">{$lang.domain}</th>
                    <th width="200">{$lang.creationdate}</th>
                    {if $metered_enable}
                        <th width="80">{$lang.price}</th>
                    {/if}
                    {if $show_zone_management}<th width="100"></th>{/if}
                </tr>
            </thead>
            {if $user_domains}
                <tbody>
                    {foreach from=$user_domains item=domain name=row}
                        <tr {if  $smarty.foreach.row.index%2 == 0}class="even" {else}class="odd"{/if}>
                            <td width="40">
                                <input class="idchecker" type="checkbox" onclick="" name="dom[]" value="{$domain.$domain_indent}"/>
                            </td>
                            <td align="left">
                                <a href="{$service_url}&act=dns_manage&domain_id={$domain.$domain_indent}">{$domain.domain}</a>
                            </td>
                            <td>{if $domain.created}{$domain.created|dateformat:$date_format}{else}-{/if}</td>
                            {if $metered_enable}
                                <td>{if $domain.charge}{$domain.charge|price:$domain.currency_id}{else}-{/if}</td>
                            {/if}
                            <!--<td><a class="autorefreash {if $domain.qty==0}off{/if}" href="#" onclick="return switchRenew(this,'{$domain.id}')" title="{$lang.autorenew}: {if $domain.qty==0}{$lang.Off}{else}{$lang.On}{/if}"></a></td>-->
                            {if $show_zone_management}
                                <td align="center">
                                    <a title="{$lang.delete}" onclick="return confirm('{$lang.suretoremovedomain}');" href="{$service_url}&did={$domain.$domain_indent}&make=removedomain&security_token={$security_token}" class="btn btn-sm btn-small btn-danger">{$lang.remove}</a>
                                </td>
                            {/if}
                        </tr>
                    {/foreach}
                </tbody>
                {if $show_zone_management}
                    <tbody>
                    <tr>
                        <th colspan="{if $metered_enable}2{else}4{/if}" style="font-weight:normal">
                            {$lang.domainscount}: <b {if $dom_limit && $user_domains_cnt==$dom_limit}style="color:red"{/if}>
                                {$user_domains_cnt}</b>{if $dom_limit!="disabled"} {$lang.maxallowed}:
                            <b>{if $lang[$dom_limit]}{$lang[$dom_limit]}{else}{$dom_limit}{/if}</b>{/if}
                        </th>
                        {if $metered_enable}
                            <th style="text-align:right">{$lang.total}:</th>
                            <th colspan="2">
                                <b>{$service.metered_total|price:$currency}</b>
                            </th>
                        {/if}
                    </tr>
                    </tbody>
                {/if}
            {else}
                <tbody>
                    <tr>
                        <td colspan="{if $metered_enable}5{else}4{/if}" align="center">{$lang.nodomainsaddedyet}</td>
                    </tr>
                </tbody>
            {/if}
        </table>
        {if $show_zone_management}
            <table border="0" width="100%">
                <tr>
                    <td>
                        {if $dom_limit && $dom_limit!='unlimited' && $dom_limit!="disabled" && $user_domains_cnt>=$dom_limit}
                            <span class="fs11" style="color:red">{$lang.youvereachedyourdomainslimit}</span>
                        {elseif $dom_limit!="disabled"}
                            <a class="btn btn-primary" href="{$service_url}&act=add_domain">{$lang.adddomain}</a>
                        {/if}
                    </td>
                    <td style="text-align: right">
                        {if $metered_enable}
                            {if $next_price}
                                {$lang.yourcurrentpricenextdomainis} {$next_price|price:$currency}
                            {/if}
                            <a href="#" onclick="$('#mpricing').toggle();
                                return false">{$lang.viewpricing}</a>
                        {/if}
                    </td>
                </tr>
            </table>
        {/if}
        {securitytoken}
    </form>
{/if}

{if $show_billing}
    <div class="wbox" style="margin-top:30px;">
        <div class="wbox_header">{$lang.billing_info}</div>
        <div class="wbox_content">
            {if $service.showcancel}
                <p class="pull-right">
                    <a href="{$service_url}&cid={$service.category_id}&cancel" style="color:red">
                        <span class="cancel">{$lang.cancelrequest}</span>
                    </a>
                </p>
            {/if}

            {include file="services/service_billing2.tpl"}
            {include file='services/service_forms.tpl'}

            <div id="mpricing" style="display:none">
                <table border="0" cellspacing="0" cellpadding="0" width="100%" class="checker table table-striped ">
                    {foreach from=$pricebrackets item=bracket}
                        {foreach from =$bracket.prices item=p key=k name=bloop}
                            <tr {if $smarty.foreach.bloop.index%2==0}class="even"{/if}>
                                <td width="20"></td>
                                <td>{$lang.from} {$p.qty} {$bracket.unit_name}</td>
                                <td>{if $p.qty_max>0}{$lang.to} {$p.qty_max} {$bracket.unit_name}{else} {$lang.to}
                                        <b>{$lang.unlimited}</b>{/if}</td>
                                <td>{$p.price|price:$currency} / {$lang[$service.billingcycle]}</td>
                            </tr>
                        {/foreach}
                    {/foreach}
                </table>
            </div>
        </div>
    </div>
{/if}

{if $service.status=='Active'}
    {if $nameserv}
        <div class="wbox" style="margin-top:30px;">
            <div class="wbox_header">{$lang.updateyourdomainregistrarsnameserve}</div>
            <div class="wbox_content">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <td width="50%" style="padding-right:10px;">
                            <ul style="" class="listi">
                                <li>{$lang.dnsguideline1}</li>
                                <li>{$lang.dnsguideline2}</li>
                                <li>{$lang.dnsguideline3}</li>
                                <li>{$lang.dnsguideline4}</li>
                            </ul>
                        </td>
                        <td valign="top">
                            <table cellspacing="0" cellpadding="0" class="checker table table-striped table-bordered"
                                   width="100%">
                                <tr>
                                    <th style="text-align: left">{$lang.hostname}</th>
                                    <th style="text-align: left">{$lang.ipadd} </th>
                                </tr>
                                {foreach from=$nameserv item=ns name=namserver}
                                    {if $ns!=''}
                                        <tr {if $smarty.foreach.namserver.index%2==0}class="even"{/if}>
                                            <td>{$ns.name}</td>
                                            <td>{$ns.ip}</td>
                                        </tr>
                                    {/if}
                                {/foreach}
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    {/if}
{/if}