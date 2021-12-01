{if $adminpanel=='ok'}
{if $vpsdo=='clientsvms'}
{literal}<!-- {"ERROR":[],"INFO":[],"STACK":0} -->{/literal}
<div class="data-table backups-list">
		<div class="svmgraphs" style="width: 500px; margin-left: 24px; margin-bottom:12px; padding: 0px; float: left;">
		    {if $nfo.trafficgraph != ''}
		    <img style="display: block; margin: 12px auto 12px auto;" src="{$nfo.trafficgraph}" alt="" />
		    {elseif $nfo.type =='openvz'}
			<p>Bandwidth Usage graph is not available yet. <a href="#" onclick="$('#vmrefresh').click();">Click</a> to reload.</p>
		    {/if}
		    {if $nfo.loadgraph != ''}
			<img style="display: block; margin: 12px auto 12px auto;" src="{$nfo.loadgraph}" alt="" />
			{elseif $nfo.type =='openvz'}
			<p>CPU Load Usage graph is not available yet. <a href="#" onclick="$('#vmrefresh').click();">Click</a> to reload.</p>
			{/if}
			{if $nfo.memorygraph != ''}
			<img style="display: block; margin: 12px auto 12px auto;" src="{$nfo.memorygraph}" alt="" />
			{elseif $nfo.type =='openvz'}
			<p>Memory Usage graph is not available yet. <a href="#" onclick="$('#vmrefresh').click();">Click</a> to reload.</p>
			{/if}
		</div>
		<div style="padding: 0px; margin-left: 24px; margin-top: 12px; margin-bottom:24px; float: left; width: 50%;">
			<table style="width: 500px; margin: 0px 0px 0px auto; border: 1px #ccc solid;" class="svmstat" cellspacing="0">
				<tr style="background-color: #eee;">
					<td class="right-aligned" width="33%">
						<b>State</b>
					</td>
					<td class="courier-font"  width="75%"><b>{$nfo.state}</b> {$lastrefresh}</td>
				</tr>
				<tr>
					<td class="right-aligned"><b>Type</b></td>
					<td class="courier-font">{$nfo.type}</td>
				</tr>
				<tr style="background-color: #eee;">
					<td class="right-aligned"><b>IP&nbsp;Addresses</b></td>
					<td class="courier-font">{foreach from=$nfo.ipaddresses item=ip}<a style="display: block; width: 100px;" href="http://{$ip}">{$ip}</a> {/foreach}</td>
				</tr>
			</table>
			<table style="width: 500px; margin: 12px 0px 0px auto; border: 1px #ccc solid;" class="svmstat" cellspacing="0">
				<tr style="background-color: #eee;">
					<td class="right-aligned"><b>Traffic</b></td>
					<td class="courier-font">
						<p><b>used:</b> {$nfo.bandwidth.used}</p>
						<p><b>limit:</b> {$nfo.bandwidth.total}</p>
						<p><b>free:</b> {$nfo.bandwidth.free} ( {$nfo.bandwidth.percent} )</p>
					</td>
				</tr>
				<tr>
					<td class="right-aligned"><b>Memory</b></td>
					<td class="courier-font">
						<p><b>used:</b> {$nfo.memory.used}</p>
						<p><b>limit:</b> {$nfo.memory.total}
						<p><b>free:</b> {$nfo.memory.free} ( {$nfo.memory.percent} )
						</td>
				</tr>
				<tr style="background-color: #eee;">
					<td class="right-aligned"><b>Disk</b></td>
					<td class="courier-font">
						<p><b>used:</b> {$nfo.hdd.used}</p>
						<p><b>limit:</b> {$nfo.hdd.total}</p>
						<p><b>free:</b> {$nfo.hdd.free} ( {$nfo.hdd.percent} )</td>
				</tr>
			</table>
		</div>
		<div style="clear: both;"></div>
</div>

{else}
{literal}
<style>
.svmstat td {
	height: 32px;
	margin: 0px !important;
	padding: 6px 12px 6px 12px !important;
}
.svmstat b {
	display: inline-block;
	width: 75px;
}

.svmstat tr:nth-child(n) {
	background-color: #f5f9ff;
}
.svmstat tr {
	margin: 3px;
}

.svmstat {
	-webkit-border-radius: 6px; /* Safari, Chrome */
	-khtml-border-radius: 6px;    /* Konqueror */
	-moz-border-radius: 6px; /* Firefox */
	border-radius: 6px;
}

.svmgraphs p {
	display: block;
	border: #ccc solid 1px;
	background-color: #eee;
	line-height: 24px;
	text-align: center;
	-webkit-border-radius: 6px; /* Safari, Chrome */
	-khtml-border-radius: 6px;    /* Konqueror */
	-moz-border-radius: 6px; /* Firefox */
	border-radius: 6px;
}

.svmgraphs p:nth-child(2n) {
	background-color: white;
}
</style>
{/literal}
<ul class="accor">
  <li>
    <a href="#" class="darker">VM</a>
    <div class="sor"><a id="vmrefresh" href="#" style="position: relative; top: -25px; left: 50px;" class="menuitm" onclick="ajax_update('?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=clientsvms','','#lmach',true);">refresh</a>
		<div id="lmach">
			<br />
		</div>
		<script type="text/javascript">
			ajax_update('?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&vpsdo=clientsvms','','#lmach',true);
		</script>
    </div>
  </li>
</ul>

{/if}
{/if}