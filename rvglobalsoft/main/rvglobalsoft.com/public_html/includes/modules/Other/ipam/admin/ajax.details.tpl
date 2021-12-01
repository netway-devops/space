{if $showth}<ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">

    <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                        <td width="80" valign="top"><div style="padding:10px 0px;"><a onclick="return editList('{$group.id}')" href="#" class="menuitm menuf" title="Edit" style="display:inline-block;width:14px;"><span class="editsth"></span></a><!--
                                --><a class="menuitm menul" title="delete" onclick="dellist(); return false" href="#"><span class="delsth"></span></a>

                            </div>
                        </td>
                        <td width="300">
                            <h3><a href="#" onclick="groupDetails({$group.id});return false;">List: {$group.name}</a></h3>
                           
                            {$group.description}
                        </td>
                        <td width="80" align="right">
                             {if $group.is_pool}Subnet:<br/>{/if}
                            Auto-assign: <br/>
                            Owner: <br/>
                        </td>
                        <td>
                             {if $group.is_pool}<b>{$group.firstip}{$group.mask}</b><br/>{/if}
                             <b>{if $group.autoprovision}Yes{else}No{/if}</b><br/>
                             <b>{if $group.client_id}<a href="?cmd=clients&action=show&id={$group.client_id}" target="_blank">#{$group.client_id} {$group.client}</a>{else}<em>None</em>{/if}</b>
                        </td>
                    </tr>
                    <tr>
                        <td >
                        </td>
                        <td colspan="3"> <div style="padding:10px 0px">
                                {if !$sub.id}<a class="new_control" onclick="return addIP();" href="#">
                                    <span class="addsth">Add new IP</span>
                                </a>
                                <a class="new_control" onclick="return addIPRange();" href="#" style="margin-left:10px;margin-right:10px;">
                                    <span class="addsth">Add IP Range</span>
                                </a>
                                {/if}
                                <a class="new_control" onclick="addlist('server', {$group.id}); return false" href="#" style="margin-right:10px;">
                                    <span class="addsth">Add Sublist</span>
                                </a>
                                {if $group.is_pool}
                                <a class="new_control" onclick="splitIP( {$group.id}); return false" href="#" >
                                    <span  class="duplicatesth" style="padding-left:19px;background-position:center left">Split</span>
                                </a>
                                {/if}
                            </div>

                        </td>
                    </tr>
                </tbody>
            </table>

        </div></li>
    {if $sub}

    <li style="background:#F4F4F4"><div style="border-bottom:solid 1px #ddd;padding-left:25px">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                        <td width="80" valign="top"><div style="padding:10px 0px;"><a onclick="return editList('{$sub.id}')" href="#" class="menuitm menuf" title="Edit" style="display:inline-block;width:14px;"><span class="editsth"></span></a><!--
                                --><a class="menuitm menul" title="delete" onclick="delsublist(); return false" href="#" style="display:inline-block;width:12px;"><span class="delsth"></span></a>

                            </div>
                        </td>
                        <td width="300">
                            <h3><a href="#" onclick="subDetails({$sub.id},{$group.id});return false;">Sub-list: {$sub.name}</a></h3>
                            {$sub.description}
                        </td>
                         <td width="80" align="right">
                             {if $sub.is_pool}Subnet:<br/> {/if}
                            Auto-assign: <br/>
                            Owner: <br/>
                        </td>
                        <td>
                             {if $sub.is_pool}<b>{$sub.firstip}{$sub.mask}</b><br/>{/if}
                             <b>{if $sub.autoprovision}Yes{else}No{/if}</b><br/>
                             <b>{if $sub.client_id}<a href="?cmd=clients&action=show&id={$sub.client_id}" target="_blank">#{$sub.client_id} {$sub.client}</a>{else}<em>None</em>{/if}</b>

                        </td>
                    </tr>
                    <tr>
                        <td >
                        </td>
                        <td colspan="3"> <div style="padding:10px 0px">
                                <a class="new_control" onclick="return addIP();" href="#">
                                    <span class="addsth">Add new IP</span>
                                </a>
                                <a class="new_control" onclick="return addIPRange();" href="#" style="margin-left:10px;margin-right:10px;">
                                    <span class="addsth">Add IP Range</span>
                                </a>

                                {if $sub.is_pool}
                                <a class="new_control" onclick="splitIP( {$sub.id}); return false" href="#" style="margin-right:10px;">
                                    <span class="duplicatesth" style="padding-left:19px;background-position:center left">Split</span>
                                </a>
                                <a class="new_control" onclick="joinIP( {$sub.id}); return false" href="#" style="margin-right:10px;">
                                    <span class="wizard" style="padding-left:19px;background-position:center left">Join</span>
                                </a>
                                {/if}
                            </div>

                        </td>
                    </tr>
                </tbody>
            </table>

        </div></li>

    {/if}
