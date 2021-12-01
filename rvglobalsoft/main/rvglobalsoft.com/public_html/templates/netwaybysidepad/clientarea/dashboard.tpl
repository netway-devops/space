{php}
    if (isset($_GET)) {
        foreach ($_GET as $k => $v) {
           $this->_tpl_vars['REQUEST'][$k] = "{$v}";
        }
        
    }

    if(isset($_POST)) {
        foreach ($_POST as $k => $v) {
           $this->_tpl_vars['REQUEST'][$k] = "{$v}";
        }
    }   
    $templatePath   = $this->get_template_vars('template_path');
    include_once($templatePath . 'clientarea/dashboard.tpl.php');
{/php}



{if $REQUEST.rvaction=='apikey'}
    {include file='clientarea/rvglobalsoft_api.tpl'}
{elseif $REQUEST.rvaction=='rootcommission'}
    {include file='clientarea/rootcommission.tpl'}
{elseif $REQUEST.rvaction=='partner'}
	{include file='clientarea/rv_partner_license.tpl'}
{else}

{*

Clientarea dashboard - summary of owned services, due invoices, opened tickets

*}
<!-- <img src="{$template_dir}images/black_ribbon_top_left.png" class="black-ribbon stick-top stick-left"/>-->
{if $sslalerttext}
<div class="alert-error">{$sslalerttext}</div>
{/if}

<div class="text-block clear clearfix">
    <!--<h4>{$lang.welcomeback}, {$login.firstname} {$login.lastname}</h4>
    <span>{$offer_total} {$lang.services}</span>-->
</div>
<div class="container client-area">

		{if $annoucements|@count > 0}
		<div class="row-fluid padd">
			<div class="span12">
				<div>
					<h2 class="icon-speaker">
						<span>Announcement</span>
						<div style="margin: 20px 80px 5px 20px;">
						{foreach from=$annoucements item=eAnnoucement}
						<table width="100%" style="margin-top: 20px;">
							<tr>
								<td><font color="white"><b>{$eAnnoucement.title}</b></font> [ <font style="font-size: 10px;">{$eAnnoucement.date|date_format:'%d %b %Y'}</font> ] : <br><br></td>
							</tr>
							<tr style="width: 100%;">
								<td style="padding: 10px 10px 2px 10px; margin-top: 15px; background-color: #98aebd; border: 3px solid #013B6C; color: white; border-radius: 10px;">{$eAnnoucement.content|strip}</td>
							</tr>
 						</table>
						{/foreach}
						</div>
					</h2>
				</div>
			</div>
		</div>
		{/if}
        
      
        <div class="row-fluid padd">
            <div class="span6" style="margin-bottom:10px;"><a href="https://rvsitebuilder.com/release-note" target="_blank"><img src="{$template_dir}images/banner-client-area-dashborad-v73.png" alt="" width="654" height="268" /></a></div>
            <!-- <div class="span6 pull-right"><a href="https://rvglobalsoft.com/?cmd=cart&action=add&id=111" target="_blank"><img src="{$template_dir}images/client/ads-cpanel-2018.png" alt="" width="658" height="267" /></a></div>-->
<div class="span6 pull-right"><a href="https://www.rvsitebuilder.com/noc-partner/" target="_blank"><img src="{$template_dir}images/client/clientarea_right_banner.jpg" alt="" width="654" height="268"></a></div>
<!--<div class="span6 pull-right"><a href="https://rvskin.com/" target="_blank"><img src="{$template_dir}images/client/banner-rvskin13.png" alt="" width="654" height="268" /></a></div>-->
        </div>   
        
<!-- Invoices -->
 {if $dueinvoices}
<!--
แก้ปัญหาเรื่องที่ว่า ผลรวมของเงิน เอา ยอด credit มาลบด้วย เช่น
ยอดเงิน 100 บาทใช้ credit ไป 20 บาท เหลือ 80 บาท
ใน display แสดง 60 บาท เพราะว่า เอา 80 ไปลบกับ credit อีกที เลยผิด
-->
{php}
$this->_tpl_vars['acc_balance'] = 0;
foreach ($this->_tpl_vars['dueinvoices'] as $invoice=>$foo){
    $this->_tpl_vars['acc_balance'] +=$foo['total'];
}
$templatePath   = $this->get_template_vars('template_path');
include_once($templatePath.'clientarea/dashboard.tpl.php');
{/php}
 <div class="clear clearfix">
    <h5><i class="icon-service-invoice"></i>{$lang.invoices}</h5>
    <div class="separator-down-arrow"></div>
    <div class="line-separaotr"></div>

    <div class="clear clearfix">
        <div class="table-box">
            <div class="table-header">
                <div class="right-btns">
                	<form method="post" action="index.php" style="margin:0px">
{if $enableFeatures.bulkpayments!='off'} <input type="hidden" name="action" value="payall"/>{else} <input type="hidden" name="action" value="invoices"/>{/if}
                        <input type="hidden" name="cmd" value="clientarea"/>
                        <button type="submit" class="clearstyle green-custom-btn btn"><i class="icon-success"></i> {$lang.paynowdueinvoices}</button>
                    </form>
                </div>
                <p>{$lang.dueinvoices} {if $acc_balance && $acc_balance>0}<span class="redone">{$acc_balance|price:$currency}</span>{/if}</p>
            </div>
            <table class="table table-striped table-hover">
                <tr class="table-header-row">
                    <th>{$lang.invoicenum} <i class="icon-sort-arrow-down"></i></th>
                    <th class="w25 cell-border">Payment method</th>
                    <th class="w25 cell-border">{$lang.total}</th>
                    <th class="w25 cell-border">{$lang.duedate}</th>
                </tr>
                {foreach from=$dueinvoices item=invoice name=foo}
                <tr>
                    <td><a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank">
                    {if $proforma && ($invoice.status=='Paid' || $invoice.status=='Refunded') && $invoice.paid_id!=''}{$invoice.paid_id}{else}{$invoice.date|invprefix:$prefix}{$invoice.id}{/if}
                    </a></td>
                    <td class="cell-border grey-c">{$invoice.paymentmethod}</td>
                    <td class="cell-border grey-c">{$invoice.total|price:$invoice.currency_id}</td>
                    <td class="cell-border grey-c no-bold">{$invoice.duedate|date_format:'%d %b %Y'}</td>
                </tr>
                {/foreach}
            </table>
        </div>
    </div>
 </div>
 {/if}
<!-- End of Invoices -->

<!--  host provider -->

{if $checkingPartner.status == 1 && $checkingPartner.client_id != 0} 
<h5 class="hosting-free desktop">
    <span class='newtab'> New</span>
    &nbsp;&nbsp;Free Marketing for RVsitebuilder Hosting Provider
</h5>
<h5 class="hosting-free phone">
    <span class="newtab"> New</span>
    &nbsp;&nbsp;Free Marketing for RVsitebuilder Hosting Provider
</h5>
<div class="left-btns detialCompany" style="margin-bottom: 27px;">
     <button class="viewdetial"style="border: solid 3px #217100;color: #156b00; background-color: #ffffff;">
         <i class="icon-view"></i>View Company Details
         </button>
 </div>
