<script src="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/external/jquery.ui/1.8.24/jquery-ui.min.js?v={$hb_version}"></script>
<script src="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/VIP.js"></script>
<script src="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/symantecvip.js"></script>

<link href="{$system_url}includes/modules/Hosting/symantecvip/public_html/js/external/jquery.ui/1.8.24/themes/base/jquery-ui.css?v={$hb_version}" rel="stylesheet" media="all" />

<script type="text/javascript">

	var system_url = "{$system_url}";

{literal}	

     $(document).ready(function () {
    	 $.symantecvip.init();
	 });
	</script>
	
{/literal}





<!-- START CONTENT FROM services/service_billing2.tpl -->
<p class="bold">{$service.catname} - {$service.name} 
    {if $upgrades && $upgrades!='-1'}
        <small>
            <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&make=upgrades&upgradetarget=service" class="lmore">        
                {$lang.UpgradeDowngrade}
            </a>
        </small>
    {/if}
</p>
    
<div class="table-box">
    <div class="table-header">
        <p>{$lang.service}</p>
    </div>
    <table class="table table-striped account-details-tb tb-sh">
    
    {if $service.domain!=''}
        <tr>
            <td class="w30">{$lang.domain}</td>
            <td class="cell-border no-bold"><a target="_blank" href="http://{$service.domain}">{$service.domain}</a></td>
        </tr>
    {/if}
    
        <tr>
            <td class="w30">{$lang.status}</td>
            <td class="cell-border no-bold"><span class="label-{$lang[$service.status]}">{$lang[$service.status]}</span></td>
        </tr>
        
        {if $service.showbilling}
        <tr>
            <td class="w30">{$lang.registrationdate}</td>
            <td class="cell-border no-bold">{$service.date_created|dateformat:$date_format}</td>
        </tr>
            {if $service.firstpayment!=0 }
        <tr>
            <td class="w30">{$lang.firstpayment_amount}</td>
            <td class="cell-border no-bold">{$service.firstpayment|price:$currency}</td>
        </tr>
            {/if}
        
            {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.total>0}
        <tr>
            <td class="w30">{if $service.billingcycle=='Hourly'}{$lang.curbalance}{else}{$lang.reccuring_amount}{/if}</td>
            <td class="cell-border no-bold">{$service.total|price:$currency} {if $service.billingcycle=='Hourly'}({$lang.updatedhourly}){/if}</td>
        </tr>
            {/if}
        
            {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time' && $service.next_due!='' && $service.next_due!='0000-00-00'}
        <tr>
            <td class="w30">{$lang.nextdue}</td>
            <td class="cell-border no-bold">{$service.next_due|dateformat:$date_format}</td>
        </tr>
            {/if}
        <tr>
            <td class="w30">{$lang.bcycle}</td>
            <td class="cell-border no-bold">{$lang[$service.billingcycle]}</td>
        </tr>
        {/if}
    </table>
</div>
<!-- END CONTENT FROM services/service_billing2.tpl -->







<!-- START DEFAULT WIDGET -->
<br><br>

<p class="bold">Subscription Symantec™ VIP detail</p>

<div class="table-box">
    <div class="table-header">
        <p>1. Account Detail</p>
    </div>
    <table class="table table-striped account-details-tb tb-sh">
        <tr>
            <td class="w30">Organizational Unit Number</td>
            <td class="cell-border no-bold">{$ou_number}</td>
        </tr>
        <tr>
            <td class="w30">Purchased Account</td>
            <td class="cell-border no-bold">{$quantity}</td>
        </tr>
        <tr>
            <td class="w30">Active Account</td>
            <td class="cell-border no-bold">{$quantity_at_symantec}</td>
        </tr>
    </table>
</div>    
  
          	
<br />

<div class="table-box">
    <div class="table-header">
        <p>2. Certificate File</p>
    </div>
    <table class="table table-striped account-details-tb tb-sh">
        <tr>
            <td class="w30">Certificate File</td>
            <td class="cell-border no-bold">{if $vip_view_file==1}<a href="javascript:void(0);" id="show-dialog-cer-file-p12" class="show-dialog">{$certificate_file_path_p12}</a>{/if}</td>
        </tr>
        <tr>
            <td class="w30">Certificate File Expire Date</td>
            <td class="cell-border no-bold">{$certificate_expire_date_p12}</td>
        </tr>
    </table>
</div>  


<br />      


 <div id="dialog-cer-detail-p12" style="display:none;width:500px">
 
    <table class="table table-striped account-details-tb tb-sh">
        <tr>
            <td class="w30">File name</td>
            <td class="cell-border no-bold">{$certificate_file_path_p12}</td>
        </tr>
        <tr>
            <td class="w30">File type</td>
            <td class="cell-border no-bold">{$certificate_file_type_p12}</td>
        </tr>
        <tr>
            <td class="w30">File size</td>
            <td class="cell-border no-bold">{$certificate_file_size_p12} bytes</td>
        </tr>
        <tr>
            <td class="w30">File upload date</td>
            <td class="cell-border no-bold">{$date_file_upload_p12}</td>
        </tr>
        <tr>
            <td class="w30">File last upload date</td>
            <td class="cell-border no-bold">{$date_file_last_upload_p12}</td>
        </tr>
        <tr>
            <td class="w30">md5sum</td>
            <td class="cell-border no-bold">{$md5sum_p12}</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><a href="{$download_url_cer_p12}" target="_blank" class="download">Download Certificate File</a></td>
        </tr>
    </table>
 
 </div>  
          

<!-- END DEFAULT WIDGET -->


<!-- START CONTENT FROM services/service_forms.tpl -->
{if $service.custom}
	<table width="100%" cellspacing="0" cellpadding="0" border="0" class="table table-striped fullscreen" >
	    {foreach from=$service.custom item=cst}
	    <tr >
	        <td align="right" width="160"><strong>{$cst.name}</strong>  </td>
	        <td>{include file=$cst.configtemplates.clientarea} </td>
	    </tr>
	    {/foreach}
	</table>
{/if}
<!-- END CONTENT FROM services/service_forms.tpl -->


