{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'share/header-corporate-temp.tpl.php');
$date_now = date("Y-m-d");
$date_show = '2020-07-29';
$this->assign('date_now',$date_now);
$this->assign('date_show',$date_show);
{/php}


{literal}
<style>
.cbp-hrmenu > ul > li.cbp-hropen > a > span{
    height: 0 !important;
    right: 48% !important;
    bottom: 1px !important;
}
.cbp-hrmenu .cbp-hrsub{
    margin-top: 0px !important;

}
</style>
{/literal}

<div class="head-corporate hidden-phone" style="margin-top: 8px;" >
    <div class="topmenu fix-topmenu-desktop">
        <div class="container">
            <div class="row-fluid">
             <div class="span6">
                    <span class="left">
                    <a href="{$smarty.const.CMS_URL}"><img src="{$template_dir}images/logo-netway-20th.png" style="margin-top:0px; margin-bottom: 8px;      margin-left: 8px; width:80%;"/></a>
                    </span>
                    <div class="left txt-top">
                        <i class="fa fa-phone" aria-hidden="true"></i>

                       <a href="tel:+6620551095" >
                            <span style="color: #0052cd; font-size: 15px;">+662-055-1095</a>  บริการ 24 ชั่วโมง</span>
                        </a>

                        <br/>

                    </div>
             </div>
            <div class="span6" style="margin-top: 13px;">
                <div class="right">
                    <ul id="navtop">
                        <li><a href="{$smarty.const.CMS_URL}/kb"><i class="fa fa-question-circle"></i> <span class="hidden-phone">Help!</span></a></li>
                        <li><a href="{$smarty.const.CMS_URL}/training" style="padding: 3px 2px;"><img src="{$template_dir}images/icon-training.png" style="width:22px;height:auto"/> <span class="hidden-phone">Training</span></a></li>
                        <li><a href="{$smarty.const.CMS_URL}/contact" style="padding: 3px 12px;"><i class="fa fa-comments-o"></i> <span class="hidden-phone">ติดต่อเรา </span></a></li>
                        <li><a href="{$smarty.const.CMS_URL}/payment"><i class="fa fa-money"></i> <span class="hidden-phone">การชำระเงินและภาษี</span></a></li>
                        <li>
                                {if $logged=='1'}
                            <img class="avatar-mobile" alt="" src="{$clientAvatar}">
                            {else}
                            <a href="{$ca_url}clientarea/" rel="nofollow"><i class="fa fa-user" ></i> Log-in</a>
                            {/if}
                            <div class="btn-group" style="float:right; margin-top:0px;">
                                <ul class="dropdown-menu  pull-right" style="margin-left:-200px; margin-top:0px; background:#f2f2f2; width: 270px;">
                                    {if $logged!='1'}
                                    {else}
                                    <li>
                                        <div class="container" style="width: 250px;">
                                            <div class="row">
                                                <div class="col-lg-3 col-sm-6">

                                                    <div class="card hovercard">
                                                        <div class="cardheader">

                                                        </div>
                                                        <div class="avatar">
                                                            <img alt="" src="{$clientAvatar}">
                                                        </div>
                                                        <div class="info">
                                                            <br>{$clientEmail}<br><br>
                                                        </div>
                                                        <div class="bottom">
                                                            <button type="button" class="btn-card" onclick="location.href='{$ca_url}clientarea/';" rel='nofollow'>Dashboard</button>
                                                            <button type="button" class="btn-card" onclick="location.href='{$ca_url}clientarea/details/';" rel='nofollow'>Account</button>
                                                            <br><br>
                                                            <button type="button" class="btn-card"  onclick="location.href='https://support.netway.co.th/access/logout?return_to=https%3A%2F%2Fnetway.co.th%2F';" rel='nofollow' >
                                                                {$lang.logout}
                                                           </button>

                                                        </div>
                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                    </li>
                                    <li></li>
                                    <li></li>
                                    {/if}
                                    {if $adminlogged}
                                    <li class="divider"></li>
                                    <li><a  href="{$admin_url}/index.php{if $login.id}?cmd=clients&amp;action=show&amp;id={$login.id}{/if}">{$lang.adminreturn}</a></li>
                                    {/if}

                                </ul>
                            </div>
                      </li>
                    </ul>
                </div>
            </div>

                </div>
               <div class="clearit"></div>
              </div>
        </div>
    </div>

