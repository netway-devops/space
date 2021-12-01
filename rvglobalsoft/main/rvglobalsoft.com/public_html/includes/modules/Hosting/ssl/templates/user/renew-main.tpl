{if isset($service.order_info.CertificateInfo.CanRenew) && $service.order_info.CertificateInfo.CanRenew}
{include_php file=$templatePath|cat:"renew-main.tpl.php"}
{include file=$templatePath|cat:"js/renew-main.js"}
{assign var=validity value=$price_summary.validity}

<div style="width:100%;" class="container body-client">
    <div id="step1">
        <p style="margin-top:29px;"><img src="{$template_dir}images/ssl/logo_v1.3_{$authorityId}.png" alt="" border="0" width="250px"/></p>
        <p class="title">{$service.ssl_name}</p>
        <div class="linebottom"></div>
        <br />
        <div>
            {$sslDetail.ssl_defail}
        </div>
        <p class="title">More Information</p>
        <div class="linebottom"></div>
        <br>
        <table align="center">
            <tr>
                <td width="50%"><img src="{$sslDetail.validation_img}" />&nbsp;<b>Validation:</b> {$service.domain_validation}</td>
                <td width="40%"><img src="{$sslDetail.insuance_time_img}" />&nbsp;<b>Insuance time:</b> {$sslDetail.issuance_time}</td>
            </tr>
            <tr>
                <td><img src="{$sslDetail.warranty_img}" />&nbsp;<b>Warranty:</b> ${$sslDetail.warranty|number_format:2}</td>
                <td><img src="{$sslDetail.green_addressbar_img}" />&nbsp;<b>Green Address Bar:</b> {if $sslDetail.green_addressbar}Yes{else}No{/if}</td>
            </tr>
            <tr>
                <td><img src="{$sslDetail.secure_subdomain_img}" />&nbsp;<b>Secure sub-domains:</b> {if $sslDetail.secure_subdomain}Yes{else}No{/if}</td>
                <td><img src="{$sslDetail.support_for_san_img}" />&nbsp;<b>Support for SAN (UC):</b> {if $sslDetail.support_for_san}Yes{else}No{/if}</td>
            </tr>
            <tr>
                <td><img src="{$sslDetail.reissue_img}" />&nbsp;<b>Free Reissue:</b> {if $sslDetail.reissue}Yes{else}No{/if}</td>
                <td><img src="{$sslDetail.licensing_multi_server_img}" />&nbsp;<b>Unlimited server license:</b> {if $sslDetail.licensing_multi_server}Yes{else}No{/if}</td>
            </tr>
            <tr>
                <td><img src="{$sslDetail.malware_scan_img}" />&nbsp;<b>Malware Scanning:</b> {if $sslDetail.malware_scan}Yes{else}No{/if}</td>
                <td><img src="{$sslDetail.secureswww_img}" />&nbsp;<b>Secures both with/without WWW:</b> {if $sslDetail.secureswww}Yes{else}No{/if}</td>
            </tr>
        </table>
        <p class="title">Order Summary</p>
        <div class="linebottom"></div>
        <br>
        <form action="?cmd=module&module=ssl&action=upload_csr" method="post" enctype="multipart/form-data" id="form_upload_csr" name="form_upload_csr" onsubmit="return false;">
            <input type="file" id="upload_csr" name="upload_csr" style="visibility: hidden; width: 1px; height: 1px" multiple />
            <input name="submit_upload_csr" id="submit_upload_csr" type="submit" style="visibility: hidden;width: 1px; height: 1px"/>
        </form>
        <form id="renewForm" action="{$ca_url}clientarea/services/ssl/{$service.id}&action=renew" method="POST">
        <input type="hidden" id="orderInfo" value=""/>
        <input type="hidden" id="clientId" name="clientId" value="{$service.client_id}"/>
        <input type="hidden" id="orderId" name="orderId" value="{$service.order_id}"/>
        <input type="hidden" id="acctId" name="acctId" value="{$service.id}"/>
        <input type="hidden" id="supportSAN" value="{$supportSAN}" />
        <input type="hidden" id="domainName" value="{$service.domain}" />
        <input type="hidden" id="discount" value="{if $ssl_renew_discount}{$ssl_renew_discount|@json_encode|replace:'"':'\''}{/if}" />
        <input type="hidden" id="pid" value="{$product_id}" />
        <input type="hidden" id="ssl_id" value="{$service.ssl_id}" />
        <table width="100%">
            <tr>
                <td width="50%">
                    <table>
                        <tr valign="top">
                            <td>{$productPrice.a}</td>
                            <td>{$productPrice.b}</td>
                            <td>{$productPrice.t}</td>
                        </tr>
                    </table>
                </td>
                <td width="50%" valign="top">
                    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="boxTable">
                        <tr>
                            <td colspan="2">
                                <div class="title">Price Summary</div>
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <th class="cellService">
                                <div style="font-size:18px; margin-bottom:5px;">Service</div>
                            </th>
                            <th class="cellPrice">
                                <div style="font-size:18px; margin-bottom:5px;" align="center">Price</div>
                            </th>
                        </tr>
                        <tr>
                            <td class="cellService">{$service.ssl_name} ( <span id="price_summary_num_year">{$price_summary.validity_num/12}</span> Year<span id="price_summary_year_text">{if $price_summary.validity_num/12 > 1}s{/if}</span> )</td>
                            <td class="cellPrice"><div align="right">$<span id="price_summary_product_price">{$price_summary.$validity.product_price|number_format:2}</span> USD</div></td>
                        </tr>
                        {if $price_summary.$validity.san_amount > 0}
                        <tr>
                            <td class="cellService">Additional Domain{if $price_summary.$validity.san_amount > 1}s{/if} x {$price_summary.$validity.san_amount}</td>
                            <td class="cellPrice"><div align="right">$<span id="price_summary_san_price">{$price_summary.$validity.san_price|number_format:2}</span> USD</div></td>
                        </tr>
                        {/if}
                        {if $price_summary.$validity.server_amount > 0}
                        <tr>
                            <td class="cellService">Additional Server{if $price_summary.$validity.server_amount > 1}s{/if} x {$price_summary.$validity.server_amount}</td>
                            <td class="cellPrice"><div align="right">$<span id="price_summary_server_price">{$price_summary.$validity.server_price|number_format:2}</span> USD</div></td>
                        </tr>
                        {/if}
                        {if $ssl_renew_discount}
                            <tr id="renew_discount">
                                <td class="cellService">Discount :</td>
                                <td class="cellPrice"><div align="right">$<span id="price_summary_server_price">-{$ssl_renew_discount.discount|number_format:2}</span> USD</div></td>
                            </tr>
                        {/if}
                        <tr>
                            <td class="cellService">
                                <div align="right"><b>Total</b></div>
                            </td>
                            <td class="cellPrice">
                                <div align="right">
                                    <b>$<span id="totalShow">
                                    {if isset($ssl_renew_discount.discount)}
                                        {$price_summary.$validity.total-$ssl_renew_discount.discount|number_format:2}
                                    {else}
                                        {$price_summary.$validity.total|number_format:2}
                                    {/if}
                                    </span> USD</b>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br><br><br>
        <p class="title" style="margin-top:-20px;width:48%;float:left;">
            SSL Certificate Signing Request (CSR)
        </p>
        <div style="margin-top:-20px; width:50%;float:right; text-align:right;">
            <a target="_blank" href="{$system_url}{$ca_url}knowledgebase/article/15/what-is-csr/">
                <u>What is a CSR?  </u>
            </a>
             |
            <a target="_blank" href="https://rvssl.com/generate-csr/">
                <u> How to generate CSR?</u>
            </a>
        </div>

        <p class="linebottom"></p>
        <div class="bgvalidate_CSR">
            <div style="margin:10px;">
                <div id="submitcsrlater">
                    <div>
                        <br>
                        <input type="radio" name="submitCSROption" id="submitCSROption0" value="0" checked="checked" />
                        <label for="submitCSROption0">
                            &nbsp;Use the current order information.
                            <br>
                            <div style="padding:10px 0;">I will proceed this renew with the current order information from previous.</div>
                        </label>
                    </div>
                </div>
                <br>
                <div id="submitcsrnow">
                    <div>
                        <input type="radio" name="submitCSROption" id="submitCSROption1" value="1" />
                        <label for="submitCSROption1">
                            &nbsp;Use the new order information. <a style="color: #0088cc; display: none" id="editCSR">View/Edit CSR</a>
                            <br>
                            <div style="padding:10px 0;">I need to edit some information of the order for this renewal.</div>
                        </label>
                    </div>
                </div>
                <div class="format_textarea" style="display: none">
                    <div class="title" style="margin-top:24px;width:48%;float:left;">
                        Certificate Signing Request (CSR)
                    </div>
                    <br clear="all" />
                    <br>
                    <div>
                        A Certificate Signing Request or "CSR" is required for SSL Certificate issuance. Please generate CSR on your server and submit in the following box. RSA or ECC-based CSR are acceptable.
                    </div>
                    <br>
                    <div>
                         <input class="clearstyle btn orange-custom-btn l-btn" onclick="$('#upload_csr').click();" type="button" value="Upload CSR" style="margin-bottom:5px; background:#3285cb; border:1px solid #3285cb;"/>
                          or Paste one below :
                    </div>
                    <textarea rows="6" id="csr_data" name="csr_data"></textarea>
                    <div>
                        Server software :
                        <select id="servertype" name="servertype" >
                            <option value="Other"{if $server_type == 'Other'} selected{/if}>Other</option>
                            <option value="IIS"{if $server_type == 'IIS'} selected{/if}>Microsoft IIS (all versions)</option>
                        </select>
                    </div>
                    <div>
                        Hashing Algorithm :
                        <select id="hashing" name="hashing" style="width: auto;">
                            {foreach from=$hashing_data key=hashingKey item=hashingValue}
                            {if $hashingValue.visible}<option value="{$hashingKey}"{if !$hashingValue.enable} disabled{elseif ($hashing_algorithm == 'SHA2-256' && $hashingKey == 'SHA256-FULL-CHAIN') || ($hashing_algorithm == $hashingKey)} selected{/if}>{$hashingValue.name}</option>{/if}
                            {/foreach}
                        </select>
                    </div>
                    <div>
                        The new security standard will be forcing any SSL Certificates expiring on January 1, 2017 and after, to be issued with Certificate Algorithm as SHA-2, whether list above selected as SHA-2 or not.
                    </div>
                    <div style="padding-left: 19px"></div><br>
                    <div id="progressBar"></div>
                    <div id="err" style="display:none;"><font color="red">Error : </font><font id="errMessage" color="red"></font></div>
                    <br>
                    <div><input id="validate_button" type="button" value="Continue" ></div>
                    <br/>
                </div>
                <div class="information_textarea" style="display: none;">
                    {include file=$templatePath|cat:"renew-step2.tpl"}
                </div>
                <br>
                <button type="button" id="addtocart" class="clearstyle btn orange-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> Add To Cart </button>
            </div>
        </div>
    </div>
    <div id="step2" style="display:none;">
        {include file=$templatePath|cat:"renew-checkout.tpl"}
    </div>
    </form>
</div>
<br><br><br><br><br>
<style>
{literal}
#progressBar {
        width: 400px;
        height: 22px;
        border: 1px solid #111;
        background-color: #292929;
}
#progressBar div {
        height: 100%;
        color: #fff;
        text-align: right;
        line-height: 22px;
        width: 0;
        background-color: #0099ff;
}
{/literal}
</style>
{else}
<br>
<div align="center"><font color="red">This product is not in the renewal period yet.</font></div>
{/if}
