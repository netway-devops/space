{if $inline}
    <div id="ipam_assignment">
        <div class="clear">
            <label class="nodescr">Owner</label>
            <select class="w250" name="client_id" id="ipam_client_id" onchange="reloadServices()">
                {if $ip.client_id}
                    <option value="{$ip.client_id}">#{$ip.client_id}</option>
                {/if}
                <option value="0">None</option>
            </select>
        </div>
        <div class="clear">
            <div id="related_service">
                <label class="nodescr">Related service</label>
                <input type="text" size="" value="{$ip.account_id}" class="w250" name="account_id"
                       id="ipam_account_id"/>
                <div class="clear"></div>
            </div>
        </div>
        <div class="loader"></div>
    </div>
    {if $dedimgr}
        <div id="dedimgr_dev" class="clear">
            <label class="nodescr">Related device/port</label>
            <div style="margin: 7px 0 20px 10px;" class="left">
                {if $ip.port}
                    <a href="?cmd=module&module=dedimgr&do=rack&rack_id={$ip.port.rack_id}&expand={$ip.port.id}"
                       target="_blank">{$ip.port.typename} - {$ip.port.label} ({$ip.port.number})</a>
                {else}
                    <em>No device/port assigned in <a href="?cmd=module&module=dedimgr" target="_blank">Dedimgr</a></em>
                {/if}
            </div>
        </div>
    {/if}
    <div class="clear"></div>
{literal}
    <style>
        #ipam_assignment{
            position: relative;
        }
        #ipam_assignment .loader{
            display: none;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #ffffff96 url('templates/default/img/ajax-loading.gif') no-repeat center center;
        }
        #ipam_assignment.ipam-loading .loader{
            display: block;
        }
        .chosen-single .group-name::after{
            content: '- '
        }
    </style>
    <script type="text/javascript">
        var ipam_loading;

        $(function () {
            inichosen();
            ipam_loading = $('#ipam_assignment');
        });

        function inichosen() {
            $('#ipam_client_id', '#facebox').chosensearch({width: "250px"})
        }

        function reloadServices() {
            ipam_loading.addClass('ipam-loading');
            $.post('?cmd=module&module=ipam&action=getclientservices', {
                client_id: $("#ipam_client_id").val(),
                service_id: $('#ipam_account_id').val()
            }).then(function (data) {
                $('#related_service').html(parse_response(data));
                var servicelist = $('#ipam_account_id');
                if(servicelist.length){
                    servicelist.trigger('change').chosenedge({width: '250px'});
                }else{
                    ipam_loading.removeClass('ipam-loading');
                }
            }).fail(function () {
                ipam_loading.removeClass('ipam-loading');
            });
        }

        function reloadServicesForm() {
            ipam_loading.addClass('ipam-loading');
            $.post('?cmd=module&module=ipam&action=getclientserviceform', {
                ipam_id: $("#ipam_id").val(),
                client_id: $("#ipam_client_id").val(),
                service_id: $('#ipam_account_id').val()
            }).then(function (data) {
                var container = $('#related_service_form')
                container.html(parse_response(data));
                container.find('select').chosenedge({
                    width: '250px',
                    include_group_label_in_selected: true
                });
            }).always(function () {
                ipam_loading.removeClass('ipam-loading');
            });;
        }

        reloadServices();
    </script>
{/literal}
{else}
    <table width="100%">
        <tr>
            <td class="fright">
                <h3 style="margin-bottom:0px;">IP assignment details {$ip.ipaddress}</h3>
                <div class="form_container">
                    <form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false">
                        <input type="hidden" name="action" value="editassignment"/>
                        <input type="hidden" name="ip_id" value="{$ip.id}" id="ipam_id"/>
                        <input type="hidden" name="make" value="save"/>
                        <br/>

                        {include file="ajax.editassignment.tpl" inline=true}
                    </form>
                </div>

            </td>
        </tr>
    </table>
    <div class="f-footer">
        <div class="left spinner" style="display: none;">
            <img src="ajax-loading2.gif"/>
        </div>
        <div class="right">
            <span class="bcontainer ">
                <a class="new_control greenbtn" onclick="$('.spinner').show();
                    submitIPRange($('#facebox .form_container form').eq(0));
                    return false;" href="#">
                    <span>Update IP assignment</span>
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
{/if}
