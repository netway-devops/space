<section class="section-signup">
    <div class="d-flex align-items-center flex-column form-credentials form-signup">
        <h1 class="my-4">{$lang.createaccount}</h1>
        <form method="post" action="" id="singupform" name="signupform" enctype="multipart/form-data" data-parsley-validate data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], [disabled], :hidden">
            {include file="`$template_path`ajax.signup.tpl"}
            <div class="d-flex justify-content-center">
                <button type="submit" class="btn btn-primary btn-lg my-4 w-25" >{$lang.submit}</button>
            </div>
            {securitytoken}
        </form>
    </div>
</section>
