<div id="librenmsmgr">
    <div id="librenms_billing" style="margin-bottom:25px;">
    <center>
    Loading bandwidth/billing data... <Br/><Br/>
    <img src="ajax-loading.gif" alt="" />
    <br/>


    </center>
    {literal}
<script type="text/javascript">
    ajax_update('?cmd=librenms_billing&action=billingdata&account_id='+$('#account_id').val(),{},'#librenms_billing');
    </script>
    {/literal}
</div>

<script type="text/javascript">
    var gtpl = "?cmd=librenms_billing&action=showgraph&account_id={$account_id}";
    {literal}
    function loadlibrenmsMgr() {
       ajax_update('?cmd=librenms_billing&action=accountdetails',{id:$('#account_id').val(),loadbyajax:true},'#librenmsmgr');
    }
  function loadlibrenmsPorts() {
    $('#add_librenms').show();
    ajax_update('?cmd=librenms_billing&action=loadswitch',{account_id:$('#account_id').val()},'#librenms_port_loader',true);
      return false;
  }
  function change_librenms_sw(select) {
      var v = $(select).val();
      $('.sw_librenms_port').hide();
      $('#librenms_port_id_'+v).show();
      return false;
  }
  function showlibrenmsGraphs(sw,p,btn) {
      $(btn).toggleClass('activated');
      var imurl = gtpl + "&switch_id="+sw+"&port_id="+p;
      var targetc = $('#graphs_'+sw+'_'+p).toggle();
      var target = $('.lgraphs',targetc);
      if(targetc.hasClass('loaded'))
          return false;
      targetc.addClass('loaded');
      var fn = "drawgraph_"+sw+"_"+p;
      console.log(fn);
      window[fn]();

return false;
  }
 function  unassignlibrenmsPort(sw,p) {
     if(!confirm('Are you sure you wish to unassign this port? This may change billing totals')) {
         return false;
     }
     $.post('?cmd=librenms_billing&action=rmassignment',{
            account_id:$('#account_id').val(),
            switch_id:sw,
            port_id:p
        },function(){
            loadlibrenmsMgr();
        });
        return false;

  }
   function assignlibrenmsPort() {
        if(!$('#librenms_switch_id').val())
            return false;

var switch_id=$('#librenms_switch_id');
var port_id = $('#librenms_port_id_'+switch_id.val());

        $.post('?cmd=librenms_billing&action=addassignment',{
            account_id:$('#account_id').val(),
            switch_id:switch_id.val(),
            port_id:port_id.val(),
            billforit: $('#billforit').is(':checked')?1:0,
            switch_name:$('option:selected',switch_id).text(),
            port_name:$('option:selected',port_id).text()
        },function(){
            loadlibrenmsMgr();
        });
        return false;
    }
    </script><style type="text/css">
        .lgraph {
            min-height:150px;
            text-align: center;
            margin-bottom:10px;
}
    </style>
{/literal}<div id="add_librenms" style="display:none">
    <div class="left" style="margin-right:10px;padding:4px"><b>Assign new billed graph from LibreNMS:</b></div>

    <div id="librenms_port_loader" class="left">Loading data...</div>
    <div class="clear"></div>
</div>
{if !$librenms_datasources}

<div class="blank_state_smaller blank_forms" id="blank_librenms">
        <div class="blank_info">
            <h3>Connect this account with LibreNMS billing graphs</h3>
            <span class="fs11">
                With HostBill you can bill for bandwidth utilisation/overages measured by LibreNMS Billing module. <br/>
                Additionally using Product->Client functions you can allow access to selected graphs for your customers in client area.<br/>

            </span>
            <div class="clear"></div>
            <br>
            <a onclick="$('#blank_librenms').hide();return loadlibrenmsPorts();" class="new_control" href="#"><span class="addsth"><strong>Select switch/ports to connect</strong></span></a>
            <div class="clear"></div>
        </div>
    </div>
{else}
<h3>Assigned librenms devices</h3>
    <script type="text/javascript" src="../includes/modules/Hosting/librenms_billing/templates/dygraph.js"></script>
    <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">

