<a href="?cmd={$cmd}&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
<form class="searchform filterform" action="?cmd={$cmd}&action=lists&widget={$wedgetName}" method="post" onsubmit="return filter(this)">
{securitytoken}
    <table width="1000" cellspacing="2" cellpadding="3" border="0">
    <tbody>
    <tr>
        <td>
        	<strong>Filter:</strong>
			&nbsp;&nbsp;&nbsp;
        	<input type="text" name="filter[keyword]" value="{$currentfilter.keyword}" placeholder="ค้นหา" />
		    <input type="submit" value="{$lang.Search}" />
            &nbsp;&nbsp;&nbsp;
            <input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/>
		</td>
    </tr>
    </tbody>
    </table>
</form>
<script type="text/javascript">bindFreseter();</script>