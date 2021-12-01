{literal}
<style type="text/css">
	#newshelf a.picked {background: #FFFFFF !important; }	
	p#vtip{max-width: none;}
	#bodycont > .blu  {display:none}
</style>
<script type="text/javascript">
	$(function(){
		$('#newshelfnav .list-1 li').each(function(i){
			$(this).click(function(){
				$('#newshelfnav .list-1 li').removeClass('active').eq(i).addClass('active');
				$('.selectable').hide().eq(i).show();
			});
		});
		$('.legend').siblings().hide();
		$('.legend').click(function(){
			$(this).siblings().toggle();
		});
	});
</script> 
{/literal}
<div id="newshelfnav" class="newhorizontalnav">
	<div class="list-1">
		<ul>
			<li {if !$tab || $tab==0}class="active"{/if}>
				<a href="#"><span>Email blocking</span></a>
			</li>
			<li {if $tab && $tab==1}class="active"{/if}>
				<a href="#"><span>IP blocking</span></a>
			</li>
			<li {if $tab && $tab==2}class="active"{/if}>
				<a href="#"><span>On block message</span></a>
			</li>
		</ul>
	</div>
</div>
<div id="email" class="selectable" {if $tab && $tab!=0}style="display:none"{/if}>
	<div style="margin:10px" class="p6">
		<strong>Blocked emails</strong>
		<br>
		<form name="input" action="?cmd=module&module={$moduleid}" method="post">
			<input type="hidden" name="make" value="add" />
			{$lang.add} 
			<input type="text" name="site" /> <input type="submit" value="{$lang.submit}" />
		</form>
	</div>
	<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" >
		<tr>
			<th >Rule</th>
			<th width="20"></th>
		</tr>
	{if !$emailrule}
		<tr>
			<td colspan="2">Nothing to display</td>
		</tr>
	{else}{foreach from=$emailrule item=site}
		<tr>
			<td>{$site.rule} </td>
			<td>
				<a class="delbtn" onclick="return remove_bannedemail($(this).attr('href'))"href="?cmd=module&module={$moduleid}&site={$site.id}&make=delete">Remove</a>
			</td>
		</tr>
	{/foreach}
	{/if}
	</table>
	<div style="min-height:1em;padding:10px" class="sectionfoot nicerblu">
		<h3 class="legend" style="margin:5px 0 2px;cursor:pointer">Legend<img src="{$template_dir}img/question-small-white.png" /></h3>
		<ul style="list-style:inside;padding:0">
		Rule formats:
		<li> <strong>name@domain.com</strong> - matching only one email address</li>
		<li> <strong>domain.com</strong> - matching all emails from a specific domain</li>
		<li> <strong>domain</strong> - matching all domains containing this string</li></li>
		</ul>
		<ul style="list-style:inside;padding:0">
		Example rules:
		<li><strong>foo@yahoo.com</strong> will block registration only for foo@yahoo.com. </li>
		<li><strong>yahoo.ca</strong> will block any email from yahoo.ca but not yahoo.com or yahoo.de etc. </li>
		<li><strong>yahoo</strong> will block any email from yahoo.com/yahoo.ca/subyahoo.de.</li>
		</ul>
	</div>
</div>
<div id="ip"  class="selectable" {if !$tab || $tab!=1}style="display:none"{/if}>
	<div style="margin:10px" class="p6">
		<strong>Blocked IPs</strong>
		<br>
		<form name="input" action="?cmd=module&module={$moduleid}" method="post">
			<input type="hidden" name="make" value="addip" />
			<input type="hidden" name="tab" value="1" />
			Add ip blocking rule
			<input type="text" name="site" /> <input type="submit" value="{$lang.submit}" />
		</form>
	</div>
	<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" >
		<tr>
			<th>Rule</th>
			<th width="20"></th>
		</tr>
	{if !$iprule}
		<tr>
			<td colspan="2">Nothing to display</td>
		</tr>
	{else}{foreach from=$iprule item=site}
		<tr>
			<td>{$site.rule} </td>
			<td>
				<a class="delbtn" onclick="return remove_bannedemail($(this).attr('href'))"href="?cmd=module&module={$moduleid}&site={$site.id}&make=delete&tab=1">Remove</a>
			</td>
		</tr>
	{/foreach}
	{/if}
	</table>
	<div style="min-height:1em;padding:10px" class="sectionfoot nicerblu">
		<h3 class="legend" style="margin:5px 0 2px;cursor:pointer">Legend<img src="{$template_dir}img/question-small-white.png" /></h3>
		<ul style="list-style:inside;padding:0">
	Rule formats:
		<li> <strong>all</strong> - keyword matching all IPs</li>
		<li> <strong>xxx.xxx.xxx.xxx</strong> - Single IP</li>
		<li> <strong>xxx.xxx.xxx.xxx/M</strong> - IP with Mask in CIDR format</li>
		<li> <strong>xxx.xxx.xxx.xxx/mmm.mmm.mmm.mmm</strong> - IP with Mask in dotted quad format</li>
	</ul>
	<ul style="list-style:inside;padding:0">
	Example rules:
		<li><strong>120.123.123.57/28</strong> matches IP from 120.123.123.48 to 120.123.123.63 </li>
		<li><strong>120.123.123.57/24</strong> matches IP from 120.123.123.0 to 120.123.123.255 </li>
		<li><strong>120.123.123.57/16</strong> matches IP from 120.123.0.0 to 120.123.255.255</li>
		<li><strong>120.123.123.57/8</strong> matches IP from 120.0.0.0 to 120.255.255.255</li>
	</ul>
	</div>
</div>
<div id="msg" {if !$tab || $tab!=2}style="display:none"{/if} class="selectable">
	<div style="margin:10px" class="p6">
		<strong>Block Message</strong>
		<br>
		<form name="input" action="?cmd=module&module={$moduleid}" method="post">
			<input type="hidden" name="make" value="setmsg"  />
			<input type="hidden" name="tab" value="2" />
			<div style="margin: 5px;"><textarea name="msg" style="width:100%">{$blockmsg}</textarea></div>
			Above message will be displayed on blocked registrations <input type="submit" value="{$lang.submit}" />
		</form>
	</div>	
</div>