<div class="table-box box-form show-company" style="margin-bottom: 40px;" >
          <div class='desktop'> 
            <div class="table-header">
               <p>Your Company Details</p>
            </div>
                <table class=" table table-hover" style="font-size: 16px;">
                    <tbody>              
                        <tr>
                            <td style="width:217px;">Country : </td>
                            <td class="cell-border">
                                {if $checkingPartner.country == 'AF'}{$checkingPartner.country|replace:'AF':'Afghanistan'}
                                            {elseif $checkingPartner.country == 'AX'}{$checkingPartner.country|replace:'AX':'Aland Islands'}
                                            {elseif $checkingPartner.country == 'AL'}{$checkingPartner.country|replace:'AL':'Albania'}
                                            {elseif $checkingPartner.country == 'DZ'}{$checkingPartner.country|replace:'DZ':'Algeria'}
                                            {elseif $checkingPartner.country == 'AS'}{$checkingPartner.country|replace:'AS':'American'}
                                            {elseif $checkingPartner.country == 'AD'}{$checkingPartner.country|replace:'AD':'Andorra'}
                                            {elseif $checkingPartner.country == 'AO'}{$checkingPartner.country|replace:'AO':'Angola'}
                                            {elseif $checkingPartner.country == 'AI'}{$checkingPartner.country|replace:'AI':'Anguilla'}
                                            {elseif $checkingPartner.country == 'AG'}{$checkingPartner.country|replace:'AG':'Antigua And Barbuda'}
                                            {elseif $checkingPartner.country == 'AR'}{$checkingPartner.country|replace:'AR':'Argentina'}
                                            {elseif $checkingPartner.country == 'AM'}{$checkingPartner.country|replace:'AM':'Armenia'}
                                            {elseif $checkingPartner.country == 'AW'}{$checkingPartner.country|replace:'AW':'Aruba'}
                                            {elseif $checkingPartner.country == 'AQ'}{$checkingPartner.country|replace:'AQ':'Antarctica'}
                                            {elseif $checkingPartner.country == 'AU'}{$checkingPartner.country|replace:'AU':'Australia'}
                                            {elseif $checkingPartner.country == 'AT'}{$checkingPartner.country|replace:'AT':'Austria'}
                                            {elseif $checkingPartner.country == 'AZ'}{$checkingPartner.country|replace:'AZ':'Azerbaijan'}
                                            {elseif $checkingPartner.country == 'BS'}{$checkingPartner.country|replace:'BS':'Bahamas'}
                                            {elseif $checkingPartner.country == 'BH'}{$checkingPartner.country|replace:'BH':'Bahrain'}
                                            {elseif $checkingPartner.country == 'BD'}{$checkingPartner.country|replace:'BD':'Bangladesh'}
                                            {elseif $checkingPartner.country == 'BB'}{$checkingPartner.country|replace:'BB':'Barbados'}
                                            {elseif $checkingPartner.country == 'BY'}{$checkingPartner.country|replace:'BY':'Belarus'}
                                            {elseif $checkingPartner.country == 'BE'}{$checkingPartner.country|replace:'BE':'Belgium'}
                                            {elseif $checkingPartner.country == 'BZ'}{$checkingPartner.country|replace:'BZ':'Belize'}
                                            {elseif $checkingPartner.country == 'BJ'}{$checkingPartner.country|replace:'BJ':'Benin'}
                                            {elseif $checkingPartner.country == 'BM'}{$checkingPartner.country|replace:'BM':'Bermuda'}
                                            {elseif $checkingPartner.country == 'BT'}{$checkingPartner.country|replace:'BT':'Bhutan'}
                                            {elseif $checkingPartner.country == 'BO'}{$checkingPartner.country|replace:'BO':'Bolivia'}
                                            {elseif $checkingPartner.country == 'BA'}{$checkingPartner.country|replace:'BA':'Bosnia And Herzegovina'}
                                            {elseif $checkingPartner.country == 'BW'}{$checkingPartner.country|replace:'BW':'Botswana'}
                                            {elseif $checkingPartner.country == 'BV'}{$checkingPartner.country|replace:'BV':'Bouvet'}
                                            {elseif $checkingPartner.country == 'BR'}{$checkingPartner.country|replace:'BR':'Brazil'}
                                            {elseif $checkingPartner.country == 'IO'}{$checkingPartner.country|replace:'IO':'British Indian Ocean Territory'}
                                            {elseif $checkingPartner.country == 'BN'}{$checkingPartner.country|replace:'BN':'Brunei Darussalam'}
                                            {elseif $checkingPartner.country == 'BG'}{$checkingPartner.country|replace:'BG':'Bulgaria'}
                                            {elseif $checkingPartner.country == 'BF'}{$checkingPartner.country|replace:'BF':'Burkina Faso'}
                                            {elseif $checkingPartner.country == 'BI'}{$checkingPartner.country|replace:'BI':'Burundi'}
                                            {elseif $checkingPartner.country == 'KH'}{$checkingPartner.country|replace:'KH':'Cambodia'}
                                            {elseif $checkingPartner.country == 'CM'}{$checkingPartner.country|replace:'CM':'Cameroon'}
                                            {elseif $checkingPartner.country == 'CA'}{$checkingPartner.country|replace:'CA':'Canada'}
                                            {elseif $checkingPartner.country == 'CV'}{$checkingPartner.country|replace:'CV':'Cape Verde'}
                                            {elseif $checkingPartner.country == 'KY'}{$checkingPartner.country|replace:'KY':'Cayman Islands'}
                                            {elseif $checkingPartner.country == 'CF'}{$checkingPartner.country|replace:'CF':'Central African Republic'}
                                            {elseif $checkingPartner.country == 'TD'}{$checkingPartner.country|replace:'TD':'Chad'}
                                            {elseif $checkingPartner.country == 'CL'}{$checkingPartner.country|replace:'CL':'Chile'}
                                            {elseif $checkingPartner.country == 'CN'}{$checkingPartner.country|replace:'CN':'China'}
                                            {elseif $checkingPartner.country == 'CX'}{$checkingPartner.country|replace:'CX':'Christmas Island'}
                                            {elseif $checkingPartner.country == 'CC'}{$checkingPartner.country|replace:'CC':'Cocos (Keeling) Islands'}
                                            {elseif $checkingPartner.country == 'CO'}{$checkingPartner.country|replace:'CO':'Colombia'}
                                            {elseif $checkingPartner.country == 'KM'}{$checkingPartner.country|replace:'KM':'Comoros'}
                                            {elseif $checkingPartner.country == 'CG'}{$checkingPartner.country|replace:'CG':'Congo'}
                                            {elseif $checkingPartner.country == 'CD'}{$checkingPartner.country|replace:'CD':'Congo, Democratic Republic'}
                                            {elseif $checkingPartner.country == 'CK'}{$checkingPartner.country|replace:'CK':'Cook Islands'}
                                            {elseif $checkingPartner.country == 'CR'}{$checkingPartner.country|replace:'CR':'Costa Rica'}
                                            {elseif $checkingPartner.country == 'HR'}{$checkingPartner.country|replace:'HR':'Croatia'}
                                            {elseif $checkingPartner.country == 'CU'}{$checkingPartner.country|replace:'CU':'Cuba'}
                                            {elseif $checkingPartner.country == 'CY'}{$checkingPartner.country|replace:'CY':'Cyprus'}
                                            {elseif $checkingPartner.country == 'CZ'}{$checkingPartner.country|replace:'CZ':'Czech Republic'}
                                            {elseif $checkingPartner.country == 'DK'}{$checkingPartner.country|replace:'DK':'Denmark'}
                                            {elseif $checkingPartner.country == 'DM'}{$checkingPartner.country|replace:'DM':'Dominica'}
                                            {elseif $checkingPartner.country == 'DO'}{$checkingPartner.country|replace:'DO':'Dominican Republic'}
                                            {elseif $checkingPartner.country == 'EC'}{$checkingPartner.country|replace:'EC':'Ecuador'}
                                            {elseif $checkingPartner.country == 'EE'}{$checkingPartner.country|replace:'EE':'Estonia'}
                                            {elseif $checkingPartner.country == 'EG'}{$checkingPartner.country|replace:'EG':'Egypt'}
                                            {elseif $checkingPartner.country == 'ES'}{$checkingPartner.country|replace:'ES':'Spain'}
                                            {elseif $checkingPartner.country == 'FI'}{$checkingPartner.country|replace:'FI':'Finland'}
                                            {elseif $checkingPartner.country == 'FR'}{$checkingPartner.country|replace:'FR':'France'}
                                            {elseif $checkingPartner.country == 'GB'}{$checkingPartner.country|replace:'GB':'United Kingdom'}
                                            {elseif $checkingPartner.country == 'GH'}{$checkingPartner.country|replace:'GH':'Ghana'} 
                                            {elseif $checkingPartner.country == 'GR'}{$checkingPartner.country|replace:'GR':'Greece'} 
                                            {elseif $checkingPartner.country == 'GT'}{$checkingPartner.country|replace:'GT':'Guatemala'} 
                                            {elseif $checkingPartner.country == 'HK'}{$checkingPartner.country|replace:'HK':'Hong Kong'} 
                                            {elseif $checkingPartner.country == 'HR'}{$checkingPartner.country|replace:'HR':'Croatia'} 
                                            {elseif $checkingPartner.country == 'HU'}{$checkingPartner.country|replace:'HU':'Hungary'} 
                                            {elseif $checkingPartner.country == 'ID'}{$checkingPartner.country|replace:'ID':'Indonesia'} 
                                            {elseif $checkingPartner.country == 'IE'}{$checkingPartner.country|replace:'IE':'Ireland'} 
                                            {elseif $checkingPartner.country == 'IL'}{$checkingPartner.country|replace:'IL':'Israel'} 
                                            {elseif $checkingPartner.country == 'IN'}{$checkingPartner.country|replace:'IN':'India'}
                                            {elseif $checkingPartner.country == 'IT'}{$checkingPartner.country|replace:'IT':'Italy'} 
                                            {elseif $checkingPartner.country == 'JP'}{$checkingPartner.country|replace:'JP':'Japan'}
                                            {elseif $checkingPartner.country == 'KE'}{$checkingPartner.country|replace:'KE':'Kenya'} 
                                            {elseif $checkingPartner.country == 'LK'}{$checkingPartner.country|replace:'LK':'Falkland Islands (Malvinas)'}
                                            {elseif $checkingPartner.country == 'LU'}{$checkingPartner.country|replace:'LU':'Luxembourg'} 
                                            {elseif $checkingPartner.country == 'MX'}{$checkingPartner.country|replace:'MX':'Mexico'}
                                            {elseif $checkingPartner.country == 'MY'}{$checkingPartner.country|replace:'MY':'Malaysia'} 
                                            {elseif $checkingPartner.country == 'NL'}{$checkingPartner.country|replace:'NL':'Netherlands'}
                                            {elseif $checkingPartner.country == 'NO'}{$checkingPartner.country|replace:'NO':'Norway'} 
                                            {elseif $checkingPartner.country == 'NG'}{$checkingPartner.country|replace:'NG':'Nigeria'} 
                                            {elseif $checkingPartner.country == 'NZ'}{$checkingPartner.country|replace:'NZ':'New Zealand'}
                                            {elseif $checkingPartner.country == 'PH'}{$checkingPartner.country|replace:'PH':'Philippines'} 
                                            {elseif $checkingPartner.country == 'PK'}{$checkingPartner.country|replace:'PK':'Pakistan'}
                                            {elseif $checkingPartner.country == 'PL'}{$checkingPartner.country|replace:'PL':'Poland'} 
                                            {elseif $checkingPartner.country == 'RO'}{$checkingPartner.country|replace:'RO':'Romania'}
                                            {elseif $checkingPartner.country == 'RS'}{$checkingPartner.country|replace:'RS':'Serbia'}
                                            {elseif $checkingPartner.country == 'SG'}{$checkingPartner.country|replace:'SG':'Singapore'}
                                            {elseif $checkingPartner.country == 'TH'}{$checkingPartner.country|replace:'TH':'Thailand'}
                                            {elseif $checkingPartner.country == 'TR'}{$checkingPartner.country|replace:'TR':'Turkey'}
                                            {elseif $checkingPartner.country == 'UA'}{$checkingPartner.country|replace:'UA':'Ukraine'}
                                            {elseif $checkingPartner.country == 'US'}{$checkingPartner.country|replace:'US':'United States'}    
                                            {elseif $checkingPartner.country == 'ZA'}{$checkingPartner.country|replace:'ZA':'South Africa'}
                                            {else}{$checkingPartner.country}  
                                            {/if}
                            </td>
                        </tr>
                         <tr>
                            <td>Company Name :</td>
                            <td class="cell-border">{$checkingPartner.company_name} </td>
                        </tr>
                         <tr>
                            <td>Logo :</td>
                            <td class="cell-border">{if $checkingPartner.logo ==''}-{else}<img src="{$template_dir}images/{$checkingPartner.logo}" alt="" style="max-height: 100px;max-width: 300px;">{/if}</td>
                        </tr>
                        <tr>
                            <td>Website :</td>
                            <td class="cell-border"><a href="https://www.{$checkingPartner.web_url}" target="_blank"><span style="padding: 0px 0px;font-size: 16px">{$checkingPartner.web_url}</span></a></td>
                        </tr>
                        <tr>
                            <td>Brief Info :</td>
                            <td class="cell-border">{$checkingPartner.title} </td>
                         </tr>
                         <tr>
                            <td>Status :</td>
                            <td class="cell-border">
                                <span style="padding: 0px 0px;font-size: 16px;color:green;">Active</span>
                           </td>
                        </tr>
                        {if $checkingPartner.status_edit_company == 0}
                        
                        <tr>
                            <td>New Submitted Detail :</td>
                            <td class="cell-border"><span style="padding: 0px 0px;font-size: 16px;color:red;">Waiting for Approval</span></a></td>
                        </tr>
                         <tr>
                              <td colspan="2"  style="text-align: left;">        
                                <a href="https://rvsitebuilder.com/hosting-partner/" target="_blank">
                                   <button class="btn-check-border" > View all Hosting Partner<b>  > </b></button>
                                  
                                </a>
                             </td>
                        </tr>
                        {else}
                  
                            {if isset($accountProduct.client_id)}
                                 <tr>
                                      <td colspan="2"  style="text-align: left;">
                                           <button class="btn-check-border edit" > Edit </button>
                                        <a href="https://rvsitebuilder.com/hosting-partner/" target="_blank">
                                           <button class="btn-check-border" > View all Hosting Partner<b>  > </b></button>
                                          
                                        </a>
                                     </td>
                                </tr>
                                {else}
                                 <tr>
                                      <td colspan="2"  style="text-align: left;">
                                        <a href="https://rvsitebuilder.com/hosting-partner/" target="_blank">
                                           <button class="btn-check-border" > View all Hosting Partner<b>  > </b></button>
                                        </a>
                                     </td>
                                </tr>
                                {/if}
                        {/if}
                </tbody>
            </table>
        </div>  
        <div class='phone'> 
            <div class="table-header-phone" style="height: 37px;">
               <p style="font-size: 16px;padding: 7px;font-weight: bold;">Your Company Details</p>
            </div>
                <table class=" table table-hover" style="font-size: 14px;">
                    <tbody>              
                        <tr>
                            <td style="width:114px;padding: 7px 4px 9px 8px">Country : </td>
                            <td class="cell-border">
                                {if $checkingPartner.country == 'AF'}{$checkingPartner.country|replace:'AF':'Afghanistan'}
                                            {elseif $checkingPartner.country == 'AX'}{$checkingPartner.country|replace:'AX':'Aland Islands'}
                                            {elseif $checkingPartner.country == 'AL'}{$checkingPartner.country|replace:'AL':'Albania'}
                                            {elseif $checkingPartner.country == 'DZ'}{$checkingPartner.country|replace:'DZ':'Algeria'}
                                            {elseif $checkingPartner.country == 'AS'}{$checkingPartner.country|replace:'AS':'American'}
                                            {elseif $checkingPartner.country == 'AD'}{$checkingPartner.country|replace:'AD':'Andorra'}
                                            {elseif $checkingPartner.country == 'AO'}{$checkingPartner.country|replace:'AO':'Angola'}
                                            {elseif $checkingPartner.country == 'AI'}{$checkingPartner.country|replace:'AI':'Anguilla'}
                                            {elseif $checkingPartner.country == 'AG'}{$checkingPartner.country|replace:'AG':'Antigua And Barbuda'}
                                            {elseif $checkingPartner.country == 'AR'}{$checkingPartner.country|replace:'AR':'Argentina'}
                                            {elseif $checkingPartner.country == 'AM'}{$checkingPartner.country|replace:'AM':'Armenia'}
                                            {elseif $checkingPartner.country == 'AW'}{$checkingPartner.country|replace:'AW':'Aruba'}
                                            {elseif $checkingPartner.country == 'AQ'}{$checkingPartner.country|replace:'AQ':'Antarctica'}
                                            {elseif $checkingPartner.country == 'AU'}{$checkingPartner.country|replace:'AU':'Australia'}
                                            {elseif $checkingPartner.country == 'AT'}{$checkingPartner.country|replace:'AT':'Austria'}
                                            {elseif $checkingPartner.country == 'AZ'}{$checkingPartner.country|replace:'AZ':'Azerbaijan'}
                                            {elseif $checkingPartner.country == 'BS'}{$checkingPartner.country|replace:'BS':'Bahamas'}
                                            {elseif $checkingPartner.country == 'BH'}{$checkingPartner.country|replace:'BH':'Bahrain'}
                                            {elseif $checkingPartner.country == 'BD'}{$checkingPartner.country|replace:'BD':'Bangladesh'}
                                            {elseif $checkingPartner.country == 'BB'}{$checkingPartner.country|replace:'BB':'Barbados'}
                                            {elseif $checkingPartner.country == 'BY'}{$checkingPartner.country|replace:'BY':'Belarus'}
                                            {elseif $checkingPartner.country == 'BE'}{$checkingPartner.country|replace:'BE':'Belgium'}
                                            {elseif $checkingPartner.country == 'BZ'}{$checkingPartner.country|replace:'BZ':'Belize'}
                                            {elseif $checkingPartner.country == 'BJ'}{$checkingPartner.country|replace:'BJ':'Benin'}
                                            {elseif $checkingPartner.country == 'BM'}{$checkingPartner.country|replace:'BM':'Bermuda'}
                                            {elseif $checkingPartner.country == 'BT'}{$checkingPartner.country|replace:'BT':'Bhutan'}
                                            {elseif $checkingPartner.country == 'BO'}{$checkingPartner.country|replace:'BO':'Bolivia'}
                                            {elseif $checkingPartner.country == 'BA'}{$checkingPartner.country|replace:'BA':'Bosnia And Herzegovina'}
                                            {elseif $checkingPartner.country == 'BW'}{$checkingPartner.country|replace:'BW':'Botswana'}
                                            {elseif $checkingPartner.country == 'BV'}{$checkingPartner.country|replace:'BV':'Bouvet'}
                                            {elseif $checkingPartner.country == 'BR'}{$checkingPartner.country|replace:'BR':'Brazil'}
                                            {elseif $checkingPartner.country == 'IO'}{$checkingPartner.country|replace:'IO':'British Indian Ocean Territory'}
                                            {elseif $checkingPartner.country == 'BN'}{$checkingPartner.country|replace:'BN':'Brunei Darussalam'}
                                            {elseif $checkingPartner.country == 'BG'}{$checkingPartner.country|replace:'BG':'Bulgaria'}
                                            {elseif $checkingPartner.country == 'BF'}{$checkingPartner.country|replace:'BF':'Burkina Faso'}
                                            {elseif $checkingPartner.country == 'BI'}{$checkingPartner.country|replace:'BI':'Burundi'}
                                            {elseif $checkingPartner.country == 'KH'}{$checkingPartner.country|replace:'KH':'Cambodia'}
                                            {elseif $checkingPartner.country == 'CM'}{$checkingPartner.country|replace:'CM':'Cameroon'}
                                            {elseif $checkingPartner.country == 'CA'}{$checkingPartner.country|replace:'CA':'Canada'}
                                            {elseif $checkingPartner.country == 'CV'}{$checkingPartner.country|replace:'CV':'Cape Verde'}
                                            {elseif $checkingPartner.country == 'KY'}{$checkingPartner.country|replace:'KY':'Cayman Islands'}
                                            {elseif $checkingPartner.country == 'CF'}{$checkingPartner.country|replace:'CF':'Central African Republic'}
                                            {elseif $checkingPartner.country == 'TD'}{$checkingPartner.country|replace:'TD':'Chad'}
                                            {elseif $checkingPartner.country == 'CL'}{$checkingPartner.country|replace:'CL':'Chile'}
                                            {elseif $checkingPartner.country == 'CN'}{$checkingPartner.country|replace:'CN':'China'}
                                            {elseif $checkingPartner.country == 'CX'}{$checkingPartner.country|replace:'CX':'Christmas Island'}
                                            {elseif $checkingPartner.country == 'CC'}{$checkingPartner.country|replace:'CC':'Cocos (Keeling) Islands'}
                                            {elseif $checkingPartner.country == 'CO'}{$checkingPartner.country|replace:'CO':'Colombia'}
                                            {elseif $checkingPartner.country == 'KM'}{$checkingPartner.country|replace:'KM':'Comoros'}
                                            {elseif $checkingPartner.country == 'CG'}{$checkingPartner.country|replace:'CG':'Congo'}
                                            {elseif $checkingPartner.country == 'CD'}{$checkingPartner.country|replace:'CD':'Congo, Democratic Republic'}
                                            {elseif $checkingPartner.country == 'CK'}{$checkingPartner.country|replace:'CK':'Cook Islands'}
                                            {elseif $checkingPartner.country == 'CR'}{$checkingPartner.country|replace:'CR':'Costa Rica'}
                                            {elseif $checkingPartner.country == 'HR'}{$checkingPartner.country|replace:'HR':'Croatia'}
                                            {elseif $checkingPartner.country == 'CU'}{$checkingPartner.country|replace:'CU':'Cuba'}
                                            {elseif $checkingPartner.country == 'CY'}{$checkingPartner.country|replace:'CY':'Cyprus'}
                                            {elseif $checkingPartner.country == 'CZ'}{$checkingPartner.country|replace:'CZ':'Czech Republic'}
                                            {elseif $checkingPartner.country == 'DK'}{$checkingPartner.country|replace:'DK':'Denmark'}
                                            {elseif $checkingPartner.country == 'DM'}{$checkingPartner.country|replace:'DM':'Dominica'}
                                            {elseif $checkingPartner.country == 'DO'}{$checkingPartner.country|replace:'DO':'Dominican Republic'}
                                            {elseif $checkingPartner.country == 'EC'}{$checkingPartner.country|replace:'EC':'Ecuador'}
                                            {elseif $checkingPartner.country == 'EE'}{$checkingPartner.country|replace:'EE':'Estonia'}
                                            {elseif $checkingPartner.country == 'EG'}{$checkingPartner.country|replace:'EG':'Egypt'}
                                            {elseif $checkingPartner.country == 'ES'}{$checkingPartner.country|replace:'ES':'Spain'}
                                            {elseif $checkingPartner.country == 'FI'}{$checkingPartner.country|replace:'FI':'Finland'}
                                            {elseif $checkingPartner.country == 'FR'}{$checkingPartner.country|replace:'FR':'France'}
                                            {elseif $checkingPartner.country == 'GB'}{$checkingPartner.country|replace:'GB':'United Kingdom'}
                                            {elseif $checkingPartner.country == 'GH'}{$checkingPartner.country|replace:'GH':'Ghana'} 
                                            {elseif $checkingPartner.country == 'GR'}{$checkingPartner.country|replace:'GR':'Greece'} 
                                            {elseif $checkingPartner.country == 'GT'}{$checkingPartner.country|replace:'GT':'Guatemala'} 
                                            {elseif $checkingPartner.country == 'HK'}{$checkingPartner.country|replace:'HK':'Hong Kong'} 
                                            {elseif $checkingPartner.country == 'HR'}{$checkingPartner.country|replace:'HR':'Croatia'} 
                                            {elseif $checkingPartner.country == 'HU'}{$checkingPartner.country|replace:'HU':'Hungary'} 
                                            {elseif $checkingPartner.country == 'ID'}{$checkingPartner.country|replace:'ID':'Indonesia'} 
                                            {elseif $checkingPartner.country == 'IE'}{$checkingPartner.country|replace:'IE':'Ireland'} 
                                            {elseif $checkingPartner.country == 'IL'}{$checkingPartner.country|replace:'IL':'Israel'} 
                                            {elseif $checkingPartner.country == 'IN'}{$checkingPartner.country|replace:'IN':'India'}
                                            {elseif $checkingPartner.country == 'IT'}{$checkingPartner.country|replace:'IT':'Italy'} 
                                            {elseif $checkingPartner.country == 'JP'}{$checkingPartner.country|replace:'JP':'Japan'}
                                            {elseif $checkingPartner.country == 'KE'}{$checkingPartner.country|replace:'KE':'Kenya'} 
                                            {elseif $checkingPartner.country == 'LK'}{$checkingPartner.country|replace:'LK':'Falkland Islands (Malvinas)'}
                                            {elseif $checkingPartner.country == 'LU'}{$checkingPartner.country|replace:'LU':'Luxembourg'} 
                                            {elseif $checkingPartner.country == 'MX'}{$checkingPartner.country|replace:'MX':'Mexico'}
                                            {elseif $checkingPartner.country == 'MY'}{$checkingPartner.country|replace:'MY':'Malaysia'} 
                                            {elseif $checkingPartner.country == 'NL'}{$checkingPartner.country|replace:'NL':'Netherlands'}
                                            {elseif $checkingPartner.country == 'NO'}{$checkingPartner.country|replace:'NO':'Norway'} 
                                            {elseif $checkingPartner.country == 'NZ'}{$checkingPartner.country|replace:'NZ':'New Zealand'}
                                            {elseif $checkingPartner.country == 'NG'}{$checkingPartner.country|replace:'NG':'Nigeria'} 
                                            {elseif $checkingPartner.country == 'PH'}{$checkingPartner.country|replace:'PH':'Philippines'} 
                                            {elseif $checkingPartner.country == 'PK'}{$checkingPartner.country|replace:'PK':'Pakistan'}
                                            {elseif $checkingPartner.country == 'PL'}{$checkingPartner.country|replace:'PL':'Poland'} 
                                            {elseif $checkingPartner.country == 'RO'}{$checkingPartner.country|replace:'RO':'Romania'}
                                            {elseif $checkingPartner.country == 'RS'}{$checkingPartner.country|replace:'RS':'Serbia'}
                                            {elseif $checkingPartner.country == 'SG'}{$checkingPartner.country|replace:'SG':'Singapore'}
                                            {elseif $checkingPartner.country == 'TH'}{$checkingPartner.country|replace:'TH':'Thailand'}
                                            {elseif $checkingPartner.country == 'TR'}{$checkingPartner.country|replace:'TR':'Turkey'}
                                            {elseif $checkingPartner.country == 'UA'}{$checkingPartner.country|replace:'UA':'Ukraine'}
                                            {elseif $checkingPartner.country == 'US'}{$checkingPartner.country|replace:'US':'United States'}    
                                            {elseif $checkingPartner.country == 'ZA'}{$checkingPartner.country|replace:'ZA':'South Africa'}
                                            {else}{$checkingPartner.country}  
                                            {/if}
                            </td>
                        </tr>
                         <tr>
                            <td style="padding: 7px 4px 9px 8px;">Company Name :</td>
                            <td class="cell-border">{$checkingPartner.company_name} </td>
                        </tr>
                         <tr>
                            <td style="padding: 7px 4px 9px 8px">Logo :</td>
                            <td class="cell-border">{if $checkingPartner.logo ==''}-{else}<img src="{$template_dir}images/{$checkingPartner.logo}" alt="" style="max-height: 60px;max-width: 120px;">{/if}</td>
                        </tr>
                        <tr>
                            <td style="padding: 7px 4px 9px 8px">Website :</td>
                            <td class="cell-border"><a href="https://www.{$checkingPartner.web_url}" target="_blank"><span style="padding: 0px 0px;font-size: 14px">{$checkingPartner.web_url}</span></a></td>
                        </tr>
                        <tr>
                            <td style="padding: 7px 4px 9px 8px">Brief Info :</td>
                            <td class="cell-border">{if $checkingPartner.title ==''}-{else}{$checkingPartner.title} {/if}</td>
                         </tr>
                         <tr>
                            <td style="padding: 7px 4px 9px 8px">Status :</td>
                            <td class="cell-border">
                                <span style="padding: 0px 0px;font-size: 14px;color:green;font-weight: bold;">Active</span>
                           </td>
                        </tr>
                        {if $checkingPartner.status_edit_company == 0}
                        
                        <tr>
                            <td>New Submitted Detail :</td>
                            <td class="cell-border"><span style="padding: 0px 0px;font-size: 14px;color:red;font-weight: bold;">Waiting for Approval</span></a></td>
                        </tr>
                         <tr>
                              <td colspan="2"  style="text-align: left;">        
                                <a href="https://rvsitebuilder.com/hosting-partner/" target="_blank">
                                   <button class="btn-check-border" > View all Hosting Partner<b>  > </b></button>
                                  
                                </a>
                             </td>
                        </tr>
                        {else}
                         <tr>
                              <td colspan="2"  style="text-align: left;">
                                   <button class="btn-check-border edit" > Edit </button>
                                <a href="https://rvsitebuilder.com/hosting-partner/" target="_blank">
                                   <button class="btn-check-border" > View all Hosting Partner<b>  > </b></button>
                                  
                                </a>
                             </td>
                        </tr>
                        {/if}
                </tbody>
            </table>
        </div>     
    </div>
    <div class="table-box  Edit box-form"  >
        <div class="desktop">
            <div class="table-header">
                <p>I would like to edit my company detail.</p>
            </div>
            <form  method="post" action="" id="eidtCompany" enctype="multipart/form-data">
                <table class=" table table-hover">
                    <tbody>
                        <tr style="display: none">
                            <td>Client ID </td>      
                            <td><input type="text" name="clientId"  class="clientId" value="{$checkingPartner.client_id} "disabled> </td>       
                        </tr>
                         <tr>
                            <td>Company Name :</td>
                            <td class="cell-border"> <input type="text"  class="companyName"  name="editcompanyName" value="{$checkingPartner.company_name}"  ></td>
                        </tr>
                         <tr>
                            <td>Logo :</td>
                            <td class="cell-border"><img src="{$template_dir}images/{$checkingPartner.logo}" class='logo' alt="" style="max-height: 100px;max-width: 300px;"><br>
                                                    <input type="file" name="Editlogoupload"  class="Editlogoupload" id='myFile'><span class ='warning' style="color:red;display: none">**Please choose the new image or resize to be less than 150 KB</span>
                            </td>
                        </tr>
                        <tr>
                            <td>Website URL :</td>
                            <td class="cell-border"><input type="text"   name="editWeburl" class="weburl" value="{$checkingPartner.web_url}" placeholder="hello123.com"> 
                             <span class ='warningWeb' style="color:red;display: none">You entered the wrong  URL website!!( e.g. hello123.com )</span>
                            </td>
                        </tr>
                        <tr>
                            <td>Brief Info :</td>
                            <td class="cell-border"><textarea name="editTitle" class="title" value="{$checkingPartner.title}"  maxlength="70" >{$checkingPartner.title}</textarea> 
                              <br><span style="font-size: 14px;color: #737373;padding: 0px;">(Maximum 70 characters including spaces)</span>  
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"  style="text-align: center;">
                                <input type="submit" name="save"  class="saveEdit" value="Save" style="background-color:#339e43;color:#FFFFFF">
                                <input type="button" name="backCompany" class="backCompany" value="Back"  style="background-color:#336fbc;color:#FFFFFF" />
                            </td>
                            
                        </tr>
                    </tbody>
                </table>
            </form>  
        </div>
        
        <div class="phone">
          <div class="table-header-phone" style="height: 37px;">
                <p style="font-size: 13px;padding: 7px;font-weight: bold;">I would like to edit my company detail . </p>
            </div>
            <form  method="post" action="" id="eidtCompany" enctype="multipart/form-data">
                <table class=" table table-hover phone">
                    <tbody>
                        <tr style="display: none">
                            <td>Client ID </td>      
                            <td><input type="text" name="clientId"  class="clientId" value="{$checkingPartner.client_id} "disabled> </td>       
                        </tr>
                         <tr>
                            <td>Company Name :</td>
                         </tr>
                         <tr>
                            <td class="cell-border"> <input type="text"  class="companyName"  name="editcompanyName" value="{$checkingPartner.company_name}"  ></td>
                        </tr>
                         <tr>
                            <td>Logo :</td>
                         </tr>
                         <tr>
                            <td class="cell-border"><img src="{$template_dir}images/{$checkingPartner.logo}" class='logo' alt="" style="max-height: 60px;max-width: 120px;"><br>
                                                    <input type="file" name="Editlogoupload"  class="Editlogoupload" id='myFile'><span class ='warning' style="color:red;display: none">**Please choose the new image or resize to be less than 150 KB</span>
                            </td>
                        </tr>
                        <tr>
                            <td>Website URL :</td>
                        </tr>
                        <tr>
                            <td class="cell-border"><input type="text"   name="editWeburl" class="weburl-phone" value="{$checkingPartner.web_url}"> 
                                <span class ='warningWeb-phone' style="color:red ;font-size: 15px;padding: 0px;display: none"><br>You entered the wrong  URL website!!( e.g. hello123.com )</span></td>
                        </tr>
                        <tr>
                            <td>Brief Info :</td>
                        </tr>
                        <tr>    
                            <td class="cell-border"><textarea  name="editTitle" class="title" value="{$checkingPartner.title}"  maxlength="70">{$checkingPartner.title} </textarea>
                             <br><span style="font-size: 13px;padding: 0px;color: #737373;">(Maximum 70 characters including spaces)</span>
                            </td>
                        </tr>
                          <tr>
                            <td colspan="2"  style="text-align: center;">
                                <input type="submit" name="save"  class="saveEdit" value="Save" style="background-color:#339e43;color:#FFFFFF">
                                <input type="button" name="backCompany" class="backCompany" value="Back"  style="background-color:#336fbc;color:#FFFFFF" />
                            </td>
                            
                        </tr>
                    </tbody>
                </table>
            </form>  
        </div>
    </div>
                 

