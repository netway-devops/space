{php}
     include_once $this->template_dir . '/cart_ssl/product_list.tpl.php';
{/php}
{include file="cart_ssl/product_list_javascript.tpl"}
<!-- <img src="{$template_dir}/images/rvssl-banner-endoffifteen.jpg" style="width: 100%; height: 275px;"/> -->
<div class="container">

    <div class="bgcontent">
        <h2 class="txttitle">Product list</h2>
        <p>Select SSL &gt; CSR &gt; Payment</p>

    <div>
        {include file="cart_ssl/product_list_searchmodule.tpl"}
    </div>

    <div id="content">

        <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
            <li class="active"><a href="#tabs-prices" data-toggle="tab">Prices</a></li>
            <li><a href="#tabs-properties" data-toggle="tab">Properties</a></li>
        </ul>

{literal}<style type="text/css">

table th{
    background:#010101;
    padding:8px 10px;
    color:#FFFFFF;
    font-size:16px;
    text-align:center;
    font-weight:normal;
}

table th.bg{
    background:#262626;
}

table th.arrow-tab{
    background:#262626 url({/literal}{$template_dir}{literal}/images/arrow-tab.png) no-repeat -7px center;
}
table th.arrow-tab2{
    background:#010101 url({/literal}{$template_dir}{literal}/images/arrow-tab2.gif) no-repeat -7px center;
}
table th.arrow-tab3{
    background:#010101 url({/literal}{$template_dir}{literal}/images/arrow-tab3.gif) no-repeat left center;
}

table.properties th{
    font-size:14px;
    font-weight:normal;
    vertical-align:middle;
}
.bgheadTable1{
	border-right:#1a1919 solid 1px;
}

.promotion {
    transition: color 10ms ease;
    font-family: Tahoma;
    background-color: yellow;
    border-radius: 5px;
    padding: 1px 3px 1px 3px;
}

.promotion.blink {
    color: yellow;
    background-color: #F08800;
    border-radius: 5px;
    padding: 1px 3px 1px 3px;
}
.endoffifteen{
    border-radius: 5px;
    background-color:#ffd285;
    font-family: Tahoma;
    font-size:13px;
}

