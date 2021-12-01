{literal}<style>.chzn-container{margin: 0px 0px 20px 10px;}</style>{/literal}<div id="formloader">
    <form id="saveform" method="post" action="">
        <input type="hidden" name="do" value="rack" />
        {if $item.id!='new'}
        <input type="hidden" name="id" value="{$item.id}" id="item_id"/>
        <input type="hidden" name="make" value="edititem" />
        {else}
        <input type="hidden" name="id" value="new" id="item_id"/>
        <input type="hidden" name="make" value="additem" />
        <input type="hidden" name="item_id" value="{$item.type_id}" />
        <input type="hidden" name="category_id" value="{$item.category_id}" />
        <input type="hidden" name="rack_id" value="{$rack_id}" />
        <input type="hidden" name="position" value="{$position}" />

        {/if}

        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr>
                <td width="140" id="s_menu" style="" valign="top">
                    <div id="lefthandmenu">
                        <a class="tchoice" href="#">Basic settings</a>
                        <a class="tchoice" href="#">Hardware</a>
                        <a class="tchoice" href="#">Connections</a> 
                        <a class="tchoice" href="#">Monitoring</a>
                        <a class="tchoice" href="#">Notes</a>


                    </div>
                </td>
                <td class="conv_content form"  valign="top">
                    <div class="tabb" style="overflow:visible">
                        <h3 style="margin-bottom:10px;"><img src="../includes/libs/configoptions/select/select_thumb2.png" alt="" style="margin-right:5px" class="left"  />  {$item.category_name} - {$item.name} {if $item.label}&raquo; {$item.label}{/if}  #{$item.id}</h3>

                        <div class="clear"></div>


                               <div style="padding:10px 0px;position:relative">
                                   
                        <label class="nodescr">Hostname / label</label>
                        <input type="text"   size=""  class="w250" name="label" value="{$item.label}" id="item_label"/>
                        <input type="hidden" value="{$item.hash}" id="item_hash"/>
                        <div class="clear"></div>


                        <label class="nodescr">Parent device</label>
                         <select  class="w250" name="parent_id" load="parents" default="{$item.parent_id}" id="parent_id"><option value="0" {if $item.parent_id=='0'}selected="selected"{/if}>#0: None</option></select>

                        <div class="clear"></div>


                        <label class="nodescr">Owner</label>
                        <select  class="w250" name="client_id" load="clients" default="{$item.client_id}" id="client_id" onchange="reloadServices()"><option value="0">None</option></select>
                        <div class="clear"></div>
                        

                        <div id="related_service">
                            <label class="nodescr">Related service</label>
                            <input type="text"   size="" value="{$item.account_id}" class="w250" name="account_id" id="account_id" />
                            <div class="clear"></div>
                        </div>
                        <div class="clear"></div>

                                    <div style="border:solid 1px #ddd;background:#F5F9FF; padding:5px; position:absolute;top:5px; right:5px;">
                            <table cellspacing="0" cellpadding="3" class="left">
                                <tbody>
                                    <tr><td width="100">Size:</td><td> {$item.units} U</td></tr>
                                    <tr><td>Current:</td><td>{$item.current} Amps</td></tr>
                                    <tr><td>Power:</td><td>{$item.power} W</td></tr>
                                    <tr><td>Weight: </td><td>{$item.weight} lbs</td></tr>
                                    <tr><td>Monthly price:</td><td>{$item.monthly_price} {$currency.code}</td></tr>
                                    <tr><td>Vendor:</td><td>{$item.vendor_name}</td></tr>
                                    <tr><td colspan="2"><a href="?cmd=module&module=dedimgr&do=inventory&subdo=category&category_id={$item.category_id}&item_id={$item.item_id}" target="_blank" class="editbtn fs11 orspace">Edit this item type</a></td></tr>
                                </tbody>
                            </table>
                                    </div>

                            {if $accounts}
                            <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;margin-right:10px;" class="left">
                                <tbody>
                                    <tr>
                                        <td><b>This item is assigned to following accounts:</b></td>
                                    </tr>
                                    {foreach from=$accounts item=a}
                                    <tr>
                                        <td>
                                            <a href="?cmd=clients&action=show&id={$a.client_id}" target="_blank">Client #{$a.client_id} {$a.firstname} {$a.lastname}</a> - <a href="?cmd=accounts&action=edit&id={$a.id}" target="_blank">Account#{$a.id}</a>
                                        </td>
                                    </tr>
                                    {/foreach}
                                </tbody>
                            </table>

                            {/if}

                            <div class="clear"></div>


                        </div>
                    </div>



                     <div class="tabb">
                        <h3 style="margin-bottom:10px;"><img src="../includes/libs/configoptions/select/select_thumb2.png" alt="" style="margin-right:5px" class="left"  />  {$item.category_name} - {$item.name} {if $item.label}&raquo; {$item.label}{/if}  #{$item.id}</h3>

                        <div class="clear"></div>


                        {foreach from=$item.fields item=f}
                                            {if $f.field_type=='clients'}{continue}{/if}
                                     <label class="nodescr">{$f.name} </label>
                                            {if $f.field_type=='input'}
                                            <input name="field[{$f.id}]" value="{$f.value}" class="w250"  type="text" />
                                            {elseif $f.field_type=='text'}
                                            <input name="field[{$f.id}]" value="{$f.value}" type="hidden" />
                                            {$f.default_value}
                                            {elseif $f.field_type=='select'}
                                            <select name="field[{$f.id}]" class="w250">
                                                {foreach from=$f.default_value item=d}
                                                <option {if $f.value==$d}selected="selected"{/if}>{$d}</option>
                                                {/foreach}
                                            </select>

                                            {elseif $f.field_type=='pdu_app'}
                                            <select name="field[{$f.id}]" class="w250">
                                                <option value="0" {if $f.value=='0'}selected="selected"{/if}>---</option>
                                                {foreach from=$pdu_apps item=d}
                                                <option value="{$d.id}" {if $f.value==$d.id}selected="selected"{/if}>#{$d.id} {$d.groupname} - {$d.name}</option>
                                                {/foreach}
                                            </select>
                                            {elseif $f.field_type=='switch_app'}
                                            <select name="field[{$f.id}]" class="w250">
                                                <option value="0" {if $f.value=='0'}selected="selected"{/if}>---</option>
                                                {foreach from=$switch_apps item=d}
                                                <option value="{$d.id}" {if $f.value==$d.id}selected="selected"{/if}>#{$d.id} {$d.groupname} - {$d.name}</option>
                                                {/foreach}
                                            </select>
                                            {/if}
                                        <div class="clear"></div>
                                    {/foreach}



                            <div class="clear"></div>


                    </div>

                   
                    <div class="tabb" style="display:none;position:relative">
                        <div id="connection_mgr" >
                        {if $item.id=='new'}
                            <strong>Save your item first to connect it to network / power</strong>
                        {else}
                            {include file='ajax.connections.tpl'}
                            {/if}</div>
                        
                    </div>

                    <div class="tabb" style="display:none">
                        <h3 style="margin-bottom:10px;"><img src="../includes/libs/configoptions/select/select_thumb2.png" alt="" style="margin-right:5px" class="left"  />  {$item.category_name} - {$item.name} {if $item.label}&raquo; {$item.label}{/if}  #{$item.id}</h3>
                        <div >
                            If Nagios module is enabled and configured you can monitor this item. Monitoring search items with corresponding hostname/label and match them with those in related rack.
                            <br/>
                        </div><br/><br/>
                        <div id="itemmonitoring"></div>
                    </div>

                    <div class="tabb" style="display:none">
                        <h3 style="margin-bottom:10px;"><img src="../includes/libs/configoptions/select/select_thumb2.png" alt="" style="margin-right:5px" class="left"  />  {$item.category_name} - {$item.name} {if $item.label}&raquo; {$item.label}{/if}  #{$item.id}</h3>
                        <b style="padding-left:10px">Admin notes:</b>
                        <textarea style="width:95%;height:150px" name="notes">{$item.notes}</textarea>
                    </div>