{elseif $checkingPartner.status == 0 &&  $checkingPartner.client_id != 0 } 
<div class="clear clearfix">
   <h5 class="hosting-free desktop">
        <span class='newtab'> New</span>
        &nbsp;&nbsp;Free Marketing for RVsitebuilder Hosting Provider
    </h5>
    <h5 class="hosting-free phone">
        <span class="newtab"> New</span>
        &nbsp;&nbsp;Free Marketing for RVsitebuilder Hosting Provider
    </h5>
           <div class="left-btns detialCompany" style="margin-bottom: 27px;"> 
                <button class="viewdetial"   style="border: solid 3px #ff8003;color: #ec360f; background-color: #ffffff;"  >
                    <i class='icon-view'></i>View Company Details
                </button>
            </div>
       <div class="table-box box-form show-company" style="margin-bottom: 40px;" >
            <div class="desktop">
                <div class="table-header">
                   <p>Your Company Detail</p>
                </div>
                    <table class=" table table-hover" style="font-size: 16px;">
                        <tbody>              
                             <tr>
                                <td style="width:217px;">Company Name</td>
                                <td class="cell-border">{$checkingPartner.company_name}</td>
                            </tr>
                             <tr>
                                <td>Logo</td>
                                <td class="cell-border">{if $checkingPartner.logo ==''}-{else}<img src="{$template_dir}images/{$checkingPartner.logo}" alt="" style="max-height: 100px;max-width: 300px;">{/if}</td>
                            </tr>
                            <tr>
                                <td>Website</td>
                                <td class="cell-border"><a href="https://www.{$checkingPartner.web_url}" target="_blank"><span style="padding: 0px 0px;font-size: 16px">{$checkingPartner.web_url}</span></a></td>
                            </tr>
                             <tr>
                                <td>Brief Info :</td>
                                <td class="cell-border">{$checkingPartner.title}</td>
                            </tr>
                             <tr>
                                <td>Status</td>
                                <td class="cell-border"><span style="padding: 0px 0px;font-size: 16px;color:red;">Waiting for Approval</span></a></td>
                            </tr>
                             <tr>
                                 <td colspan="2" style="text-align: left;">
                                    <a href="https://rvsitebuilder.com/hosting-partner/" target="_blank">
                                       <button class="btn-check-border" > View all Hosting Partner<b>  > </b></button>
                                      
                                    </a>
                                 </td>
                            </tr>
                            
                    </tbody>
                </table>
                </div>
                <div class="phone">
                <div class="table-header-phone" style="height: 37px;">
                   <p style="font-size: 16px;padding: 7px;font-weight: bold;">Your Company Detail</p>
                </div>
                    <table class=" table table-hover" style="font-size: 14px;">
                        <tbody>              
                             <tr>
                                <td style="width:114px;padding: 7px 4px 9px 8px;">Company Name :</td>
                                <td class="cell-border">{$checkingPartner.company_name}</td>
                            </tr>
                             <tr>
                                <td>Logo</td>
                                <td class="cell-border">{if $checkingPartner.logo ==''}-{else}<img src="{$template_dir}images/{$checkingPartner.logo}" alt="" style="max-height: 60px;max-width: 120px;">{/if}</td>
                            </tr>
                            <tr>
                                <td>Website</td>
                                <td class="cell-border"><a href="https://www.{$checkingPartner.web_url}" target="_blank"><span style="padding: 0px 0px;font-size: 16px">{$checkingPartner.web_url}</span></a></td>
                            </tr>
                             <tr>
                                <td>Brief Info :</td>
                                <td class="cell-border">{$checkingPartner.title}</td>
                            </tr>
                             <tr>
                                <td>Status</td>
                                <td class="cell-border"><span style="padding: 0px 0px;font-size: 14px;color:red;font-weight: bold;">Waiting for Approval</span></a></td>
                            </tr>
                             <tr>
                                 <td colspan="2" style="text-align: left;">
                                    <a href="https://rvsitebuilder.com/hosting-partner/" target="_blank">
                                       <button class="btn-check-border" > View all Hosting Partner<b>  > </b></button>
                                      
                                    </a>
                                 </td>
                            </tr>
                            
                    </tbody>
                </table>
                </div>
            </div>
     </div>
{else}
    {if $accountProduct.client_id != 0}
    <div class="clear clearfix">
     <h5 class="hosting-free desktop">
        <span class='newtab'> New</span>
        &nbsp;&nbsp;Free Marketing for RVsitebuilder Hosting Provider
    </h5>
    <h5 class="hosting-free phone">
        <span class="newtab"> New</span>
        &nbsp;&nbsp;Free Marketing for RVsitebuilder Hosting Provider
    </h5> 
       
           <div class="clear clearfix">
            <div class="left-btns addCompany" style="margin-bottom: 27px;">
                <button class="btn-add"><i class="icon-grey-add" style="margin: 4px 4px;"></i>Add Company</button>
            </div>
            <div class="table-box box-form AddCompany">
                <div class="desktop">
                    <div class="table-header">
                        <p>I would like to have my company name shows on RVsitebuilder website to gain more customers. </p>
                    </div>
                    <form   method="post" action="" class="formCompany" enctype="multipart/form-data">
                        <table class=" table table-hover ">
                            <tbody>
                                <tr style="display: none">
                                    <td>Client ID </td>      
                                    <td ><input type="text" name="clientId"  class="clientId" value="{$accountProduct.client_id}" disabled> </td>       
                                </tr>
                                <tr>
                                    <td>Country </td>
                                    <td class="cell-border">
                                             <input type="text" name="country"  class="country" 
                                             value="{if $accountProduct.country == 'AF'}{$accountProduct.country|replace:'AF':'Afghanistan'}
                                                    {elseif $accountProduct.country == 'AX'}{$accountProduct.country|replace:'AX':'Aland Islands'}
                                                    {elseif $accountProduct.country == 'AL'}{$accountProduct.country|replace:'AL':'Albania'}
                                                    {elseif $accountProduct.country == 'DZ'}{$accountProduct.country|replace:'DZ':'Algeria'}
                                                    {elseif $accountProduct.country == 'AS'}{$accountProduct.country|replace:'AS':'American'}
                                                    {elseif $accountProduct.country == 'AD'}{$accountProduct.country|replace:'AD':'Andorra'}
                                                    {elseif $accountProduct.country == 'AO'}{$accountProduct.country|replace:'AO':'Angola'}
                                                    {elseif $accountProduct.country == 'AI'}{$accountProduct.country|replace:'AI':'Anguilla'}
                                                    {elseif $accountProduct.country == 'AG'}{$accountProduct.country|replace:'AG':'Antigua And Barbuda'}
                                                    {elseif $accountProduct.country == 'AR'}{$accountProduct.country|replace:'AR':'Argentina'}
                                                    {elseif $accountProduct.country == 'AM'}{$accountProduct.country|replace:'AM':'Armenia'}
                                                    {elseif $accountProduct.country == 'AW'}{$accountProduct.country|replace:'AW':'Aruba'}
                                                    {elseif $accountProduct.country == 'AQ'}{$accountProduct.country|replace:'AQ':'Antarctica'}
                                                    {elseif $accountProduct.country == 'AU'}{$accountProduct.country|replace:'AU':'Australia'}
                                                    {elseif $accountProduct.country == 'AT'}{$accountProduct.country|replace:'AT':'Austria'}
                                                    {elseif $accountProduct.country == 'AZ'}{$accountProduct.country|replace:'AZ':'Azerbaijan'}
                                                    {elseif $accountProduct.country == 'BS'}{$accountProduct.country|replace:'BS':'Bahamas'}
                                                    {elseif $accountProduct.country == 'BH'}{$accountProduct.country|replace:'BH':'Bahrain'}
                                                    {elseif $accountProduct.country == 'BD'}{$accountProduct.country|replace:'BD':'Bangladesh'}
                                                    {elseif $accountProduct.country == 'BB'}{$accountProduct.country|replace:'BB':'Barbados'}
                                                    {elseif $accountProduct.country == 'BY'}{$accountProduct.country|replace:'BY':'Belarus'}
                                                    {elseif $accountProduct.country == 'BE'}{$accountProduct.country|replace:'BE':'Belgium'}
                                                    {elseif $accountProduct.country == 'BZ'}{$accountProduct.country|replace:'BZ':'Belize'}
                                                    {elseif $accountProduct.country == 'BJ'}{$accountProduct.country|replace:'BJ':'Benin'}
                                                    {elseif $accountProduct.country == 'BM'}{$accountProduct.country|replace:'BM':'Bermuda'}
                                                    {elseif $accountProduct.country == 'BT'}{$accountProduct.country|replace:'BT':'Bhutan'}
                                                    {elseif $accountProduct.country == 'BO'}{$accountProduct.country|replace:'BO':'Bolivia'}
                                                    {elseif $accountProduct.country == 'BA'}{$accountProduct.country|replace:'BA':'Bosnia And Herzegovina'}
                                                    {elseif $accountProduct.country == 'BW'}{$accountProduct.country|replace:'BW':'Botswana'}
                                                    {elseif $accountProduct.country == 'BV'}{$accountProduct.country|replace:'BV':'Bouvet'}
                                                    {elseif $accountProduct.country == 'BR'}{$accountProduct.country|replace:'BR':'Brazil'}
                                                    {elseif $accountProduct.country == 'IO'}{$accountProduct.country|replace:'IO':'British Indian Ocean Territory'}
                                                    {elseif $accountProduct.country == 'BN'}{$accountProduct.country|replace:'BN':'Brunei Darussalam'}
                                                    {elseif $accountProduct.country == 'BG'}{$accountProduct.country|replace:'BG':'Bulgaria'}
                                                    {elseif $accountProduct.country == 'BF'}{$accountProduct.country|replace:'BF':'Burkina Faso'}
                                                    {elseif $accountProduct.country == 'BI'}{$accountProduct.country|replace:'BI':'Burundi'}
                                                    {elseif $accountProduct.country == 'KH'}{$accountProduct.country|replace:'KH':'Cambodia'}
                                                    {elseif $accountProduct.country == 'CM'}{$accountProduct.country|replace:'CM':'Cameroon'}
                                                    {elseif $accountProduct.country == 'CA'}{$accountProduct.country|replace:'CA':'Canada'}
                                                    {elseif $accountProduct.country == 'CV'}{$accountProduct.country|replace:'CV':'Cape Verde'}
                                                    {elseif $accountProduct.country == 'KY'}{$accountProduct.country|replace:'KY':'Cayman Islands'}
                                                    {elseif $accountProduct.country == 'CF'}{$accountProduct.country|replace:'CF':'Central African Republic'}
                                                    {elseif $accountProduct.country == 'TD'}{$accountProduct.country|replace:'TD':'Chad'}
                                                    {elseif $accountProduct.country == 'CL'}{$accountProduct.country|replace:'CL':'Chile'}
                                                    {elseif $accountProduct.country == 'CN'}{$accountProduct.country|replace:'CN':'China'}
                                                    {elseif $accountProduct.country == 'CX'}{$accountProduct.country|replace:'CX':'Christmas Island'}
                                                    {elseif $accountProduct.country == 'CC'}{$accountProduct.country|replace:'CC':'Cocos (Keeling) Islands'}
                                                    {elseif $accountProduct.country == 'CO'}{$accountProduct.country|replace:'CO':'Colombia'}
                                                    {elseif $accountProduct.country == 'KM'}{$accountProduct.country|replace:'KM':'Comoros'}
                                                    {elseif $accountProduct.country == 'CG'}{$accountProduct.country|replace:'CG':'Congo'}
                                                    {elseif $accountProduct.country == 'CD'}{$accountProduct.country|replace:'CD':'Congo, Democratic Republic'}
                                                    {elseif $accountProduct.country == 'CK'}{$accountProduct.country|replace:'CK':'Cook Islands'}
                                                    {elseif $accountProduct.country == 'CR'}{$accountProduct.country|replace:'CR':'Costa Rica'}
                                                    {elseif $accountProduct.country == 'HR'}{$accountProduct.country|replace:'HR':'Croatia'}
                                                    {elseif $accountProduct.country == 'CU'}{$accountProduct.country|replace:'CU':'Cuba'}
                                                    {elseif $accountProduct.country == 'CY'}{$accountProduct.country|replace:'CY':'Cyprus'}
                                                    {elseif $accountProduct.country == 'CZ'}{$accountProduct.country|replace:'CZ':'Czech Republic'}
                                                    {elseif $accountProduct.country == 'DK'}{$accountProduct.country|replace:'DK':'Denmark'}
                                                    {elseif $accountProduct.country == 'DM'}{$accountProduct.country|replace:'DM':'Dominica'}
                                                    {elseif $accountProduct.country == 'DO'}{$accountProduct.country|replace:'DO':'Dominican Republic'}
                                                    {elseif $accountProduct.country == 'EC'}{$accountProduct.country|replace:'EC':'Ecuador'}
                                                    {elseif $accountProduct.country == 'EE'}{$accountProduct.country|replace:'EE':'Estonia'}
                                                    {elseif $accountProduct.country == 'EG'}{$accountProduct.country|replace:'EG':'Egypt'}
                                                    {elseif $accountProduct.country == 'ES'}{$accountProduct.country|replace:'ES':'Spain'}
                                                    {elseif $accountProduct.country == 'FI'}{$accountProduct.country|replace:'FI':'Finland'}
                                                    {elseif $accountProduct.country == 'FR'}{$accountProduct.country|replace:'FR':'France'}
                                                    {elseif $accountProduct.country == 'GB'}{$accountProduct.country|replace:'GB':'United Kingdom'}
                                                    {elseif $accountProduct.country == 'GH'}{$accountProduct.country|replace:'GH':'Ghana'} 
                                                    {elseif $accountProduct.country == 'GR'}{$accountProduct.country|replace:'GR':'Greece'} 
                                                    {elseif $accountProduct.country == 'GT'}{$accountProduct.country|replace:'GT':'Guatemala'} 
                                                    {elseif $accountProduct.country == 'HK'}{$accountProduct.country|replace:'HK':'Hong Kong'} 
                                                    {elseif $accountProduct.country == 'HR'}{$accountProduct.country|replace:'HR':'Croatia'} 
                                                    {elseif $accountProduct.country == 'HU'}{$accountProduct.country|replace:'HU':'Hungary'} 
                                                    {elseif $accountProduct.country == 'ID'}{$accountProduct.country|replace:'ID':'Indonesia'} 
                                                    {elseif $accountProduct.country == 'IE'}{$accountProduct.country|replace:'IE':'Ireland'} 
                                                    {elseif $accountProduct.country == 'IL'}{$accountProduct.country|replace:'IL':'Israel'} 
                                                    {elseif $accountProduct.country == 'IN'}{$accountProduct.country|replace:'IN':'India'}
                                                    {elseif $accountProduct.country == 'IT'}{$accountProduct.country|replace:'IT':'Italy'} 
                                                    {elseif $accountProduct.country == 'JP'}{$accountProduct.country|replace:'JP':'Japan'}
                                                    {elseif $accountProduct.country == 'KE'}{$accountProduct.country|replace:'KE':'Kenya'} 
                                                    {elseif $accountProduct.country == 'LK'}{$accountProduct.country|replace:'LK':'Falkland Islands (Malvinas)'}
                                                    {elseif $accountProduct.country == 'LU'}{$accountProduct.country|replace:'LU':'Luxembourg'} 
                                                    {elseif $accountProduct.country == 'MX'}{$accountProduct.country|replace:'MX':'Mexico'}
                                                    {elseif $accountProduct.country == 'MY'}{$accountProduct.country|replace:'MY':'Malaysia'} 
                                                    {elseif $accountProduct.country == 'NL'}{$accountProduct.country|replace:'NL':'Netherlands'}
                                                    {elseif $accountProduct.country == 'NO'}{$accountProduct.country|replace:'NO':'Norway'} 
                                                    {elseif $accountProduct.country == 'NZ'}{$accountProduct.country|replace:'NZ':'New Zealand'}
                                                    {elseif $accountProduct.country == 'PH'}{$accountProduct.country|replace:'PH':'Philippines'} 
                                                    {elseif $accountProduct.country == 'PK'}{$accountProduct.country|replace:'PK':'Pakistan'}
                                                    {elseif $accountProduct.country == 'PL'}{$accountProduct.country|replace:'PL':'Poland'} 
                                                    {elseif $accountProduct.country == 'RO'}{$accountProduct.country|replace:'RO':'Romania'}
                                                    {elseif $accountProduct.country == 'RS'}{$accountProduct.country|replace:'RS':'Serbia'}
                                                    {elseif $accountProduct.country == 'SG'}{$accountProduct.country|replace:'SG':'Singapore'}
                                                    {elseif $accountProduct.country == 'TR'}{$accountProduct.country|replace:'TR':'Turkey'}
                                                    {elseif $accountProduct.country == 'TH'}{$accountProduct.country|replace:'TH':'Thailand'}
                                                    {elseif $accountProduct.country == 'UA'}{$accountProduct.country|replace:'UA':'Ukraine'}
                                                    {elseif $accountProduct.country == 'US'}{$accountProduct.country|replace:'US':'United States'}
                                                    {elseif $accountProduct.country == 'ZA'}{$accountProduct.country|replace:'ZA':'South Africa'}
                                                    {else}{$accountProduct.country}  
                                                    {/if}
                                                    " disabled>              
                                         
                                    </td>
                                </tr>
                                 <tr>
                                    <td>Company Name :</td>
                                    <td class="cell-border"> <input type="text"  class="companyName"  name="companyName" value="" required="required" > </td>
                                </tr>
                                 <tr>
                                    <td>Logo :</td>
                                    <td class="cell-border"><input type="file" name="logoupload" value="logoupload" class="logoupload"><span class ='warning' style="color:red;display: none;">**Please choose the new image or resize to be less than 150 KB</span></td>
                                </tr>
                                <tr>
                                    <td>Website URL :</td>
                                    <td class="cell-border"><input type="text"   name="weburl" class="weburl" value=""  placeholder="hello123.com"required="required" >
                                        <span class ='warningWeb' style="color:red;display: none">You entered the wrong  URL website!!( e.g. hello123.com ) </span> </td>
                                </tr>
                                <tr>
                                    <td>Brief Info :</td>
                                    <td class="cell-border"><textarea  name="title" class="title" value="" maxlength="70" > </textarea> 
                                    <br><span style="font-size: 14px;padding: 0px;color: #737373;">(Maximum 70 characters including spaces)</span> 
                                    </td>
                                </tr>
                                  <tr>
                                    <td colspan="2"  style="text-align: center;">
                                        <input type="submit" name="submit"  id="submitCom" value="Submit" class='submitCom subMitCom'style="background-color:#339e43;">
                                        <input type="button" name="resetCompany" id="resetCompany" value="Reset" class='submitCom resetCompany'  style="background-color:#f12a2e;" />
                                        <input type="button" name="cancel" id="cancel" value="Cancel"  class='submitCom cancel' style="background-color:#000000;" />
                                    </td>
                                    
                                </tr>
                        </tbody>
                    </table>           
                    </form>  
                </div>
     <!-- --------- start form responsive ------------->
                 <div class="phone">
                    <div class="table-header-phone">
                        <p style="padding: 5px;font-weight:bold;">I would like to have my company name shows on RVsitebuilder website to gain more customers. </p>
                    </div>
                    <form   method="post" action="" class="formCompany-phone" enctype="multipart/form-data">
                        <table class=" table table-hover phone">
                            <tbody>
                                <tr style="display: none">
                                    <td>Client ID </td>      
                                    <td ><input type="text" name="clientId"  class="clientId" value="{$accountProduct.client_id}" disabled> </td>       
                                </tr>
                                <tr>
                                    <td><span class="add-column">Country :</span></td>
                                </tr>
                                <tr>    
                                    <td class="cell-border" style="margin-left: 5px;">
                                             <input type="text" name="country"  class="country" 
                                             value="{if $accountProduct.country == 'AF'}{$accountProduct.country|replace:'AF':'Afghanistan'}
                                                    {elseif $accountProduct.country == 'AX'}{$accountProduct.country|replace:'AX':'Aland Islands'}
                                                    {elseif $accountProduct.country == 'AL'}{$accountProduct.country|replace:'AL':'Albania'}
                                                    {elseif $accountProduct.country == 'DZ'}{$accountProduct.country|replace:'DZ':'Algeria'}
                                                    {elseif $accountProduct.country == 'AS'}{$accountProduct.country|replace:'AS':'American'}
                                                    {elseif $accountProduct.country == 'AD'}{$accountProduct.country|replace:'AD':'Andorra'}
                                                    {elseif $accountProduct.country == 'AO'}{$accountProduct.country|replace:'AO':'Angola'}
                                                    {elseif $accountProduct.country == 'AI'}{$accountProduct.country|replace:'AI':'Anguilla'}
                                                    {elseif $accountProduct.country == 'AG'}{$accountProduct.country|replace:'AG':'Antigua And Barbuda'}
                                                    {elseif $accountProduct.country == 'AR'}{$accountProduct.country|replace:'AR':'Argentina'}
                                                    {elseif $accountProduct.country == 'AM'}{$accountProduct.country|replace:'AM':'Armenia'}
                                                    {elseif $accountProduct.country == 'AW'}{$accountProduct.country|replace:'AW':'Aruba'}
                                                    {elseif $accountProduct.country == 'AQ'}{$accountProduct.country|replace:'AQ':'Antarctica'}
                                                    {elseif $accountProduct.country == 'AU'}{$accountProduct.country|replace:'AU':'Australia'}
                                                    {elseif $accountProduct.country == 'AT'}{$accountProduct.country|replace:'AT':'Austria'}
                                                    {elseif $accountProduct.country == 'AZ'}{$accountProduct.country|replace:'AZ':'Azerbaijan'}
                                                    {elseif $accountProduct.country == 'BS'}{$accountProduct.country|replace:'BS':'Bahamas'}
                                                    {elseif $accountProduct.country == 'BH'}{$accountProduct.country|replace:'BH':'Bahrain'}
                                                    {elseif $accountProduct.country == 'BD'}{$accountProduct.country|replace:'BD':'Bangladesh'}
                                                    {elseif $accountProduct.country == 'BB'}{$accountProduct.country|replace:'BB':'Barbados'}
                                                    {elseif $accountProduct.country == 'BY'}{$accountProduct.country|replace:'BY':'Belarus'}
                                                    {elseif $accountProduct.country == 'BE'}{$accountProduct.country|replace:'BE':'Belgium'}
                                                    {elseif $accountProduct.country == 'BZ'}{$accountProduct.country|replace:'BZ':'Belize'}
                                                    {elseif $accountProduct.country == 'BJ'}{$accountProduct.country|replace:'BJ':'Benin'}
                                                    {elseif $accountProduct.country == 'BM'}{$accountProduct.country|replace:'BM':'Bermuda'}
                                                    {elseif $accountProduct.country == 'BT'}{$accountProduct.country|replace:'BT':'Bhutan'}
                                                    {elseif $accountProduct.country == 'BO'}{$accountProduct.country|replace:'BO':'Bolivia'}
                                                    {elseif $accountProduct.country == 'BA'}{$accountProduct.country|replace:'BA':'Bosnia And Herzegovina'}
                                                    {elseif $accountProduct.country == 'BW'}{$accountProduct.country|replace:'BW':'Botswana'}
                                                    {elseif $accountProduct.country == 'BV'}{$accountProduct.country|replace:'BV':'Bouvet'}
                                                    {elseif $accountProduct.country == 'BR'}{$accountProduct.country|replace:'BR':'Brazil'}
                                                    {elseif $accountProduct.country == 'IO'}{$accountProduct.country|replace:'IO':'British Indian Ocean Territory'}
                                                    {elseif $accountProduct.country == 'BN'}{$accountProduct.country|replace:'BN':'Brunei Darussalam'}
                                                    {elseif $accountProduct.country == 'BG'}{$accountProduct.country|replace:'BG':'Bulgaria'}
                                                    {elseif $accountProduct.country == 'BF'}{$accountProduct.country|replace:'BF':'Burkina Faso'}
                                                    {elseif $accountProduct.country == 'BI'}{$accountProduct.country|replace:'BI':'Burundi'}
                                                    {elseif $accountProduct.country == 'KH'}{$accountProduct.country|replace:'KH':'Cambodia'}
                                                    {elseif $accountProduct.country == 'CM'}{$accountProduct.country|replace:'CM':'Cameroon'}
                                                    {elseif $accountProduct.country == 'CA'}{$accountProduct.country|replace:'CA':'Canada'}
                                                    {elseif $accountProduct.country == 'CV'}{$accountProduct.country|replace:'CV':'Cape Verde'}
                                                    {elseif $accountProduct.country == 'KY'}{$accountProduct.country|replace:'KY':'Cayman Islands'}
                                                    {elseif $accountProduct.country == 'CF'}{$accountProduct.country|replace:'CF':'Central African Republic'}
                                                    {elseif $accountProduct.country == 'TD'}{$accountProduct.country|replace:'TD':'Chad'}
                                                    {elseif $accountProduct.country == 'CL'}{$accountProduct.country|replace:'CL':'Chile'}
                                                    {elseif $accountProduct.country == 'CN'}{$accountProduct.country|replace:'CN':'China'}
                                                    {elseif $accountProduct.country == 'CX'}{$accountProduct.country|replace:'CX':'Christmas Island'}
                                                    {elseif $accountProduct.country == 'CC'}{$accountProduct.country|replace:'CC':'Cocos (Keeling) Islands'}
                                                    {elseif $accountProduct.country == 'CO'}{$accountProduct.country|replace:'CO':'Colombia'}
                                                    {elseif $accountProduct.country == 'KM'}{$accountProduct.country|replace:'KM':'Comoros'}
                                                    {elseif $accountProduct.country == 'CG'}{$accountProduct.country|replace:'CG':'Congo'}
                                                    {elseif $accountProduct.country == 'CD'}{$accountProduct.country|replace:'CD':'Congo, Democratic Republic'}
                                                    {elseif $accountProduct.country == 'CK'}{$accountProduct.country|replace:'CK':'Cook Islands'}
                                                    {elseif $accountProduct.country == 'CR'}{$accountProduct.country|replace:'CR':'Costa Rica'}
                                                    {elseif $accountProduct.country == 'HR'}{$accountProduct.country|replace:'HR':'Croatia'}
                                                    {elseif $accountProduct.country == 'CU'}{$accountProduct.country|replace:'CU':'Cuba'}
                                                    {elseif $accountProduct.country == 'CY'}{$accountProduct.country|replace:'CY':'Cyprus'}
                                                    {elseif $accountProduct.country == 'CZ'}{$accountProduct.country|replace:'CZ':'Czech Republic'}
                                                    {elseif $accountProduct.country == 'DK'}{$accountProduct.country|replace:'DK':'Denmark'}
                                                    {elseif $accountProduct.country == 'DM'}{$accountProduct.country|replace:'DM':'Dominica'}
                                                    {elseif $accountProduct.country == 'DO'}{$accountProduct.country|replace:'DO':'Dominican Republic'}
                                                    {elseif $accountProduct.country == 'EC'}{$accountProduct.country|replace:'EC':'Ecuador'}
                                                    {elseif $accountProduct.country == 'EE'}{$accountProduct.country|replace:'EE':'Estonia'}
                                                    {elseif $accountProduct.country == 'EG'}{$accountProduct.country|replace:'EG':'Egypt'}
                                                    {elseif $accountProduct.country == 'ES'}{$accountProduct.country|replace:'ES':'Spain'}
                                                    {elseif $accountProduct.country == 'FI'}{$accountProduct.country|replace:'FI':'Finland'}
                                                    {elseif $accountProduct.country == 'FR'}{$accountProduct.country|replace:'FR':'France'}
                                                    {elseif $accountProduct.country == 'GB'}{$accountProduct.country|replace:'GB':'United Kingdom'}
                                                    {elseif $accountProduct.country == 'GH'}{$accountProduct.country|replace:'GH':'Ghana'} 
                                                    {elseif $accountProduct.country == 'GR'}{$accountProduct.country|replace:'GR':'Greece'} 
                                                    {elseif $accountProduct.country == 'GT'}{$accountProduct.country|replace:'GT':'Guatemala'} 
                                                    {elseif $accountProduct.country == 'HK'}{$accountProduct.country|replace:'HK':'Hong Kong'} 
                                                    {elseif $accountProduct.country == 'HR'}{$accountProduct.country|replace:'HR':'Croatia'} 
                                                    {elseif $accountProduct.country == 'HU'}{$accountProduct.country|replace:'HU':'Hungary'} 
                                                    {elseif $accountProduct.country == 'ID'}{$accountProduct.country|replace:'ID':'Indonesia'} 
                                                    {elseif $accountProduct.country == 'IE'}{$accountProduct.country|replace:'IE':'Ireland'} 
                                                    {elseif $accountProduct.country == 'IL'}{$accountProduct.country|replace:'IL':'Israel'} 
                                                    {elseif $accountProduct.country == 'IN'}{$accountProduct.country|replace:'IN':'India'}
                                                    {elseif $accountProduct.country == 'IT'}{$accountProduct.country|replace:'IT':'Italy'} 
                                                    {elseif $accountProduct.country == 'JP'}{$accountProduct.country|replace:'JP':'Japan'}
                                                    {elseif $accountProduct.country == 'KE'}{$accountProduct.country|replace:'KE':'Kenya'} 
                                                    {elseif $accountProduct.country == 'LK'}{$accountProduct.country|replace:'LK':'Falkland Islands (Malvinas)'}
                                                    {elseif $accountProduct.country == 'LU'}{$accountProduct.country|replace:'LU':'Luxembourg'} 
                                                    {elseif $accountProduct.country == 'MX'}{$accountProduct.country|replace:'MX':'Mexico'}
                                                    {elseif $accountProduct.country == 'MY'}{$accountProduct.country|replace:'MY':'Malaysia'} 
                                                    {elseif $accountProduct.country == 'NL'}{$accountProduct.country|replace:'NL':'Netherlands'}
                                                    {elseif $accountProduct.country == 'NO'}{$accountProduct.country|replace:'NO':'Norway'} 
                                                    {elseif $accountProduct.country == 'NZ'}{$accountProduct.country|replace:'NZ':'New Zealand'}
                                                    {elseif $accountProduct.country == 'PH'}{$accountProduct.country|replace:'PH':'Philippines'} 
                                                    {elseif $accountProduct.country == 'PK'}{$accountProduct.country|replace:'PK':'Pakistan'}
                                                    {elseif $accountProduct.country == 'PL'}{$accountProduct.country|replace:'PL':'Poland'} 
                                                    {elseif $accountProduct.country == 'RO'}{$accountProduct.country|replace:'RO':'Romania'}
                                                    {elseif $accountProduct.country == 'RS'}{$accountProduct.country|replace:'RS':'Serbia'}
                                                    {elseif $accountProduct.country == 'SG'}{$accountProduct.country|replace:'SG':'Singapore'}
                                                    {elseif $accountProduct.country == 'TR'}{$accountProduct.country|replace:'TR':'Turkey'}
                                                    {elseif $accountProduct.country == 'TH'}{$accountProduct.country|replace:'TH':'Thailand'}
                                                    {elseif $accountProduct.country == 'UA'}{$accountProduct.country|replace:'UA':'Ukraine'}
                                                    {elseif $accountProduct.country == 'US'}{$accountProduct.country|replace:'US':'United States'}
                                                    {elseif $accountProduct.country == 'ZA'}{$accountProduct.country|replace:'ZA':'South Africa'}
                                                    {else}{$accountProduct.country}  
                                                    {/if}
                                                    " disabled>              
                                         
                                    </td>
                                </tr>
                                 <tr>
                                    <td><span class="add-column">Company Name :</span></td>
                                </tr>   
                                <tr>
                                    <td class="cell-border"> <input type="text"  class="companyName"  name="companyName" value="" required="required" > </td>
                                </tr>
                                <tr>
                                    <td><span class="add-column">Logo :</span></td>
                                </tr>
                                <tr>
                                    <td class="cell-border"><input type="file" name="logoupload" value="logoupload" class="logoupload"><span class ='warning' style="color:red;display: none;">**Please choose the new image or resize to be less than 150 KB</span></td>
                                </tr>
                                <tr>
                                    <td><span class="add-column">Website URL :</span></td>
                                </tr>
                                <tr> 
                                    <td class="cell-border"><input type="text"   name="weburl" class="weburl-phone" value=""  placeholder="hello123.com" required="required" > 
                                        <span class ='warningWeb-phone' style="color:red ;font-size: 15px;padding: 0px;display: none"><br>You entered the wrong  URL website!!( e.g. hello123.com )</span>
                                    </td> 
                                </tr>
                                <tr>
                                    <td><span class="add-column">Brief Info :</span></td>
                                </tr>
                                <tr>
                                    <td class="cell-border"><textarea name="title" class="title" value="" maxlength="70"> </textarea>
                                       <br><span style="font-size: 13px;padding: 0px;color: #737373;">(Maximum 70 characters including spaces)</span>    
                                    </td>
                                
                                </tr>
                                  <tr>
                                    <td colspan="2"  style="text-align: center;">
                                        <input type="submit" name="submit"  id="submitCom" value="Submit" class='submitCom subMitCom-phone'style="background-color:#339e43;">
                                        <input type="button" name="resetCompany" id="resetCompany" value="Reset" class='submitCom resetCompany-phone'  style="background-color:#f12a2e;" />
                                        <input type="button" name="cancel" id="cancel" value="Cancel"  class='submitCom cancel-phone' style="background-color:#000000;" />
                                    </td>
                                    
                                </tr>
                            </tbody>
                        </table>      
                    </form>  
                </div>
                <!---  end form responsive ---->
            </div>
        </div>
     </div>
    {/if}
{/if}
<!--End host provider-->

