<div class="padding white-bg" id="">
    <h3>{$lang.billingalerts}</h3>
    {$lang.billingalerts_descr}

    <br/><br/>
    <form action="" method="post" >
    <table class="table table-bordered" width="100%">
        <tr>
            <td width="20" style="vertical-align: middle"><input type="radio" name="enable" value="0" style="margin:0px" {if !$settings || $settings.enable=='0'}checked="checked"{/if}/></td>
            <td>{$lang.billingalerts_disabled}</td>
        </tr>
        <tr>
            <td width="20" style="vertical-align: middle"><input type="radio" name="enable" value="1" style="margin:0px"  {if  $settings.enable=='1'}checked="checked"{/if}/></td>
            <td>{$lang.billingalerts_enabled} <input type="text" name="amount" value="{$settings.amount}" size="5" style="width:80px;margin:0px"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" class="btn btn-success" value="{$lang.savechanges}"/> </td>
        </tr>
    </table>
        {securitytoken}
    </form>

</div>