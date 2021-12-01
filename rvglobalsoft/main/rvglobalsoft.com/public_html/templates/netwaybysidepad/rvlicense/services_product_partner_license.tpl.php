<?php 
/*********************************************************
    1. $aService = Array
        (
        [host] => 75.126.165.114
        [dbname] => rvglobal_maincccc
        [user] => rvglobal_rvstore
        [pwd] => (b{=?t&%E)Gi
        )
    2. productid
    
 ********************************************************/
$pathTheme 	= $this->_tpl_vars['template_dir'];
$action 	= $this->_tpl_vars['action'];
$ca_url 	= $this->_tpl_vars['ca_url'];
$cid 		= $this->_tpl_vars['cid'];
$aa 		= $this->_tpl_vars;

$a_service = array();
foreach ($this->_tpl_vars['services'] as $val) {
    $a_service[$val['product_id']] = $val;
}

$caUrl 		= $ca_url . 'clientarea' . '/' . $action .'/noc-licenses';
$clientid 	= $_SESSION['AppSettings']['login']['id'];
//http://192.168.1.82/demo/rvglobalsoft.com/public_html/index.php?/clientarea/services/licenses/10853/
require_once( APPDIR_MODULES . "Other/rv_partner_sitebuilder/class.rv_partner_sitebuilder.php");
require_once ( APPDIR_MODULES . "Other/rv_partner_skin/class.rv_partner_skin.php");
 
$modSB = new rv_partner_sitebuilder;
$aData = $modSB->getLicenseSB($clientid);

$modSK 	= new rv_partner_skin;
$aData2 = $modSK->getLicenseSK($clientid);

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
            //$('#example_filter').before('Data '+$('#nettotal').html());
        },
        "aoColumnDefs": [
            { "bVisible": false, "aTargets": [ 0 ] }
        ],
            "bJQueryUI": true,
            "sDom": '<"wrapper"it>, <lf<t>ip>',
            "iDisplayLength": 25,
            "bSort": true,
            "bLengthChange": false,
            "sPaginationType": "full_numbers"
        });
        
        
    } );
        function btnCallTransferLicenseDialog(objLink){
           // ฟังก์ชั่นของปุ่ม Transfer License เรียก modal dialog
            var ip = objLink.attr('ip');
            var subip = objLink.attr('subip');
            var accid = objLink.attr('accid');
            var licensetype = objLink.attr('licensetype');
            var cmd = objLink.attr('cmd');
            $('.errortran').hide();
            $('.infotran').hide();
            $('#yourIP').text(ip) ;
            $('#cmd').val(cmd); 
            $('#accid').val(accid); 
            $('#licensetype').val(licensetype); 
            $('#newIP').val(ip);
            $('#yoursubIP').text(subip); 
            $('#newsubIP').val(subip);
        }
</script>

<table border="1"id="example" class="display table table-bordered table-striped data-table">
<thead>
  <tr>
    <th><div  align="center"> Product/Service </div></th>
     <th><div  align="center">Server IP</div></th>

    <th><div  align="center"> status</div></th>

    <th><div  align="center">Manage</div></th>
  </tr>
</thead>
<tbody>
 <?php 
 global $aServername;
 $aServername = array();
