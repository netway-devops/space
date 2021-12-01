<tr><td id="getvaluesloader">{if $test_connection_result}
        <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
            {$lang.test_configuration}:
            {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}{else}{$test_connection_result.result}{/if}
            {if $test_connection_result.error}: {$test_connection_result.error}{/if}
        </span>
        {/if}</td>
    <td id="onappconfig_"><div id="">
            <ul class="breadcrumb-nav" style="margin-top:10px;">
                <li><a href="#" class="active disabled" onclick="load_onapp_section('provisioning')">Preconfigure</a></li>
                <li><a href="#" class="disabled" onclick="load_onapp_section('resources')">User & Group</a></li>
            </ul>
            <div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
                <div class="onapptab" id="provisioning_tab">
                    <div id="preconfigure_off">
                        You need to collect username & password from user - please add Form elements with variable names: rd_username & rd_password
                         <div style="padding:15px" >
                                    <a onclick="return preconfigure();"  class="new_control" href="#"><span class="gear_small">Auto-add required form fields</span></a>
                                </div>
                    </div>
                    <div id="preconfigure_on" style="display:none;">Your package is now preconfigured with user & password Form fields, you can continue with User & Group settings. <br/>
                    Please check under Components->Forms whether related fields are added correctly  <br /> <br/>

                    {literal}
                    <em>In automated emails sent to client after creation use <b>{$service.forms.rd_username.value}</b> to show username and <b>{$service.forms.rd_password.value}</b> to show password.</em>
                    {/literal}
                    </div>

                  

                </div>
                <div class="onapptab form" id="resources_tab">
                    <table border="0" cellspacing="0" cellpadding="6" width="100%" >
                        <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from FreeRadius, please wait...</td></tr>

                      
                       
                        <tr>
                            <td width="160"><label >User Group<a class="vtip_description" title="HostBill will create new user and assign him to this group"></a></label></td>
                            <td id="option1container" class="tofetch"><input type="text" size="3" name="options[option1]" value="{$default.option1}" id="option1"/>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label >Password type <a class="vtip_description" title="Select storage type for user password"></a></label></td>
                            <td  ><select name="options[option0]"  >
                                    <option value="MD5-Password" {if $default.option0=='MD5-Password'}selected="selected"{/if}>MD5-Password</option>
                                    <option value="SHA-Password" {if $default.option0=='SHA-Password'}selected="selected"{/if}>SHA-Password</option>
                                    <option value="NT-Password" {if $default.option0=='NT-Password'}selected="selected"{/if}>NT-Password</option>
                                    <option value="User-Password" {if $default.option0=='User-Password'}selected="selected"{/if}>Clear Text password</option>

                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><label >User Attributes<a class="vtip_description" title="Attributes will be assigned to user after creation"></a></label></td>
                            <td>
                                <table border="0" cellspacing="0" cellpadding="3" id="trtable">
                                    <tr>
                                        <td width="120">Attribute:</td>
                                        <td width="70">OP:</td>
                                        <td width="120">Value:</td>
                                        <td width="14"></td>
                                    </tr>
                                     {foreach from=$default.option2 item=attribute key=k}
                                    <tr id="tr{$k}">
                                        <td ><input type="text" name="options[option2][{$k}][attribute]" value="{$attribute.attribute}" /></td>
                                        <td ><select name="options[option2][{$k}][op]">
                                                {foreach from=$ops item=op}
                                                <option value="{$op}" {if $op==$attribute.op}selected="selected"{/if}>{$op|htmlspecialchars}</option>
                                                {/foreach}
                                            </select></td>
                                        <td ><input type="text" name="options[option2][{$k}][value]" value="{$attribute.value}" /></td>
                                        <td><a onclick="tr_remove_row(this); return false" class="rembtn" href="#">Remove</a></td>
                                    </tr>
                                    {/foreach}
                                     <tr id="tr{if $default.option2}{$k+1}{else}0{/if}">
                                        <td ><input type="text" name="options[option2][{if $default.option2}{$k+1}{else}0{/if}][attribute]" value="" /></td>
                                        <td ><select name="options[option2][{if $default.option2}{$k+1}{else}0{/if}][op]">
                                                {foreach from=$ops item=op}
                                                <option value="{$op}">{$op|htmlspecialchars}</option>
                                                {/foreach}
                                            </select></td>
                                        <td ><input type="text" name="options[option2][{if $default.option2}{$k+1}{else}0{/if}][value]" value="" /></td>
                                        <td><a onclick="tr_remove_row(this); return false" class="rembtn" href="#">Remove</a></td>
                                    </tr>
                                </table>
                                <a href="#" class="editbtn" onclick="tr_add_row(); return false;">Add new attribute</a>
                            </td>
                        </tr>

                    </table>
                 
                </div>

            </div>
            {literal}
          

            <script type="text/javascript">
                function tr_remove_row(el) {
                    if ($('#trtable tr').length>2) {
                        $(el).parents('tr').eq(0).remove();
                    } else {
                       $(el).parents('tr').eq(0).find('input').val('');
                    }

                }
                function tr_add_row() {
                    var t = $('#trtable tr:last');
                    if(!t.attr('id')) {
                        return false;
                    }
                    var prev = t.attr('id').replace(/[^0-9]/g,'');
                    next = parseInt(prev)+1;
                    var nw = t.clone();
                    nw.attr('id','tr'+next);
                    nw.find('input, select').each(function(){
                        var n =$(this).attr('name');
                        n=n.replace("["+prev+"]","["+next+"]");
                        $(this).attr('name',n).val('');
                    });
                    
                    $('#trtable').append(nw);
                    return false;
                }
                function preconfigure() {
                    $('#preconfigure_off').hide();
                    $('#preconfigure_on').show();
                    $.post('?cmd=freeradius&action=preconfigure',
                        {
                            id:$('#product_id').val(),
                            cat_id:$('#category_id').val(),
                            server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                        },function(data){
                            var r=parse_response(data);
                                 ajax_update('?cmd=configfields',{product_id:$('#product_id').val(),action:'loadproduct'},'#configeditor_content');
                        });
                    return false;
                }
               function load_onapp_section(section)  {
                    if(!$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()) {
                        alert('Please configure & select server first');
                        return;
                    }


                    var tab = $('#'+section+'_tab');
                    if(!tab.length)
                        return false;
                    var elements = tab.find('.tofetch').not('.fetched').not('.disabled');
                    if(!elements.length)
                        return false;
                    tab.find('.onapp-preloader').show();
                    elements.each(function(e){
                        var el = $(this);
                        var inp=el.find('input[id], select[id]').eq(0);
                        if(inp.is(':disabled')) {
                            if((e+1)==elements.length) {
                                tab.find('.onapp-preloader').slideUp();
                            }
                            return 1; //continue;

                        }
                        var vlx=inp.val();
                        var vl=inp.attr('id')+"="+vlx;
                        if(vlx!=null && vlx.constructor==Array) {
                            vl = inp.serialize();
                        }
                        $.post('?cmd=services&action=product&'+vl,
                        {
                            make:'loadoptions',
                            id:$('#product_id').val(),
                            cat_id:$('#category_id').val(),
                            opt:inp.attr('id'),
                            server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                        },function(data){
                            var r=parse_response(data);
                            if(typeof(r)=='string') {
                                $(el).addClass('fetched');
                                el.html(r);
                            }

                        });

                    });
                    return false;
                }
             function append_onapp() {
                     if($('#product_id').val()=='new') {
                        $('#onappconfig_ ').html('<b>Please save your product first</b>');

                        return;
                     }
                     if($('#configvar_rd_username').length && $('#configvar_rd_password').length) {
                    $('#preconfigure_off').hide();
                    $('#preconfigure_on').show();

                     }
                    $('#onappconfig_').TabbedMenu({elem:'.onapptab',picker:'.breadcrumb-nav a',aclass:'active',picker_id:'nan1'});
                    
                    $(document).ajaxStop(function() {
                        $('.onapp-preloader').hide();
                    });

                    if($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
                        $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
                }
                {/literal}{if $_isajax}setTimeout('append_onapp()',50);{else}appendLoader('append_onapp');{/if}{literal}
            </script>

            {/literal}

        </div>

        <link href="{$module_templates}productconfig.css?v={$hb_version}" rel="stylesheet" media="all" />
    </td>
</tr>