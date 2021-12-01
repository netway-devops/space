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


<table border="1"id="example" class="display table table-bordered table-striped data-table">
<thead>
  <tr>
    <th><div  align="center"> Product/Service </div></th>
     <th><div  align="center">Server IP</div></th>
    <th><div  align="center">expiration date</div></th>
    <th><div  align="center"> status</div></th>

    <th><div  align="center">Manage</div></th>
  </tr>
</thead>
<tbody>

 <?php 
 //TODO:: แก้ไขชั่วคร่าวเรื่อง วันหมดอายุ
function getEXPSK($accid) {
    $res = array();
    if (count($accid) == 0 )return $res;
    
    $db             = hbm_db();
    $accid = join(',',$accid);
    $sql = "
        SELECT 
            u.main_ip ,FROM_UNIXTIME(u.expire,'%Y-%m-%d') as exp
        FROM 
            rvskin_license u
        WHERE 
           u.hb_acc in (" . $accid . ")
        ORDER BY
            u.license_id DESC      
            ";
    $aData = $db->query($sql)->fetchall();
    if (count($aData) > 0 ) {
        foreach ($aData as $k => $v) {
            $res[$v['main_ip']] = $v['exp'];
        } 
    }
    return $res;
}

function getEXPSB($aAcc){
    $res = array();
    if (count($aAcc) == 0 )return $res;
    $db             = hbm_db();
    $accid = join(',',$aAcc);
    $sql = "
        SELECT 
            u.primary_ip,FROM_UNIXTIME(u.expire,'%Y-%m-%d') as exp
        FROM 
            rvsitebuilder_license u
        WHERE 
            u.hb_acc in (" . $accid . ")
        ORDER BY
            u.license_id DESC      
            ";
    $aData = $db->query($sql)->fetchall();
    if (count($aData) > 0 ) {
        foreach ($aData as $k => $v) {
            $res[$v['primary_ip']] = $v['exp'];
        }
    }
    return $res;

}   

	$db = hbm_db();
	$aAcc = $db->query("
	SELECT
	    acc.id,acc.product_id
	FROM
	    hb_accounts acc
	WHERE
	    acc.client_id = :client_id
	    and acc.product_id in (81,82,88,89,70,71,66,67,91,90)
	ORDER BY 
	    acc.id DESC
	",
	array(
	    ':client_id' => $clientid
	    )
	)->fetchAll();
    $aSB = array(66,67,91,90);
    $aSK = array(81,82,83,89,70,71);
    $aListAccSB = array();
    $aListAccSK = array();
    foreach($aAcc as $k => $v){
        if (in_array($v['product_id'], $aSB)){
            array_push($aListAccSB, $v['id']);
        } else{ 
            array_push($aListAccSK, $v['id']);
        }
    }
    $aExpSB = getEXPSB($aListAccSB);
    $aExpSK = getEXPSK($aListAccSK);
    $aData = $db->query("
        SELECT
            acc.id, acc.product_id,f.variable,ac.data,
            acc.total, acc.status, acc.billingcycle, 
            acc.next_due, cat.name AS catname, cat.slug, prod.name
        FROM
            hb_accounts acc
            JOIN hb_products prod ON ( acc.product_id = prod.id )
            JOIN hb_categories cat ON ( prod.category_id = cat.id )
            LEFT OUTER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
            LEFT OUTER JOIN hb_config_items_cat f ON (ac.config_cat = f.id )
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
            ':client_id' 	=> $clientid,
            ':cat_id' 		=> $cid
        )
    )->fetchAll();
 global $aServername;
 $aServername = array();

 foreach($aData as $foo=>$service) {   
    $aData = array('accountId' => $service['id'], 'nextDue' => $service['next_due']);
    if ($service['status'] == 'Terminated') {
    	$aExpire  = billingcycle_controller::getAccountExpiryDate($aData);
    	if (isset($aExpire[1]['expire']) && $aExpire[1]['expire'] != '') {
		    $aExpire  		= $aExpire[1];
		    list($d,$m,$y) 	= explode('/',$aExpire['expire']);
		    $aExpire['expire'] = date('M j, Y',strtotime($y . '-' . $m . '-' . $d));
	    } else {
	    	$aExpire['expire'] = '-';
	    }
    } else {
	    if (in_array($service['product_id'],$aSB) && isset($aExpSB[$service['data']])) {
	        $aExpire['expire'] = $aExpSB[$service['data']];
	        $aExpire['expire'] = date('M j, Y', strtotime($aExpire['expire']));
	        $aExpire['color']  = '';
	    } elseif (in_array($service['product_id'],$aSK) && isset($aExpSK[$service['data']])) {
	        $aExpire['expire'] = $aExpSK[$service['data']];
            $aExpire['expire'] = date('M j, Y', strtotime($aExpire['expire']));
	        $aExpire['color']  = '';
	    } else {
	        $aExpire  = billingcycle_controller::getAccountExpiryDate($aData);
	        $aExpire  = $aExpire[1];
	        list($d,$m,$y) = explode('/', $aExpire['expire']);
	        $aExpire['expire'] = date('M j, Y',strtotime($y . '-' . $m . '-' . $d));
	    }
	}
     
     if (!isset($aServername[$service['data']])) {
        update_hostname($service['data']);
     }
     $sname = ' (' . $aServername[$service['data']] . ')';//$aServername[$service['data']];
 ?>
 <tr class="gradeA">
    <td align="center" class="group"><?php echo $service['data'] .$sname ;?></td>
    <td align="center"><span style="display:none;"><?php echo $service['id'];?></span>
        <a href="<?php echo$caUrl . $service['slug'] . '/' .$service['id'] . '/';?>">
        <?php echo $service['name'];?>
        </a>
    </td>
    <td align="center">
        <?php if(isset($aExpire['expire']) &&  $aExpire['expire'] != '' ){?>
            <span style="color:<?php echo $aExpire['color'];?>;"><?php echo $aExpire['expire'];?></span>
        <?php }else{
            $service['next_due']    = date('M j, Y', strtotime($service['next_due']));
            echo $service['next_due'];
        }?>
    </td>
    <td align="center"><?php echo $service['status'];?></td>
    <td align="center">
        <?php if ($service['status']=='Active'){?>
        <div class="btn-group">
            <a href="<?php echo$caUrl . $service['slug'] . '/' .$service['id'] . '/';?>" class="btn dropdown-toggle" data-toggle="dropdown"><i class="icon-cog"></i> <span class="caret" style="padding:0"></span></a>
            <ul class="dropdown-menu"  style="right:0; left:auto;">
                <div class="dropdown-padding">
                    <li><a href="<?php echo$caUrl . $service['slug'] . '/' .$service['id'] . '/';?>" style="color:#737373">sevice management</a></li>
                    <li><a href="<?php echo$caUrl . $service['slug'] . '/' .$service['id'] . '/';?>&cancel" style="color:#737373">Request Cancellation</a></li>
                </div>
            </ul>
        </div>
        <?php } else {?>
        <a href="<?php echo$caUrl . $service['slug'] . '/' .$service['id'] . '/';?>" class="btn"><i class="icon-cog"></i></a>
        <?php } ?>

    </td>
 </tr>
<?php 
 }//close for
 ?>
</tbody>
</table>
<?php 

function update_hostname($ip)
{ 
    $db 	= hbm_db();
    $dbdata = $db->query("SELECT * FROM hb_server_name WHERE ip_user =:ip",
        array(
            ':ip' => $ip
        )
    )->fetch();
    if($dbdata){
        $hostname = ($dbdata['hostname']);
    } else {
		$hostname = "N/A.";
    }
    $aServername[$ip] = $hostname;
    return true; 
} 

?>