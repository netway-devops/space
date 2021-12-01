

            {if $ach.account}
            <h2>{$lang.ach_information}</h2>
        <table width="100%" border="0"  cellspacing="0" class="checker">

            <tr><td align="right" width="160"><b>{$lang.type}</b></td><td>{$lang[$ach.type]}</td></tr>
            <tr class="even"><td align="right"><b>{$lang.ach_account_number}</b></td><td>{$ach.account}</td></tr>
            <tr><td align="right"><b>{$lang.ach_routing_number}</b></td><td>{$ach.routing}</td></tr>
            
        </table>

            <form action="" method="post" style="margin-bottom:0px;">
            {if $allow_storage}<a href="#newccdetails" data-toggle="modal" class="btn btn-info" onclick="$(this).attr('disabled','disabled'); $('#newccdetails').show(); return false;" >{$lang.changeach}</a>&nbsp; {/if}
            {if $allowremove} <input type="submit" name="removeach" value="{$lang.removeach}" onclick="return confirm('{$lang.removeach_confirm}')"  class="btn btn-danger"/> {/if}
        {securitytoken}</form>



            {else}
            <br/><br/>
            <center>{$lang.noachyet}
            <br/><br/>
                <div class="box-feature">
                    <a href="#newccdetails" data-toggle="modal" onclick="$(this).attr('disabled','disabled'); $('#newccdetails').show(); return false;"  >{$lang.newach}</a>

                </div>
            </center>
            {/if}

        <div id="newccdetails" style="display:none" >
            <form action="" method="post" style="margin-bottom:0px;">
                <input type="hidden" name="addach" value="1" />
                    <div class="modal-header">
                        <h3>{$lang.changeachdesc}</h3>
                    </div>
                    <div class="modal-body">
                        <table width="100%" cellpadding="2">
                        <tr><td width="150" >{$lang.type}</td><td>
                                <select name="type">
                                    <option value="checkings">{$lang.checking}</option>
                                    <option value="savings">{$lang.savings}</option>
                                    <option value="business_checking">{$lang.business_checking}</option>
                                </select>
                            </td></tr>
                        <tr><td >{$lang.ach_account_number}</td><td><input type="text" name="account" size="25" /></td></tr>
                        <tr><td >{$lang.ach_routing_number}</td>
                            <td><input type="text" name="routing" size="25" /></td></tr>
                    </table>
                    </div>
                    <div class="modal-footer">
                        <input type="submit" name="addcard" value="{$lang.savechanges}"  class="btn btn-info"/>
                    </div>

                {securitytoken}
            </form>
            
        </div>
