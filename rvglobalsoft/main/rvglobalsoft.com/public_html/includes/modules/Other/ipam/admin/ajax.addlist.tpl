
{if !$mode}{literal}
<script type="text/javascript">
    var actv_form = 0;
    $(function(){
        $('.form_container').hide().eq(0).show();
        $('.content .fleft > div').eq(0).addClass('actv');
        $('.content .fleft > div').each(function(x){
            $(this).click(function(){
                actv_form = x;
                $('.form_container').hide().eq(x).show();
                $('.content .fleft > div').removeClass('actv').eq(x).addClass('actv');
            });
        });
        $("a.vtip_description").vTip();
    });
    function test(l){
        form = $(l).parents('form');
        ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&mode=testcon&"+form.serialize(), {}, $(l).next('.test'), false)
    }
    function submitList(form){
        ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&mode=addlist&"+form.serialize(), false, function(data){
            ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&refresh=1&",{}, "#treecont");
            $(document).trigger('close.facebox');
        });
    }
    function shpool(el) {
        if($(el).is(':checked')) {
            $('#pool_settings').show();
        } else {
            $('#pool_settings').hide();
        }
        return false;
    }
    function vtype(ip) {
        $('.cidrts').hide();
        $('#cidr_'+ip).show();
    }
    function inichosen() {
        if(typeof jQuery.fn.chosen != 'function') {
            $('<style type="text/css">@import url("templates/default/js/chosen/chosen.css")</style>').appendTo("head");
            $.getScript('templates/default/js/chosen/chosen.min.js', function(){
                inichosen();
                return false;
            });
            return false;
        }

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

            });
        });
    }
    inichosen();
</script>
{/literal}
<table width="100%"><tr>
        <td class="fleft">
            <div>Add new list</div>
	{if $suported}
	{foreach from=$suported item=api}
            <div>{$api.modname}</div>
	{/foreach}
	{/if}
        </td>
        <td class="fright">
            <h3 style="margin-bottom:0px;">
	Add {if $suported}or Import {/if}new IP {if $sublist}sublist to {$sublist.name}{else}List{/if}
            </h3>
            <div class="form_container">
                <form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false">
                    <input type="hidden" name="action" value="addlist" />
		{if $sublist}<input type="hidden" name="sub" value="{$sublist.id}" />{/if}
                    <br/>
                    <label>List name</label><input type="text" name="listname" value="" />
                    <div class="clear"></div>

                    

                        <label class="nodescr">Owner</label>
                        <select  class="w250" name="client_id" load="clients"  id="client_id" ><option value="0">None</option></select>
                        <div class="clear"></div>

                    <label>IP Types</label><select name="type" class="w250" onchange="vtype($(this).val())">
                        <option value="ipv4">IP v4</option>
                        <option value="ipv6">IP v6</option>
                    </select>
                    <div class="clear"></div>

                    <label>Auto-assign <a class="vtip_description" title="Enable this option if you want HostBill to use this pool with auto-provisioned servers"></a></label><input type="checkbox" name="autoprovision" value="1" />
                    <div class="clear"></div>

                    <label>Fill IP pool?</label><input type="checkbox" name="is_pool" value="1" onclick="shpool(this)" />

                    <div class="clear"></div>
                    <div id="pool_settings" style="display:none">
                        <label>Network (CIDR)</label><input type="text" name="firstip" value=""  class="w250 left" style="width:200px;margin-right:10px;"/>
                        <select name="cidr_ipv4" id="cidr_ipv4" class="w250 left cidrts" style="width:80px">
                            {foreach from=$v4blocks item=i key=k}
                            <option value="{$k}">{$k} ({$i})</option>
                            {/foreach}
                        </select>
                        <select name="cidr_ipv6" id="cidr_ipv6" class="w250 left cidrts" style="width:80px;display:none">
                            {foreach from=$v6blocks item=i key=k}
                            <option value="{$k}">{$k} ({$i})</option>
                            {/foreach}
                        </select>
                        <div class="clear"></div>
                        <label>Gateway</label><input type="text" name="gateway" value=""  class="w250"/>
                        <div class="clear"></div>
                    </div>


                    <label>Description</label><textarea name="description" class="w250"></textarea>
                    <div class="clear"></div>

                </form>
            </div>
	{if $suported}
	{foreach from=$suported item=api}
            <div class="form_container">
                <form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false" >
                    <input type="hidden" name="action" value="addlist" />
		{if $sublist}<input type="hidden" name="sub" value="{$sublist.id}" />{/if}
                    <input type="hidden" name="import" value="{$api.id}" />
                    <br>
                    <label>List name</label><input type="text" name="listname" value="" />
		{if $forms[$api.id] && is_array($forms[$api.id])}
			{foreach from=$forms[$api.id] item=field}
                    <label>{$field.name}{if $field.descr}<br /><small>{$field.descr}</small>{/if}</label><{$field.type} {if $field.attr}{foreach from=$field.attr item=attr key=atn}{$atn}="{$attr}"{/foreach}{/if}>
			{/foreach}
		{else}
                    <label>Hostname</label><input type="text" name="host" value="" />
                    <label>IP address</label><input type="text" name="ip" value="" />
                    <label>Username</label><input type="text" name="username" value="" />
                    <label>Password</label><input type="password" name="password" value="" />
                    <label>Secure</label><input type="checkbox" name="secure" value="1" />
		{/if}
                    <br />
                    <a href="#" class="testcon" onclick="test(this)">Test Conection</a>
                    <div class="cleat test"></div>
                </form>
            </div>
	{/foreach}
	{/if}
        </td>
    </tr></table>
<div style=" background: #272727; box-shadow: 0 -1px 2px rgba(0, 0, 0, 0.3); color: #FFFFFF; height: 20px; padding: 11px 11px 10px; clear:both">
    <div class="left spinner" style="display: none;">
        <img src="ajax-loading2.gif">
    </div>
    <div class="right">
        <span class="bcontainer ">
            <a class="new_control greenbtn" onclick="$('.spinner').show();submitList($('.form_container form').eq(actv_form));return false;" href="#">
                <span>Add list</span>
            </a>
        </span>
        <span class="bcontainer">
            <a class="submiter menuitm" href="#" onclick="$(document).trigger('close.facebox');return false;">
                <span>Close</span>
            </a>
        </span>
    </div>
    <div class="clear"></div>
</div>
{elseif $mode == 'testcon'}
{if $conection == 1}<span class="Successfull"><strong>Successfull!</strong></span>{else}<span class="error">Error: {$conection}</span>{/if}
{/if}