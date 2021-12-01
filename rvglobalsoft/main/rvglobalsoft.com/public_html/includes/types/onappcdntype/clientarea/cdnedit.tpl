<div class="header-bar">
    <h3 class="reinstall hasicon">{$lang.edit} CDN Resource</h3>

    <div class="clear"></div>
</div>
<div class="content-bar  nopadding" style="position:relative">


    <form method="post" action="">
    <input type="hidden" name="make" value="editresource" />
    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
        <tr>
            <td colspan="2"><span class="slabel">CDN Hostname <a class="vtip_description" title="Domain name only. Provide hostname you will use to fetch data from Content Delivery Network"></a></span>
            <input type="text" size="30" required="required" name="editcdn[hostname]"  class="styled" value="{$resource.cdn_hostname}"/>
            </td>
        </tr>

        <tr>
            <td colspan="2"><span class="slabel">Origin <a class="vtip_description" title=" We automatically will fetch data from this domain and distribute over Content Delivery Network"></a></span>
            <input type="text" size="30" required="required" name="editcdn[origin]"  class="styled" value="{$resource.origin}"/>
            </td>
        </tr>

        <tr>
            <td ><span class="slabel">Edge groups <a class="vtip_description" title="Select server groups you wish to distribute data over. <br>Note: More locations will generate more traffic"></a></span>
            <select name="editcdn[edge_groups][]" multiple="multiple" style="min-width:250px;min-height:100px;font-size:12px;" onchange="updateLocations()" id="groups_values">
                    {foreach from=$edge_groups item=zone}
                        <option value="{$zone.id}" >{$zone.label}</option>
                    {/foreach}
                </select>
            </td>
            <td width="400" valign="top">
                <div id="locations" style="display:none">
                    <b>Locations:</b> {foreach from=$widgets item=w}{if $w.widget=='onappcdngooglemaps'}<a href="#" onclick="loadGMaps();return false;">Show on map</a>{/if}{/foreach}
                    <div class="clear"></div>
                     {foreach from=$edge_groups item=zone}
                         {foreach from=$zone.locations item=location}
                            <div class="location g_{$zone.id}" id="g_{$zone.id}_{$location.id}" style="display:none;" longitude="{$location.longitude}" latitude="{$location.latitude}">{$location.city}, {$location.country}</div>
                          {/foreach}
                    {/foreach}
                </div>
                {literal}
                <script type="text/javascript">
                        function updateLocations() {
                            $('#locations').show();
                            var w = $('#groups_values').val();
                            $('#locations .location').hide();
                            for(var i in w) {
                                $('.g_'+w[i],'#locations').show();
                            }
                            if(typeof(updateMap)!='undefined') {
                                updateMap();
                            }
                        }
                </script>
                {/literal}

            </td>
        </tr>
          <tr>
            <td align="center" style="border:none" colspan="2">
                <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class=" blue" />
            </td>
        </tr>
    </table>

    <div id="widget-bar" style="display: none;">

    </div>
        {foreach from=$widgets item=w}
        {if $w.widget=='onappcdngooglemaps'}{literal}
        <script type="text/javascript">
            function loadGMaps() {
                $('#widget-bar').show();
                if(!$('#map_canvas').length)
                    ajax_update('?cmd=clientarea&action=services&cdndo=other&service={/literal}{$service.id}&wid={$w.id}{literal}',{widget:'onappcdngooglemaps'},'#widget-bar');
            }
        </script>
       {/literal} {break}{/if}
        {/foreach}
        {securitytoken}
</form>

   

</div>