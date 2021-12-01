<?php 
$pathTheme 	= $this->_tpl_vars['template_dir'];
$action 	= $this->_tpl_vars['action'];
$ca_url 	= $this->_tpl_vars['ca_url'];
$cid 		= $this->_tpl_vars['cid'];
$caUrl 		= $ca_url . 'clientarea' . '/' . $action .'/';
$clientid 	= $_SESSION['AppSettings']['login']['id'];
// --- Custom helper ---
require_once( APPDIR_MODULES . "Other/billingcycle/api/class.billingcycle_controller.php");

// --- Custom helper ---

?>
 <style type="text/css" title="currentStyle">
    @import "<?php echo$pathTheme;?>rvlicense/script_datatable/css/demo_table_jui.css";
    @import "<?php echo$pathTheme;?>rvlicense/script_datatable/themes/smoothness/jquery-ui-1.8.4.custom.css";
</style>
<script type="text/javascript" language="javascript" src="<?php echo$pathTheme;?>rvlicense/script_datatable/js/jquery.dataTables.js"></script>
        
<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        oTable = $('.data-table').dataTable({
        	"fnDrawCallback": function ( oSettings ) {
            if ( oSettings.aiDisplay.length == 0 )
            {
                return;
            }
             
            var nTrs = $('#example tbody tr');
            var iColspan = nTrs[0].getElementsByTagName('td').length;
            var sLastGroup = "";
            for ( var i=0 ; i<nTrs.length ; i++ )
            {
                var iDisplayIndex = oSettings._iDisplayStart + i;
                var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[0];
                if ( sGroup != sLastGroup )
                {
                    var nGroup = document.createElement( 'tr' );
                    var nCell = document.createElement( 'td' );
                    nCell.colSpan = iColspan;
                    nCell.className = "group";
                    nCell.innerHTML = sGroup;
                    nGroup.appendChild( nCell );
                    nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
                    sLastGroup = sGroup;
                }
            }
        },
        "aoColumnDefs": [
            { "bVisible": false, "aTargets": [ 0 ] }
        ],
            "bJQueryUI": true,
            "iDisplayLength": 25,
            "bSort": true,
            "bLengthChange": false,
            "sPaginationType": "full_numbers"
        });
    } );
</script>
<?php
	$db = hbm_db();
    
    $aData = $db->query("
        SELECT
            acc.id, acc.product_id,f.variable,ac.data,
            acc.total, acc.status, acc.billingcycle, 
            acc.next_due, cat.name AS catname, cat.slug, prod.name,
            l.dt_update
        FROM
            hb_accounts acc
            JOIN hb_products prod ON ( acc.product_id = prod.id )
            JOIN hb_categories cat ON ( prod.category_id = cat.id )
            LEFT OUTER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
            LEFT OUTER JOIN hb_config_items_cat f ON (ac.config_cat = f.id )
            LEFT OUTER JOIN hb_rv_renew_log l ON (acc.id = l.account_id )
        WHERE
            acc.client_id = :client_id
            AND cat.id = :cat_id
            AND f.variable='ip'
        GROUP BY 
            acc.id
        ORDER BY 
            ac.data DESC
        ",
        array(
            ':client_id' => $clientid,
            ':cat_id' => $cid
        )
    )->fetchAll();
 	
    
    for($i=0;$i<sizeof($aData);$i++){
        $accountID = $aData[$i]['id'];
        $result    = $db->query("
                    SELECT  
                            *
                    FROM    
                            hb_invoice_items ii
                            INNER JOIN hb_invoices i
                            ON (ii.invoice_id = i.id)
                    WHERE   
                            ii.type = 'Hosting'
                            AND ii.item_id = :accountid
                            AND i.status = 'Unpaid'    
                    ",
                    array(
                        ':accountid' => $accountID
                    )
                )->fetchAll();
 
        if(sizeof($result) > 0){
            $aData[$i]['inv_unpaid'] = 1;    
        }
        else{
            $aData[$i]['inv_unpaid'] = 0;   
        }
    }
 	//$aServername = array();
	//onsubmit="action_renew() return false;;
