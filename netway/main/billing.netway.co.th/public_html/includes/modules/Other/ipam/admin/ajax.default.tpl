<div class="ipam-left" >
    <form action="" method="post" id="ipamleftform">
        <div id="ipamsearch" class="ipam-search">
            <input type="text" value="{$searchterm}" name="stemp" autocomplete="off" /><button onclick="$(this).prev().val('').keypress(); return false"><img src="{$plugin_dir}/img/bimg.png" alt="clear" title="Clear" /></button>
        </div>
        <div id="ipamsearch_filters" class="ipam-filters">
            <label>List name</label>	<input value="1" type="checkbox" name="name">
            <label>IP Address</label>	<input value="1" type="checkbox" name="ipaddress" checked="checked"><br>
            <label>Hostname</label>		<input value="1" type="checkbox" name="domains"><br>
            <label>Rev DNS</label>		<input value="1" type="checkbox" name="revdns"><br>
            <label>Description</label>	<input value="1" type="checkbox" name="descripton"><br>
            <label>Client ID</label>	<input value="1" type="checkbox" name="client_id"><br>
            <label>Last Update</label>	<input value="1" type="checkbox" name="lastupdate"><br>
            <label>Changed by</label>	<input value="1" type="checkbox" name="changedby"><br>
            <label>With flag</label>	<input value="1" type="checkbox" name="flag">
        </div>
        <div style="padding:10px 5px"><a onclick="addlist('server');return false;" id="ip_add" href="#" class="menuitm"><span class="addsth">Add new list</span></a></div>
        <ul class="tree" id="treecont">
		{include file='ajax.servertree.tpl'}
        </ul>
    </form>
</div><!-- !LEFT -->
<div id="ipamright" class="ipam-right">
    {if $action=='details'}
        {include file='ajax.details.tpl'}
    {else}
        {include file='dashboard.tpl'}
    {/if}
    
</div>
<div class="clear"></div>


{if $searchterm}
{literal}<script>
    $(document).ready(function(){
        $('#ipamsearch input').eq(0).trigger('keypress');
    });</script>{/literal}
{/if}