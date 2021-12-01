<div id="nextStep" class="col-md-12" {if $support_san} style="display:none;"{/if}> <!-- open div csr content -->
    <p class="title" style="margin-top:24px;width:48%;float:left;">SSL Certificate Signing Request (CSR)</p>
    <div style="margin-top:24px; width:50%;float:right; text-align:right;"><a target="_blank" href="https://rvglobalsoft.com/knowledgebase/article/15/what-is-csr/"><u>What is a CSR?  </u></a> | <a target="_blank" href="https://rvssl.com/generate-csr/"><u> How to generate CSR?</u></a></div>
    <br clear="all" />
    <!--<div class="bgdetail_SSLCSR" style=" background-color: #FFB253">
    </div>-->
    <input type="hidden" id="client_login_id" value="{$client_login_id}" />
        <p class="linebottom"></p>
        <div class="bgvalidate_CSR">
            <div>
                <!--<div id="submitcsrlater">
                    <div><br><input type="radio" name="submitCSROption" id="submitCSROption0" value="0"  checked="checked"/><label for="submitCSROption0">&nbsp;I want to submit CSR later</label></div>
                    <div style="padding:10px 0;">You can complete this order without CSR submitted. To submit CSR later, please access to your account
                    <a href="https://rvglobalsoft.com/clientarea">https://rvglobalsoft.com/clientarea</a> -> Services -> SSL.</div>
                </div>-->
                <br>
                <div id="submitcsrnow">
                    <div><input type="radio" name="submitCSROption" id="submitCSROption1" value=""  checked /><label for="submitCSROption1">&nbsp;I would like to provide my CSR and auto-fill names now. <a style="color: #0088cc; display: none" id="editCSR">View/Edit CSR</a></label></div>
                    <div id="toselect" style="padding:10px 0;">To select this, you'll be required to submit CSR in the next step.</div>
                </div><br>
                    <div class="format_textarea" >
                        <div class="title" style="margin-top:24px;width:48%;float:left;">Certificate Signing Request (CSR)</div><br clear="all" /><br>
                        <div>A Certificate Signing Request or "CSR" is required for SSL Certificate issuance. Please generate CSR on your server and submit in the following box. RSA or ECC-based CSR are acceptable.</div><br>
                        <div>
                             <input class="clearstyle btn green-custom-btn l-btn" onclick="$('#upload_csr').click();" type="button" value="Upload CSR" style="margin-bottom:5px; background:#3285cb; border:1px solid #3285cb;"/>
                              or Paste one below : </div>
                        <textarea rows="6" id="csr_data" name="csr_data">{if isset($REQUEST.csr)}{$REQUEST.csr}{/if}</textarea>
                        <p>Server software :</p>
                        <div>
                        <select name="servertype">
                            <option value="Other">Other</option>
                            <option value="IIS">Microsoft IIS (all versions)</option>
                        </select>
                        </div>
                        <p>Hashing Algorithm : <br><font color="#c31818">*For best RSA browser compatibility, choose the SHA-256 with RSA and SHA-1 root option.</font></p>
                        <div>
                        <select id="hashing" name="hashing" style="width:auto;">
                            {assign var="hashingcount" value="0"}
                        	{foreach from=$hashing_data|@array_reverse key=hashingKey item=hashingValue}
                            {if $hashingValue.visible}<option value="{$hashingKey}"{if !$hashingValue.enable} disabled{elseif $hashingcount == "0"} selected{assign var="hashingcount" value="1"}{/if}>{$hashingValue.name}</option>{/if}
                            {/foreach}
                        </select>
                        </div>
                        <div> </div>
                        <div style="padding-left: 19px"></div><br>
                        <div><input id="validate_button" class="clearstyle btn green-custom-btn l-btn" type="button" value="Continue" ></div>
                    <br/>
                    </div>

                    <div id="progressBar"><div></div><p></p></div>

                    <div id="csr_errorblock" class="message"></div>
                    <div id="submitcsrlaster">
                      {if $support_san}
                        <input id="backFirst" type="button" class="clearstyle btn green-custom-btn l-btn" value="Back" />&nbsp;&nbsp;
                      {/if}
                        <button type="submit" class="clearstyle btn orange-custom-btn l-btn"  style="display: none"><i class="icon-shopping-cart icon-white"></i> Add To Cart </button>
                        <!--<input type="submit" value="Order" id="order_button" class="btn btn-primary">-->
                    </div>
                <div id ="checkcontact">
                    <input type="hidden" id="fieldcontact" name="fieldcontact">
                <div>
            </div>
        </div>


        <div class="order">
            <div class="step2">
                <br>
                <div class="title">CSR:Information</div>
                <div class="CSRinformation2">
                    <p style="text-indent:20px;">
                      The Common Name field should be the Fully Qualified Domain Name (FQDN) or the Web address for which you plan to use your Certificate, e.g. the area of your site you wish customers to connect to using SSL. For example, an SSL Certificate issued for example-name.com will not be valid for www.example-name.com or for secure.example-name.com. If the Web address to be used for SSL is www.example-name.com, ensure that the common name submitted in the CSR is www.example-name.com; similarly, if the Web address to be used for SSL is secure.example-name.com, ensure that the common name submitted in the CSR is secure.example-name.com.
                    </p>
                    <p style="text-indent:20px;">
                    If you want your domain name to be secured with SSL Certificate for both with and without "www". The CSR will need to be generated with "www" in the Common Name.
                    </p>
                    {if $support_san}
                        {if $sanInclude > 1}
                        <p style="padding-left:10px; text-indent:20px;">
                            {$aSSL.ssl_name} can include up to {$sanInclude-1} additional domain names in one certificate. These domain names are included in the certificate subject alternative name field and will be processed by browsers just like the common name. The second and third level domains can be different and internal host names / machine names are accepted as well.
                        </p>
                        {/if}
                        <p style="padding-left:10px; text-indent:20px;">
                            {if $aSSL.ssl_id == 44 || $aSSL.ssl_name == 'GeoTrust QuickSSL Premium SAN Package'}
                            <b>Important</b> : The top and second level domains must be the same for each value in the SAN field.
                            {else}
                            <b>Important</b> : All fully qualified domains should be registered to the same organization.
                            {/if}
                        </p>
                        {if false}
                        <p style="padding-left:10px; text-indent:20px;">
                            <b>Warning</b> : If you proceed with the enrollment without specifying additional domains you will be not be able to add additional domains on reissue of the certificate.
                        </p>
                        {/if}
                    {/if}
                    <table border="0">
                        <tr>
                            <td width="160px"><b>Common Name</b></td>
                            <td>: <span id="csr_commonname_data" style="padding-left:10px;"></span></td>
                        </tr>
                        <tr>
                            <td width="160px"><b>Organization</b></td>
                            <td>: <span id="csr_organization_data" style="padding-left:10px;"></span></td>
                        </tr>
                        <tr>
                            <td width="160px"><b>Organization Unit</b></td>
                            <td>: <span id="csr_organizationunit_data" style="padding-left:10px;"></span></td>
                        </tr>
                        <tr>
                            <td width="160px"><b>Location</b></td>
                            <td>: <span id="csr_locality_data" style="padding-left:10px;"></span></td>
                        </tr>
                        <tr>
                            <td width="160px"><b>State</b></td>
                            <td>: <span id="csr_state_data" style="padding-left:10px;"></span></td>
                        </tr>
                        <tr>
                            <td width="160px"><b>Country</b></td>
                            <td>: <span id="csr_country_data" style="padding-left:10px;"></span></td>
                        </tr>
                        <tr>
                            <td width="160px"><b>Key Algorithm</b></td>
                            <td>: <span id="csr_keyalgorithm_data" style="padding-left:10px;"></span></td>
                        </tr>
                        <tr>
                            <td width="160px"><b>Signature Algorithm</b></td>
                            <td>: <span id="csr_signaturealgorithm_data" style="padding-left:10px;"></span></td>
                        </tr>
                        {if isset($sanInclude) && $sanInclude > 0}
                        <tr>
                            <td colspan="2" id="sanArea">
                            </td>
                        </tr>
                        {/if}
                    </table>
{if false}
                    <div class="divRow">
                        <div class="divCell"><span id="csr_cn_status"></span><b>Common Name : </b></div>
                        <div class="divCell"><span id="csr_cn_data"></span></div>
                    </div>
                    <div class="divRow">
                        <div class="divCell"><span id="csr_o_status"></span><b>Organization : </b></div>
                        <div class="divCell"><span id="csr_o_data"></span></div>
                    </div>
                    <div class="divRow">
                        <div class="divCell"><span id="csr_ou_status"></span><b>Organizational Unit : </b></div>
                        <div class="divCell"><span id="csr_ou_data"></span></div>
                    </div>
                    <div class="divRow">
                        <div class="divCell"><span id="csr_l_status"></span><b>Location : </b></div>
                        <div class="divCell"><span id="csr_l_data"></span></div>
                    </div>
                    <div class="divRow">
                        <div class="divCell"><span id="csr_st_status"></span><b>State : </b></div>
                        <div class="divCell"><span id="csr_st_data"></span></div>
                    </div>
                    <div class="divRow">
                        <div class="divCell"><span id="csr_c_status"></span><b>Country : </b></div>
                        <div class="divCell"><span id="csr_c_data"></span></div>
                    </div>
                    <!--
                    <div class="divRow">
                        <div class="divCell"><span id="csr_signature_status"></span><b>Signature : </b></div>
                        <div class="divCell"><span id="csr_signature_data"></span></div>
                    </div>
                    <div class="divRow">
                        <div class="divCell"><span id="csr_keyalgorithm_status"></span><b>Key Algorithm : </b></div>
                        <div class="divCell"><span id="csr_keyalgorithm_data"></span></div>
                    </div>
                    <div class="divRow">
                        <div class="divCell"><span id="csr_keylength_status"></span><b>Key Length : </b></div>
                        <div class="divCell"><span id="csr_keylength_data"></span></div>
                    </div>-->
{/if}

                </div>
{if false}
                <div class="title" style="margin:13px 0 0 26px;">Domain Information:</div>
                <div class="domainInformation">
                    <div class="divCell" style="padding-left:25px;">
                        <span id="whois_domaininfo"></span>
                    </div>
                    <div class="clear"></div>
                </div>
{/if}

            </div>

            <div class="step3">
            <br>
            <div class="title" style=" {if $hide_email}display: none;{/if}">
                E-mail Approval:<font color="#FF0000">*</font>
            </div>
            
            <div class="emailApproval" style="padding-top: 5px; {if $hide_email}display: none;{/if}">
               <div>
                   <font>
                       <hr>
                           <p style="margin: -10px 0;">
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Email Verification will be sent to the "Email Approval" you specified here. Please don't miss to click the Owner Verification to confirm yourself on the email. If you don't feel convenience to verify by E-mail Approval, you can choose 2 alternative ways:
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.HTTP Verification Method  
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.DNS Record Approval 
<br>By contacting to <a href="https://www.digicert.com/security-certificate-support/#Contact" target="_blank">https://www.digicert.com/security-certificate-support/#Contact</a>, if the order processing is completed.
                           </p>
                       <hr>
                   </font>
               </div>
               <div>
                   <div class="divCell" id="whois_emailinfo"></div>
               </div>
               <div class="clear"></div>
            </div>
            
            {if $aSSL.ssl_validation_id == 2 || $aSSL.ssl_validation_id == 3}
            <div class="title" >
                E-mail Approval:<font color="#FF0000">*</font>
            </div>
            <div class="emailApproval" style="padding-top: 5px;">
               <div>
                       <hr>
                           <p  style="margin: -10px 0;">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The domain ownership rights should be confirmed prior to the certificate issuance The approval email will be sent to 5 administrative emails as the below list. 
                            <br>Please don't miss to click the Owner Verification to confirm yourself on the email.
                            <br>
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;admin@example.com
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;administrator@example.com
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hostmaster@example.com
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;postmaster@example.com
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;webmaster@example.com  
                            <br>
                            <br>If you don't feel convenience to verify by E-mail Approval, you can choose 2 alternative ways:
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.HTTP Verification Method  
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.DNS Record Approval 
                            <br>By contacting to <a href="https://www.digicert.com/security-certificate-support/#Contact" target="_blank"> https://www.digicert.com/security-certificate-support/#Contact</a>,if the order processing is completed.
                          </p>
                       <hr>
               </div> 
               <div class="clear"></div>
            </div>
            {/if}

            {if $hide_email || $ssl_productcode == 'SSL123' || $aSSL.ssl_validation_id != 1}
            <div class="title" style="{if false}display: none;{/if}">
               Organization Information:
            </div>

            <div class="contact_detail" style="padding:10px 0;{if false}display: none;{/if}">
               <div>
                       <p>
                           The information entered below about your company will appear in your certificate. Some of the information was obtained from the CSR you submitted. You may edit this information, but make sure this information matches what you want to appear in the certificate. Delays in approving your request may result if the information does not match what is listed in the Articles of Incorporation for your company, which has been recorded and maintained in official third-party databases.
                       </p>

                       <div>Organization Name : <font color="red">*</font></div>
                       <div><input type="text" id="o_name" name="o_name" class="txtContact" style="width: 40%" /></div>

                       <div>Phone Number : <font color="red">*</font></div>
                       <div><input type="text" id="o_phone" name="o_phone" class="txtContact" style="width: 40%" /></div>

                       <div>Address : <font color="red">*</font></div>
                       <div><input type="text" id="o_address" name="o_address" class="txtContact" style="width: 40%" /></div>

                       <div>City : <font color="red">*</font></div>
                       <div><input type="text" id="o_city" name="o_city" class="txtContact" style="width: 40%" /></div>

                       <div>State/Province : <font color="red">*</font></div>

                       <div><input type="text" id="o_state" name="o_state" class="txtContact" style="width: 40%" /></div>

                       <div>Country : <font color="red">*</font></div>
                       <div>
                            <select id="o_country" name="o_country" style="width: 40%" >
                                {foreach from=$country_list item=countryList}
                                    <option value="{$countryList.code}">{$countryList.name}</option>
                                {/foreach}
                            </select>
                        </div>

                       <div>Postal Code : <font color="red">*</font></div>
                       <div><input type="text" id="o_postcode" name="o_postcode" class="txtContact" style="width: 40%" /></div>

               </div>
               <div>
                   <div class="divCell" id="organize_info"></div>
               </div>
            </div>
            {/if}
            <div class="clear"></div>

            <table width="95%">
                <tr>
                    <td valign="top">
                        <div class="title">Administrative Contact:</div>
                        <!--<div class="whoisWarning" style="display:none; background-color:white; margin: 13px 0 -10px 26px; color:#C00;" align="right"><b>This domain can not</b></div>-->
                        <div id="adminContactDiv" class="contact_detail" style="width: 87%; height: 90%; border:1px solid #ccc;">
                        <div>The administrative contact is the primary contact and will be contacted to assist in resolution of any questions about the order.</div>
                        <div>Administrative person will be also used for Verification "Callbacks", that will be made for all Business/Extended Validation certificates. No callbacks will be made for Domain Validation Certificates.</div>
                        <br />
                        <div id="admin_error_div" style="display:none; border:1px solid grey; padding:3px; background:#ECECEC; margin-bottom:10px;">
                            <span><font id="admin_error_text" color="red"></font><span>
                        </div>
                        <div>First Name:<font color="red">*</font></div>
                            <div><input type="text" id="txt_name" name="txt_name" class="txtContact" style="width: 96%" /></div>
                        <div>Last Name:<font color="red">*</font></div>
                            <div><input type="text" id="txt_lastname" name="txt_lastname" class="txtContact" style="width: 96%" /></div>
                        <div>Email Address:<font color="red">*</font></div>
                            <div><input type="email" id="txt_email" name="txt_email" class="txtContact" style="width: 96%" /></div>
                        {if $is_symantec}
                        <div>Organization Name:<font color="red">*</font></div>
                            <div><input type="text" id="txt_org" name="txt_org" class="txtContact" style="width: 96%"/></div>
                        {/if}
                        <div>Job Title:<font color="red">*</font></div>
                            <div><input type="text" id="txt_job" name="txt_job" class="txtContact" style="width: 96%" /></div>
                        {if $is_symantec}
                        <div>Address:<font color="red">*</font></div>
                            <div><textarea name="txt_address" id="txt_address" style="width: 96%"></textarea></div>
                        <div>City:<font color="red">*</font></div>
                            <div><input type="text" id="txt_city" name="txt_city" class="txtContact" style="width: 96%"/></div>
                        <div>State/Province:<font color="red">*</font></div>
                            <div><input type="text" id="txt_state" name="txt_state" class="txtContact" style="width: 96%"/></div>
                        <div>Country:<font color="red">*</font></div>
                            <div>
                                <select name="txt_country" id="txt_country" style="width: 96%">
                                {foreach from=$country_list item=countryList}
                                    <option value="{$countryList.code}">{$countryList.name}</option>
                                {/foreach}
                                </select>
                            </div>
                         <div>Postal Code:<font color="red">*</font></div>
                            <div><input type="text" id="txt_post" name="txt_post_code" class="txtContact" style="width: 96%"/></div>
                        {/if}
                        <div>Phone Number:<font color="red">*</font></div>
                            <div><input type="text" id="txt_tel" name="txt_tel" class="txtContact" style="width: 96%" /></div>
                       <div>Ext Number:</div>
                            <div><input type="text" id="txt_ext" name="txt_ext" class="txtContact" style="width: 96%"/></div>

                        </div>
                </td>
                    <td valign="top">
                        <div class="title">Technical Contact Details:</div>
                        <!--<div align="left" class="whoisWarning" width="100%" style="display:none; background-color:white; margin: 13px 0 -10px -2px; color: #C00; width:106%;"><b>&nbsp;get data from whois.</b></div>-->
                        <div id="techContactDiv" class="contact_detail" style="width: 91%; height: 100%; border:1px solid #ccc;">
                            <div>The Technical contact will receive the certificate and generally be the individual to install the certificate on the web server. Technical contact will also receive renewal notices.</div>

                            <!--<div class="same_address">
                                <input name="ch_same_address" id="ch_same_address" type="checkbox" checked="checked" value="0"/> Same as administrative contact.
                            </div>-->
                            <br />
                            <select id="techInfoType" style="width:70%;">
                                <option value="sameAdmin">Same as administrative contact</option>
                                <option value="sameBilling" selected>Same as billing contact</option>
                                <option value="sameTech">Same as technical contact from whois</option>
                            </select>
                            <div class="not_same_address" style="display: none; padding-top:20px; margin-top:-20px;">
                                <div id="tech_error_div" style="display:none; border:1px solid grey; padding:3px; background:#ECECEC; margin-bottom:10px;">
                                    <span><font id="tech_error_text" color="red"></font><span>
                                </div>
                                <div>First Name:<font color="red">*</font></div>
                                    <div><input type="text" id="txt_name_1" name="txt_name_1" class="txtContact" style="width: 96%" /></div>
                                <div>Last Name:<font color="red">*</font></div>
                                    <div><input type="text" id="txt_lastname_1" name="txt_lastname_1" class="txtContact" style="width: 96%" /></div>
                                <div>Email Address:<font color="red">*</font></div>
                                    <div><input type="email" id="txt_email_1" name="txt_email_1" class="txtContact" style="width: 96%" /></div>
                                {if $is_symantec}
                                <div>Oraganization Name:<font color="red">*</font></div>
                                    <div><input type="text" id="txt_org_1" name="txt_org_1" class="txtContact" style="width: 96%"/></div>
                                {/if}
                                <div>Job Title:<font color="red">*</font></div>
                                    <div><input type="text" id="txt_job_1" name="txt_job_1" class="txtContact" style="width: 96%" /></div>
                                {if $is_symantec}
                                <div>Address:<font color="red">*</font></div>
                                    <div><textarea name="txt_address_1" id="txt_address_1" style="width: 96%"></textarea></div>
                                <div>City:<font color="red">*</font></div>
                                    <div><input type="text" id="txt_city_1" name="txt_city_1" class="txtContact" style="width: 96%"/></div>
                                <div>State/Province:<font color="red">*</font></div>
                                    <div><input type="text" id="txt_state_1" name="txt_state_1" class="txtContact" style="width: 96%"/></div>
                                <div>Country:<font color="red">*</font></div>
                                    <div>
                                        <select name="txt_country_1" id="txt_country_1" style="width: 96%">
                                            {foreach from=$country_list item=countryList}
                                                <option value="{$countryList.code}">{$countryList.name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                 <div>Postal Code:<font color="red">*</font></div>
                                    <div><input type="text" id="txt_post_1" name="txt_post_code_1" class="txtContact" style="width: 96%"/></div>
                                {/if}
                                <div>Phone Number:<font color="red">*</font></div>
                                    <div><input type="text" id="txt_tel_1" name="txt_tel_1" class="txtContact" style="width: 96%" /></div>
                                <div>Ext Number:</div>
                            <div><input type="text" id="txt_ext_1" name="txt_ext_1" class="txtContact" style="width: 96%"/></div>

                        </div>
                            </div>
                    </td>
                </tr>
            </table>


            </div>
            <div><br>
                <button type="submit" class="clearstyle btn orange-custom-btn l-btn"><i class="icon-shopping-cart icon-white"></i> Add To Cart </button>
            <br><br></div>

            <!--<div><input type="submit" value="Order" id="order_button"  class="btn btn-primary"></div>-->
        </div>

</div> <!-- close div csr content -->