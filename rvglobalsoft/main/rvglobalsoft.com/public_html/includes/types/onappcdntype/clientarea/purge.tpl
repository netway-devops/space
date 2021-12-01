<div class="header-bar">
    <h3 class="purge hasicon">HTTP Purge</h3>

    <div class="clear"></div>
</div>
<div class="content-bar" style="position:relative">

<div class="notice">
    This tool allows instant removal of HTTP Pull cache content in the CDN, if newly updated content have not been reflected.<br />
    Specify paths on the CDN Resource (not the origin) to purge, one per line

</div>

 <form method="post" action="">
        <input type="hidden" name="make" value="setpurge" />
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
            <tr>
                <td colspan="2"><span class="slabel">Paths to Purge</span>
                    <textarea name="purge"  class="styled" placeholder="/path/file.jpg" style="width:600px;height:125px;"></textarea>
                </td>
            </tr>
        <tr>
            <td align="center" style="border:none" colspan="2">
                <input type="submit" value="Purge" style="font-weight:bold" class=" blue" />
            </td>
        </tr>
        </table>

        {securitytoken}
    </form>

</div>