<div id="porteditor" style="display:none"></div>

                </td>
            </tr>
        </table>
        {securitytoken}</form> </div> {literal}
<script type="text/javascript">
    $('#lefthandmenu').TabbedMenu({elem:'.tabb'});
    function inichosen() {
        if(typeof jQuery.fn.chosen != 'function') {
            $('<style type="text/css">@import url("templates/default/js/chosen/chosen.css")</style>').appendTo("head");
            $.getScript('templates/default/js/chosen/chosen.min.js', function(){
                inichosen();
                return false;
            });
            return false;
          }
      $('#parent_id','#facebox').each(function(n){
          var that = $(this);
          var selected = that.attr('default');
          $.get('?cmd=module&module=dedimgr&do=getjsonlist&rack_id='+$('#rack_id').val()+'&item_id='+$('#item_id').val(),function(data){
            if(data.list != undefined){
                for(var i in data.list){
                    var name = data.list[i].label;
                    var select = selected == data.list[i].id ? 'selected="selected"' : '';
                    that.append('<option value="'+data.list[i].id+'" '+select+'>'+name+'</option>');
                }
            }
            that.chosen();
        });
    });
      $('#client_id','#facebox').each(function(n){
          var that = $(this);
          var selected = that.attr('default');
          $.get('?cmd=clients&action=json',function(data){
            if(data.list != undefined){
                for(var i = 0; i<data.list.length; i++){
                    var name = data.list[i][3].length ? data.list[i][3] : data.list[i][1] +' '+ data.list[i][2];
                    var select = selected == data.list[i][0] ? 'selected="selected"' : '';
                    that.append('<option value="'+data.list[i][0]+'" '+select+'>#'+data.list[i][0]+' '+name+'</option>');
                }
            }
            that.chosen();
           reloadServices();

        });
    });
    }
        inichosen();
        var l = $('#item_hash').val();
        if($('#status_'+l,'#monitoringdata').length) {
            $('#itemmonitoring').html($('#status_'+l,'#monitoringdata').html());
        } else {
             $('#itemmonitoring').html("No monitoring data found/fetched for this item");
        }

        function reloadServices() {
            ajax_update('?cmd=module&module=dedimgr&do=getclientservices',{client_id:$("#client_id").val(),service_id:$('#account_id').val()},'#related_service');
        }

    
</script>{/literal}
<div class="dark_shelf dbottom">
    <div class="left spinner"><img src="ajax-loading2.gif"></div>
    <div class="right">
        <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#saveform').submit();return false"><span>{$lang.savechanges}</span></a></span>
        <span >{$lang.Or}</span>
        <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>


    </div>
    <div class="clear"></div>
</div>