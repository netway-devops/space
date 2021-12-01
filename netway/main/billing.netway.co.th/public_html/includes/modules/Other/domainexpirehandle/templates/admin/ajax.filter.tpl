<a href="?cmd={$cmd}&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
<form class="searchform filterform" action="?cmd={$cmd}&action=lists&widget={$wedgetName}" method="post" onsubmit="return filter(this)">
{securitytoken}
    <table width="1000" cellspacing="2" cellpadding="3" border="0">
    <tbody>
    <tr>
        <td>
            <strong>Filter:</strong>
            <input type="text" id="filterKeyword" name="filter[keyword]" value="{$currentfilter.keyword}" placeholder="ชื่อโดเมน" />
        </td>
        <td>
			&nbsp;&nbsp;&nbsp;
            <input type="text" id="filterStartDate" name="filter[start_date]" value="{$currentfilter.start_date}" placeholder="วันเริ่มต้น log" />
            <input type="text" id="filterEndDate" name="filter[end_date]" value="{$currentfilter.end_date}" placeholder="วันสิ้นสุด log" />
            &nbsp;&nbsp;&nbsp;
        	<select name="filter[module]">
        	    <option value="">ทั้งหมด</option>
        	    {foreach from=$aModules item=aModule}
        	    <option value="{$aModule.id}" {if $aModule.id == $currentfilter.module} selected="selected" {/if}>{$aModule.module}</option>
        	    {/foreach}
        	</select>
		    <input type="hidden" name="filter[widget]" value="{$widget}" />
		    <input type="submit" value="{$lang.Search}" />
            &nbsp;&nbsp;&nbsp;
            <input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/>
		</td>
    </tr>
    </tbody>
    </table>

</form>

<script type="text/javascript">bindFreseter();</script>
<script type="text/javascript">

{literal}
$(document).ready( function () {
    $('#filterStartDate').datePicker({
        startDate:'01/01/2000',
        direction: true,
        pair: $('#filterEndDate')
    });
    $('#filterEndDate').datePicker({
        startDate:'01/01/2000',
        direction: 1
    });
});
{/literal}


</script>