//echo '<pre>';print_r($aData);
 $aProductName = array(
    //'9'  => array('pid' => 77,'name' => 'RVSiteBuilder (for dedicated server)'),
    //'11' => array('pid' => 78, 'name' =>'RVSiteBuilder (for VPS server)'),
    '77'  => array('pid' => 77,'name' => 'RVSiteBuilder (for dedicated server)'),
    '78' => array('pid' => 78, 'name' =>'RVSiteBuilder (for VPS server)'),
    '159' => array('pid' => 78, 'name' =>'RVSiteBuilder NOC License')
 );
 $netSB = count($aData);
 foreach($aData as $foo=>$service) {
     if (!isset($aServername[$service['primary_ip']])) {
        $aa = update_hostname($service['primary_ip']);
     }
     $sname = '('.$aServername[$service['primary_ip']] . ')';//$aServername[$service['data']];
     $sta 	= ($service['active'] == 1) ? 'Active' : 'Suspend';
     $service['name'] = $aProductName[$service['product_id']]['name'];
 ?>
 <tr class="gradeA">
    <td align="center" class="group"><?php echo 'PrivateIP '.$service['primary_ip'].', PublicIP '.$service['secondary_ip'] .' '.$sname ;?></td>
    <td align="center"><span style="display:none;"><?php echo $service['id'];?></span>
        <!--<a href="<?php echo$caUrl . '/' .$a_service[$aProductName[$service['license_type']]['id']]['pid'];?>">-->
        <?php echo $service['name'];?>
        <!--</a>-->
    </td>
   
    <td align="center"><?php echo $sta;?></td>
    <td align="center">
        <a href="#myModal" role="button" onclick="btnCallTransferLicenseDialog($(this));" class="btn btntran" data-toggle="modal" accid="<?=$service['hb_acc']?>" ip="<?php echo $service['primary_ip']?>" licensetype="<?=$service['license_type']?>" cmd="rvsitebuilder_license" subip="<?php echo $service['secondary_ip']?>">Edit</a>
        
        <button showip="<?php echo $service['primary_ip']?>" licenseid="<?php echo $service['license_id']; ?>" onclick="action_terminate($(this));"cmd="rvsitebuilder_license"  class="clearstyle btn green-custom-btn l-btn">
        <i class="icon-remove icon-white"></i>Delete</button>
    </td>
 </tr>
<?php 
 }//close for
 
 $aProductNameSK = array(
 	''		=> array('pid' => 73, 'name' => 'RVSkin (for dedicated server)'),
 	'VPS' 	=> array('pid' => 74, 'name' => 'RVSkin (for VPS)'),
 );
 $netSK = count($aData2);
 $totalData = $netSB + $netSK;
 foreach($aData2 as $foo=>$service) {   
     if (!isset($aServername[$service['main_ip']])) {
        $aa = update_hostname($service['main_ip']);
     }
     $sname 			= ' (' . $aServername[$service['main_ip']] . ')';
     $sta 				= ($service['active'] == 'yes')?'Active':'Suspend';
     $service['name'] 	= $aProductNameSK[$service['license_type']]['name'];
 ?>
 <tr class="gradeA">
    <td align="center" class="group"><?php echo 'PrivateIP '.$service['main_ip'].', PublicIP '.$service['second_ip'] .' '.$sname ;?></td>
    <td align="center"><span style="display:none;"><?php echo $service['id'];?></span>
        <!--<a href="<?php echo$caUrl . '/' . $a_service[$aProductNameSK[$service['license_type']]['id']]['pid'];?>">-->
        <?php echo $service['name'];?>
        <!--</a>-->
    </td>
   
    <td align="center"><?php echo $sta;?></td>
    <td align="center">
        <a href="#myModal" role="button" onclick="btnCallTransferLicenseDialog($(this));" class="btn btntran" data-toggle="modal" accid="<?=$service['hb_acc']?>" ip="<?php echo $service['main_ip']?>" licensetype="<?=$service['license_type']?>" cmd="rvskin_license" subip="<?php echo $service['second_ip']?>">Edit</a>
        <button class="clearstyle btn green-custom-btn l-btn"showip="<?php echo $service['main_ip']?>" licenseid="<?php echo $service['license_id']; ?>" onclick="action_terminate($(this));"cmd="rvskin_license" ><i class="icon-remove icon-white"></i>Delete</button>
    </td>
 </tr>
<?php 
 }//close for
 ?>
</tbody>
</table>
<span id="nettotal" style="display:none;"><?php echo $totalData;?> entries</span>
<?php 

