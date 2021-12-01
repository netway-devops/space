<div id="cactimgr">
    <div id="cacti_billing" style="margin-bottom:25px;">
    <center>
    Loading bandwidth/billing data... <Br/><Br/>
    <img src="ajax-loading.gif" alt="" />
    <br/>


    </center>
    {literal}
<script type="text/javascript">
    ajax_update('?cmd=cacti&action=billingdata&account_id='+$('#account_id').val(),{},'#cacti_billing');
    </script>
    {/literal}
</div>



    
<script type="text/javascript">
    var gtpl = "?cmd=cacti&action=showgraph&account_id={$account_id}";
    {literal}
    function loadCactiMgr() {
       ajax_update('?cmd=cacti&action=accountdetails',{id:$('#account_id').val(),loadbyajax:true},'#cactimgr');
    }
  function loadCactiPorts() {
    $('#add_cacti').show();
    ajax_update('?cmd=cacti&action=loadswitch',{account_id:$('#account_id').val()},'#cacti_port_loader',true);
      return false;
  }
  function change_cacti_sw(select) {
      var v = $(select).val();
      $('.sw_cacti_port').hide();
      $('#cacti_port_id_'+v).show();
      return false;
  }
  function showCactiGraphs(sw,p,btn) {
      $(btn).toggleClass('activated');
      var imurl = gtpl + "&switch_id="+sw+"&port_id="+p;
      var targetc = $('#graphs_'+sw+'_'+p).toggle();
      var target = $('.lgraphs',targetc);
      if(targetc.hasClass('loaded'))
          return false;
      targetc.addClass('loaded');

$('.ldaily',target).append('<img src="'+imurl+'" />');
$('.lweekly',target).append('<img src="'+imurl+'&type=weekly" />');
$('.lmonthly',target).append('<img src="'+imurl+'&type=monthly" />');
return false;
  }
 function  unassignCactiPort(sw,p) {
     if(!confirm('Are you sure you wish to unassign this port? This may change billing totals')) {
         return false;
     }
     $.post('?cmd=cacti&action=rmassignment',{
            account_id:$('#account_id').val(),
            switch_id:sw,
            port_id:p
        },function(){
            loadCactiMgr();
        });
        return false;

  }
   function assignCactiPort() {
        if(!$('#cacti_switch_id').val())
            return false;

var switch_id=$('#cacti_switch_id');
var port_id = $('#cacti_port_id_'+switch_id.val());

        $.post('?cmd=cacti&action=addassignment',{
            account_id:$('#account_id').val(),
            switch_id:switch_id.val(),
            port_id:port_id.val(),
            switch_name:$('option:selected',switch_id).text(),
            port_name:$('option:selected',port_id).text()
        },function(){
            loadCactiMgr();
        });
        return false;
    }
    </script><style type="text/css">
        .lgraph {
            background: url('ajax-loading.gif') no-repeat center center;
            min-height:150px;
            text-align: center;
            margin-bottom:10px;
}
    </style>
{/literal}<div id="add_cacti" style="display:none">
    <div class="left" style="margin-right:10px;padding:4px"><b>Assign new switch & port fom cacti:</b></div>

    <div id="cacti_port_loader" class="left">Loading data...</div>
    <div class="clear"></div>
</div>
{if !$cacti_datasources}

<div class="blank_state_smaller blank_forms" id="blank_cacti">
        <div class="blank_info">
            <h3>Connect this account with Cacti graphs</h3>
            <span class="fs11">
                With HostBill you can monitor bandwidth utilisation/overages measured by Cacti "Interface - Traffic" graphs. <br/>
                Additionally using Product->Client functions you can allow access to selected graphs for your customers in client area.<br/>

            </span>
            <div class="clear"></div>
            <br>
            <a onclick="$('#blank_cacti').hide();return loadCactiPorts();" class="new_control" href="#"><span class="addsth"><strong>Select switch/ports to connect</strong></span></a>
            <div class="clear"></div>
        </div>
    </div>
{else}
<h3>Assigned Cacti devices</h3>

    <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">

{foreach from=$cacti_datasources item=itm}
<li style="background:#ffffff" class="cacti_row" ><div style="border-bottom:solid 1px #ddd;">
<table width="100%" cellspacing="0" cellpadding="5" border="0">
<tbody><tr>
<td width="120" valign="top"><div style="padding:10px 0px;">
<a onclick="return unassignCactiPort('{$itm.c_switch_id}','{$itm.c_port_id}')" title="delete" class="menuitm menuf" href="#"><span class="rmsth">Unassign</span></a><!--
--><a onclick="return showCactiGraphs('{$itm.c_switch_id}','{$itm.c_port_id}',this)" title="delete" class="menuitm menul" href="#"><span class="graphst">Usage graphs</span></a>
</div></td>
<td>
    {$itm.name}
</td>
</tr>
<tr id="graphs_{$itm.c_switch_id}_{$itm.c_port_id}" style="display:none">
    <td></td>
    <td class="lgraphs">
        <div class="ldaily lgraph"></div>
        <div class="lweekly lgraph"></div>
        <div class="lmonthly lgraph"></div>
    </td>
</tr>
</tbody></table>
    </div></li>
{/foreach}
</ul>

<a onclick="$(this).hide();return loadCactiPorts();" class="new_control" href="#"><span class="addsth"><strong>Select switch/ports to connect</strong></span></a>




{/if}
</div>