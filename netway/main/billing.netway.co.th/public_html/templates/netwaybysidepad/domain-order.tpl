{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'domain-order.tpl.php');
{/php}

{literal}
<style>

    hr.domain-order{
        margin: 0px;
    }
    .borderless td, .borderless th {
        border: none;
    }
    .collapsed , .main-container-header-bg , aside{
        display: none;
    }
    #couponOpenModal{
        cursor: pointer;
    }
    .tr-Unavailable {
         vertical-align: middle;
         color: #421900;
         height: 50px;
         border-bottom: 2px solid #ff5325;
         margin-bottom: 50px;

    }
    .tr-available {
         vertical-align: middle;
         color: #0052cd;
         height: 50px;
         border-bottom: 2px solid #0052cd;
        }
    @media only screen and (min-width: 768px) {
       .bg-domainorder {
        padding : 45px;
        background: #ECE9E6;
        background: -webkit-linear-gradient(to right, #F2F2F2, #ECE9E6);
        background: linear-gradient(to right, #F2F2F2, #ECE9E6);
        }
       .div-result {
        padding: 50px 50px 150px 50px;
        box-shadow: 0 2px 4px 0 rgba(192, 182, 182);
       }
       .txt-form {
         color: #0052cd;
         font-size: 18px;
         font-weight: 600;

       }
       h2 {
         font-size: 22px !important;
       }

       .result-border {

         border: 1px solid #e3e3e3;
         padding: 20px 20px 20px;
         line-height: 16px;
         border-radius: 8px;
         color: #555;


       }
       .epp_code {
          width: 300px;
       }
       .tr-order {
          vertical-align: middle;
          color: #0052cd;
          height: 60px;
          border-bottom: 2px solid #0052cd;
          font-size: 16px;
       }
       .table-order {
          table-layout: fixed;
          text-align: center;
          color: #3b3e4d;
          background-color: #f6f9ff;
          border-radius: 10px;
          font-size: 18px;
       }
       .btn-order-etc {
         color: #757575;
         font-weight: 100;
         background-color: transparent;
         border-color: transparent;
         margin-top: 10px;
         font-size: 16px;
	    }
	    .btn-order-etc:hover {
	         color: #ff6000;
	         text-decoration: none;
	         background-color: transparent;
	         border-color: transparent;
	         margin-top: 10px;
	         font-size: 16px;
	    }
	    .btn-confirm{
		     margin: 50px 0% 50px 0%;
		     border-radius: 5px;
		     display: inline-block;
		     color: #fff;
		     font-style: normal;
		     font-size: 18px;
		     padding: 15px 20px;
		     text-decoration: none;
		     border: 2px solid transparent;
		     background-color: #ff3d00;

        }
        #domain-cart-vat {
		     font-size: 20px;
		     color: #abb9d8;
		}
		.div-summary {
		     text-align: right;
		     font-size: 22px;
		     margin-top: 20px;
		     line-height: 11px;
		}
		.td-width{
		    width: 125px;
		}
		input[type="text"].txt-checker{
		    height: 45px;
		    width: 60%;
		    font-size: 18px;
		    color: #0052cd;
	    }
	    select {
            width: 220px;
            background-color: #ffffff;
            border: 1px solid #1A73E8 !important;
            height: 40px !important;
            line-height: 40px !important;
            font-size: 16px !important;

        }
        .tale th, .table td {
            padding: 20px 20px 0px 20px !important;
            line-height: 0px !important;
            text-align: left !important;
            vertical-align: baseline !important;
        }


    }
    @media screen and (max-width: 600px) {
        .bg-domainorder {
        padding : 0 0 0 0;
        background: #ffffff;
        }
       .div-result {
        padding: 5px 5px 5px 5px;
        box-shadow: 0 2px 4px 0 transparent;
       }
      .txt-form {
         color: #0052cd;
         font-size: 16px;
         font-weight: 600;
         margin-top: 10px;

       }
       h2 {
         font-size: 18px !important;
       }
       .result-border {

         padding: 0 5px 0 5px;
         line-height: 16px;
         border-radius: 8px;
         color: #555;
       }
       .epp_code {
          width: 100%;
       }
       .tr-order {
          vertical-align: middle;
          color: #0052cd;
          height: 60px;
          border-bottom: 2px solid #0052cd;
          font-size: 12px;
       }
       .table-order {
          table-layout: fixed;
          text-align: left;
          color: #3b3e4d;
          background-color: #f6f9ff;
          border-radius: 10px;
          font-size: 14px;
       }
       .btn-order-etc {
          color: #757575;
          font-weight: 100;
          background-color: transparent;
          border-color: transparent;
          margin-top: 10px;
          font-size: 12px;
	    }
	    .btn-order-etc:hover {
	      color: #ff6000;
	      text-decoration: none;
	      background-color: transparent;
	      border-color: transparent;
	      margin-top: 10px;
	      font-size: 12px;
	    }

	    .btn-confirm{
		   margin: 50px 0% 50px 0%;
		   border-radius: 5px;
		   display: inline-block;
		   color: #fff;
		   font-style: normal;
		   font-size: 16px;
		   padding: 6px 8px;
		   text-decoration: none;
		   border: 2px solid transparent;
		   background-color: #ff3d00;

		   }
		#domain-cart-vat {
           font-size: 18px;
           color: #abb9d8;
        }
        .div-summary {
           text-align: right;
           font-size: 18px;
           margin-top: 50px;
           line-height: 9px;
        }
        .td-width{
            width: 0px;
        }
        input[type="text"].txt-checker{
            height: 45px;
            width: 90%;
            font-size: 18px;
            color: #0052cd;
            margin-top: 20px;
            margin-bottom: -30px;
        }
        select {
	        width: 140px;
	        background-color: #ffffff;
	        border: 1px solid #1A73E8 !important;
	        height: 40px !important;
	        line-height: 40px !important;
	        font-size: 10px !important;
	        margin-top: 30px;

         }

         .tale th, .table td {
           /*padding: 20px 20px 0px 20px !important;
            line-height: 0px !important;*/
            text-align: left !important;
            vertical-align: baseline !important;
        }
    }
    .bg-form {

        margin-top: 20px;
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0 2px 4px 0 rgba(192, 182, 182);
        border-color: #0052cd;
        border-left: 6px solid #0052cd;


    }
    .div-shadow {
        border-radius: 5px;
        box-shadow: 0 2px 4px 0 rgba(192, 182, 182);
    }
    .div-result {
          box-shadow: 0 1px 6px 0 rgba(32, 33, 36, 0.28);
          text-align: left;
          background-color: #fff;
          margin-top: 0 0 10px 0;
          border-radius: 8px;
    }
    .panel-primary > .panel-heading {
          color: #004085;
          background-color: #cce5ff;
          padding: 30px 0 30px 15px !important;
          border: 1px solid #b8daff;

    }


    .title-form {
         color: #00398f;
         font-weight: 300;
         margin-bottom: 30px;

    }
     .btn-order-add {
         color: #0052cd;
         font-weight: 100;
         background-color: transparent;
         border-color: transparent;
         margin-top: 10px;
    }
    .btn-order-add:hover {
         color: #52b202;
         text-decoration: none;
         background-color: transparent;
         border-color: transparent;
         margin-top: 10px;
    }