<!-- Tickets -->

 <div class="clear clearfix">
    <h5><i class="icon-service-ticket"></i>{$lang.openedtickets|capitalize}</h5>
    <div class="separator-down-arrow"></div>
    <div class="line-separaotr"></div>

    <div class="clear clearfix">
        <div class="table-box">
            <div class="table-header">
                <div class="right-btns">
                    <a href="{$ca_url}tickets/new/" class="clearstyle grey-custom-btn btn"><i class="icon-view-all"></i>{$lang.ca_createticket}</a>
                    <a href="https://rvglobalsoft.zendesk.com/hc/en-us/requests" class="clearstyle grey-custom-btn btn"><i class="icon-grey-add"></i>{$lang.viewalltickets}</a>
                </div>
                <p>{$lang.openedtickets|capitalize}</p>
            </div>
            
            <table class="table table-hover">
                <tr class="table-header-row">                
                    <th class="cell-border">{$lang.subject}</th>
                    <th class="w20">{$lang.status}<i class="icon-sort-arrow-down"></i></th>
                    <th class="w20 cell-border">{$lang.dateupdated}</th>
                   
                </tr>
                {foreach from=$openedtickets item=ticket name=foo}
                {if $ticket.status == 'In-Progress'}{/if}
                <tr>
                    {if $ticket.client_read=='0'}
                        <td class="cell-border">
                    {else}
                        <td class="cell-border no-bold">
                    {/if}
                    <a href="{$ca_url}tickets/view/{$ticket.ticket_number}/">{$ticket.subject}</a></td>
                    <td><span class="ticket-{$ticket.status}">{$lang[$ticket.status]}</span></td>
                    <td class="cell-border grey-c">{$ticket.lastupdate|date_format:"%d-%m-%Y "}</td>
                </tr>
                {/foreach}
                {foreach from=$openedtickets2 item=ticket name=foo}
                {if $ticket.status == 'solved' || $ticket.status == 'closed'}{continue}{/if}
                <tr>
                    <td><a href="https://rvglobalsoft.zendesk.com/hc/en-us/requests/{$ticket.id}" target="_blank">{$ticket.subject}</a></td>
                    <td class="cell-border"><span class="ticket-{$ticket.status}">{$ticket.status}</span></td>
                    <td class="cell-border grey-c">{$ticket.updated_at|date_format:"%d-%m-%Y "} </td>
                </tr>
                {/foreach}
            </table>
           
        </div>
    </div>
 </div>
 
 <!-- End of Tickets -->
 
 <p style="color:#000;">You don't have any ticket.</p>

