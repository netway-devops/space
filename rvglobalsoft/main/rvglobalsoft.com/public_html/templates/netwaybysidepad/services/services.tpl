{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'services/services.tpl.php');
{/php}

{if isset($ga_mode)}
<script type="text/javascript">
    var APP_VERSION = '{$ga_mode}';
{literal}
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','gao');


    try{
        gao('create', 'UA-65722035-5', 'auto', {appName: APP_VERSION});
        gao('send', {
          hitType: 'pageview',
          page: 'clientarea/services/ssl/',
          location: APP_VERSION,
          title: 'demo'
        });

    } catch(err) {}
{/literal}
</script>
{/if}



{if $service}
    {include file='services/service_details.tpl'}
{else}
    <!-- for product cpanel:6 ,rvsitebuilder:8, rvskin:7 -->

    {if $cid == 6}

        {include file='services/lists.tpl'}

    {elseif $cid==6 || $cid == 9}
        {if $cid == 9}
            {include file='rvlicense/product_perpetual_btn.tpl'}
            {php}
                include_once $this->template_dir . 'rvlicense/services_product_perpetual_license.tpl.php';
            {/php}
        {else}
            {php}
                include_once $this->template_dir . 'rvlicense/services_product_license.tpl.php';
            {/php}
        {/if}

        {include file='rvlicense/services_product_license_footer.tpl.php'}
    {elseif $cid==8}
    <!--
        <div class="service-box" style="width:90%;height:100%;padding:10px 10px 10px 10px;">
           We are migrating license data to the new system. It will take a few days.In the meanwhile, <br />
           please login on the old system at  <a href="https://member.rvskin.com/index_idn.php" target="_blank"> https://member.rvskin.com/index_idn.php</a> using your old login credential.
        </div>-->
        {include file='rvlicense/product_partner_btn.tpl'}
        {php}
            include_once $this->template_dir . 'rvlicense/services_product_partner_license.tpl.php';
        {/php}
        <!--  {include file='rvlicense/services_product_license_footer.tpl.php'}-->
    {elseif $services}
        {if $custom_template}
            {include file=$custom_template}
        {else}
            {if $cid==1}
            <!--<pre>-->
                {php}
                    include_once $this->template_dir . 'services/services_ssl.tpl.php';
                {/php}
            <!--</pre>-->
            {/if}
            {if $opdetails.slug == 'rv2factor'}
                <div class="text-block clear clearfix"> <!-- Block A -->
                    <div class="clear clearfix cart-order" >
                        <p class="pad">
                        {if $services.2.status == 'Pending'}
                            You’ve already made an order for RV2Factor. The status of your previous order is “Pending”. Please keep waiting for our staff to review and activate RV2Factor license for you very soon.

                            If this is longer than you can wait, please <a href="https://rvglobalsoft.com/tickets/new&deptId=1 ">submit a ticket</a> to us for urgent.

                        {elseif $services.2.status == 'Active' || $services.2.status == 'Expired'}
                            Your RV2Factor account is active and available to use. You can now start by installing RV2Factor to your WHM <a href='https://rvglobalsoft.com/knowledgebase/article/176/how-to-install-rv2factor-on-whm/' >here</a>.
                            There are some <a href='https://rvglobalsoft.com/knowledgebase/category/41/how--must-have--requirements' >requirements</a> of using RV2Factor you may want to know. <br><br>

                            It can also be enabled for your cPanel users, please <a href='https://rvglobalsoft.com/knowledgebase/article/181/how-to-active-rv2factor-for-cpanel-users-/' >click here</a> to see the guide.
                            And for more <a href='https://rvglobalsoft.com/knowledgebase/category/45/wordpress--hostbill--cpanel--cpanel-user-'>apps under cPanel</a>.<br><br>

                            If you have any questions or need some help, please feel free to <a href="https://rvglobalsoft.com/tickets/new&deptId=1">contact us</a>.


                        {elseif $services.2.status == 'Suspended'}
                            Your current RV2Factor account is “Suspended”, according to:<br>
                            1) Trial period was ended. Please click at “Upgrade” button above to upgrade your RV2Factor account from Trial to the Paid account.<br>
                            2) Monthly renewal was not proceeded. Please pay for the pending invoice for RV2Factor to reactivate your account again. <br>
                        {elseif $services.2.status == 'Terminated'}
                            Your RV2Factor account was terminated and removed from our system already, according to trial period was ended, monthly renewal was not preceded, or by requested. <br><br>

                            <font color='red'><b>If you want to use RV2Factor again, please renew <a href="{$system_url}index.php?cmd=order2factorhb&action={if $services.2.product_id == '58'}gotoupgrade{else}checkLogin{/if}" style='color:#b00;'>here</a>.</b></font>
                        {/if}
                        </p>
                    </div>
                </div>
            {/if}
            {if $cid == 1 }
            <!-- SSL <pre>{$offer|@print_r}</pre>-->
            {if isset($smarty.get.sort)}{assign var="chk_sort" value="&amp;sort="|cat:$smarty.get.sort}{/if}
            {assign var="sort_url" value=$ca_url|cat:"/clientarea/services/ssl"}
            {if isset($smarty.get.service_page)}{assign var="chk_page" value="&amp;service_page="|cat:$smarty.get.service_page}{/if}
            {if isset($smarty.get.search)}{assign var="chk_search" value="&amp;search="|cat:$smarty.get.search}{/if}
            <div class="container-fluid clear clearfix"> <!-- Block A -->
                <div class="clear clearfix">
                    <div class="alert-info">
                        Every SSL Certificate order on WHMCS addons will be returned the order email to the related client.
                    </div>
                    <div>
                        <div class="table-header" style="background: transparent; border-bottom: 0 none; border-radius: 0; box-shadow: none;">
                            <p class="inline-block">SSL Certificates</p>
                            <div class="search_ssl">
                            <form action="{$ca_url}{$request_url}" id="ui_element" class="sb_wrapper" method="POST">
                                <p>
                                    <input id="filter" name="search" type="text" class="form-control" placeholder="Search" value="{$smarty.post.search}" style="background-color: #e6e6e6; margin-right: 20px; margin-top: 7px;">
                                </p>
                                {if isset($smarty.get.orderby)}
                                    <input name="orderby" type="hidden" value="{$smarty.get.orderby}" />
                                    <input name="sort_type" type="hidden" value="{$smarty.get.sort_type}" />
                                {/if}
                            </form>
                            </div>
                        </div>
                        <a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
                        <table id="ssl-account-table" class="table table-striped table-hover">
                            <tr class="table-header-high" align="center">
                                <th class="ssl-information-head">
                                    <a href="{$sort_url}{$chk_page}{$chk_sort}{$chk_search}{if empty($smarty.get.orderby) || $smarty.get.orderby != 'account_id'}&amp;orderby=account_id&amp;sort_type=ASC{/if}">
                                        Account ID <i class="icon-resize-vertical icon-white"></i>
                                    </a>
                                </th>
                                <th class="ssl-information-head">
                                    <a href="{$sort_url}{$chk_page}{$chk_sort}{$chk_search}&amp;orderby=name&amp;sort_type={if isset($smarty.get.sort_type) && $smarty.get.sort_type == 'ASC' && isset($smarty.get.orderby) && $smarty.get.orderby == 'name'}DESC{else}ASC{/if}">
                                        Service <i class="icon-resize-vertical icon-white"></i>
                                    </a>
                                </th>
                                <th class="ssl-information-head">
                                    <a href="{$sort_url}{$chk_page}{$chk_sort}{$chk_search}&amp;orderby=account_status&amp;sort_type={if isset($smarty.get.sort_type) && $smarty.get.sort_type == 'ASC' && isset($smarty.get.orderby) && $smarty.get.orderby == 'account_status'}DESC{else}ASC{/if}">
                                        Account Status <i class="icon-resize-vertical icon-white"></i>
                                    </a>
                                </th>
                                <th class="ssl-information-head">
                                    <a href="{$sort_url}{$chk_page}{$chk_sort}{$chk_search}&amp;orderby=symantec_status&amp;sort_type={if isset($smarty.get.sort_type) && $smarty.get.sort_type == 'ASC' && isset($smarty.get.orderby) && $smarty.get.orderby == 'symantec_status'}DESC{else}ASC{/if}">
                                        Certificate Issuing Status <i class="icon-resize-vertical icon-white"></i>
                                    </a>
                                </th>
                                <th class="ssl-information-head">
                                    <a href="{$sort_url}{$chk_page}{$chk_sort}{$chk_search}&amp;orderby=total&amp;sort_type={if isset($smarty.get.sort_type) && $smarty.get.sort_type == 'ASC' && isset($smarty.get.orderby) && $smarty.get.orderby == 'total'}DESC{else}ASC{/if}">
                                        Price <i class="icon-resize-vertical icon-white"></i>
                                    </a>
                                </th>
                                <th class="ssl-information-head">
                                    <a href="{$sort_url}{$chk_page}{$chk_sort}{$chk_search}&amp;orderby=next_due&amp;sort_type={if isset($smarty.get.sort_type) && $smarty.get.sort_type == 'ASC' && isset($smarty.get.orderby) && $smarty.get.orderby == 'next_due'}DESC{else}ASC{/if}">
                                        Expiration Date <i class="icon-resize-vertical icon-white"></i>
                                    </a>
                                </th>
                                <th class="ssl-information-head"></th>
                            </tr>
                            <tbody id="updater">

                                {include file='ajax/ajax.services.tpl'}

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>  <!-- Block A -->
            {else}
            <div class="text-block clear clearfix"> <!-- Block A -->
                <div class="clear clearfix">
                    <div class="table-box">
                        <div class="table-header">
                            <p class="inline-block">
                                {if $action=='services' && $cid}
                                    {foreach from=$offer item=o}
                                        {if $action=='services' && $cid==$o.id}
                                            {$o.name}
                                        {/if}
                                    {/foreach}
                                {else}
                                    {$lang[$action]|capitalize}
                                {/if}
                            </p>
                        </div>
                        <a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
                        <table class="table table-striped table-hover">
                            <tr class="table-header-high">
                                <th class="w30"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=name|ASC">{$lang.service}</a></th>
                                {if $opdetails.slug == 'rv2factor'}
                                    <th class="w15"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=qty|ASC">VIP<br>Accounts</a></th>
                                {/if}
                                <th class="w15"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=status|ASC">{$lang.status}</a></th>
                                    {if $action=='vps'}
                                    <th class="w15 cell-border">
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=domain|ASC">{$lang.hostname}</a>
                                    </th>
                                    <th>{$lang.ipadd}</th>
                                    {else}
                                    <th class="w15 cell-border">
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=total|ASC">{$lang.price}</a>
                                    </th>
                                    <th>
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=billingcycle|ASC">{$lang.bcycle}</a>
                                    </th>
                                {/if}
                                <th class="w15 cell-border">
                                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=next_due|ASC">{$lang.nextdue}</a>
                                </th>
                                <th class="w10 cell-border"></th>
                            </tr>
                            <tbody id="updater">

                                {include file='ajax/ajax.services.tpl'}

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>  <!-- Block A -->
            {/if}
        {/if}
        <div class="top-btm-padding">
            {if $cid}
                {foreach from=$offer item=oo}
                    {if $cid==$oo.id && $oo.visible=='1'}
                         {if $oo.name=='RV2Factor'}
                            {if $services.2.product_id == '58'}
                                {if $services.2.status == 'Active' || $services.2.status == 'Suspended' || $services.2.status == 'Expired'}
                                 <form method="post" action="{$ca_url}index.php?cmd=order2factorhb&action=gotoupgrade" style="display:inline-block;">
                                    <button class="clearstyle btn orange-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.Upgrade} {$oo.name}</button>
                                 </form>
                                 {/if}
                            {elseif $services.2.product_id == '59' && $services.2.status == 'Terminated'}
                            {else}
                                <form method="post" action="{$ca_url}clientarea/services/rv2factor/{$services.2.id}/&widget=symantecvip_manage&wid=75" style="display:inline-block;">
                                    <button class="clearstyle btn orange-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> Add {$oo.name} VIP account</button>
                                 </form>
                            {/if}
                         {else}
                         <div id="progressBar" style="display:none; width: 400px; height: 22px; border: 1px solid #111; background-color: #292929;">
                            <div style="height: 100%; color: #fff; text-align: right; line-height: 22px; width: 0; background-color: #0099ff;"></div>
                            <p></p>
                         </div>
                         <br />
                         <form method="post" action="{$ca_url}cart&cat_id={$cid}" style="display:inline-block;">
                            <button class="clearstyle btn orange-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.Add} {$oo.name}</button>
                         </form>
                         {/if}
                            {securitytoken}

                        {/if}
                    {/foreach}
                {/if}
                {if $totalpages && $opdetails.name != 'SSL'}
                <div class="pagination pagination-box">
                    <div class="right p19 pt0 no-margin">
                        <div class="pagelabel left ">{$lang.page}</div>
                        <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
                            {section name=foo loop=$totalpages}
                                <button class="btn {if $smarty.section.foo.iteration==1}active{/if}">{$smarty.section.foo.iteration}</button>
                            {/section}
                        </div>
                        <input type="hidden" id="currentpage" value="0" />
                    </div>
                </div>
                {else}
                {if $ssl_side_sort|@count > 0}
                    {assign var="size_sort" value=$ssl_side_sort|@count}
                    {assign var="totalpages" value=$size_sort/25|ceil}
                    {assign var="paginateSSLSort" value=$smarty.get.sort}
                {else}
                    {assign var="serviceSize" value=$services|@count}
                    {assign var="totalpages" value=$serviceSize/25|ceil}
                {/if}


                <form action="{$request_url}" method="POST">
                {if isset($smarty.get.orderby)}
                    <input name="orderby" type="hidden" value="{$smarty.get.orderby}" />
                    <input name="sort_type" type="hidden" value="{$smarty.get.sort_type}" />
                {/if}
                {if isset($smarty.get.sort)}
                    <input name="sort" type="hidden" value="{$smarty.get.sort}" />
                {/if}
                {if isset($smarty.post.search)}
                    <input name="search" type="hidden" value="{$smarty.post.search}" />
                {/if}
                <div class="pagination pagination-box">
                    <div class="right p19 pt0 no-margin">
                        <div class="pagelabel left ">{$lang.page}</div>
                        <div class="right" data-toggle="buttons-radio" id="pageswitch">
                            {section name=foo loop=$service_page}
                                <input name="service_page" {if $smarty.section.foo.iteration==$paginateSSL}style="cursor:default;" onclick="return false;"{/if} class="btn {if $smarty.section.foo.iteration==$paginateSSL}active{/if}" value="{$smarty.section.foo.iteration}" type="submit"></input>
                            {/section}
                        </div>
                        <input type="hidden" id="currentpage" value="0" />
                    </div>
                </div>
                </form>
            {/if}
        </div>
        {if $opdetails.slug == 'rv2factor'}
             <div class="text-block clear clearfix"> <!-- Block A -->
                <div class="clear clearfix">
                    <div class="table-box">

                        <a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
                        <table class="table table-striped table-hover">
                            <tr class="table-header-high">
                                <th class="w30"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=name|ASC">{$lang.service}</a></th>
                                {if $opdetails.slug == 'rv2factor'}
                                    <th class="w15"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=qty|ASC">VIP<br>Accounts</a></th>
                                {/if}
                                <th class="w15"><a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=status|ASC">{$lang.status}</a></th>
                                    {if $action=='vps'}
                                    <th class="w15 cell-border">
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=domain|ASC">{$lang.hostname}</a>
                                    </th>
                                    <th>{$lang.ipadd}</th>
                                    {else}
                                    <th class="w15 cell-border">
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=total|ASC">{$lang.price}</a>
                                    </th>
                                    <th>
                                        <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=billingcycle|ASC">{$lang.bcycle}</a>
                                    </th>
                                {/if}
                                <th class="w15 cell-border">
                                    <a href="{$ca_url}clientarea&amp;action={$action}&amp;cid={$cid}&amp;orderby=next_due|ASC">{$lang.nextdue}</a>
                                </th>
                                <th class="w10 cell-border"></th>
                            </tr>
                            <tbody id="updater">

                                {foreach from=$services item=service name=foo}
                                {if $service.product_id != 59 && $service.product_id != 58}
                                    <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
                                    <td><a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/">  <strong>{$service.name}</strong> </a>
                                        {if $service.domain!=''}<br/>
                                        <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" style="text-decoration:none">{$service.domain}</a> {/if} </td>
                                    <td class="cell-border">{$service.qty}</td>
                                    <td class="cell-border"><span class="label label-{$service.status}">{$lang[$service.status]}</span></td>
                                    <td class="cell-border">{$service.total|price:$currency}</td>
                                    <td class="cell-border">{$lang[$service.billingcycle]}</td>
                                    <td class="cell-border">{if $service.next_due!=0}{$service.next_due|date_format:'%d %b %Y'}{else}-{/if}</td>
                                    <td class="cell-border grey-c">
                                        {if $service.status=='Active' }
                                        <div class="btn-group">
                                            <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" class="btn dropdown-toggle" data-toggle="dropdown"><i class="icon-cog"></i> <span class="caret" style="padding:0"></span></a>
                                            <ul class="dropdown-menu"  style="right:0; left:auto;">
                                                <div class="dropdown-padding">
                                                    <li><a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" style="color:#737373">{$lang.servicemanagement}</a></li>
                                                    <li><a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/&cancel" style="color:#737373">{$lang.cancelrequest}</a></li>
                                                </div>
                                            </ul>
                                        </div>
                                        {else}
                                        <a href="{$ca_url}clientarea/{$action}/{$service.slug}/{$service.id}/" class="btn"><i class="icon-cog"></i></a>
                                        {/if}


                                    </td>
                                    </tr>
                                {/if}

                            {/foreach}

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>  <!-- Block A -->

            <div class="text-block clear clearfix"> <!-- Block A -->
                <div class="clear clearfix cart-order" >
                    <p class="pad">
                        RV2Factor for cPanel and Applications (Hostbill, WordPress, Joomla, and etc.).<br>
                        We’ll calculate the actual activated RV2Factor accounts from cPanel and Applications (not the quota you provided them) and bill you on the date 7th of every month.<br><br>

                        If you have the test account(s) for these Apps, you may remove it before the date 7th.

                     </p>
                </div>
            </div>
        {/if}
    {else}
        <div class="text-block clear clearfix">
            <h5>{$lang[$action]|capitalize}</h5>
            <div class="clear clearfix">
                <center>
                    <strong>{$lang.nothing}</strong>
                </center>
                {if $cid}
                    {foreach from=$offer item=oo}
                        {if $cid==$oo.id && $oo.visible=='1'}
                            <form method="post" action="{$system_url}cart&cat_id={$cid}">
                                <button class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> {$lang.Add} {$oo.name}</button>
                                {securitytoken}
                            </form>
                        {/if}
                    {/foreach}
                {/if}
            </div>
        </div>
    {/if}
{/if}


<script type="text/javascript">
{literal}
    $(document).ready(function(){

        var status = '{/literal}{php}echo $_REQUEST["status"];{/php}{literal}';
        if(status == 'Pending'){
            var error = 'Your account has a submitted order for RV2Factor already. You don’t need to make a new order ';
            error    += 'again, just wait for the order approval and license active by our staff.<br><br>';
            error    += 'Our staff will proceed the process as soon as possible. If this is longer than you can wait, please ';
            error    += 'submit a ticket to us for urgent:';
            error    += '<a href="https://rvglobalsoft.com/tickets/new/">https://rvglobalsoft.com/tickets/new/</a>';
            $('.alert-error').append(error);
            $('.alert-error').show();
        }
        else if(status == 'Active' || status == 'Expired'){
            var info = 'You have the existent RV2Factor account(s) already. To make a new order will duplicate the current one(s). Please check your RV2Factor account below.';


            $('.alert-info').append(info);

            $('.alert-info').show();
        }
    });
{/literal}
</script>