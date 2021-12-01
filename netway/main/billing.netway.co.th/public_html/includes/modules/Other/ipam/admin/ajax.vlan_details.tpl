{if $showth}
    <ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">
        <li style="background:#ffffff">
            <div style="border-bottom:solid 1px #ddd;">
                <table width="100%" cellspacing="0" cellpadding="5" border="0">
                    <tbody>
                        <tr>
                            <td width="80" valign="top">
                                <div style="padding:10px 0px;">
                                    <a onclick="return editlist('{$group.id}')" href="#" class="menuitm menu-auto" title="Edit">
                                        <span class="editsth"></span>
                                    </a>
                                    <a class="menuitm menu-auto" title="delete" onclick="dellist();
                                            return false" href="#"><span class="delsth"></span>
                                    </a>
                                </div>
                            </td>
                            <td width="300">
                                <h3>
                                    <a href="#" onclick="groupDetails({$group.id});
                                            return false;">List: {$group.name}</a>
                                </h3>
                                {$group.description}
                            </td>
                            <td width="80" align="right" class="ipam-linebrs">
                                Range: <br/>
                                Auto-assign: <br/>
                                Private: <br/>

                            </td>
                            <td  width="180"class="ipam-linebrs">

                                <b>{$group.range_from} - {$group.range_to}</b><br/>
                                <b>{if $group.autoprovision}Yes{else}No{/if}</b><br/>
                                <b>{if $group.private}Yes{else}No{/if}</b><br/>

                            </td>
                            <td width="80" align="right" class="ipam-linebrs">
                                VLAN count: <br/>
                                Unassigned: <br/>
                                Usage: <br/>

                            </td>
                            <td class="ipam-linebrs">

                                <b>{$group.count}</b><br/>
                                <b>{$group.count_unasigned}</b><br/>
                                <div class="usage {if $group.count_percent > 75}red{elseif $group.count_percent>50}yelow{elseif $group.count_percent>25}green{/if}">
                                    <div style="width: {$group.count_percent}%"><span class="inverted">{$group.count_percent}%</span></div>
                                    <span>{$group.count_percent}%</span>
                                </div>

                            </td>
                        </tr>
                        <tr>
                            <td >
                            </td>
                            <td colspan="3"> 
                                <div style="padding:10px 0px">
                                    <a class="new_control" onclick="return add();" href="#">
                                        <span class="addsth">Add new VLAN</span>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </li>
    </ul>
{/if}

{assign var="sortid" value=$group.id}
<a href="?cmd=ipam&action=vlan_details&group={$sortid}" id="vlancurrentlist"></a>
{if $showth}
    <div class="right"><div class="pagination" style="margin-top:10px;"></div></div>
    <div class="clear"></div>
    <form action="" method="post" onsubmit="return submitForm(this)" id="vlanform" >
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="vlantotalpages"/>

        <table class="clear" width="100%" cellspacing="0" cellpadding="0" style="margin-top:10px">
            <tbody>
                <tr>
                    <th width="120px" >{if $sortid}<a href="?cmd=ipam&action=vlan_details&group={$sortid}&orderby=vlan|ASC" class="sortorder">{/if}VLAN{if $sortid}</a>{/if}</th>
                    <th >{if $sortid}<a href="?cmd=ipam&action=vlan_details&group={$sortid}&orderby=name|ASC" class="sortorder">{/if}Name{if $sortid}</a>{/if}</th>
                    <th style="min-width:100px">{if $sortid}<a href="?cmd=ipam&action=vlan_details&group={$sortid}&orderby=descripton|ASC" class="sortorder">{/if}Description{if $sortid}</a>{/if}</th>
                    <th >Subnets</th>
                    <th width="115px" >{if $sortid}<a href="?cmd=ipam&action=vlan_details&group={$sortid}&orderby=lastupdate|ASC" class="sortorder">{/if}Last update{if $sortid}</a>{/if}</th>
                    <th width="85px" >{if $sortid}<a href="?cmd=ipam&action=vlan_details&group={$sortid}&orderby=changedby|ASC" class="sortorder">{/if}Changed by{if $sortid}</a>{/if}</th>
                    <th ><input name="group" value="{$group.id}" type="hidden"/></th>
                </tr>
            </tbody>
            <tbody id="vlanupdater">
            {/if}
            {foreach from=$list item=line}
                <tr>
                    <td ><div>{$line.vlan}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">Edit</span></td>
                    <td ><div>{$line.name}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">Edit</span></td>
                    <td ><div>{$line.descripton}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">Edit</span></td>
                    <td class="fs11">
                        {foreach from=$line.subnet item=sub name=sub}{*}
                            {*}{if !$smarty.foreach.sub.first}, {/if}{*}
                            {*}<a href="?cmd=ipam&action=details&group={$sub.id}" >{$sub.name}</a>{*}
                            {*}{/foreach}
                        </td>
                        <td class="fs11"><div>{$line.lastupdate}</div></td>
                        <td class="fs11"><div>{$line.changedby}</div></td>
                        <td style="padding:5px 0 0 10px; width:20px"><a class ="delbtn" href="#" onClick="del(this,{$line.server_id})"></a></td>
                    </tr>
                {/foreach}
                {if $showth}
                </tbody>
            </table>
        </form>
        {$lang.showing} <span id="vlansorterlow">{$sorterlow}</span> - <span id="vlansorterhigh">{$sorterhigh}</span> {$lang.of} <span id="vlansorterrecords">{$sorterrecords}</span>

        <div class="clear"></div>
        <div style="padding:20px 0px">

            <a class=" new_control greenbtn" href="#" onclick="$('#vlanform').submit();
                    return false;"><span><strong>{$lang.savechanges}</strong></span></a>
                        {if count($list)>5}   
                <a class="new_control" onclick="return add();" href="#"  style="margin-left:10px;"><span class="addsth" >Add new VLAN</span></a>
            {/if}

            <div class="clear"></div>
        </div>
    {/if}
