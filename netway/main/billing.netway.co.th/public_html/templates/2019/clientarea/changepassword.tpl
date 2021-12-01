<section class="section-account-header">
    <h1>{$lang.accountdetails}</h1>
</section>

{include file="clientarea/top_nav.tpl" nav_type="details"}

<section class="section-account">
    <form class="form-horizontal" action='' method='post'>
        <input type="hidden" name="make" value="changepassword" />
        <div class="table-responsive table-borders table-radius">
            <table class="table stackable">
                <tbody>
                    <tr>
                        <td class="w-25">{$lang.oldpass}</td>
                        <td><input class="form-control pb-2" type="password" autocomplete="off" name="oldpassword" required="required"></td>
                    </tr>
                    <tr>
                        <td class="w-25">{$lang.newpassword}</td>
                        <td><input class="form-control pb-2" type="password" autocomplete="off" name="password" required="required"></td>
                    </tr>
                    <tr>
                        <td class="w-25">{$lang.confirmpassword}</td>
                        <td><input class="form-control pb-2" type="password" autocomplete="off" name="password2" required="required"></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="d-flex flex-row justify-content-center align-items-center">
            <button type="submit" class="btn btn-primary btn-lg btn-long my-4">{$lang.savechanges}</button>
        </div>
        {securitytoken}
    </form>
</section>