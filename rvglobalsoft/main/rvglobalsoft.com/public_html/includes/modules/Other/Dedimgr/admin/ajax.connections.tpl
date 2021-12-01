<h3 style="margin-bottom:10px;"><img src="{$moduledir}icons/network-ethernet.png" alt="" style="margin-right:5px" class="left"  /> <span class="left">Network ports:</span> 
    <select style="margin:-5px 10px 0px;" name="conn[NIC][in]" onchange="setports($(this).val(),'NIC','in')">
			<option value="0" {if $ports.NIC.in.count=='0'}selected="selected"{/if}>0</option>
			 {section name=foo loop=48}
			<option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.NIC.in.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                         {/section}
    </select>
</h3><div class="clear"></div>


    <div class="crow">
{foreach from=$ports.NIC.in.ports item=p}
<div class="connector {if $p.title}hastitle{/if}" {if $p.title}title="{$p.title}"{/if} onclick="getportdetails('{$p.id}')">{if $p.connected_to!='0'}<div class="hasconnection"></div>{/if}<div class="nth"><div>{$p.number}</div></div></div>
{/foreach}</div>

<div class="clear"><br/></div>


<h3 style="margin-bottom:10px;"><img src="{$moduledir}icons/plug.png" alt="" style="margin-right:5px" class="left"  /> <span class="left">In-Power sockets:</span>
    <select style="margin:-5px 10px 0px;" name="conn[PDU][IN]"  onchange="setports($(this).val(),'PDU','in')">
           <option value="0" {if $ports.PDU.in.count=='0'}selected="selected"{/if}>0</option>
			 {section name=foo loop=4}
			<option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.PDU.in.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                         {/section}

    </select></h3><div class="clear"></div>

    <div class="crow">
{foreach from=$ports.PDU.in.ports item=p}
<div class="connector {if $p.title}hastitle{/if}" {if $p.title}title="{$p.title}"{/if}  onclick="getportdetails('{$p.id}')">{if $p.connected_to!='0'}<div class="haspower"></div>{/if}<div class="nth"><div>{$p.number}</div></div></div>
{/foreach}</div>
<div class="clear"><br/></div>


<h3 style="margin-bottom:10px;"><img src="{$moduledir}icons/network-ethernet.png" alt="" style="margin-right:5px" class="left"  /> <span class="left">Uplink ports <a class="vtip_description" title="Use for switch only"></a>:</span> 
    <select style="margin:-5px 10px 0px;" name="conn[NIC][OUT]"  onchange="setports($(this).val(),'NIC','out')">
        <option value="0" {if $ports.NIC.out.count=='0'}selected="selected"{/if}>0</option>
			 {section name=foo loop=4}
			<option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.NIC.out.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                         {/section}
    </select></h3><div class="clear"></div>



    <div class="crow">
{foreach from=$ports.NIC.out.ports item=p}
<div class="connector {if $p.title}hastitle{/if}" {if $p.title}title="{$p.title}"{/if} onclick="getportdetails('{$p.id}')">{if $p.connected_to!='0'}<div class="hasconnection"></div>{/if}<div class="nth"><div>{$p.number}</div></div></div>
{/foreach}</div>

<div class="clear"><br/></div>


<h3 style="margin-bottom:10px;"><img src="{$moduledir}icons/plug.png" alt="" style="margin-right:5px" class="left"  /> <span class="left">Out-Power sockets <a class="vtip_description" title="Use for PDU only"></a>:</span>
    <select style="margin:-5px 10px 0px;" name="conn[PDU][OUT]" onchange="setports($(this).val(),'PDU','out')">
        <option value="0" {if $ports.PDU.out.count=='0'}selected="selected"{/if}>0</option>
			 {section name=foo loop=48}
			<option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.PDU.out.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                         {/section}

    </select></h3><div class="clear"></div>


    <div class="crow">
{foreach from=$ports.PDU.out.ports item=p}
<div class="connector {if $p.title}hastitle{/if}" {if $p.title}title="{$p.title}"{/if}  onclick="getportdetails('{$p.id}')">{if $p.connected_to!='0'}<div class="haspower"></div>{/if}<div class="nth"><div>{$p.number}</div></div></div>
{/foreach}</div>

<div class="clear"><br/></div>


<div class="fs11">
<b>Legend:</b><br/>
<img src="{$moduledir}icons/network-status.png" /> <span class="orspace">This port is connected</span> <br/>
<img src="{$moduledir}icons/plug-connect.png" /> <span class="orspace">This power socket is connected</span> <br/>
<img src="{$moduledir}icons/chart.png" /> <span class="orspace">This port have graphs assigned</span></div>


{literal}
<script>

    $(function(){
        $('.vtip_description','#facebox').vTip();
        $('.connector.hastitle','#facebox').vTip();
    });

    function setports(count,type,dir) {
        ajax_update('?cmd=module&module=dedimgr&do=setports',{
            count: count,
            type: type,
            direction: dir,
            item_id: $('#item_id').val()
        },
        '#connection_mgr');
    }

    function refreshports() {
         ajax_update('?cmd=module&module=dedimgr&do=setports',{
            item_id: $('#item_id').val()
        },
        '#connection_mgr');
    }

    function getportdetails(id) {
        $('.spinner').show();
        $('#porteditor').hide().html('');
        $.get('?cmd=module&module=dedimgr&do=getport',{id:id},function(data) {
            $('.spinner').hide();
            $('#porteditor').html(data).show();
        });

    }
</script>
{/literal}