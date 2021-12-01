{php}
include_once $this->template_dir . '/cart_ssl/cart0_ssl_preorder.tpl.php';
include_once $this->template_dir . '/order_coupon.tpl.php';
{/php}

<style>
{literal}
.divTable {
    display:  table;
    width: 100%;
    background-color:#e4e4e4;
    border:0px solid  #dfdfdf;
    border-spacing:5px; 
    padding:10px 0px;
    /*cellspacing:poor IE support for  this*/
    /* border-collapse:separate;*/
}

.divRow {
    display:table-row;
    width:auto;
}

.divCell {
    float:left;/*fix for  buggy browsers*/
    display:table-column;
    width:auto;
    text-align: left;
    padding-left: 10px;
    /* background-color:#ccc; */
}
.bg-content {
    background-color:#759db7;
	padding:10px 0px;
	color:#fff; 
}
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
        line-height: 22px; /* same as #progressBar height if we want text middle aligned */
        width: 0;
        background-color: #0099ff;
}

{/literal}
</style>

<div id="tabs" class="ssl-product">
    <div id="tabs_home" class="tbl_order">
        <form method="post" action="{$ca_url}cart/ssl">
            <input type="hidden" id="ssl_id" name="ssl_id" value="{$ssl_id}" />
            <input type="hidden" id="rvaction" name="rvaction" value="order" />
            <input type="hidden" id="commonname" name="commonname" value="" />
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr valign="top">
                    <td width="250" valign="top">
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <th class="title">Related Products by Validation</th>
                            </tr>
{foreach from=$aRelatedbyValidate key="k" item="v"}
                            <tr>
                                <td class="clearpad" valign="top">
                                    <ul class="arrow">
                                        <li>
                                            <a href="{$ca_url}cart/ssl&amp;rvaction=preorder&amp;ssl_id={$k}">{$v}</a>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
{/foreach}
                        </table>
                        <div class="border"></div>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <th class="title">Related Products by Authority</th>
                            </tr>
{foreach from=$aRelatedbyAuthority key="k" item="v"}
                            <tr>
                                <td class="clearpad" valign="top">
                                    <ul class="arrow">
                                        <li>
                                            <a href="{$ca_url}cart/ssl&amp;rvaction=preorder&amp;ssl_id={$k}">{$v}</a>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
{/foreach}
                        </table>
                        <div class="border"></div>
                    </td>
                    <td class="graybdr">
						<table cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="left" valign="top" width="50%">
								<div>
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="100" align="left" valign="top" class="bg-subject" nowrap="nowrap" style="padding:15px 10px;"><div>{$aSSL.ssl_name}</div></td>
											<td valign="top"><img
												src="{$template_dir}images/ssl/logo_{$aSSL.ssl_authority_id}.jpg"
												alt="{$aSSL.authority_name}" title="{$aSSL.authority_name}" />
											</td>
										</tr>
										<tr>
											<td align="left" valign="top" colspan="2">
												<p class="txtbluecontent">You do not have a dedicated IP address. In this case, you need to order a dedicated IP address before ordering any SSL Certificate.</p>
											</td>
										</tr>
									</table> 
									</div>
									
									<div>
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td align="right" valign="top" class="subject"><b>Warranty : </b></td>
											<td valign="top">{$aSSL.warranty} USD</td>
										</tr>
										<tr valign="top">
											<td align="right" valign="top" class="subject"><b>Price : </b>
											</td>
											<td align="left" valign="top">
												<table width="100%" cellpadding="0" cellspacing="0">
													{foreach from=$aSSL._Price key="k" item="v"}
													<tr valign="top">
														<td nowrap="nowrap">
			{if $k==$selectConract}
															<input type="radio" id="price_id_{$k}" name="ssl_price" value="{$k}" checked="checked" />
			{else}
															<input type="radio" id="price_id_{$k}" name="ssl_price" value="{$k}" />
			{/if}
															<label for="price_id_{$k}">
																{$v} USD / 
																{if $k==12} 1 Year {elseif $k==24} 2 Years {elseif $k==36} 3 Years {/if}
															</label>
														</td>
													</tr>
													{/foreach}
												</table>
												<p>
													{php}
													  order_coupon::singleton()->displayCoupon(3, $pid);
													{/php}
												</p>
											</td>
										</tr>
									</table>
									</div>
								</td>
								<td align="left" valign="top" width="50%"><img src="{$template_dir}images/ssl-order.jpg" alt="ssl" width="460" height="300" /></td>
							</tr>
						</table> 
						 
                        <h3><a href="#section2" class="txtblue">SSL Certificate Signing Request (CSR)</a></h3>
                        
						<div class="divRow bg-content">
							<div class="divCell padd">
								Before ordering SSL Certificates, you need to generate a CSR (Certificate Signing Request) on your server first. A CSR is an encrypted body of text which contains encoded information specific to your company and domain name. This information is known as a Distinguished Name or DN. Once your CSR is created, just copy and paste it into the below field:
							</div>
						</div>
						<div style="padding:3px;"></div>
						<div class="divTable">
                            {if $isSupportServer==true}
                            <div class="divRow">
                                <div class="divCell"><b>Web Server Software : </b><em>*</em></div>
                                <div class="divCell">
                                    <select name="servertype" id="servertype">
                                        {foreach from=$aSupportServer key="k" item="v"}
                                        {if $k== 'other'}
                                            <option value="{$k}" selected="true">{$v}</option>
                                        {else}
                                            <option value="{$k}">{$v}</option>
                                        {/if}
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            {/if}
                            <div class="divRow">
                                <div class="divCell subject"><b>CSR : </b><em>*</em></div>
                                <div class="divCell">
                                    <div style="background:#000000; padding:0px 10px 3px 5px; color:#fff; width:15em;">
                                        <input type="checkbox" id="submit_csr_later" name="submit_csr_later" value="1"/>
                                        <label for="submit_csr_later">I want to submit CSR later.</label>                                    
                                    </div>
                                    <p></p>
                                    <div id="submit_csr">
                                        <p>
                                            A standard CSR should begin with<br />
                                            -----BEGIN CERTIFICATE REQUEST-----<br />
                                            and end with<br />
                                            -----END CERTIFICATE REQUEST-----<br />
                                        </p>
                                        <textarea rows="14" class="block" name="crs_data" id="csr_data">{$csrData}</textarea>
                                        <div align="center">
                                            <input id="csr_validate" type="button" value="Validate" class="btn btn-primary" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="progressBar"><div></div><p></p></div>
                            <div id="csr_errorblock" class="message"></div>
                            <div class="divRow step2">
                                <div class="divCell subject"><b>CSR Information : </b></div><br />
                                <div class="divCell">
                                     <div class="divTable" id="csr_infomation">
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
                                        </div>
                                     </div>
                                </div>
                            </div>
                            <div class="divRow step3 whois_domaininfo">
                                <div class="divCell"><b>Domain Information : </b></div><br clear="all" />
                                <div class="divCell" style="padding-left:25px;"><span id="whois_domaininfo"></span></div>
                            </div>
                            <div class="divRow step4 whois_emailinfo">
                                 <div class="divCell" style="margin-top:15px;"><b>E-mail Approval : </b><em>*</em></div><br clear="all" />
                                 <div style="padding-left:5px;"><div class="divCell" id="whois_emailinfo"></div></div>
                             </div>
                        </div>
                        <center style="padding-top:10px;">
                            <div class="order"><input type="submit" name="submit" value="Order" class="btn btn-primary" /></div>
                        </center>
                    </td>
                </tr>
            </table>
        </form>
        <div id="dialog" style="display: none;">
            <div class="message"></div>
        </div>
    </div>
