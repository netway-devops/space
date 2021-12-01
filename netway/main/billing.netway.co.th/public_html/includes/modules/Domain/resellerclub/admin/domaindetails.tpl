<div style="margin:10px 0px;">
    <ul class="accor">
        <li>
            <a>Resellerclub Domain Details</a>


            <div id="domreq-details" >
                <a href="#" onclick="return loadRCDeatails('{$domainid}')" class="btn btn-primary">Load details</a>

            </div>
    </ul>
</div>
{literal}
<script>

    function loadRCDeatails(id) {
        ajax_update('?cmd=resellerclub&action=domaindetails&id='+id,{ load: 1},'#domreq-details',true);
        return false;
    }
</script>{/literal}