.btn-confirm:hover {
    background-color: #ff6333;

}
.info-domain {
    padding: 5px 10px 5px;
    color: #fff;
    font-weight: 100;
    background-color: #5d9af7;
}
#domain-cart-discount{
   color: 2fb61e !important;
}
    .collapsed{
        display: unset !important;
    }



</style>
<script>
    {/literal}{if $listHostingPlan}{literal}
    var listHostingPlan = JSON.parse('{/literal}{$listHostingPlan}{literal}');
    {/literal}{/if}{literal}
    var listDomainOrder = JSON.parse('{/literal}{$listDomainOrder}{literal}');
</script>

{/literal}
<script src="/includes/modules/Other/netway_common/public_html/js/domain/domain2.js"></script>
{if $step == 0 || $smarty.get.addmore == 1}

    <div align="center" class="bg-domainorder" >

        <div class="container">
	        <div class="fow-fluid">
		        <div class="span12" style="width: 100%;">
			        <div class="bg-form" style=" padding-top: 20px;">
			            <label><h1 >สั่งซื้อ Domain Name</h1></label>
			            <center>
		                <span class="nw-2018-content-line"></span>
		                </center>
			            {if $isOrderHosting == 1}.
			            <div style="color: #00398f; font-size: 18px;" >
			            <div style="margin-bottom: 10px;">
				            <input type="radio" checked="checked" name="noDomain" class="noDomain" value="1" id="1"/><label for="1" style="display: unset;">ต้องการจดโดเมน หรือย้ายโดเมนมาด้วย</label>
				            <input type="radio" name="noDomain"  class="noDomain" value="0" style="margin-left: 60px;"   id="0" /><label for="0" style="display: unset;">สนใจเฉพาะโฮสติ้งเท่านั้น</label>
				        </div>

				        </div>
				        {/if}
			            <form  class="form-inline" onsubmit="event.preventDefault()">
			               <div class="form-group">
			                <input type="text" name="domain-checker-txt" class="txt-checker" id="domain-checker-txt" value="{$autorderDomain}" required="" placeholder="พิมพ์ชื่อโดเมนที่คุณต้องการที่นี่"/>
			                <button value="orderDomain" id="check-now" class="btn-check" name="" style="margin-top: 50px; padding: 10px 20px;"><i class="fa fa-search" aria-hidden="true"></i></button>
			                {if $smarty.get.addmore == 1 && count($inDomainCart.items) != 0}<button onclick="window.location.assign('/domain-order');" class="btn-confirm" name="" style="margin-top: 50px; padding: 10px 20px; border-radius: 0px; margin-left: 5px;" > <i class="fa fa-shopping-cart" aria-hidden="true"></i></button>{/if}
			               </div>
			            </form>
			        </div>
		        </div>
	        </div>
        </div>

        <div class="container load-result" style="display:none; margin-top: 20px;">
            <div class="fow-fluid">
                <div class="span12" style="width: 100%;">
			        <div>
			            <form name="domain-order" action="/domain-order" method="post">
			                <input type="hidden" name="order-domain" value="1" />
                            <div class="domain-checker-result " id="domain-order-result"></div>
			                <div class="domain-checker-result div-result" id="domain-checker-result"></div>
			            </form>
			        </div>
			    </div>
			 </div>
        </div>
    {if $autorderDomain != ''}
        {literal}
        <script>
            $(document).ready(function(){
                $('#check-now').click();
            });
        </script>
        {/literal}
    {/if}

