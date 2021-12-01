{include file='dedicated/cart_header.tpl'}


<div class="content">
    <div id="left">

        {if $logged!="1"}
            <p class="ps">
                <span>{$lang.existingcustomer}</span>
                <a href="?cmd=login" onclick="$('#regme').slideUp();
                                        $('#logmein').slideDown();
                                        return false;">{$lang.loginonaccount}</a>
            </p>
            <div>

                <div class="reg" id="logmein" {if $action=='login'}{else}style="display:none"{/if}>
                    <form method="post" action="" id="loginform1"><input type="hidden" name="action" value="login"/>
                        <h1 class="check2">
                            <span class="s33"></span>
                            <span class="s2">{$lang.returningcustomerq} {$lang.login}</span>
                        </h1>
                        {include file="ajax.login.tpl"}
                        <div class="clear"></div>
                    </form>
                </div>
            </div>

            <form method="post" action="" id="checkoutform" class="form-horizontal">
                <input type="hidden" name="make" value="step4" />
                <p class="ps">
                    <span>{$lang.newcustomerq}</span>
                    <a href="?cmd=signup" onclick="$('#logmein').slideUp();
                                        $('#regme').slideDown();
                                        return false;">{$lang.createaccount}</a>
                </p>
                <div class="reg" id="regme" {if $action=='login'}style="display:none"{else}{/if}>
                    <h1 class="check2">
                        <span class="s1"></span>
                        <span class="s2">{$lang.contactinformation}</span>
                    </h1>

                     {include file="ajax.signup.tpl"}

                </div>
            {else}
                <form method="post" action="" id="checkoutform">
                    <input type="hidden" name="make" value="step4" />

                    <h1 class="check2">
                        <span class="s33"></span>
                        <span class="s2">{$lang.customerinfo}</span>
                    </h1>

                    {include file="drawclientinfo.tpl"}



                {/if}

                <div
        {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
        <h1 class="check"><span class="s1"></span><span class="s2">{$lang.choose_payment}</span></h1>
                {if $gateways}
            <center>{foreach from=$gateways item=module key=mid name=payloop}
                <input type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module}
                {/foreach} </center>  {/if}

                </div>

                <div class="reg">
                    {if $tos}
                        <div id="tos" style="display:none">
                            <h1>
                                <span class="s1"></span>
                                <span class="s2">{$lang.tos2}</span>
                            </h1>
                            <div id="confirmation">
                                <h2>{$lang.confirmation}</h2>
                                <iframe class="bC" src="#" id="tos_ifr"></iframe>

                            </div>
                        </div>
                        <p class="ch ch2">
                            <input type="checkbox" value="1" name="tos"/>
                            <span>{$lang.tos1} &nbsp;</span>
                            <a href="{$tos}" onclick="$('#tos_ifr').attr('src', $(this).attr('href')).focus();
                                        $('#tos').toggle();
                                        return false;">{$lang.tos2}</a>
                        </p>  {/if}
                        <p id="submits">
                            <a href="#" class="checkout" onclick="$('#checkoutform').submit();
                                        return false">{$lang.submityourorder}</a>
                        </p>

                    </div>
                </form>
        </div>
        {include file='dedicated/cart_sidemenu.tpl'}

    </div>
    {include file='dedicated/cart_footer.tpl'}