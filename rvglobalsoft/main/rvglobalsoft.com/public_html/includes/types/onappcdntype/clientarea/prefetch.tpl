<div class="header-bar">
    <h3 class="prefetch hasicon">HTTP Prefetch</h3>

    <div class="clear"></div>
</div>
<div class="content-bar" style="position:relative">

    <div class="notice">This tool allows HTTP Pull content to be pre-populated to the CDN. Recommended only if files especially large.<br>
        Specify paths on the CDN Resource (not the origin) to prefecth, one per line.</div>

    <form method="post" action="">
        <input type="hidden" name="make" value="setprefetch" />
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
            <tr>
                <td colspan="2"><span class="slabel">Paths to Prefetch</span>
                    <textarea name="prefetch"  class="styled" placeholder="/path/file.jpg" style="width:600px;height:125px;"></textarea>
                </td>
            </tr>
        <tr>
            <td align="center" style="border:none" colspan="2">
                <input type="submit" value="Prefetch" style="font-weight:bold" class=" blue" />
            </td>
        </tr>
        </table>

        {securitytoken}
    </form>

</div>