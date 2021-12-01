<div class="row flex-container ">
    <div class="span2  flex-box-1 box-feature-small">
        {include file='clientarea/leftnavigation.tpl'}
    </div>
    <div class="span12  flex-box-1 bordered-section article iep">
        <h2>{$lang.Settings}</h2>
        <div class="brcrm">{$lang.Settings_p}</div>
        <div class="p19">
            <form class="form-horizontal" method="post">
                {include file="../common/tpl/settings.tpl"}
                <center><button type="submit" class="btn btn-primary btn-large" name="submit">{$lang.savechanges}</button></center>
                {securitytoken}
            </form>
        </div>

    </div>
</div>