<!-- Services -->
{if $offer_total > 0}
<div class="clear clearfix">
    <h5><i class="icon-service-header"></i>{$lang.servicedetails}</h5>
    <div class="separator-down-arrow"></div>
    <div class="line-separaotr"></div>

    <div class="clear clearfix">
        {if $mydomains>0}

        <div class="service-box">
            <div class="service-box-config">
                <a class="clearstyle btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-config-service"></i>
                </a>
                <ul class="dropdown-menu">
                    <div class="dropdown-padding">
                    {if $expdomains}
                        <li><a href="{$ca_url}clientarea/domains/">{$expdomains_count} {$lang.ExpiringDomains}</a></li>
                    {/if}
                        <li><a href="{$ca_url}checkdomain/">{$lang.ordermore}</a><span></span></li>
                        <li><a href="{$ca_url}clientarea/domains/">{$lang.listmydomains}<span></span></a></li>
                    </div>
                </ul>
            </div>
            <a href="{$ca_url}clientarea/domains/"><span>{$mydomains}</span></a>
            <p><i class="icon-domain-service"></i>{$lang.mydomains}</p>
        </div>
        {/if}

        {foreach from=$offer item=offe}
        	{if $offe.total>0}
        	{assign var="offa" value="1"}
        <div class="service-box">
        	{if $offe.visible}
            <div class="service-box-config">
                <a class="clearstyle btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-config-service"></i>
                </a>
                <ul class="dropdown-menu">
                    <div class="dropdown-padding">
                        <li><a href="{$ca_url}cart/{$offe.slug}/">{$lang.ordermore}</a><span></span></li>
                        <li><a href="{$ca_url}clientarea/services/{$offe.slug}/"> {$lang.servicemanagement}</a><span></span></li>
                    </div>
                </ul>
            </div>
            {/if}
            <a href="{$ca_url}clientarea/services/{$offe.slug}/"><span>{$offe.total}</span></a>
            <p><i class="icon-hosting-service"></i>{$offe.name}</p>
        </div>
        	{/if}
		{/foreach}

        {if $mydomains>0 || $offa}
        <div class="service-box order-more">
            <a href="{$ca_url}cart/">
                <i class="icon-order-more"></i>
                <span><p class="order-more-txt">{$lang.ordermore}</p></span>
            </a>
        </div>
        {/if}
    </div>
 </div>
 {/if}
 <!-- End of Services -->

