
{if $logs}
<table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover">
    <tbody>
      <tr>
        <th width="20%">Who</th>
		<th width="20%">When</th>
		<th width="60%">Did what</th>
	</tr>

	{foreach from=$logs item=log}
		<tr>
        <td><strong>{$log.who}</strong></td>
		<td>{$log.when}</td>
		<td>{$log.what}</td>
	</tr>
	{/foreach}
	</tbody>
</table>
{else}
No logs to display yet.
{/if}