{elseif $step == 1}
<div class="  bg-domainorder">
<div class="container">
    <div class="row-fluid ">
        <div class="span12 div-result">
            <h1 class="title-form">สรุปรายการสั่งซื้อ <i class="fa fa-cart-plus pull-right" aria-hidden="true"></i></h1>
            <div class="result-border">
            <h2  style="color: #212529;"><img src="{$system_url}templates/netwaybysidepad/images/icon-Netway2018-Domain.png" width="40px" alt="icon-domian"> &nbsp;โดเมน (Domain)</h2>
            {if count($inDomainCart.items) == 0 || (count($inDomainCart.items) == 1 && $inDomainCart.items[$smarty.session.domainordercart.hosting.hostname].type == 'Dummy')}
               <div class="result-border">
                <div class="alert alert-warning" style="padding: 30px; text-align: center; font-size: 16px;" >
                   <p>ไม่มีรายการโดเมนที่ต้องการจด </p><a href="/domain-order?addmore=1" class="btn-order-add"><i class="fa fa-plus-circle" aria-hidden="true"></i> ซื้อโดเนมเพิ่ม</a>
               </div>
               </div>
            {else}

            <table width="100%" class="tableborderless table-order" >
                <tr class="tr-order"><th  style="color: #0052cd; ">รายการ </th><th>ประเภท</th><th>ราคา</th><th style="width: 10%;">จำนวน</th><th style="text-align: center;"><a href="/domain-order?addmore=1" class="btn-order-add"><i class="fa fa-plus-circle" aria-hidden="true"></i> เพิ่ม</a></th></tr>
                {foreach from=$inDomainCart.items key=key item=domain}
                {if $domain.type == 'Dummy'}{continue}{/if}
                    <tr>
                        <td style="font-weight: 600;">
                            {$key}
                        </td>
                        <td>{$domain.type}</td>
                        <td style="font-weight: 600;">{$domain.price} บาท</td>
                        <td>{$domain.period} ปี</td>
                        <td style="text-align: center;">
                            <form name="domain-remove" action="/domain-order" method="post">
                                <input type="hidden" name="removeItem" value="{$key}" />
                                <input type="hidden" name="addHosting" value="1" />
                                <button type="submit"  value="Remove" class="btn-order-etc"> <i class="fa fa-trash" aria-hidden="true"></i>  ลบ </button>

                            </form>
                        </td>
                    </tr>

                    {if $domain.type == 'Transfer'}
                    <tr>
                       <td align="left" colspan="5">
                            <div class="form-group" style="padding: 5px;">
                            <label style="color: #f60c2f; font-weight: 300;">
                            EPP Code <a href="" class="vtip_description vtip_applied" title="Authorized code หรือ EPP Code ขอได้จากผู้ให้บริการเดิม"></a>&nbsp;
                            </label>
                            <input type="text" class="epp_code" name="epp[]" id="{$key}"  style="padding: 16px;"/><br><a href="https://netway.co.th/kb/Domains/Service%20Request/%E0%B8%82%E0%B8%B1%E0%B9%89%E0%B8%99%E0%B8%95%E0%B8%AD%E0%B8%99%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%A2%E0%B9%89%E0%B8%B2%E0%B8%A2%E0%B9%82%E0%B8%94%E0%B9%80%E0%B8%A1%E0%B8%99%20%20gTLD%20%E0%B8%A1%E0%B8%B2%E0%B8%97%E0%B8%B5%E0%B9%88%20Netway-115005316048" class="btn-order-etc" target="_blank">อ่านเพิ่มเติม <i class="fa fa-external-link "></i> </a>
                            </div>
                       </td>

                    </tr>
                    {/if}
                {/foreach}
            </table>
           </div>

            {/if}


            {if count($smarty.session.domainordercart.items) > 0}
            <form name="domain-hosting-order" action="/domain-order" method="post">
                <div class="result-border" style="margin-top:20px;">
                    <div class="row-fluid" style="margin-bottom: 40px;">
                        <div class="span6">
                                <h2 style="color: #212529;">
                                    <img src="{$system_url}templates/netwaybysidepad/images/icon-Netway2018-Hosting.png" width="40px" alt="icon-hosting" />
                                    &nbsp;โฮสติ้ง(Hosting)
                                </h2>
                        </div>
                        <div class="span6">
                                <select name="interesting" id="interesting" style="margin-top: 10px; width: 100%;">
                                <option value="0">ไม่สนใจ </option>
                                <option value="1" {if $smarty.session.domainordercart.hosting} selected="selected" {/if}>สนใจ </option>
                                </select>

                        </div>
                    </div>
                        <div class="row-fluid" {if ! $smarty.session.domainordercart.hosting} style="display: none; " {/if} id="show-select-hosting-plan">
                            <div class="span4">
                                <div class="form-group">
                                   <label class="control-label  txt-form"> สำหรับโดเมน </label>
                                   <hr/>
                                   <select name="hostname" id="hostname" style="width: 100%;">
                                    {foreach from=$inDomainCart.items key=key item=domain}
                                        <option value="{$key}" {if $smarty.session.domainordercart.hosting.hostname == $key} selected="selected" {/if}>{$key}</option>
                                    {/foreach}
                                    </select>
                                </div>

                            </div>
                            <div class="span5">
                                <div class="form-group">
                                   <label class="control-label  txt-form">
                                       {if $categoryId == 2}
                                       <i class="fa fa-linux" aria-hidden="true"></i> Linux Hosting | <small><a href="https://netway.co.th/windows-hosting#PlanandPricing">สนใจ Windows Hosting</a></small></label>
                                       {elseif $categoryId == 4}
                                       <i class="fa fa-windows" aria-hidden="true"></i> Windows Hosting | <small><a href="https://netway.co.th/linux-hosting#PlanandPricing">สนใจ Linux Hosting</a></small></label>
                                       {/if}
                                   <hr/>
                                      <select name="hosting-plan" id="hosting-plan" style="width: 100%;">
                                                {foreach from=$alistHostingPlan item=hostingplan}
                                                    <option value="{$hostingplan.pid}" {if $smarty.session.domainordercart.hosting.product_id == $hostingplan.pid} selected="selected" {/if}>{$hostingplan.name}</option>
                                                {/foreach}
                                      </select>
                                      <br>
                                      <a class="vtip_description vtip_applied">&nbsp;</a><a href="https://netway.co.th/linux-hosting#PlanandPricing" target="_blank" style="cursor: pointer; font-size: 14px;"> เปรียบเทียบ Package</a>
                                </div>
                            </div>
                            <div class="span3">
                                <div class="form-group">
                                   <label class="control-label  txt-form"> เลือกชำระ</label>
                                   <hr/>
                                       <select name="hosting-plan-price" id="hosting-plan-price" style="width: 100%;">

                                            </select>
                                </div>
                            </div>
                        </div>

                </div>
                {if $promotion}
                <div class="row-fluid" style="margin-top: 20px; ">

                    <div class="span12 div-whynetway" style="border: 1px solid gray; margin-bottom: 10px;">
                        Promotion: {$promotion|nl2br}
                    </div>

                </div>
                {/if}
                <div class="row-fluid">

                        <div class="modal fade" id="couponModal" role="dialog">
                            <div class="modal-dialog modal-lg">
                              <div class="modal-content">
                                <div class="modal-header">
                                  <h4 class="modal-title" style="font-size: 25px; color: #15489f;">Coupon Code ส่วนลด <i class="fa fa-ticket" aria-hidden="true"></i> </h4>
                                </div>
                                <div class="modal-body">
                                  <div class="form-group">
                                         <input type="text" style="height: 40px; width: 250px;" class="styled" id="couponTxt" name="promocode" value="{$smarty.session.domainordercart.couponIsValid}" />
                                         <button class="btn-check" id="promoform" style="padding: 8px; margin-top: 40px;"> ยืนยัน</button>
                                  </div>


                                    <div id="InvalidCouponcode" style="display: none"><font color="red">Invalid Coupon Code  <i class="fa fa-ticket" aria-hidden="true"></i></font></div>
                                    <div id="validCouponcode" style="display: none"></div>
                                </div>
                                <div class="modal-footer">
                                  <button type="button" class="btn btn-default" data-dismiss="modal">ปิด </button>
                                </div>
                              </div>
                            </div>
                        </div>

                </div>

                <div class="row-fluid result-border" id="cartSummary" style="margin-top:20px;">

                    <div class="span12 div-summary">
                        <span id="domain-cart-sammary"><p class="domain-cart-price-text" style="font-weight: 600;">รวม 0 บาท</p></span>
                        <br>
                        <span id="domain-cart-discount"><p class="domain-cart-price-text"><a id="couponOpenModal" onclick="couponModalToggle()">Coupon Code
                         <i class="fa fa-ticket" aria-hidden="true"></i></a> ส่วนลด 0 บาท</p></span>
                        <br>
                        <span id="domain-cart-vat"><p class="domain-cart-price-text">VAT(7%) 0 บาท</p></span>
                        <br>
                        <span id="domain-cart-total" style="font-weight: 600; color: #0052cd;"><p class="domain-cart-price-text" >ยอดรวมชำระ 0 บาท</p></span>
                        <hr/>
                        {if count($inDomainCart.items) > 0 || $smarty.session.domainordercart.hosting }
                        <input name="cartDomainIsCheckout" value="1" type="hidden" />
                        <button type="submit" id="checkout-now" class="btn-confirm" name="" style="margin-top: 10px;"><i class="fa fa-check-circle-o" aria-hidden="true"></i>&nbsp;ยืนยันคำสั่งซื้อ</button>
                        {/if}
                    </div>

                </div>

            </form>
            {/if}
        </div>
    </div>
 </div>
