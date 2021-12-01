<div id="loginbox_container">
    <div class="wbox">
        <div class="wbox_header">{$lang.login}</div>
        <div  class="wbox_content">
            <div class="alert alert-info">{$lang.securitycode_info}</div>

            <form name="" action="" method="post">
                <input type="hidden" name="make" value="submit"/>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" colspan="2" style="padding-bottom:10px;"><label for="securitycode" class="styled">{$lang.securitycode}</label>
                            <input name="securitycode" value="" class="styled"  type="text" style="width:98%"/>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <div class="form-actions">

                                <div class="right">
                                    <button type="submit" value="" class="btn btn-info btn-large" style="font-weight:bold"><i class="icon-ok icon-white"></i> {$lang.login}</button>
                                </div>
                                <div class="clear"></div>
                            </div>

                        </td>
                    </tr>



                </table>{securitytoken}</form>
        </div>
    </div>
</div>