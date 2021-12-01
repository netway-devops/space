{php}
                 $db         = hbm_db();
               $neworderpage =   $db->query("SELECT *  
                                            FROM `hb_categories` 
                                            WHERE `id` NOT IN (117,118,97)
                                            AND `visible` = 1
                                            AND template = 'neworderpage' 
                                            OR template = 'cart_neworderpage'
                                            AND visible = 1
                                            ORDER BY `name` ASC
                               ")->fetchAll();
              
               $this->assign('neworderpage',$neworderpage);       
                      
{/php}

{literal}
<style>
       .bg {
       
                background-repeat: no-repeat;
                background-size: cover;
                background-position: top;
                background-attachment: fixed;
             
                height: 360px;
                width: 100%;
            }    
       .bg-back {
            background: rgba(0, 24, 192, 0.5);
            height: 360px;
        }
     
        .order-txt-banner {
            font-size: 36px;
            font-family: 'Prompt', sans-serif;
            font-style: normal;
            line-height: 40px;
            font-weight: 500;
            color: #fff;
            margin-top: 117px;
            text-shadow: 1px 1px 6px #000;

        }
      .fancybox-opened {
        z-index: 8030;
      } 
      .fancybox-close {
        position: absolute;
        top: -18px;
        right: -18px;
        width: 36px;
        height: 36px;
        cursor: pointer;
        z-index: 8040;
     }
      .order .bg {
        padding: 5px;
        margin: 25px 0;
      }
     .order .bg .list-menu{
        clear: both;
        padding: 50px 10px 60px 35px;
        border: 2px solid #00b8d8;
        border-radius: 21px;
        background-color: #fff;
        color: #717171;
     }   
    .order .bg .list-menu ul li {
        width: 265px;
        height: 46px;
        float: left;
        padding-right: 25px;
    }
    .order .bg .list-menu ul li a, .order .bg .list-menu ul li a:visited, .order .bg .list-menu ul li a:active{ 
        color:black; 
        line-height: 1em; 
    }
    
    .order .bg .list-menu ul li a:hover, .order .bg .list-menu ul li a:active{ 
        text-decoration: none; 
        color :#0000FF;
    }
    .left {
         float: left;
    }
    
    .btnorder, .btnorder:visited, .btnorder:hover, .btnorder:active  {
      background: #189efe;
    color: #FFFFFF;
    font-size: 18px;
    -webkit-border-radius: 20px;
    padding: 10px 10px 10px 10px;
    text-decoration: none;
    margin-right: 15px;
    margin-left: 10px;
    font-family: 'prompt', Tahoma, Verdana, sans-serif;
    }   
    .btnorder:hover, .btnorder:active { 
        background:#5faadf; 
        text-decoration:none; 
    }
    .line-word{
        background: #C9D6FF;
        background: -webkit-linear-gradient(to right, #E2E2E2, #C9D6FF); 
        background: linear-gradient(to right, #E2E2E2, #C9D6FF); 

    }
</style>
{/literal}

<div class="bg  lazy-hero" data-src="/templates/netwaybysidepad/images/bg-orders2018-2.png">
  <div class="bg-back">
        <div class="container" >
            <div class="row" >
        
                <div class="hero-inner hidden-phone"  style="text-align: center;">
                        <h2 class="order-txt-banner">เลือกซื้อสินค้า และบริการสั่งซื้อ<br>และชำระเงินผ่านระบบออนไลน์ได้ทุกวันตลอด 24 ชั่วโมง</h2> 
                        <br/>
                        <a href="{$site_url}order#special"><button class="btn-check" style="margin-top:-20px">&nbsp;<i class="fa fa-cart-plus" aria-hidden="true" style="font-size: 20px"></i>&nbsp;&nbsp; สั่งซื้อสินค้า  </button></a>            
                </div>
                
                <div class="hero-inner  visible-phone">
                        <h2 class="order-txt-banner" style="font-size: 20px;text-align: center;">เลือกซื้อสินค้า และบริการสั่งซื้อ<br>และชำระเงินผ่านระบบออนไลน์ได้ทุกวันตลอด 24 ชั่วโมง</h2>  
                        <center>
                            <a href="order#special"><button class="btn-check" style="margin-top: 15px;">&nbsp;<i class="fa fa-cart-plus" aria-hidden="true" style="font-size: 20px"></i>&nbsp;&nbsp; สั่งซื้อสินค้า  </button></a>
                        </center>        
                </div>
                
                
            </div>
        </div>
    </div>
</div>
<div class="row-fluid white-kb-2018" id="special" style="
    margin-top: 0px;
    margin-bottom: 0px;
    background: linear-gradient(90deg,#1663e6,#002c67);
"><div class="container p-subtitle-herobanner" style="padding: 19px;color: white;text-align: center;font-size: 19px;font-family: Roboto,Arial,sans-serif;">
Office 365 เปลี่ยนชื่อเป็น Microsoft 365 ชื่อใหม่ แต่คุ้มค่าเหมือนเดิมในราคาเดิม
</div></div>
<div class="row-fluid white-kb-2018" id="special"  style="background:#f5f5f8;"> 
  <div class="container" >         
        <div class="order">
            <div class="row">
                <div class="span12" style="margin-top: 20px;">
                    <div class="bg">
                        <div class="list-menu">
                            <ul>
                            {foreach from=$neworderpage item=op}                      
                              <li>
                                  <a href="{$smarty.const.CMS_URL}/{$op.slug}">
                                  {if $op.name =='Office365'}
                                    Microsoft 365
                                  {elseif $op.name =='Office365-business'}
                                      Microsoft 365 Apps for business
                                  {else}
                                     {$op.name}
                                  {/if}
                                  </a>
                              </li>
                       
                            {/foreach}
                            </ul>
                        <div class="clearit"></div>
                        </div>
                    </div>
                    <div class="clearit"></div><div class="clearit"></div>
                </div>
           </div> 
           <div class="row">
                <div class="span12 hidden-phone">
               <div cass="left" style="margin-bottom:30px;"><a href="{$ca_url}{$paged.url}payment" class="btnorder">&nbsp;&nbsp;<i class="fa fa-money"></i>&nbsp;&nbsp;ช่องทางการชำระเงิน</a>
               <a  class="fancybox btnorder fancybox.iframe" style="top:80px;" href="{$ca_url}contact">&nbsp;&nbsp;<i class="fa fa-comments-o" style="font-size: 20px"></i>&nbsp;&nbsp;ติดต่อเรา</a></div>
               </div>
           </div>
           <div class="row  visible-phone" style="margin-bottom:30px;" >
               <div class="span6">
                 <a href="{$ca_url}{$paged.url}payment" class="btnorder span12"><center>&nbsp;&nbsp;<i class="fa fa-money"></i>&nbsp;&nbsp;ช่องทางการชำระเงิน </center></a>
               </div>
               <div class="span6"  style>
                 <br/>
                <a  class="fancybox btnorder fancybox.iframe  span12" style="top:80px;" href="{$ca_url}contact"><center>&nbsp;&nbsp;<i class="fa fa-comments-o" style="font-size: 20px"></i>&nbsp;&nbsp;ติดต่อเรา</center></a>
               </div>
           </div>
       </div>
  </div>
</div>