</div>
    {literal}
    <script>
        calculateInCartPriceWithHosting();
        $(document).ready(function(){
            if($('#couponTxt').val() != ''){
                $('#promoform').click();
            }
        });
    </script>
    {/literal}

{elseif $step == 2}
<div  class="bg-domainorder" >
<div class="bg-form">
<div class="sing-up container " style="width: 95%; padding: 10px 10px 10px 10px;">
    <form method="post" name="updateAddress" id="updateAddress">
    <div><h3 class="txt-form"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> การสั่งซื้อโดเมนจะต้องมีข้อมูลเจ้าของโดเมนประกอบ </h3></div>
    <div>
        <span class="label label-info info-domain">Info</span> ข้อมูลจะต้องเป็นภาษาอังกฤษเท่านั้น
    </div>
    <div><hr/></div>
    {foreach from=$aAddressType item=addressType}
        <div>
            <h3 style="font-size: 16px; font-weight: 100; color: #0052cd;">{$addressType} Address {if $addressType != 'registrant'}&nbsp;<input checked="checked" name="" class="same_registrant" id="{$addressType}" type="checkbox" /> ใช้ที่อยู่เดียวกับ Registrant Address</h3>{/if}
        {if is_array($aClientAddress[$addressType])}
        <table id="{$addressType}_address" {if $addressType != 'registrant'}style="display: none;"{/if}>
        {foreach from=$aClientAddress[$addressType] key=k item=value}
            {if !in_array($k , $aRequireAddressField)}{continue}{/if}
            <tr>
                {if $k == 'country'}
                    {if $value==''}{assign var=value value='TH'}{/if}
                    <td class="td-width"><label class="control-label" for="field_{$k}">{$k}</label></td>
                    <td><div class="controls">
                        <select name="{$addressType}[{$k}]" class="address_form_{$addressType}" style="width: 90%;" id="field_{$k}"  class="chzn-select">
                            {foreach from=$aCountry key=key item=v}
                                <option value="{$key}" {if $key==$value} selected="Selected"{/if}>{$v}</option>
                            {/foreach}
                        </select>
                    </div></td>
                {else}
                        <td class="td-width"><label class="control-label" for="field_{$k}">{$k}</label></td>
                        <td><div class="controls">
                            <input value="{$value}" {if $k == 'email'}type="email" {else}type="text"{/if} style="width: 90%; padding: 16px;" name="{$addressType}[{$k}]" class="address_form_{$addressType}" id="field_{$k}">
                        </div></td>
                 {/if}
            </tr>
        {/foreach}
        </table>
        {else}
        <table id="{$addressType}_address" {if $addressType != 'registrant'}style="display: none;"{/if}>
        {foreach from=$aRequireAddressField item=field}
            <tr>
                {if $field == 'country'}
                    {if $value==''}{assign var=value value='TH'}{/if}
                    <td class="td-width"><label class="control-label" for="field_{$field}">{$field}</label></td>
                    <td><div class="controls">
                        <select name="{$addressType}[{$field}]" class="address_form_{$addressType}" style="width: 90%;" id="field_{$field}"  class="chzn-select">
                            {foreach from=$aCountry key=key item=v}
                                <option value="{$key}" {if $key==$value} selected="Selected"{/if}>{$v}</option>
                            {/foreach}
                        </select>
                    </div></td>
                {else}
                        <td class="td-width"><label class="control-label" for="field_{$field}">{$field}</label></td>
                        <td><div class="controls">
                            <input value="" {if $field == 'email'}type="email" {else}type="text"{/if} style="width: 90%;padding: 16px;" name="{$addressType}[{$field}]" class="address_form_{$addressType}" id="field_{$field}">
                        </div></td>
                {/if}
            </tr>
        {/foreach}
        </table>
        {/if}
        </div>
    {/foreach}
    <button value="saveAddress" id="saveAddress" class="btn-confirm pull-right" name="" style="margin-top: 40px;">ไปหน้าชำระเงิน <i class="fa fa-chevron-circle-right" aria-hidden="true"></i></button>
    <a style="display: none;" href="javascript:void(0)" class="gotoInvoice" id='{$invoiceId}'><h4>ข้าม, ไปหน้าชำระเงิน</h4></a>
    </form>
  </div>