</style>{/literal}
        <div id="my-tab-content" class="tab-content">
            <!-- price tabs -->
            <div class="tab-pane active" id="tabs-prices">
                <table class="table table-striped">
                    <!--
                    <thead>
                        <tr>
                            <th class="bg" style="text-align:center; padding-bottom:17px;">Product Name</th>
                            <th width="23%" class="arrow-tab" style="text-align:center; padding-bottom:17px;"><a id="aValidate" href="{$now_url}{if $nowSort != 'validation'}&sort=validation{/if}">Validation</a></th>
                            <th width="15%" class="arrow-tab" style="text-align:center; padding-bottom:17px;">Assurance</th>
                            <th width="8%" class="arrow-tab2" style="text-align:center;">1 Year</th>
                            <th width="8%" style="text-align:center;"><a href="{$now_url}{if $nowSort != 'price'}&sort=price{/if}">Price</a><br />2 Year</th>
                            <th width="8%" style="text-align:center;">3 Year</th>
                            <th width="8%" style="text-align:center;">SAN</th>
                            <th width="8%" style="text-align:center;"></th>
                        </tr>
                    </thead>
                    -->

                    <tr>
                        <td rowspan="2" class="bgheadTable1">Product Name</td>
                        <td rowspan="2" width="23%" class="bgheadTable1">
                            <a id="aValidate" class="sortby" href="{$system_url}{$ca_url}cart/ssl{if $nowSort != 'validation'}&sort=validation{/if}">Validation
                            <i class="icon-resize-vertical icon-white"></i></a>
                        </td>
                        <td rowspan="2" width="15%" class="bgheadTable1">Assurance</td>
                        <td colspan="5" width="8%" class="bgheadTable2">
                            <a class="sortby" href="{$system_url}{$ca_url}cart/ssl{if $nowSort != 'price'}&sort=price{/if}">Price (USD)
                            <i class="icon-resize-vertical icon-white"></i></a>
                        </td>
                    </tr>
                    <tr>
                        <td width="8%" class="bgheadTable2">1 Year</td>
                        <td width="8%" class="bgheadTable2">2 Year</td>
                        <!-- <td width="8%" class="bgheadTable2">3 Year</td> -->
                        <td width="8%" class="bgheadTable2">SAN</td>
                        <td width="8%" class="bgheadTable2"></td>
                    </tr>


                    <div id="pNormal">
                    <tbody class="searchable">
                        {foreach from=$aSSLbyprice key="kSSLbyprice" item="vSSLbyprice"}
                        {if $vSSLbyprice->ssl_name == 'Rapid SSL' || $vSSLbyprice->ssl_name == 'Thawte SSL123' || $vSSLbyprice->ssl_name == 'GeoTrust QuickSSL Premium' || $vSSLbyprice->ssl_name == 'Symantec Secure Site'}
                                {assign var=promo value=0}
                            {else}
                                {assign var=promo value=0}
                            {/if}
                        <tr class="pNor">
                            <td{if $promo} style="padding-top:18px;"{/if}>{$vSSLbyprice->ssl_name}{if $promo} <font class="promotion" color="#f08800"><b>SALE</b></font>{/if}</td>
                            <td{if $promo} style="padding-top:18px;"{/if}>{$vSSLbyprice->validation_name}</td>
                            <td style="text-align:center;">{$vSSLbyprice->ssl_assurance}</td>
                            <td style="text-align:center;">
                                {if $promo}
                                    <div class="endoffifteen">SALE</div>
                                {/if}
                                {if $vSSLbyprice->oneyear != '-'} {$vSSLbyprice->oneyear|number_format:2}{else}-{/if}
                            </td>
                            <td style="text-align:center;{if $promo}padding-top:18px;{/if}">{if $vSSLbyprice->twoyear == '0.00'}-{else}{$vSSLbyprice->twoyear|number_format:2}{/if}</td>
                            <!-- <td style="text-align:center;{if $promo}padding-top:18px;{/if}">{if $vSSLbyprice->threeyear == '0.00'}-{else}{$vSSLbyprice->threeyear|number_format:2}{/if}</td> -->
                            <td style="text-align:center;{if $promo}padding-top:18px;{/if}">{if $vSSLbyprice->san_oneyear == '0.00'}-{else}{$vSSLbyprice->san_oneyear|number_format:2}{/if}</td>
                            <td style="text-align:center;">
                                <button type="button" onclick="location.href = '{$ca_url}cart/ssl&amp;rvaction=chklogin&amp;ssl_id={$vSSLbyprice->ssl_id}';" style="background:#83d507; border-color:#83d507;" class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> Buy </button>
                            </td>
                        </tr>
                        {/foreach}
                    </tbody>
                    </div>
                </table>

            </div>
            <!-- end price tabs -->

            <!-- properties tabs -->
            <div class="tab-pane" id="tabs-properties">
                <table class="table table-striped properties">
                    <thead>
                        <tr>
                            <th class="aleft" style="text-align:center;">Product Name</th>
                            <th width="15%" class="arrow-tab3" style="text-align:center;">ECC: Strongest Security</th>
                            <th width="12%" style="text-align:center;">Free Reissue</th>
                            <th width="10%" style="text-align:center;">Green Address Bar</th>
                            <th width="10%" style="text-align:center;">Secures both<br />with/without WWW</th>
                            <th width="10%" style="text-align:center;">Unlimited<br />server license</th>
                            <th width="10%" style="text-align:center;">Malware Scanning</th>
                            <th width="8%" style="text-align:center;"></th>
                        </tr>
                    </thead>
                    <tbody class="searchable">
                        {foreach from=$aSSLbyproperty key="kSSLbyproperty" item="vSSLbyproperty"}
                        <tr>
                            <td style="text-align:left;">{$vSSLbyproperty->ssl_name}</td>
                            <td style="text-align:center;">{if $vSSLbyproperty->strongest_security}<img src="{$template_dir}/images/ssl/checked.png"/>{else}<img src="{$template_dir}/images/ssl/non.png"/>{/if}</td>
                            <td style="text-align:center;">{if $vSSLbyproperty->free_reissue}<img src="{$template_dir}/images/ssl/checked.png"/>{else}<img src="{$template_dir}/images/ssl/non.png"/>{/if}</td>
                            <td style="text-align:center;">{if $vSSLbyproperty->green_addressbar}<img src="{$template_dir}/images/ssl/checked.png"/>{else}<img src="{$template_dir}/images/ssl/non.png"/>{/if}</td>
                            <td style="text-align:center;">{if $vSSLbyproperty->secureswww == '-1'}-{else}{if $vSSLbyproperty->secureswww}<img src="{$template_dir}/images/ssl/checked.png"/>{else}<img src="{$template_dir}/images/ssl/non.png"/>{/if}{/if}</td>
                            <td style="text-align:center;">{if $vSSLbyproperty->licensing_multi_server}<img src="{$template_dir}/images/ssl/checked.png"/>{else}<img src="{$template_dir}/images/ssl/non.png"/>{/if}</td>
                            <td style="text-align:center;">{if $vSSLbyproperty->malware_scan}<img src="{$template_dir}/images/ssl/checked.png"/>{else}<img src="{$template_dir}/images/ssl/non.png"/>{/if}</td>
                            <td style="text-align:center;">
                                 <button type="button" onclick="location.href = '{$ca_url}cart/ssl&amp;rvaction=chklogin&amp;ssl_id={$vSSLbyproperty->ssl_id}';" style="background:#83d507; border-color:#83d507;" class="clearstyle btn green-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> Buy </button>
                            </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            <!-- end properties tabs -->
            </div>
        </div>

</div>

