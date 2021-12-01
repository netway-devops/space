{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/_common/estimate_address_notification.tpl.php');
{/php}

{if $estimate.client_id}

<!-- Notification address -->
<div style="display: block;">
    
    <div class="ticketmsg ticketmain" style="width: 350px; display: block; float: left;">
        <div><b>Billing Address:</b></div>
        <div style="background-color: #FFFFFF; padding: 5px;">
            {$billingAddress|nl2br}
            <br />
            <div align="right"><a href="?cmd=addresshandle&action=listInvoice&type=billing&estimateId={$estimate.id}" class="manageContactAddress">แก้ไข</a></div>
        </div>
    </div>
    
    <div style="clear: both;"> </div>
</div>

<script type="text/javascript">
{literal}
$(document).ready(function () {
    $('.manageContactAddress').click(function () {
        var fbUrl   = $(this).prop('href');
        $.facebox({ ajax: fbUrl,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
        return false;
    });
});
{/literal}
</script>
{/if}