</ul>
{/if}

		{if $group.id && $sub.id}
			{assign var="sortid" value=$sub.id}
		{elseif $group.id}
			{assign var="sortid" value=$group.id}
		{/if}
<a href="?cmd=module&module={$moduleid}&action=details&group={$sortid}" id="currentlist"></a>


{if $showth}
<div class="right"><div class="pagination" style="margin-top:10px;"></div></div>
                                <div class="clear"></div>
<form action="" method="post" onsubmit="return submitForm(this)" id="ipform" >
<input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
			
    <table class="clear" width="100%" cellspacing="0" cellpadding="0" style="margin-top:10px">
        <tbody>
            <tr>
                <th width="120px">{if $sortid}<a href="?cmd=module&module={$moduleid}&action=details&group={$sortid}&orderby=ipaddress|ASC" class="sortorder">{/if}IP Address{if $sortid}</a>{/if}</th>
                <th >{if $sortid}<a href="?cmd=module&module={$moduleid}&action=details&group={$sortid}&orderby=domains|ASC" class="sortorder">{/if}Hostname{if $sortid}</a>{/if}</th>
                <th >{if $sortid}<a href="?cmd=module&module={$moduleid}&action=details&group={$sortid}&orderby=revdns|ASC" class="sortorder">{/if}Rev DNS</a></th>
                <th style="min-width:100px">{if $sortid}<a href="?cmd=module&module={$moduleid}&action=details&group={$sortid}&orderby=descripton|ASC" class="sortorder">{/if}Description{if $sortid}</a>{/if}</th>
                <th width="160px">{if $sortid}<a href="?cmd=module&module={$moduleid}&action=details&group={$sortid}&orderby=client_id|ASC" class="sortorder">{/if}Assignment{if $sortid}</a>{/if}</th>
                <th width="18px" >{if $sortid}<a href="?cmd=module&module={$moduleid}&action=details&group={$sortid}&orderby=flag|ASC" class="sortorder flagpole"></a>{else}<div class="flagpole"></div>{/if}</th>
                <th width="110px">{if $sortid}<a href="?cmd=module&module={$moduleid}&action=details&group={$sortid}&orderby=lastupdate|ASC" class="sortorder">{/if}Last update{if $sortid}</a>{/if}</th>
                <th width="85px" >{if $sortid}<a href="?cmd=module&module={$moduleid}&action=details&group={$sortid}&orderby=changedby|ASC" class="sortorder">{/if}Changed by{if $sortid}</a>{/if}</th>
                <th ></th>
            </tr>
        </tbody>
        <tbody id="updater">
           {/if}
        <input name="group" value="{$group.id}" type="hidden"/>
				{if $sub.id}<input name="sub" value="{$sub.id}" type="hidden"/>{/if}
		{foreach from=$list item=line}
        <tr>
            <td ><div>{$line.ipaddress}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">Edit</span></td>
            <td ><div>{$line.domains}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">Edit</span></td>
            <td ><div>{$line.revdns}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">Edit</span></td>
            <td ><div>{$line.descripton}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">Edit</span></td>
            <td class="fs11 ownercol"><div class="left">{if $line.client_id!='0'}Client: <a href="?cmd=clients&action=show&id={$line.client_id}" target="_blank">#{$line.client_id}</a>{else}-{/if}{if $line.account_id}
                    <br/>Account <a href="?cmd=accounts&action=edit&id={$line.account_id}" target="_blank">#{$line.account_id}</a>{/if}{if $line.port}
                    <br/>Device <a href="?cmd=module&module=dedimgr&do=rack&rack_id={$line.port.rack_id}&expand={$line.port.id}" target="_blank">{$line.port.label} ({$line.port.number})</a>
                    {/if}
                </div>
                <span class="editbtn right" onclick="editAssign('{$line.id}')">Edit</span>
            </td>
            <td style="vertical-align: middle"><div class="flagpole{if $line.flag == '1'} active{/if}" onclick="toggleFlag(this,{$line.server_id})"> </div></td>
            <td class="fs11"><div>{$line.lastupdate}</div></td>
            <td class="fs11"><div>{$line.changedby}</div></td>
            <td style="padding:5px 0 0 10px; width:20px"><a class ="delbtn" href="#" onClick="del(this,{$line.server_id})"></a></td>
        </tr>
				{/foreach}

            
                  
            

{if $showth}
        </tbody>
    </table>
</form>
  {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                                
<div class="clear"></div>
	<div style="padding:20px 0px">

            <a class=" new_control greenbtn" href="#" onclick="$('#ipform').submit(); return false;"><span><strong>{$lang.savechanges}</strong></span></a>
         {if count($list)>5}   <a class="new_control" onclick="return addIP();" href="#"  style="margin-left:10px;"><span class="addsth" >Add new IP</span></a>
            <a class="new_control" onclick="return addIPRange();" href="#" style="margin-left:10px;"><span class="addsth">Add IP Range</span></a>
            {/if}
		
		<div class="clear"></div>
	</div>
{/if}
