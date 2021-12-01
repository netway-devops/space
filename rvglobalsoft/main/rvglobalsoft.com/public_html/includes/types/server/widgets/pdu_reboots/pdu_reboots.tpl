
<div class="wbox">
        <div class="wbox_header">
            Reboot Confirmation
        </div>

        <div class="wbox_content">
            <form action="" method="post" onsubmit="return confirm('Are you sure?')">
                <input type="hidden" name="make" value="reboot"/>


Clicking the reboot link below will issue a reboot command. <br/>
This request is processed realtime and will reboot this server.<br/><br/>
<button type="submit" class="btn btn-danger"><i class="icon-repeat icon-white"></i> Reboot server</button>
            {securitytoken}</form></div>
    </div>