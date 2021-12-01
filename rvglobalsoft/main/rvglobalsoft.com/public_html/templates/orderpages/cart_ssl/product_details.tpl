{php}
include_once $this->template_dir . '/cart_ssl/product_details.tpl.php';
$templatePath = $this->get_template_vars('template_path');
$product_details_javascript = $templatePath . '../orderpages/cart_ssl/product_details_javascript.tpl';
$product_details_information = $templatePath . '../orderpages/cart_ssl/product_details_information.tpl';
$product_details_csrmodule = $templatePath . '../orderpages/cart_ssl/product_details_csrmodule.tpl';
$this->assign('product_details_javascript', $product_details_javascript);
$this->assign('product_details_information', $product_details_information);
$this->assign('product_details_csrmodule', $product_details_csrmodule);
{/php}
{include file=$product_details_javascript}

<div class="container">     <!-- open div class content  -->
    <div class="col-md-12">
        <p style="float:right;">
            <select id="change_ssl">
                <option>Change SSL</option>
                {foreach from=$aSSLbyprice key="kSSLbyprice" item="vSSLbyprice"}
                <option value="{$vSSLbyprice->ssl_id}" {if $smarty.get.ssl_id == $vSSLbyprice->ssl_id}selected="selected"{/if}>{$vSSLbyprice->ssl_name}</option>
                {/foreach}
            </select>
        </p>
        <p style="margin-top:29px;"><img src="{$template_dir}images/ssl/logo_v1.3_{$aSSL.ssl_authority_id}.png" alt="" border="0" width="250px"/></p>
        <p class="title" style="margin-top:24px;">{$aSSL.ssl_name}</p>
        <p class="linebottom"></p>
        <div class="content">
            {$aSSL.ssl_defail}
        </div>
    </div>
    
    <div class="col-md-12">
        <p class="title" style="margin-top:24px;">More Information</p>
        <p class="linebottom"></p>
        {include file=$product_details_information}
    </div>
    
    <div class="clear"></div>
    <div class="col-md-12">
        <p class="title" style="margin-top:24px;">Order Summary</p>
        <p class="linebottom"></p>
    </div>
    
    <form action="?cmd=module&module=ssl&action=upload_csr" method="post" enctype="multipart/form-data" id="form_upload_csr" name="form_upload_csr" onsubmit="return false;">
        <input type="file" id="upload_csr" name="upload_csr" style="visibility: hidden; width: 1px; height: 1px" multiple />
        <input name="submit_upload_csr" id="submit_upload_csr" type="submit" style="visibility: hidden;width: 1px; height: 1px"/>
    </form>
    
    <form method="post" action="{$ca_url}cart/ssl" name="frmMr" id="frmMr" >
        <input type="hidden" id="varidate" name="varidate" value="{$aSSL.ssl_validation_id}" />
        <input type="hidden" id="ssl_id" name="ssl_id" value="{$ssl_id}" />
        <input type="hidden" id="url_template" name="url_template" value="{$template_dir}" />
        <input type="hidden" id="url_ca" name="url_ca" value="{$ca_url}" />
        <input type="hidden" id="rvaction" name="rvaction" value="order" />
        <input type="hidden" id="commonname" name="commonname" value="" />
        <input type="hidden" id="ssl_name" name="ssl_name" value="{$aSSL.ssl_name}" />
        
        <input type="hidden" id="ssl_validation_id" name="ssl_validation_id" value="{$aSSL.ssl_validation_id}" />
        <input type="hidden" id="isSSLOrder" name="isSSLOrder" value="1" />
        
        <input type="hidden" id="sanInclude" value="{$sanInclude}" />
        <input type="hidden" id="support_san" name="support_san" value="{$support_san}" />
        <input type="hidden" id="dns_name" name="dns_name" value="" />
        <input type="hidden" id="promo_code_used" name="promo_code_used" value="0" />
        <input type="hidden" id="promo_code_code" name="promo_code_code" value="" />
        <input type="hidden" id="promo_code_data" name="promo_code_data" value='' />
        <input type="hidden" id="cid" value='{$client_login_id}' />
        <input type="hidden" id="wild_card" value='{$is_wild_card}' />
        
        <div>     <!-- open div price & server  -->      
            <div class="select_price" align="left" style="margin-left: 15px; width:100%;">
             <table width="100%"> <!--class="wbox_content"-->
                <tr> 
                    <td width="50%">
                        <table width="30%">
                            <tr>
                            {foreach from=$aSSL._Price key="k" item="v"}                                                
                                {if $k==$selectConract}
                                 <td align="center"><input type="radio" class="priceClass" id="price_id_{$k}" style="display:none;" name="ssl_price" value="{$k}" checked="checked" />
                                {else}
                                <td align="center"><input type="radio" class="priceClass" id="price_id_{$k}" style="display:none;" name="ssl_price" value="{$k}" />
                                {/if}
                                <label for="price_id_{$k}">
                                    <div id="priceBox{$k}" class="priceBox" style="vertical-align:top; border-radius: 10px; border:4px solid {if $k==$selectConract}#73c90e{else}grey{/if}; margin-right:15px; width: 120px; {if $k == 12}margin-top:-19px;{/if}">
                                        <p id="priceHead{$k}" class="priceHead" style="border-radius: 5px 5px 0 0; background-color:{if $k==$selectConract}#7ed320{else}black{/if}"><font color="white">{$k/12} Year{if $k/12 > 1}s{/if}</font></p>
                                        <p style="border-radius: 0 0 5px 5px;" >${$v}</p>
                                        <input type="hidden" id="priceNum{$k}" value="{$v|number_format:2}" />
                                    </div>
                                    <div align="center" style="margin-right:15px; width: 120px;">    
                                        <font class="priceSave" id="priceSave{$k}" {if $k == $selectConract}color="#7ed320"{/if}>                
                                        {if $k == 24}
                                            Save ${assign var=dis2y value=$discount*2-$v}{$dis2y|number_format:2}</font>
                                        {elseif $k == 36}
                                            Save ${assign var=dis3y value=$discount*3-$v}{$dis3y|number_format:2}
                                        {/if}
                                        </font>
                                    </div>
                                    <!--{$v} USD / {if $k==12}{assign var=discount value=$v} 1 Year <br>{elseif $k==24} 2 Years <br><font color=orange>Save ${assign var=dis2y value=$discount*2-$v}{$dis2y|number_format:2}</font>{elseif $k==36} 3 Years <br><font color=orange>Save ${assign var=dis3y value=$discount*3-$v}{$dis3y|number_format:2}</font>{/if}-->
                                </label><br/></td>
                            {/foreach}
                            </tr>
                        </table>
                        {if $support_san}
                            {if $sanMax > 0}
                            Domain Included : {$sanInclude}
                            <br /><br />
                            
                            <a href="javascript:void(0);" class="showSAN">+ Buy more additional domains<br /></a>
                            <div class="hidSAN" style="display:none;">
                            <a id="cancelSAN" href="javascript:void(0);">- Less<br></a>
                            <!-- <img id="cancelSAN" style="cursor: pointer;" src="{$system_url}templates/netwaybysidepad/images/non.png">-->
                            
                            Additional Domains : <br />
                            <select id="additional_domain" name="additional_domain" style="width:140px;">
                            {section name=dcount start=0 loop=$sanMax+1 step=1}
                                <option value="{$smarty.section.dcount.index}">{$smarty.section.dcount.index}</option>
                            {/section}
                            </select>
                             x $<span id="sanInfoPrice">{$sanPrice.$selectConract|number_format:2}</span> USD / Domain / <span id="perYear">{$selectConract/12} year{if $selectConract/12 > 1}s{/if}</span>
                            </div>
                            {else}
                            Domain Included : {$sanInclude}
{if false}                            <p>Additional Domains : None</p>{/if}
                            <input id="additional_domain" name="additional_domain" type="hidden" value="0" />
                            {/if}
                            
                            <br />
                            Included server to secure : {if $servMax > 1}1{else}<font color="green">Unlimited</font>{/if}
                            <br /><br />
                            {if $servMax > 1}

                            <a href="javascript:void(0);" class="showSERV">+ Buy more additional servers</a>
                            <div class="hidSERV" style="display:none;">
                            <!-- <img id="cancelSERV" style="cursor: pointer;" src="{$system_url}templates/netwaybysidepad/images/non.png"> -->

                            <a id="cancelSERV" href="javascript:void(0);">- Less<br></a>
                            Additional server to secure : <br />
                            <select id="additional_server" name="additional_server" style="width:140px;">
                            {section name=acount start=1 loop=$servMax+1 step=1}
                                <option value="{$smarty.section.acount.index}">{$smarty.section.acount.index-1}</option>
                            {/section}
                            </select>
                            </div>
                            {elseif false}
                            <p>How many Server to secure : <font color="green">Unlimited</font></p>
                            <input id="additional_server" name="additional_server" type="hidden" value="0" />
                            <br />
                            {/if}
                            
                            <br /><br />
                            
