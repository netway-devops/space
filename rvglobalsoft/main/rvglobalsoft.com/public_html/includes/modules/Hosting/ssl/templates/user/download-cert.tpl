<div id="downloadCertBox">
    <div align="left">
        <br>
        <p class="title">Download Certificates</p>
        <p class="linebottom"></p>
        <br /><br />
        You can download certificates to install on your server as the server uploader options below.
        <br /><br />
        <div style="padding-left:20px;">
            <ul>
                {$downloadText}
            </ul>
        </div>
    </div>
    <br />
    Note: These certificate files were also sent to Approval Email and Owner Email. You can either download here or from your Email.
    <br /><br />
    {if false}
    <div align="center">
        <input type="button" class="btn green-custom-btn l-btn" onclick="location.href='{$new_system_url}/clientarea/services/ssl/{$service.id}'" value="Back" />
    </div>
    {/if}
</div>