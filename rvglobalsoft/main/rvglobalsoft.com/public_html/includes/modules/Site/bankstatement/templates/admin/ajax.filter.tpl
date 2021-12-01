<a href="?cmd=transactions&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
<form class="searchform filterform" action="?cmd={$cmd}" method="post" onsubmit="return filter(this)">
{securitytoken}
    <table width="1000" cellspacing="2" cellpadding="3" border="0">
    <tbody>
    <tr>
    	<td colspan="5">
    	    <strong>Filter:</strong>
            &nbsp;&nbsp;&nbsp;
            <a href="?cmd={$cmd}&action=default&filterName=now">ดูข้อมูลวันปัจจุบัน</a> &nbsp; 
            <a href="?cmd={$cmd}&action=default&filterName=thismonth">ดูข้อมูลเดือนปัจจุบัน</a> &nbsp; 
            <a href="?cmd={$cmd}&action=default&filterName=lastmonth">ดูข้อมูลเดือนที่แล้ว</a> &nbsp;
    	</td>
	</tr>
    <tr>
        <td>ระหว่างวันที่</td>
        <td><input type="text" name="filter[date_from]" value="{$currentfilter.date_from}" class="haspicker" /></td>
        
        <td> ถึง </td>
        <td><input type="text" name="filter[date_to]" value="{$currentfilter.date_to}" class="haspicker" /></td>
        
        <td width="50">&nbsp;</td>
        <td>
            <select name="filter[payment]">
                <option value="">--- ทุกธนาคาร ---</option>
                {foreach from=$aBankTransfer key=id item=name}
                <option value="{$id}" {if $id == $currentfilter.payment } selected="selected" {/if}> {$name} </option>
                {/foreach}
            </select>
        </td>
    </tr>
      
    <tr>
          <td colspan="5">
          <center>
            <input type="submit" value="{$lang.Search}" />
            &nbsp;&nbsp;&nbsp;
            <input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/>
          </center>
		  </td>
    </tr>
    </tbody>
    </table>
</form>
<script type="text/javascript">bindFreseter();</script>