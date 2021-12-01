{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'services/cloudserver_list.tpl.php');
//echo '<pre>'.print_r($this->get_template_vars(),true).'</pre>';
{/php}
<link media="all" type="text/css" rel="stylesheet" href="includes/types/onappcloud/clientarea/styles3.css" />
<script type="text/javascript" src="{$system_url}templates/netwaybysidepad/js/jquery.blockUI.js?v=2015-12-04"></script>

<div class="container" style="padding-top: 35px;">

	{foreach from=$allServer item=data}
		{if $data.product_name == 'VMWare'}{continue}{/if}
		{assign var=extradetail value=$data.extra_details|unserialize}
		{assign var=panelstatus value='default'}
		{if $data.status == 'Pending' || $data.status == 'PendingReconfig'}
			{assign var=panelstatus value='info'}
			{literal}
			<script type="text/javascript">
			$(document).ready(function(){
				var arr 	=	['<img width=\"20px\" src=\"{/literal}{$system_url}{literal}templates/netwaybysidepad/images/buffering.gif\">' , '<input type="checkbox" checked />' , '<input type="checkbox" />'];
				var step 	=   0;
				var stepStr =	['Payment' , 'Server Configuration' , 'Optimizing application performance and configuration' , 'Done'];
				if('{/literal}{$data.payment_status}{literal}' == 'Unpaid'){
					step = 1;
				}else if('{/literal}{$data.payment_status}{literal}' == 'Paid'){
					if('{/literal}{$data.status}{literal}' == 'Pending'){
						step = 2;
					}else if('{/literal}{$data.status}{literal}' == 'PendingReconfig'){
						step = 3;
					}else if('{/literal}{$data.status}{literal}' == 'Active'){
						step = 4;
					}
				}
				var cc	=	arr[2];
				var htmlStr	=	'';
				htmlStr += '<div style=\"margin: 10px 10px 10px 20px;\"><h5>Current Status: '+ stepStr[step-1] +'</h5>';
				if(step == 1){	cc = arr[0];	}else if(step > 1 ){		cc = arr[1];	}else{ cc	=	arr[2];	}
				htmlStr += '<div class="cloud-process-step">'+ cc +' ' + stepStr[0] +'</div>';
				if(step == 2){	cc = arr[0];	}else if(step > 2 ){		cc = arr[1];	}else{ cc	=	arr[2];	}
				htmlStr += '<div class="cloud-process-step">'+ cc +' ' + stepStr[1] +'</div>';
				if(step == 3){	cc = arr[0];	}else if(step > 3 ){		cc = arr[1];	}else{ cc	=	arr[2];	}
				htmlStr += '<div class="cloud-process-step">'+ cc +' ' + stepStr[2] +'</div>';
				if(step == 4){	cc = arr[0];	}else if(step > 4 ){		cc = arr[1];	}else{ cc	=	arr[2];	}
				htmlStr += '<div class="cloud-process-step">'+ cc +' ' + stepStr[3] +'</div>';
				htmlStr += '</div>';
				
				if(step == 0){
					htmlStr = '';
				}
				
		        $('.{/literal}{$data.id}{literal}').block({ message: htmlStr }); 
		    });
			</script>
			{/literal}
		{elseif $data.status == 'Active'}
			{assign var=panelstatus value='success'}
		{/if}	
		
		{foreach from=$vpslists item=vpsdatas}
			{if $vpsdatas.account_id == $data.id}
				{assign var=vpsdata value=$vpsdatas}
			{/if}
		{/foreach}
		
		<div class="span6" {if $data.status == 'Terminated'}style="cursor:not-allowed; -webkit-filter: grayscale(100%);-moz-filter: grayscale(100%);-ms-filter: grayscale(100%);-o-filter: grayscale(100%);filter: grayscale(100%);filter: gray;"{/if}>
		    <div class="panel panel-{$panelstatus}">
		      <div class="panel-heading">
		      	Server: {$data.domain}
		      </div>
		      <div class="row-fluid {$data.id}" style="padding: 15px -5px 5px 5px;">
		      	<div class="span4">
		      		<img src="{$system_url}templates/netwaybysidepad/images/icon-server.png"/>
		         	<br>
		         	<div style="padding-left: 10px;">
		         		<img width="100px" style="margin-top: -60px; margin-left: 30px;" src="{$system_url}templates/netwaybysidepad/images/select-basicvps.png" />
		         	</div>
		      	</div>
		      	{if $data.status == 'Active'}
		      	<div class="span8">
		      		<table cellpadding="0" cellspacing="0" width="100%" class="ttable">
		      			<tbody class="cloud-detail-{$data.id}">
			      			<!--<tr>
			      				<td><b>Status</b></td>
			      				<td>
			      					<div class="load_vm_status" rel="{$extradetail.option6}">
			      						
			      					</div>
			      				</td>
			      			</tr> -->
			      			<tr>
			      				<td><b>IP Address</b></th>
			      				<td>{if $vpsdata.ip}{$vpsdata.ip}{else}???{/if}</td>
			      			</tr>
			      			<tr>
			      				<td><b>Location</b></td>
			      				<td>Thailand - CAT Telecom Tower Bangrak</td>
			      			</tr>
			      			<tr>
								<td><b>Disk Space</b></td>
								<td>{$vpsdata.disk_limit} GB</td>
							</tr>
							<tr>
								<td><b>Memory</b></td>
								<td>{$vpsdata.guaranteed_ram/1024} GB</td>
							</tr>
							<!--<tr>
								<td><b>CPU Cores</b></td>
								<td>1 Core(s)</td>
							</tr>-->
		      			</tbody>
		      		</table>
		      		<table border="0" cellspacing="0" cellpadding="0" width="100%">
				        <tr>
				            <td width="50%" style="padding-left:0px; vertical-align: top">
				                <table  cellpadding="0" cellspacing="0" width="100%">
				                     <tr>
										<td colspan="2" align="center">
											<a href="?cmd=clientarea&amp;action=services&amp;service={$data.id}" style="text-decoration:none">
									  			<strong><i class="icon-services"></i> Manage Server</strong>
									  		</a>
									  		<br><br>
										</td>
									</tr>
								</table>
							</td>
						</tr>
				    </table>
				</div>
		      	{else}
		      	<div style="height: 200px;"></div>
		      	{/if}
		      </div>	
		      
		    </div>
	    </div>
	{/foreach}