function update_hostname($ip)
{
    $db = hbm_db();
	global $aServername;
    $dbdata = $db->query("SELECT * FROM hb_server_name WHERE ip_user =:ip",
        array(
            ':ip' => $ip
        )
    )->fetch();
    if ($dbdata) {
        $hostname = ($dbdata['hostname']);
    } else {
		$hostname = "N/A.";
    }
    $aServername[$ip] = $hostname;
    return true; 
} 

?>
<form name="frmterminate"id="frmterminate" method="post"  action="">
<input type="hidden" name="licenseid" id="inputlicenseid" value="" />
</form>

    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog">
    <div class="modal-header">
    <h3>Edit license</h3>
    </div>
    <div class="modal-body" >
        <center>
            <div class="errortran alert alert-error" style="display: none"></div>
            <div class="infotran alert alert-info" style="display: none"></div>
        </center>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class='span3' style="margin-left:2.564102564102564%;">
                    <b>
                        Private IP
                    </b>
                </div>
                <div class='span8' >
                    <span id="yourIP"></span>
                </div>
                <div class='span3' >
                    <b>
                        To IP
                    </b>
                </div>
                <div class='span8' >
                    <input type="text" name="newIP" id="newIP" />
                    <input type="hidden" name="accid" id="accid" />
                    <input type="hidden" name="cmd" id="cmd" />
                    <input type="hidden" name="servertype" id="servertype" />
                </div>
                <div class='span3' >
                    <b>
                        Public IP
                    </b>
                </div>
                <div class='span8' >
                    <span id="yoursubIP"></span>
                </div>
                <div class='span3' >
                    <b>
                        To IP
                    </b>
                </div>
                <div class='span8' >
                    <input type="text" name="newsubIP" id="newsubIP" />
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
    <a href="#" onclick="$('#myModal').modal('hide'); return false;" id="closemodel" class="btn">Close</a>
    <a href="#" onclick="submitTransfer(); return false;" class="btn btn-primary">Save changes</a>
    </div>
    </div>
<script>
function action_terminate(obj) {
	if (confirm('Confirm to delete ip ='+obj.attr('showip'))) {
    var getcmd = obj.attr('cmd');//$('#cmd').val();
    $('#inputlicenseid').val(obj.attr('licenseid'));
    $('.sta_no').hide();
    $('.sta_ok ').show().find('#txt_response_yes').html('waiting.....');
    $.post('?cmd=' + getcmd + '&action=partner_terminate_license',$('form#frmterminate').serialize(),function(data) {
        // CALL BACK
        //data = jQuery.parseJSON(data);
        var datares = data.aResponse;
        if (datares.res == true) {
            alert('Terminate IP Request has been successfully processed.');
            setTimeout(function(){location.reload()},10);
           
        } else {
            alert(datares.msg);
           
        }
        
    });
	}else{

	}
    
}

function submitTransfer(){
    //$('.modal').addClass('lod')
    $('.infotran').hide();
    $('.errortran').hide();
    $('.modal').addLoader();
    $('#preloader').css({'top':'0','left':'0'});
    
    var newIP           = $("#newIP").val();
    var newsubIP		= $("#newsubIP").val();
    var acc_idd          = $("#accid").val();
    var cmdd             = $("#cmd").val();
    var server_typed     = $("#servertype").val();
    var oldIP            = $("#yourIP").text();
    var oldSubIP		=  $("#yoursubIP").text();
    var system_url      = '<?php echo $this->get_template_vars("system_url");?>';
    var urlto           = system_url+ '?cmd='+cmdd+'&action=changeipNOC';
    
   
    $.post(urlto,{to_ip:newIP,to_subip:newsubIP,cmd:cmdd,acc_id:acc_idd,server_type:server_typed,old_ip:oldIP,old_supip:oldSubIP},function(data){
        
        var datares = data.aResponse;
        if (datares.res == true) {
            $('.infotran').text('Chenge IP Request has been successfully.');
            $('.infotran').show();
            setTimeout(function(){location.reload()},3000);
           
        } else {
           
            $('.errortran').text(datares.msg);
            $('.errortran').show();
        }
        $('#preloader').hide();
            
    });
}
</script>