global $aServername;
$aServername = array();
?>
<form name="frm_rvskin_renew" id="frm_rvskin_renew"method="post"  action="">
<button class="clearstyle btn green-custom-btn l-btn btn_ok" onclick="if(confirm('You renew license?') == false)return false;">
<i class="icon-upload icon-white"></i>Renew</button>
&nbsp;&nbsp;
<button class="clearstyle btn green-custom-btn l-btn btn_ok btn_chk_all"onclick="return chkall();">
<i class="icon-upload icon-white"></i>Renew All License</button>
<table border="1"id="example" class="display table table-bordered table-striped data-table">
<thead>
  <tr>
    <th><div  align="center"> Product/Service </div></th>
     <th><div  align="center">Server IP</div></th>
    <th><div  align="center">subscription expiration date</div></th>
   <!-- <th><div  align="center">last update</div></th>-->
    <th><div  align="center"> status</div></th>

  </tr>
</thead>
<tbody>

<?php 
foreach ($aData as $foo=>$service) {   
    $aParam = array('accountId'=>$service['id'],'nextDue'=>$service['next_due']);
	$aExpire  = billingcycle_controller::getAccountExpiryDate($aParam);
	$aExpire = (isset($aExpire[1])) ? $aExpire[1] : $aExpire;
	if (!isset($aServername[$service['data']])) {
		//echo $service['data'];
        $aa = update_hostname1($service['data']);
     }
     $sname = ' ('.$aServername[$service['data']] . ')';//$aServername[$service['data']];
     $lastDate = ($service['dt_update']) ? date("Y-m-d H:i:s",$service['dt_update']) : '-';
 ?>
 <tr class="gradeA">
    <td align="center" class="group"><?php echo $service['data'] .$sname ;?></td>
    <td align="center"><span style="display:none;"><?php echo $service['id'];?></span>
    	<input type="checkbox" name="accid[]" value="<?php echo $service['id'];?>" <?php if($service['inv_unpaid'] == 1)echo 'disabled';?> />
        <a href="<?php echo$caUrl . $service['slug'] . '/' .$service['id'] . '/';?>">
        <?php echo $service['name'];?>
        </a>
    </td>
    
    </td>
     <td align="center">
        <?php 
        if(isset($aExpire['expire']) &&  $aExpire['expire'] != ''){
            $aExpire['expire']      = date('M j, Y', strtotime($aExpire['expire']));
        ?>
            <span style="color:<?php echo $aExpire['color'];?>;"><?php echo $aExpire['expire'];?></span>
        <?php 
        }else{
            $service['next_due']    = date('M j, Y', strtotime($service['next_due']));
            echo $service['next_due'];
        }?>
    </td>
    
    <td align="center"><?php echo $service['status'];?></td>
    
 </tr>
<?php 
 //}//close if
 }//close for
 ?>
</tbody>
</table>

<?php echo $this->_tpl_vars['securitytoken'];?>
<input type="hidden" name="cmd" value="rvskin_perpetual_license"/>
<input type="hidden" name="action" value="renewal_license"/>
<button class="clearstyle btn green-custom-btn l-btn btn_ok" onclick="if(confirm('You renew license?') == false)return false;">
<i class="icon-upload icon-white"></i>Renew</button>
&nbsp;&nbsp;
<button class="clearstyle btnv green-custom-btn l-btn btn_ok btn_chk_all" onclick="return chkall();">
<i class="icon-upload icon-white"></i>Renew All License</button>
</form>
<?php 

function update_hostname1($ip)
{
	global $aServername;
    	 
    $db = hbm_db();
    $dbdata = $db->query("SELECT * FROM hb_server_name WHERE ip_user =:ip", array(':ip' => $ip))->fetch();
    if ($dbdata) {
        $hostname = ($dbdata['hostname']);
    } else {
		$hostname = "N/A.";
    }
    $aServername[$ip] = $hostname;
    return true; 
} 

?>
<script>
var isnowchk = false 
function chkvalue(){
	if($('#frm_rvskin_renew').find('input[type=checkbox]').is(':checked') == false){
		alert('Please choose ip');
		return false;
	}else{
		return true;
	}
	
}

function chkall(){
	var chkbox = true;
	if (isnowchk == false) {
		chkbox = true;
		isnowchk= true;
	}else{
		chkbox = false;
		isnowchk= false;
	}
	$('#frm_rvskin_renew').find('input[type="checkbox"]').attr('checked',chkbox);
	if($('#frm_rvskin_renew').find('input[type=checkbox]').is(':checked') == true){
		if (confirm('You renew license?')) {
			$('#frm_rvskin_renew').submit();
		}
	}
	return false;
}

function action_renew() {
	//$('#frm_rvskin_renew').addLoader();
	$.post('?cmd=rvskin_license&action=renewal_license',$('form#frm_rvskin_renew').serialize(),function(data) {
	}); 
}
	
</script>