{foreach from=$librenms_datasources item=itm}
<li style="background:#ffffff" class="librenms_row" ><div style="border-bottom:solid 1px #ddd;">
<table width="100%" cellspacing="0" cellpadding="5" border="0">
<tbody><tr>
<td width="230" valign="top"><div style="padding:10px 0px;">
<a onclick="return unassignlibrenmsPort('{$itm.device_id}','{$itm.port_id}')" title="delete" class="menuitm menuf" href="#"><span class="rmsth">Unassign</span></a><!--
--><a onclick="return showlibrenmsGraphs('{$itm.device_id}','{$itm.port_id}',this)" title="delete" class="menuitm menul" href="#"><span class="graphst">Usage graphs</span></a>
</div></td>
<td>
    {$itm.name} {if !$itm.billed}<em>Not billable</em>{/if}
</td>
</tr>
<tr id="graphs_{$itm.device_id}_{$itm.port_id}" style="display:none">
    <td class="lgraphs" colspan="2">
        <div class="lbilling lgraph">
            <h3>Monthly view</h3>
            <div id="chart{$itm.device_id}_{$itm.port_id}" style="width:100%; height:360px;"> </div>
            <hr>
            <h3>Transfer graphs</h3>
            <div id="graph{$itm.device_id}_{$itm.port_id}">
                <script>$(function () {ldelim}
                        var w = $('.tab_content').width(),
                            i = $('#img_graph{$itm.device_id}_{$itm.port_id}'),
                            s = i.attr('src');
                        i.attr('src', s + (w - 20));
                    {rdelim});</script>
                <img id="img_graph{$itm.device_id}_{$itm.port_id}" loading="lazy" src="?cmd=librenms_billing&action=showgraph&account_id={$account_id}&switch_id={$itm.device_id}&port_id={$itm.port_id}&type=day&width="></div>
            </div>
        </div>

        {literal}
            <script type='text/javascript'>
                function drawgraph_{/literal}{$itm.device_id}_{$itm.port_id}{literal}() {

                 new Dygraph(
                        document.getElementById('{/literal}chart{$itm.device_id}_{$itm.port_id}{literal}'),
                         {/literal}'index.php?cmd=librenms_billing&action=billing_data&account_id={$account_id}&port_id={$itm.port_id}',{literal}
                        {
                            axes: {
                                x: {
                                    gridLineWidth: 1,
                                    drawGrid: true,
                                    gridLineColor: '#999999',
                                },
                                y: {
                                    ticker: Dygraph.numericLinearTicks,
                                    gridLineWidth: 1,
                                    drawGrid: true,
                                    gridLineColor: '#bbbbbb',
                                    gridLinePattern: [4,4]
                                }
                            },
                            ylabel: 'Bits per second',
                            xlabel: 'Date (Ticks indicate the start of the indicated time period)',
                            highlightCircleSize: 2,
                            strokeWidth: 1,
                            colors: ['#4A8328', '#323B7C'],
                            fillGraph: true,
                            fillAlpha: 0.25,
                            axisLabelFontSize: 12,
                            highlightSeriesOpts: {
                                strokeWidth: 2,
                                strokeBorderWidth: 0,
                                highlightCircleSize: 4
                            },
                            showRangeSelector: true,
                            labels: ['Date','Input', 'Output'],
                            labelsKMG2: true,
                            legend: 'always',
                            labelsDivStyles: { 'textAlign': 'right' },
                            rangeSelectorHeight: 30
                        }
                );
                }
            </script>
        {/literal}
    </td>
</tr>
</tbody></table>
    </div></li>
{/foreach}
</ul>

<a onclick="$(this).hide();return loadlibrenmsPorts();" class="new_control" href="#"><span class="addsth"><strong>Select switch/ports to connect</strong></span></a>




{/if}
</div>