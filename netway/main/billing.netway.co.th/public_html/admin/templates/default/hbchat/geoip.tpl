<div  class="nicerblu">
    {if $ChatGeoIPEnabled!='on'} <div class="imp_msg">Note: GeoIP tracking is not enabled in your HostBill yet! Follow instructions below to update your database</div>{/if}

    <div class="p6" style="padding:15px;margin-top:10px;">
        <form method="post" action="">
            <div class="row form-inline">
                <div class="form-group col-sm-12">
                    <label style="margin: 5px">Database Path <a></a></label>
                    <input style="margin: 5px; min-width: 500px" type="text" value="{$db_path}" class="form-control" name="db_path">
                    <button style="margin: 5px" type="submit" class="btn btn-sm btn-primary">Save Path</button>
                    <div class="btn-group" style="margin: 5px">
                        <button type="button" class="btn btn-sm btn-default">Database Status</button>
                        <button  type="button" class="btn btn-sm btn-{$db_status.status}">{$db_status.msg}</button>
                    </div>

                    <input type="hidden" value="1" name="submit">
                    {securitytoken}
                </div>
            </div>
        </form>
</div>
    <br/><br/><strong >HowTo: Install/Update GeoIP database <a href="#" onclick="$('#geoshow').show();return false" >show</a></strong>
    <div id="geoshow" style="display:none;padding:5px;">
        1. Download latest MaxMind DB zip file from <a href="https://dev.maxmind.com/geoip/geoip2/geolite2/" target="_blank">https://dev.maxmind.com/geoip/geoip2/geolite2/</a> <br/>
        2. Upload to the server and extract the contents of the archive to the directory specified in the path eg includes/libs/geoip. It will create directory, i.e.: includes/libs/geoip/GeoLite2-City_20190122 <br />
</div>
{literal}
<style type="text/css">
    #testcontainer {
    background: none repeat scroll 0 0 #303030;
    color: #FFFFFF;
    height: 220px;
    overflow: auto;
}
.lxa {
    margin-right: 10px;
}
#facebox .lxa {
    display: none;
    height: 0;
}
#testcontainer #testcontent {
    padding: 5px;
}

</style>
{/literal}