{if false}                            <div style="font-size:22px;">Total : $<span id="totalShow">{$firstPrice|number_format:2}</span></div>{/if}
                            <br />
                            <input id="totalPrice" type="hidden" name="totalPrice" value="{$firstPrice|number_format:2}" />
                            <input id="selectedPrice" type="hidden" value="{$firstPrice|number_format:2}" />
                            
                        {else}
{if false}                            <div style="font-size:22px;">Total : $<span id="totalShow">{$firstPrice|number_format:2}</span></div>{/if}
                            <input id="totalPrice" type="hidden" name="totalPrice" value="{$firstPrice|number_format:2}" />
                            <input id="selectedPrice" type="hidden" value="{$firstPrice|number_format:2}" />
                        {/if}
                        <td valign="top">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="boxTable">
                                <tr>
                                    <td colspan="2">
                                        <div class="title">Price Summary</div><br />
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
                                    <td class="cellService">
                                        <div>
                                            {$aSSL.ssl_name} ( <span id="price_summary_product_year">{$selectConract/12} Year{if $selectConract/12 > 1}s{/if}</span> )
                                        </div>
                                    </td>
                                    <td class="cellPrice">
                                        <div align="right">
                                            $<span id="price_summary_product_price">{$firstPrice|number_format:2}</span> USD
                                        </div>
                                    </td>
                                </tr>
                                {if $support_san}
                                    {if $sanMax > 0}
                                    <tr>
                                        <td class="cellService">
                                            <div class="hidSAN">
                                                Additional Domain<span id="price_summary_san_plural"></span> x <span id="price_summary_san_num">0</span>
                                            </div>
                                        </td>
                                        <td class="cellPrice">
                                            <div align="right" class="hidSAN">
                                                $<span id="price_summary_san_price">0.00</span> USD
                                            </div>
                                        </td>
                                    </tr>
                                    {/if}
                                    {if $servMax > 1}
                                    <tr>
                                        <td class="cellService">
                                            <div class="hidSERV">
                                                Additional Server<span id="price_summary_server_plural"></span> x <span id="price_summary_server_num">0</span>
                                            </div>
                                        </td>
                                        <td class="cellPrice">
                                            <div align="right" class="hidSERV">
                                                $<span id="price_summary_server_price">0.00</span> USD
                                            </div>
                                        </td>
                                    </tr>
                                    {/if}
                                {/if}
                                <tr>
                                    <td class="cellService" colspan="2">
                                        <div align="right">
                                            <a href="javascript:void(0);" id="promo_code_link"/><strong>Use promotional code</strong></a>
                                            <div style="display:none;" id="promo_code_div">
                                                Code: 
                                                <input type="text" id="promo_code_text" style="margin-top: 14px;"/>
                                                <input type="button" id="promo_code_submit" value="»">
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cellService">
                                        <div class="promo_code_discount_div" style="display:none;">
                                            Promotional code: <b><span id="promo_code_name"></span></b>
                                        </div>
                                    </td>
                                    <td class="cellPrice">
                                        <div align="right" class="promo_code_discount_div" style="display:none;">
                                            - $<span id="promo_code_discount"></span> USD
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cellService">
                                        &nbsp;
                                    </td>
                                    <td class="cellPrice">
                                        <div align="right" class="promo_code_discount_div" style="display:none;">
                                            <a href="javascript:void(0);" id="promo_code_remove" style="font-size:12px">Remove discount code</a>
                                        </div>
                                    </td>                                    
                                </tr>
                                <tr class="promo_code_discount_div" style="display:none;"><td>&nbsp;</td></tr>
                                <tr>
                                    <td class="cellService" colspan="2">
                                        <div align="left"><span id="promo_code_error" style="color:red; padding-left:30px;"></span></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border-top: 1px solid #CCCCCC; padding-top:10px;" class="cellService">
                                        <div align="right"><b>Total</b></div>
                                    </td>
                                    <td style="border-top: 1px solid #CCCCCC; padding-top:10px;" class="cellPrice">
                                        <div align="right">
                                            <b>$<span id="totalShow">{$firstPrice|number_format:2}</span> USD</b>
                                        </div>
                                    </td>
                                </tr>
                            </table><!-- End boxTable -->
                        </td>
                    </tr>
                </table>
                {if $chksession}
                {if $support_san}
                    <div align="center"><input id="nextButton" type="button" class="clearstyle btn green-custom-btn l-btn" value="&nbsp;&nbsp;Next Step&nbsp;&nbsp;" /></div>
                {/if}
                
                </div>
            <div class="rvclear"></div>
            
<!--{if $aSSL.ssl_authority_id =='1'|| $aSSL.ssl_authority_id =='5'}
            <div class="title" style="margin-top:24px;">Server:</div>      
            <div class="select_server" style="margin-top:3px;">
                <select name="servertype">
                    <option value="Other">Other</option>
                    <option value="Microsoft IIS (all versions)">Microsoft IIS (all versions)</option>
                </select>
            </div>
{/if}-->
        
    
        
        </div>      <!-- close div price & server  -->  
    {include file=$product_details_csrmodule}   
    </form>
    {else}
    </div></div></div></form>
    <div class="col-md-12">
        <p class="title" style="margin-top:24px;">Login</p>
        <p class="linebottom"></p>
    </div>
    <script type="text/javascript">
        {literal}
        $('#nextButton').hide();
        {/literal}
    </script>
    {include file='cart_ssl/product_login.tpl'}
    {/if}
</div>          <!-- close div class content -->