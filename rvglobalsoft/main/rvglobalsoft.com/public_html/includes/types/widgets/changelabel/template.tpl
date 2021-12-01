<section class="section-changelabel">
    <div class="wbox">
        <div class="wbox_header">{$lang.changelabel_widget}</div>
        <div class="wbox_content">
            <form action="" method="post">
                <p>{$lang.changelabel_guide}</p>
                <div class="form-group">
                    <label for="">{$lang.label}</label>
                    <input name="newlabel" class="form-control inp" value="{$currentlabel}"/>
                </div>
                <div class="d-flex flex-row align-items-center justify-content-start">
                    <input type="hidden" name="make" value="submit"/>
                    <input type="submit" class="btn btn-primary my-2 my-md-0 btn-w-100 btn-md-w-auto" value="{$lang.changelabel_widget}"/>
                </div>
                {securitytoken}
            </form>
        </div>
    </div>
</section>

