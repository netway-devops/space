<style type="text/css" title="currentStyle">
    @import "{$template_dir}rvlicense/script_datatable/css/demo_table_jui.css";
    @import "{$template_dir}rvlicense/script_datatable/themes/smoothness/jquery-ui-1.8.4.custom.css";
</style>
<script type="text/javascript" language="javascript" src="{$template_dir}rvlicense/script_datatable/js/jquery.dataTables.js"></script>
{literal}
<script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
        oTable = $('.data-table').dataTable({
            "bJQueryUI": true,
            "iDisplayLength": 15,
            "bSort": false,
            "bFilter":false,
            "bSearchable":false,
            "bLengthChange": false,
            "sPaginationType": "full_numbers"
        });
       $('.ui-corner-tl').hide();
    } );
</script>
{/literal}
<strong>View Logs</strong><br>

<table border="1"id="example" class="display table table-bordered table-striped data-table">
<thead>
  <tr>
    <th><div  align="center">Date</div></th>
    <th><div  align="center">From IP</div></th>
    <th><div  align="center">To IP</div></th>
    
  </tr>
</thead>
<tbody>
{foreach from=$aLog key=k item=i}
 <tr class="gradeA">
    <td align="center">{$i.datecreate}</td>
    <td align="center">{$i.from_ip}</td>
    <td align="center">{$i.to_ip}</td>
 </tr>
{/foreach}
</tbody>
</table>

 
 