<div class="head-corporate-phone visible-phone visible-lablet" >

        <span>
            <a href="{$ca_url}"><img src="{$template_dir}images/logo-netway-20th.png" style="width:100px;   margin-left: 8px;  margin-top: 8px; margin-bottom: 8px; "  /></a>
        </span>
        <div class="right pull-right">
            <ul id="navtop-phone">
                    {if $date_now < $date_show }
                    <li>
                        <a href="tel:+6629122558">
                            <i class="fa fa-phone" aria-hidden="true" style="font-size: 20px" id ='phoneCall'></i>
                        </a>
                    </li>
                    {else}
                    <li>
                        <a href="tel:+6620551095">
                            <i class="fa fa-phone" aria-hidden="true" style="font-size: 20px" id ='phoneCall'></i>
                        </a>
                    </li>
                    {/if}
                    <li><a href="{$smarty.const.CMS_URL}/training">
                        <img src="{$template_dir}images/icon-training.png" style="width:24px;height:auto"/></a>
                    </li>
                    <li><a href="{$smarty.const.CMS_URL}/kb">
                        <i class="fa fa-question-circle" style="font-size: 20px"></i></a>
                    </li>
                    <li><a href="{$smarty.const.CMS_URL}/payment">
                        <i class="fa fa-money" style="font-size: 20px"></i>
                    </a>
                    </li>
                    <li>
                        <a href="/order"><i class="fa fa-cart-plus" aria-hidden="true" style="font-size: 20px"></i></a>
                    </li>
                    <li>
                            {if $logged=='1'}
                            <a href="https://support.netway.co.th/access/logout?return_to=https%3A%2F%2Fnetway.co.th%2F" rel="nofollow"><i class="fa fa-user" style="font-size: 20px;  margin-right: 10px;"></i> </a>
                            <a href="{$ca_url}clientarea/details/" rel="nofollow"><img class="avatar-mobile" alt="" src="{$clientAvatar}" width="25px" style="margin-right: 10px;"></a>

                            {else}
                            <a href="{$ca_url}clientarea/" rel="nofollow"><i class="fa fa-user" style="font-size: 20px;  margin-right: 10px;"></i></a>
                            {/if}

                      </li>
            </ul>
        </div>



</div>

<!------------------- Start Middle ----------------------------->

<div class="visible-phone" style="cursor: pointer;">
<div class="navbar-default">

<div class="navbar-header">
    <div data-toggle="collapse">
        <button type="button" class="navbar-toggle pull-left collapsed ma5menu__toggle" data-toggle="collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        </button>
        <button class="topmenu-allprodouct g-txt16" style="width: 178px;  margin-top: 0px;   background: 0 0;   border-width: 0;   padding:  5px 0 5px 0;">
        ผลิตภัณฑ์ทั้งหมด
        </button>

    </div>
     <a href="{$smarty.const.CMS_URL}/promo" >
            <p class="btn-promo-phone g-txt16 pull-right" style="min-height: 0; position: inherit;margin-right: 25px;color: #ff562f;margin-top: -30px;">
             Promo <i class="fa fa-bullhorn" aria-hidden="true" style="font-size: 20px"></i>
            </p>
        </a>
</div>

{*<nav class="ma5menu">ย้ายไปที่ footer เพื่อ page speed ที่ดีขึ้น</nav>*}

<div class="ma5menu__tools">
    Your Cloud Based IT Department
</div>

</div>
</div>




{assign var=queryString value="/"|explode:$smarty.server.QUERY_STRING}
<div class="container hidden-phone">
            <div class="main" style="margin-top: {if $queryString.1 == 'cart'|| $queryString.1 != 'cart' }90px;{else}15px;{/if}">
                <nav id="cbp-hrmenu" class="cbp-hrmenu">
                    <ul>
                        <li>
                            {include file='../netwaybysidepad/menus/include/domain.tpl'}
                        </li>
                        <li>
                            {include file='../netwaybysidepad/menus/include/hosting.tpl'}
                        </li>
                        <li>
                            {include file='../netwaybysidepad/menus/include/cloud.tpl'}
                        </li>
                        <li>
                            {include file='../netwaybysidepad/menus/include/ssl.tpl'}
                        </li>
                        <li>
                            {include file='../netwaybysidepad/menus/include/email.tpl'}
                        </li>
                        <li>
                            {include file='../netwaybysidepad/menus/include/microsoft.tpl'}
                        </li>
                        <li>
                            {include file='../netwaybysidepad/menus/include/google.tpl'}
                        </li>
                        <li>
                            {include file='../netwaybysidepad/menus/include/zendesk.tpl'}
                        </li>
                       <li>
                            {include file='../netwaybysidepad/menus/include/marketing.tpl'}
                        </li>
                        <li>
                            {include file='../netwaybysidepad/menus/include/other.tpl'}
                        </li>

                        <li>
                            <!--Button Orders on topmenu-->
                              &nbsp; &nbsp;<button class="btn-order-nnw " onclick="location.href='{$system_url}order';" style="margin-left: 30px;"> <i class="fa fa-cart-plus pull-right" aria-hidden="true"></i>  Order </button>
                            <!--/Button Orders on topmenu-->
                        </li>
                        <li>
                            <!--  Buton Promotion on topmenu -->
                               &nbsp; &nbsp;<button class="btn-promo-nnw " onclick="location.href='{$smarty.const.CMS_URL}/promo';"> <i class="fa fa-bullhorn pull-right" aria-hidden="true"></i>  Promo </button>
                            <!-- / Buton Promotion on topmenu -->
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

<script src="{$template_dir}js/horizontalDropDownMenu/cbpHorizontalMenu.js"></script>
{literal}
<script>
    $(function() {
        cbpHorizontalMenu.init();
    });
</script>
 {/literal}

</div>