</div>
</div>
{literal}
<script type="text/javascript">
    $('#field_email, #field_firstname, #field_lastname, #field_address1, #field_city, #field_state, #field_postcode, #field_phonenumber').attr('required', 'required');
    $('#field_address1, #field_address2').attr('maxlength', '96');
    $('#field_postcode, #field_phonenumber').attr('placeholder', 'ระบุตัวเลขเท่านั้น').keyup(function () { this.value = this.value.replace(/[^0-9]/g,''); });
    $("#updateAddress").submit(function(e){
        e.preventDefault();
        $('.sing-up').addLoader();
        var data = $('#updateAddress').serialize();
        $.post(
        '?cmd=domainhandle&action=updateAddress' ,
        {
            addressData:   data
        } ,
        function(data){
            console.log(data);
            window.location.assign('/clientarea/invoice/'+$('.gotoInvoice').attr('id'));
        });

        setTimeout(function(){ $('#preloader').remove(); }, 3000);

    });

    $('.same_registrant').each(function(){
        $(this).click(function(){
            var id = $(this).attr('id');
            if($(this).is(':checked')){
                $('.address_form_registrant').each(function(){
                    var field = $(this).attr('id');
                    var value = $(this).val();
                    $('.address_form_'+id+'#'+field).val(value);
                });
                $('#'+id+'_address').hide();
            }else{
                 $('#'+id+'_address').show();
            }
        });

    });

    $('.gotoInvoice').click(function(){
        //$("#saveAddress").click();
        window.location.assign('/clientarea/invoice/'+$(this).attr('id'));
    });

</script>
{/literal}

{/if}

{*$inDomainCart|@print_r*}

