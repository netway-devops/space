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
            {if $all}
                <li>
                    <a href="{$ca_url}{$download_url}&type=all">All</a> : To download all certificate files at once and upload in your server by each.<br /><br />
                </li>
            {/if}
            {if $certificate}
                <li>
                    <a href="{$ca_url}{$download_url}&type=crt">CRT File</a> : To download a specific file with .CRT extension.<br /><br />
                </li>
            {/if}
            {if $ca}
                <li>
                    <a href="{$ca_url}{$download_url}&type=ca">CA File</a> : To download a specific file with .CA extension.<br /><br />
                </li>
            {/if}
            {if $pkcs7}
                <li>
                    <a href="{$ca_url}{$download_url}&type=pkcs7">PKCS7 File</a> : To download a specific file with .PKCS7 extension.<br /><br />
                </li>
            {/if}
            </ul>
        </div>
    </div>
    <br />
    Note: These certificate files were also sent to Approval Email and Owner Email. You can either download here or from your Email.
    <br /><br />
</div>