<div class="clear"></div>

<br /><br />


<script src="{$template_dir}js/feed/jquery.zrssfeed.min.js" type="text/javascript"></script>
{literal}

<script type="text/javascript">

	$(document).ready(function () {
		$('#rvglobalsoftfeed').rssfeed('http://blog.rvglobalsoft.com/?cat=2&feed=rss2', {
			limit: 20, <!--- จำกัดจำนวนไม่เกิน ที่กำหนด -->
			offset: 1, <!--- เริ่มหัวข้อข่าวที่เท่าไหร่ -->
			ssl: true,
			date: false ,
			content: 0,   <!--- เนื้อหาข่าว -->
			header: false  <!--- หัวข้อข่าว -->
		});//1update & news
        var status = '{/literal}{php}echo $_REQUEST["status"];{/php}{literal}';
        if(status == 'Suspended'){
            var error = 'Your current RV2Factor account is “Suspended”, according to:<br>';
            error    += '1) Trial period was ended. Please click at “Upgrade” button above to upgrade your RV2Factor account from Trial to the Paid account.<br>';
            error    += '2) Monthly renewal was not proceeded. Please pay for the pending invoice for RV2Factor to reactivate your account again. ';

            $('.alert-error').append(error);
            $('.alert-error').show();
        }

        $('span:contains(\'Thank you for submitting your payment request, we will inform you about transaction status over email.\')').html('Thank you for submitting your payment request. <br />The process will be proceeded within 24 hours, or on the Invoice Due Date in case you submit early.');
        $(".AddCompany").hide();
        $(".Edit").hide();
        $('.show-company').hide();
        
        $(".addCompany").click(function(){
            $(".AddCompany").show();
            $(".addCompany").hide();
        });    
        $(".resetCompany").click(function(){
            $(".formCompany")[0].reset();
        });
        $(".resetCompany-phone").click(function(){
            $(".formCompany-phone")[0].reset();
        });
        $(".edit").click(function(){
            $(".Edit").show();
            $('.show-company').hide();
	    });
	    $(".backCompany").click(function(){
            $('.show-company').show();
            $(".Edit").hide();
        });
        
        $(".cancel").click(function(){
            $(".AddCompany").hide();
            $(".addCompany").show();
        });
         $(".cancel-phone").click(function(){
            $(".AddCompany").hide();
            $(".addCompany").show();
        });

          $(".detialCompany").click(function(){
            $('.show-company').show();
            $('.detialCompany').hide();
        });
        $('.Editlogoupload').bind('change', function() {
            var sizePicture = this.files[0].size;
            if (sizePicture > 150000 ){
                var txt ="Please choose a new image or resize the image";
                alert('Sorry ,this file is more than 150KB !! It has to be less than or equal to 150KB');
                $('.saveEdit').attr('disabled', 'true');
                $(".warning").show();
            }
            else {
                $('.saveEdit').removeAttr("disabled");
                $(".warning").hide();
            }
            
        });
        $('.logoupload').bind('change', function() {
          var sizeLogoupload = this.files[0].size;
            if (sizeLogoupload > 150000){
                var txt ="Please choose a new image or resize the image";
                alert('Sorry ,this file is more than 150KB !! It has to be less than or equal to 150KB');
                $('.subMitCom').attr('disabled', 'true');
                $('.subMitCom-phone').attr('disabled', 'true');
                $(".warning").show();
            }
            else {
                $('.subMitCom').removeAttr("disabled");
                $('.subMitCom-phone').removeAttr("disabled");
                $(".warning").hide();
            }          
        });
        
        $(".weburl").change(function(){
              var webUrlInput = $(".weburl").val();
              console.log(webUrlInput);
              var https     = webUrlInput.includes("https://");
              var http      = webUrlInput.includes("http://");
              var www       = webUrlInput.includes("https://www.");
              var wwwDot    = webUrlInput.includes("www.");
              if(https == true || http == true ||www== true ||wwwDot == true){
                $(".warningWeb").show();
                $('.saveEdit').attr('disabled', 'true');
                $('.subMitCom').attr('disabled', 'true');
                
              }
                else {
                $('.subMitCom').removeAttr("disabled");
                $(".warningWeb").hide();
                $('.saveEdit').removeAttr("disabled");
            }       
        });
        $(".weburl-phone").change(function(){
              var webUrlInput = $(".weburl-phone").val();
              console.log(webUrlInput)
              var https     = webUrlInput.includes("https://");
              var http      = webUrlInput.includes("http://");
              var www       = webUrlInput.includes("https://www.");
              var wwwDot    = webUrlInput.includes("www.");
              if(https == true || http == true ||www== true ||wwwDot == true){
                $(".warningWeb-phone").show();
                $('.subMitCom-phone').attr('disabled', 'true');
                $('.saveEdit').attr('disabled', 'true');
              }
                else {
                $('.subMitCom-phone').removeAttr("disabled");
                $(".warningWeb-phone").hide();
                $('.saveEdit').removeAttr("disabled");
            }       
        });

    });
	{/literal}{if $cancel}{literal}
	   try{
            gao('send', 'event', 'order', 'order', 'cancel', 1);
        } catch(err){}
	{/literal}{/if}{literal}

