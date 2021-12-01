{literal}
<script type="text/javascript">
    $(function(){
        function flyingSidemenu() {
            setTimeout(function(){
                $('#right').height($('.cart-summary').outerHeight(true));
                $(window).scroll(_slide);
            },450);
        }
    });
</script>
{/literal}
<div class="left clearfix">
    <h2><strong>{$lang.checkout}</strong></h2>
    <div class="separator"></div>
    <form id="config_form" method="post" action="">
        <input type="hidden" name="step" value="{$step}" />
        {if $logged!="1"}
            <div class="order-step">
                <div class="circle-header clearfix">
                    <div>{counter name=step}</div>
                    <h5 class="glyph-contact">{$lang.ContactInfo}</h5>
                </div>
                <a name="formupdater"></a>
                <div class="step-content clearfix">
                    <div class="cart-option" id="formupdater">
                        {include file="ajax.signup.tpl"}
                    </div>
                    <div class="content-arrow"><div></div></div>
                    <div id="loginbtn">
                        <h5 class="glyph-user">{$lang.returningcustomerq} {$lang.login} &raquo;</h5>
                        <a href="#" class="btn btn-primary btn-order left" onclick="{literal}ajax_update('index.php?cmd=login',{layer:'ajax'},'#formupdater',true);$(document).slideToElement('formupdater'); $('#loginbtn').hide().next().show();return false{/literal} ">{$lang.login}</a>
                    </div>
                    <div id="createbtn" style="display:none">
                        <h5 class="glyph-user">{$lang.newcustomerq} {$lang.createaccount} &raquo;</h5>
                        <a href="#" class="btn btn-primary btn-order left" onclick="{literal}ajax_update('index.php?cmd=signup',{layer:'ajax'},'#formupdater',true);$(document).slideToElement('formupdater'); $('#createbtn').hide().prev().show();return false{/literal}">{$lang.createaccount}</a>
                    </div>
                </div>
            </div>
            
        {else}
            <div class="order-step">
                <div class="circle-header clearfix">
                    <div>{counter name=step}</div>
                    <h5>{$lang.ContactInfo}</h5>
                </div>
                <div class="step-content">
                    <div class="cart-option">
                        {include file="drawclientinfo.tpl"}
                    </div>
                    <div class="content-arrow"><div></div></div>
                </div>
            </div>
        {/if}
        <div class="order-step">
            <div class="circle-header clearfix">
                <div>{counter name=step}</div>
                <h5 class="glyph-cart">{$lang.choose_payment}</h5>
            </div>
            <div class="step-content">
                <div class="cart-option">
                    {if $gateways}
                        <center>
                            {foreach from=$gateways item=module key=mid name=payloop}
                                <input type="radio" name="gateway" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/> {$module}
                            {/foreach}
                        </center>  
                        
                    {/if}
                </div>
                <div class="content-arrow"><div></div></div>
            </div>
        </div>
        <div class="order-step" id="gatewayform">
            <div class="circle-header clearfix">
                <div>{counter name=step}</div>
                <h5 class="glyph-cc">{$lang.ccdetails}</h5>
            </div>
            <div class="step-content">
                <div class="cart-option wbox_content" >
                    <center><img  src="{$template_dir}img/ajax-loading.gif" /></center>
                </div>
                <div class="content-arrow"><div></div></div>
            </div>
        </div>
        <div class="order-step" >
            <div class="circle-header clearfix">
                <div>{counter name=step}</div>
                <h5 class="glyph-other">{$lang.cart_add}</h5>
            </div>
            <div class="step-content">
                <div class="cart-option wbox_content" >
                    <textarea id="c_notes" placeholder="{$lang.c_tarea}" style="width: 99%"  name="notes">{if $submit.notes}{$submit.notes}{/if}</textarea>
                </div>
                <div class="content-arrow"><div></div></div>
            </div>
        </div>
        <div class="order-step" >
            <div class="circle-header clearfix">
                <div>{counter name=step}</div>
                <h5 class="glyph-other">{$lang.tos2}</h5>
            </div>
            <div class="step-content">
                <div class="cart-option wbox_content" >
                    <input type="checkbox" value="1" name="tos"/>&nbsp;
                    {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a>
                </div>
                <div class="content-arrow"><div></div></div>
            </div>
        </div>
        <input type="hidden" name="make" value="step4" />
    </form>
    
</div>
<div class="right clearfix">
    <h3>{$lang.cart} <strong>{$lang.summary}</strong></h3>
    <div id="right">
        <div class="cart-summary" >
            <div id="cartSummary">
                {include file='ajax.cart_dedicated_new.tpl'}
            </div>
        </div>
    </div>
    <div class="separator"></div>
    <a class="btn btn-success btn-order btn-order-big" href="#" onclick="$('#config_form').submit(); return false;">{$lang.checkout}</a>
</div>
