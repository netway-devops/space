
{if !$mode}{literal}
        <script type="text/javascript">
            var actv_form = 0;
            $(function () {
                $('.form_container').hide().eq(0).show();
                $('.content .fleft > div').eq(0).addClass('actv');
                $('.content .fleft > div').each(function (x) {
                    $(this).click(function () {
                        actv_form = x;
                        $('.form_container').hide().eq(x).show();
                        $('.content .fleft > div').removeClass('actv').eq(x).addClass('actv');
                    });
                });
                $("a.vtip_description").vTip();
            });
            function submitList(form) {
                ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&mode=addlist", form.serializeObject(), function (data) {
                    refreshTree();
                    $(document).trigger('close.facebox');
                });
            }
        </script>
    {/literal}
    <table width="100%">
        <tr>
            <td class="fleft">
                <div>Add new VLAN Group</div>
            </td>
            <td class="fright">
                <h3 style="margin-bottom:0px;">
                    VLAN Group settings
                </h3>
                <div class="form_container">
                    <form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false">
                        <input type="hidden" name="action" value="vlan_addlist" />
                        <br/>

                        <label>Group name</label>
                        <input type="text" name="listname" value="" />
                        <div class="clear"></div>

                        <label>Range <a href="" class="vtip_description" title="Please provide VLANs range in xxxx-xxxx format"></a></label>
                        <input type="number" name="range_from" placeholder="eg. 1000" style="width: 106px"/>
                        <b style="float: left; padding-left: 9px; line-height: 28px; ">-</b>
                        <input type="number" name="range_to" placeholder="eg. 1100" class="span1" style="width: 106px"/>
                        <div class="clear"></div>

                        <label>Auto-Provision <a class="vtip_description" title="Enable this option if you want HostBill to use vlans from this group for automated IP Provisioning"></a></label>
                        <input type="checkbox" name="autoprovision" value="1" />
                        <div class="clear"></div>

                        <label>Is Private? <a class="vtip_description" title="This is just for information purposes and automated IP provisioning"></a></label>
                        <input type="checkbox" name="private" value="1" />
                        <div class="clear"></div>



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
            </td>
        </tr>
    </table>
    <div class="f-footer">
        <div class="left spinner" style="display: none;">
            <img src="ajax-loading2.gif">
        </div>
        <div class="right">
            <span class="bcontainer ">
                <a class="new_control greenbtn" onclick="$('.spinner').show();
                        submitList($('.form_container form').eq(actv_form));
                        return false;" href="#">
                    <span>Add list</span>
                </a>
            </span>
            <span class="bcontainer">
                <a class="submiter menuitm" href="#" onclick="$(document).trigger('close.facebox');
                        return false;">
                    <span>Close</span>
                </a>
            </span>
        </div>
        <div class="clear"></div>
    </div>
{elseif $mode == 'testcon'}
    {if $conection == 1}<span class="Successfull"><strong>Successfull!</strong></span>{else}<span class="error">Error: {$conection}</span>{/if}
{/if}