</script>

<script>
    var myVar;
    
    function myFunction() {
      myVar = setTimeout(alertFunc, 3000);
    }
    
    function alertFunc() {
      alert("Hello!");
    }
</script>

<style>
    .phone{
        display:none;
    }
    .btn-add{
        padding: 7px 13px;
        border: solid 2px #0c5a9c;
        font-size: 15px;
        border-radius: 11px;
        background-color: #fff;
        font-weight: bold;
        color: #035386;
    }
    .btn-add:hover{
        border: solid 2px #0b5aea;
        border-radius: 11px;
        background-color: #ffffff;
        color: #0b0389;
        box-shadow: 0px 4px 10px rgba(49, 128, 246, 0.4);
        font-size: 16px;
    }
	.hosting-free{
	   background: linear-gradient(to right, #2700b7, #ba06c5); 
	   color: #FFF;
	   padding: 17px;
	   font-size: 18px;
	}
     .newtab{
        background: #fd0000;
        padding: 6px 7px 6px 7px;
        color: #FFF;
        font-size: 16px;
        font-weight: 600;
        border-radius: 5px
     }
      .newtab:hover {
         background: #a70808;
     }
    .btn-check-border {
         
         background-color:transparent;
         border-radius:0;
         border:2px solid #396afc;
         border-image-slice:1;
         display:inline-block;
         color:#2948ff;
         font-style:normal;
         font-size: 14px;
         padding: 4px 8px;
         text-decoration:none;
        
    }
    .btn-check-border:hover {
         text-decoration:none;
         background:#396afc;
         background:-webkit-linear-gradient(90deg,#2948ff,#396afc);
         background:linear-gradient(90deg,#2948ff,#396afc);
         color:#fff
    }
    .submitCom{
        color: #FFFFFF;
        font-size: 16px;
        padding: 4px 4px;
        border-radius: 4px;
    }
    .icon-view{
        background: url(https://rvglobalsoft.com/templates/netwaybysidepad/img/view-icon.png);
        width: 23px;
        height: 24px;
        margin: 0 5px 0 0;
    }
    .viewdetial{
        padding: 3px 9px;
        font-size: 15px;
        border-radius: 4px;
        font-weight: bold;
    }
    .viewdetial:hover{
        font-size: 17px;
    }
    textarea.title {
    font-size: 15px;
    font-weight: 500;
    color: #3e3e3e;
    background: #fffefe;
    width: 242px;
    border: #CCCCCC solid 1px;
}
@media screen and (max-width: 768px) {
    .desktop {
        display:none;
    }
    .phone{
        display: block;
    }
    
    .AddCompany{
        width: 260px;
    }
   
    .box-form {
        width: 265px;
    }
    .table-header-phone {
        width : 100%;
        height: 69px;
        box-shadow: 0 1px 2px 0 rgba(123, 125, 128, .35);
        position: relative;
        border-bottom: solid 1px #CACDD2;
        border-radius: 4px 4px 0 0;
        background: #e6e6e6;
        color: #000;
        font-weight: 200;
        background-image: -webkit-linear-gradient(top, #ffffff, #e6e6e6);
    }
    .add-column{
        font-size: 15px;
        font-weight: bold;
        padding: 0px !important;
    }
    table.phone tr td.cell-border{
        padding: 9px 11px 9px 6px !important;
        border-top: none;
        border-bottom: 1px solid #b7c6d2 !important;
        vertical-align: middle;
    }
    table.phone tr td{
        padding: 9px 0px 9px 8px !important;
        border-top: none;
        border-bottom: unset !important;
        vertical-align: middle;
    }
   
   input[type="file"]{
        width: 245px !important;
   }
   input[type="text"]{
       -webkit-appearance: textfield;
        background-color: white;
        -webkit-rtl-ordering: logical;
        cursor: auto;
        padding: 1px;
        border-width: 2px;
        border-style: inset;
        border-color: initial;
        border-image: initial;
  }
    .newtab {
        background: #fd0000;
        padding: 2px 7px 2px 6px;
        color: #FFF;
        font-size: 15px;
        font-weight: 600;
        border-radius: 5px;
    }
   .hosting-free {
        background: linear-gradient(to right, #2700b7, #ba06c5);
        color: #FFF;
        padding: 6px;
        font-size: 16px;
   }
    textarea.title {
        font-size: 15px;
        font-weight: 500;
        color: #3e3e3e;
        background: #fffefe;
        width: 242px;
        border: #CCCCCC solid 1px;
    }

}
  
    
    

</style>
{/literal}

<!--</div>-->
{/if}
