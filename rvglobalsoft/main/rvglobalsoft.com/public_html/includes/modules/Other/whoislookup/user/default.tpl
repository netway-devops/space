<div class="padding white-bg" id="">
    <h3>{$lang.whoislookup}</h3>

    <br/><br/>
    <form action="?cmd=whoislookup" method="post" >
        <table class="table " width="100%" style="background:none;">
            <tr>
                <td width="{if !$captcha}90%{else}70%{/if}" style="vertical-align: top">

                    <label for="domain" class="styled">{$lang.domain}</label>
                    <input type="text" name="domain" class="form-control styled" style="width: 100%" value="{$domain}" placeholder="www.domain.com" id="domain" />
                </td>
                <td  style="vertical-align: top">

                {if $captcha}
                    <label for="captcha" class="styled">{$lang.captcha}</label>
                    <input name="captcha" type="text" class="styled"  style="width:98%"/>
                    <div style="white-space: nowrap; padding-top: 5px;">

                        <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" />
                        <span>

                                      <a href="#" onclick="return cptchreload();" >{$lang.refresh}</a>
                                 </span>
                    </div>

                        {literal}
                            <script>

                                function cptchreload(){
                                    var d = new Date();
                                    $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
                                    return false;
                                }
                            </script>

                        {/literal}


                {/if}
                </td>
                <td  style="vertical-align: top">

                    <label for="domain" class="styled">&nbsp;</label>
                    <input type="submit" class="btn btn-success" value="{$lang.search}" style="display: block"/>

                </td>
            </tr>


            <tr><td colspan="3">
                    <div id="results" style="min-height: 40px;">

                        {include file='ajax.default.tpl'}

                    </div>
                </td></tr>
        </table>
        <input type="hidden" name="submit" value="1" />
        {securitytoken}

    </form>




</div>