</div>


<script type="text/javascript">
var RVL_TEMPLATE_URL = "{$template_dir}";
var RVL_BASEURL = "{$ca_url}";
{literal}
$(function() {
    $('.order').hide();
    $('.step2').hide();
    $('.step3').hide();
    $('.step4').hide();
    $('#progressBar').hide();

    $("#csr_validate").click(function() {
        $('.step2').hide();
        $('.step3').hide();
        $('.step4').hide();
        $('#progressBar').show();
        progress(1, $('#progressBar'));

        $('.order').hide();
        $('#whois_domaininfo').html('');
        $('#whois_emailinfo').html('');
        var csr = $("#csr_data").val();
        var ssl_id = $( "#ssl_id" ).val();
        hideOnProgress();
        validateCsr(ssl_id ,csr);
        showAfterProgress();

    });
    
    $("#submit_csr_later").click(function(){
        if ($('#submit_csr_later').attr( 'checked' ) == 'checked') {
            $('#submit_csr').hide();
            $('.order').show();
        } else {
            $('#submit_csr').show();
            $('.order').hide();
        }
    });
    
    
    
    function hideOnProgress()
    {
        //$('#btn_csr_validate').hide();
    }
    
    function showAfterProgress()
    {
        //$( '#btn_csr_validate').show();
    }
    
    function progress(percent, $element) {
        var progressBarWidth = percent * $element.width() / 100;
        $element.find('div').animate({ width: progressBarWidth }, 500).html(percent + "%&nbsp;");
    }
    
    function validateCsr(sslId, csr)
    {
        progress(10, $( '#progressBar'));
        writeCsrError('');
        
        $.ajax({
            type: "POST"
            , url: RVL_BASEURL
            , data: {
                cmd: 'module'
                , module: 'ssl'
                , action: 'decodecsr'
                , ssl_id: sslId
                , csrData: csr
            }
            , success: function(data) {
                progress(40, $( '#progressBar'));
                if (data.aResponse == undefined) {
                    writeCsrError("Cannot get response from api!!");
                    return false;
                } else {
                    aResponse = data.aResponse;
                }
                
                if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                    writeCsrError(aResponse.message);
                    return false;
                }

                if (aResponse.status != undefined && aResponse.status == 'success') {
                    progress(50, $('#progressBar'));
                    arrayCsrKey = ['CN', 'O', 'OU', 'L', 'ST', 'C', 'KeyAlgorithm', 'KeyLength', 'Signature'];
                    if (aResponse.csrData != undefined) {
                        onError = 0;
                        csrData = aResponse.csrData;
                        validateData = aResponse.validateData;
                        
                        for (key in arrayCsrKey) {
                            id = 'csr_' + arrayCsrKey[key].toLowerCase();
                            writeCsrStatus(id, '');
                            if (csrData[arrayCsrKey[key]] != undefined) {
                                writeCsrData(id, csrData[arrayCsrKey[key]]); 
                                if (id == 'csr_cn') {
                                    $('#commonname').val(csrData[arrayCsrKey[key]]);
                                }
                            } else {
                                writeCsrData(id, ''); 
                            }
                        
                            if (validateData[arrayCsrKey[key]] != undefined) {
                                writeCsrError(validateData[arrayCsrKey[key]]['message']);
                                writeCsrStatus(id, 0);
                                onError = 1;
                            } else {
                                writeCsrStatus(id, 1);
                            }
                        }
                        
                        $('.step2').show();
                        
                        if (onError == 0) {
                            progress(60, $('#progressBar'));
                            $.ajax({
                                type: "POST"
                                , url: RVL_BASEURL
                                , data: {
                                    cmd: 'module'
                                    , module: 'ssl'
                                    , action: 'getwhoisdomain'
                                    , domain: aResponse.csrData.CN
                                }
                                , success: function(data) {
                                    progress(80, $('#progressBar'));
                                    if (data.aResponse == undefined) {
                                        writeCsrError("Cannot get response from api!!");
                                        return false;
                                    }
                                    
                                    whoisData = data.aResponse;

                                    regrinfo = {
                                        owner: {},
                                        tech: {},
                                        admin: {}
                                    };
                                    
                                    
                                    if (whoisData.regrinfo.owner != undefined) {
                                        regrinfo.owner = whoisData.regrinfo.owner;
                                    }
                                    
                                    if (whoisData.regrinfo.admin != undefined) {
                                        regrinfo.admin = whoisData.regrinfo.admin;
                                    }
                                    
                                    if (whoisData.regrinfo.tech != undefined) {
                                        regrinfo.tech = whoisData.regrinfo.tech;
                                    }
                                    
                                    aEmail = {};
                                    if (whoisData.regrinfo.domain == undefined) {
                                        writeCsrError('Cannot get whois data!!');
                                        return 1;
                                    }
                                    
                                    if (regrinfo.owner.email != undefined) {
                                        aEmail[regrinfo.owner.email] = 'Registrant Email';
                                    }
                                    
                                    if (regrinfo.admin.email != undefined) {
                                        if (aEmail[regrinfo.admin.email] == undefined) {
                                            aEmail[regrinfo.admin.email] = 'Administrative Email';
                                        }
                                    }
                                    
                                    if (regrinfo.tech.email != undefined ) {
                                        if (aEmail[regrinfo.tech.email] == undefined) {
                                            aEmail[regrinfo.tech.email] = 'Technical Email';
                                        }
                                    }
                                    
                                    emailApprovalOtp = '';
                                    count = 1;
                                    for (k in aEmail) {
                                        emailApprovalOtp = emailApprovalOtp 
                                            + '<label for="email_approval_' + count + '">' 
                                            + '<input type="radio" id="email_approval_' + count 
                                            + '" name="email_approval" value="' + k + '" />' 
                                            +  k + ' (' + aEmail[k] + ')</label>';
                                        count = count +1;
                                    }
                                    
                                    setAdminEmail = 'admin@' + whoisData.regrinfo.domain.name;
                                    setWebmasterEmail = 'webmaster@' + whoisData.regrinfo.domain.name;
                                    
                                    emailApprovalOtp = emailApprovalOtp 
                                        + '<label for="email_approval_' + count + '">' 
                                        + '<input type="radio" id="email_approval_' + count 
                                        + '" name="email_approval" value="'+ setAdminEmail +'" />' 
                                        + setAdminEmail + '</label>';
                                    
                                    count = count +1;
                                    
                                    emailApprovalOtp = emailApprovalOtp 
                                        + '<label for="email_approval_' + count + '">' 
                                        + '<input type="radio" id="email_approval_' + count 
                                        + '" name="email_approval" value="'+ setWebmasterEmail +'" />' 
                                        + setWebmasterEmail + '</label>';
                                     
                                    count = count +1;
                                    
                                    $('#whois_emailinfo').html(emailApprovalOtp);
                                    $('#email_approval_1').attr('checked','checked');
                                    
                                    progress(90, $('#progressBar'));
                                    domainDetail = '';
                                    
                                    
                                    if (regrinfo.owner.name != undefined) {
                                        domainDetail = domainDetail + regrinfo.owner.name + '<br />';
                                    }
                                    
                                    if (regrinfo.owner.organization != undefined) {
                                        domainDetail = domainDetail + regrinfo.owner.organization + '<br />';
                                    }
                                    
                                    if (regrinfo.owner.address != undefined) { 
                                        if (regrinfo['owner']['address']['0'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['0'] + '<br />';
                                        }
                                    
                                        if (regrinfo['owner']['address']['1'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['1'] + '<br />';
                                        }
                            
                                        if (regrinfo['owner']['address']['2'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['2'] + '<br />';
                                        }
                            
                                        if (regrinfo['owner']['address']['3'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['3'] + '<br />';
                                        }
                            
                                        if (regrinfo['owner']['address']['4'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['4'] + '<br />';
                                        }
                            
                                        if (regrinfo['owner']['address']['5'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['5'] + '<br />';
                                        }
                            
                                        if (regrinfo['owner']['address']['6'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['6'] + '<br />';
                                        }
                            
                                        if (regrinfo['owner']['address']['7'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['7'] + '<br />';
                                        }
                            
                                        if (regrinfo['owner']['address']['8'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['8'] + '<br />';
                                        }
                                    
                                        if (regrinfo['owner']['phone'] != undefined) {
                                            domainDetail = domainDetail + 'Phone: ' + regrinfo['owner']['phone'] + '<br />';
                                        }
                                    
                                        if (regrinfo['owner']['fax'] != undefined) {
                                            domainDetail = domainDetail + 'Fax: ' + regrinfo['owner']['fax'] + '<br />';
                                        }
                                    }
                                    
                                    if (regrinfo['owner']['email'] != undefined) {
                                        domainDetail = domainDetail + 'Email: ' + regrinfo['owner']['email'] + '<br />';
                                    }
                                    
                                    if (domainDetail == '') {
                                        domainDetail = '<font color="red"><b>Cannot found domain owner in the WHOIS information for your domain name, please Update WHOIS Information.</b></font>';
                                    }
                                    
                                    $('#whois_domaininfo').html(domainDetail);
                                    progress(100, $('#progressBar'));
                                    $('.step3').show();
                                    $('.step4').show();
                                    $('.order').show();
                                   
                                    $('#progressBar').hide();
                                }
                                , error: function(xhr,error) {
                                    respError = $.parseJSON(xhr.responseText);
                                    alert( "Whois API connection has error!! " + respError.message);
                                }
                            });
                        }
                    } else {
                        writeCsrError("Cannot read data info from CSR!!");
                        return false;
                    }
                } else {
                    writeCsrError("Unknow status response!!");
                    return false;
                }
            }
            , error: function(xhr,error) {
                respError = $.parseJSON(xhr.responseText);
                alert( "Whois API connection has error!! " + respError.message);
            }
        });
    }
    
    function writeCsrError(msg)
    {
        if (msg == '') {
            $( '#csr_errorblock' ).html('');
        } else {
            $( '#csr_errorblock' ).html($( '#csr_errorblock' ).html() + '<p class="message-error">' + msg + '</p>');
        }
    }
    
    function writeCsrData(id, val)
    {
        $( '#' + id + '_data').html(val);
    }
    
    function writeCsrStatus(id, val)
    {
        code = '';
        if (val == 0) {
            code = '<img src="' + RVL_TEMPLATE_URL + 'images/action_disable.gif" />';
        } 
        if (val == 1) {
            code = '<img src="' + RVL_TEMPLATE_URL + 'images/action_enable.gif" />';
        }
        $( '#' + id + '_status').html(code);
    }
 
});
{/literal}
</script>