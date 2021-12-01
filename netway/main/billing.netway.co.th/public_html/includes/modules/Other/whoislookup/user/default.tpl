<div class="padding white-bg" id="">
    <h3>{$lang.whoislookup}</h3>
    <br/><br/>
    <form action="?cmd=whoislookup" method="POST" class="mb-3">
        <div class="form-group">
            <label for="domain">{$lang.domain}</label>
            <input type="text" id="domain" name="domain" class="form-control styled" style="max-width: 300px" value="{$domain}" placeholder="domain.com" id="domain"/>
        </div>
        {if $captcha}
            <div class="form-group">
                <div class="d-flex flex-row align-items-end">
                    <div class="">
                        <label for="captcha">{$lang.captcha}</label>
                        <input id="captcha" name="captcha" type="text" class="form-control styled w-auto" style="max-width: 100px"/>
                    </div>
                    <div style="white-space: nowrap; padding-top: 5px;">
                        <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}"/>
                        <span>
                          <a href="#" onclick="return cptchreload();">{$lang.refresh}</a>
                     </span>
                    </div>
                    {literal}
                        <script>
                            function cptchreload() {
                                var d = new Date();
                                $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
                                return false;
                            }
                        </script>
                    {/literal}
                </div>
            </div>
        {/if}
        <input type="hidden" name="submit" value="1"/>
        {securitytoken}
        <button type="submit" class="btn btn-lg btn-primary mt-3">{$lang.search}</button>
    </form>

    {include file='ajax.default.tpl'}
</div>