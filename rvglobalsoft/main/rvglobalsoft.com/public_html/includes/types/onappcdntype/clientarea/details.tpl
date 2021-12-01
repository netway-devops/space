<div class="header-bar">
    <h3 class="vmdetails hasicon">CDN Resource details</h3>
</div>
<div class="content-bar" >
   <div class="right" id="lockable-vm-menu"> {include file="`$cdndir`ajax.vmactions.tpl"} </div>
    
    <div class="clear"></div>

    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td width="50%" style="padding-right:10px;">
                <table cellpadding="0" cellspacing="0" width="100%" class="ttable">
                    
                    <tr>
                        <td ><b>{$lang.hostname}</b> </td>
                        <td >{$resource.cdn_hostname}</td>
                    </tr>
                    <tr>
                        <td ><b>Resource type</b></td>
                        <td>{$resource.resource_type}</td>
                    </tr>
                    

                </table>
            </td>
            <td width="50%" style="padding-left:10px;">
                <table  cellpadding="0" cellspacing="0" width="100%" class="ttable">
                    <tr>
                        <td width="120"><b>Origin</b></td>
                        <td>{$resource.origin}</td>
                    </tr>

                    <tr>
                        <td  ><b>CDN Reference</b></td>
                        <td >{$resource.aflexi_resource_id}</td>
                    </tr>
                   
                </table>
            </td>
        </tr>
    </table>

    <h3 class="summarize">DNS Settings</h3>
    <span class="fs11">Add a CNAME for the CDN Hostname which can then be used to view the contents.</span><br/>
    <b style="font-size:14px">{$resource.cdn_hostname} IN CNAME {if $resource.cdn_reference}{$resource.cdn_reference}{else}{$resource.aflexi_resource_id}{/if}.r.{$cdnhostname}</b>

</div>