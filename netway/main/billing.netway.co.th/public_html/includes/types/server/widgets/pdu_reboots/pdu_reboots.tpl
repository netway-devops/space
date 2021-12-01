<div class="wbox">
    <div class="wbox_header">
        {$widget.fullname}
    </div>

    <div class="wbox_content">
        {if $errormsg}
            <div class="alert alert-error">
                {$errormsg}
            </div>
        {else}
            Clicking the reboot link below will issue a reboot command. <br/>
            This request is processed realtime and will reboot this server.<br/><br/>
            {foreach from=$items item=item}
                <table class="table table-condensed table-bordered table-striped" >

                    <tr>
                        <td ><strong>State:</strong></td>
                        <td colspan="2" class="wstate wstateon" item_id="{$item.connected.item_id}" port_id="{$item.connected.port_id}">
                            <span >Loading</span>
                            <form action="" method="post" onsubmit="return confirm('Are you sure?')" class="form-inline pull-right" style="margin:0px">
                                <strong>Power: </strong>
                                <input type="hidden" name="item_id" value="{$item.connected.item_id}" />
                                <input type="hidden" name="port_id" value="{$item.connected.port_id}" />
                                <button type="submit" class="btn btn-success btn-small state_on" name="make" value="on"><i class="icon-white icon-off icon-2x"></i>  On </button>
                                <button type="submit" class="btn btn-inverse btn-small state_off" name="make" value="off"><i class="icon-white icon-off icon-2x"></i>  Off </button>
                                <button type="submit" class="btn btn-danger btn-small " name="make" value="reboot"><i class="icon-repeat icon-white icon-2x"></i> Reboot </button>

                                {securitytoken}
                            </form>
                        </td>

                    </tr>

                    <tr>
                        <td ><strong>Rack:</strong></td>
                        <td style="width: 40%;"> {$item.rack_name}</td>
                        <td style="width: 40%;">
                            {if $item.connected_port_number}
                                {$item.connected_rack_name}
                            {else}
                                -
                            {/if}
                        </td>

                    </tr>

                    <tr>
                        <td><strong>PDU:</strong></td>
                        <td> {$item.item_name} {if $item.item_label}({$item.item_label}){/if}</td>
                        <td>
                            {if $item.connected_port_number}
                                {$item.connected_item_name} {if $item.connected_item_label}({$item.connected_item_label}){/if}
                            {else}
                                -
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Port:</strong></td>
                        <td> {if $item.port_name}{$item.port_name}{elseif $item.port_id}{$item.port_id}{else}{$item.number}{/if}</td>
                        <td>
                            {if $item.connected_port_number}
                                {if $item.connected_port_name}{$item.connected_port_name}
                                {elseif $item.connected_port_id}{$item.connected_port_id}
                                {else}{$item.connected_port_number}
                                {/if}
                            {else}
                                -
                            {/if}
                        </td>
                    </tr>

                    <tr>
                        <td colspan="3"  class="port_extras"  item_id="{$item.connected.item_id}" port_id="{$item.connected.port_id}">

                        </td>
                    </tr>
                </table>
            {/foreach}
            {if count($items) > 1}
                <form action="" method="post" onsubmit="return confirm('Are you sure?')" class="form-inline">
                    <input type="hidden" name="make" value="rebootall"/>
                    <div style="text-align: right">
                        <button type="submit" class="btn btn-danger btn-large"><i class="icon-repeat icon-white icon-2x"></i> Reboot All</button>
                    </div>
                    {securitytoken}
                </form>
            {/if}
        {/if}
        </form>
    </div>
</div>
{literal}
    <style>
        .wstate {
            font-weight:bold;
        }
        .wstateon {
            background-color:#D9FBD1 !important;
            color:#6D9663;
        }
        .wstateoff, .wstateunknown {
            background-color:#D8D8D8 !important;
            color:#172314;

        }
    </style>
    <script>
        $(document).ready(function(){
            $('.port_extras').each(function(){
                var el=$(this);
                ajax_update(window.location.href,{
                    make:"getextras",
                    item_id:el.attr('item_id'),
                    port_id:el.attr('port_id')
                },el);
            });
            $('.wstate').each(function(){
                var el=$(this);
                $.post(window.location.href,{
                    make:"getstate",
                    item_id:el.attr('item_id'),
                    port_id:el.attr('port_id')
                },function(data){
                    if(data.state) {
                        el.find('span').text(data.state.toUpperCase());
                        el.removeClass('wstateon').addClass('wstate'+data.state);
                        el.find('.state_'+data.state).attr('disabled',true);
                    }
                });
            });
        });
    </script>
{/literal}