</div>

{literal}
<script>

	$(document).ready(function(){
	        /*$('.load_vm_status').each(function(){
	           loadStatus(this,'loadvmstatus');
	        });*/
	    });
	function loadStatus(thi, make){
		var el=$(thi).html("<img src='includes/types/onappcloud/images/ajax-loader.gif' />");
		$.post('?cmd=module&module=Virtualizor&action=test',{
			veid: el.attr('rel')
		},function(data){
			//console.log(data);
			//var r= parse_response(data);
			//alert(r);
			//el.html(r);
		});	
	}
	function powerchange(el) {
        if($(el).hasClass('iphone_switch_container_on')) {
            if(confirm('Are you sure you want to Power OFF this VM?')) {
				loadStatus($(el).parent(),'poweroff');
            }
        } else if ($(el).hasClass('iphone_switch_container_off')) {
              if(confirm('Are you sure you want to Power ON this VM?')) {
				loadStatus($(el).parent(),'poweron');
            }

        }
        return false;
    }


</script>
<style>
	
	.cloud-server-action-button{
		float: right; padding: 2px 2px 2px 2px;
	}
	div.cloud-process-step{
		padding: 5px 2px 2px 2px;
	}
	input[type="checkbox"]{
		cursor: pointer;
		-webkit-appearance: none;
		appearance: none;
		background: #e8ebef;
		border-radius: 10px;
		box-sizing: border-box;
		position: relative;
		box-sizing: content-box ;
		width: 20px;
		height: 20px;
		border-width: 0;
		transition: all .3s linear;
		margin-top: -2px;
	}
	input[type="checkbox"]:checked{
		background-color: #2ECC71;
	}
	input[type="checkbox"]:focus{
		outline: 0 none;
		box-shadow: none;
	}
	.iphone_switch_container {
	    width:66px;
	    height:19px;
	    display:block;
	    position:relative;
	    cursor:pointer;
	}
	.iphone_switch_container img {
	    background: url("/includes/types/onappcloud/images/iphone_switch.png") no-repeat top left;
	    width:66px;
	    height:19px;
	}
	
	.iphone_switch_container_pending img {
	    background: url("/includes/types/onappcloud/images/iphone_pending.png") no-repeat top right !important;
	    width:66px;
	    height:19px;
	}
	.iphone_switch_container_off  img {
	    background-position: top right;
	
	}
	.iphone_switch_container_on  img  {
	    background-position: top left;
	}
	.current-menu-item a {
	    background: #e8e8e8;
	}
	
</style>
{/literal}
