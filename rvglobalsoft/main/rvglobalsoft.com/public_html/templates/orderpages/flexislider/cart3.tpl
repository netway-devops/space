<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}flexislider/style.css" />
<script type="text/javascript">
{literal}
    function verify_form(form) {
        //set gateway
             $(form).append('<input type="hidden" name="gateway" value="'+$('#gateway').val()+'"/>');
        //set tos
           
            //set login or signup
               if($('#day1').is(':checked')) {
                     $('#dosignup').remove();
                } else {
                $('#dologin').remove();
                            }
                    
        }
{/literal}
 </script>


<div class="zone-all step-n">

	<div>
		<div class="zone2" >




			<div class="zone-left">
				<form action="" method="post" id="cart4" onsubmit="return verify_form(this)">
                      <input type="hidden" name="make" value="step4" />
                    <div class="kol1" >
 <h3 class="slider-title">{$lang.ContactInfo}</h3>
                      
                     {if $logged=="1"}

	 <table cellspacing="0" cellpadding="0"  border="0" width="100%" class="checkout_table">

              <tr>
                <td width="160"  class="smalltext">{$lang.firstname}</td>
                <td>{$client.firstname}</td></tr>
				  <tr><td   class="smalltext">{$lang.address}</td>
                <td>{$client.address1}</td>
              </tr>

			  <tr >
                <td  class="smalltext">{$lang.lastname}</td>
                <td>{$client.lastname}</td> </tr>
				  <tr> <td  class="smalltext">{$lang.address2}</td>
                <td>{$client.address2}</td>
              </tr>
              <tr>
                <td  class="smalltext">{$lang.phone}</td>
                <td>{$client.phonenumber}</td> </tr>
				  <tr> <td  class="smalltext">{$lang.city}</td>
                <td>{$client.city}</td>
              </tr>
              <tr  >
                <td  class="smalltext">{$lang.postcode}</td>
                <td>{$client.postcode}</td> </tr>
			  <tr> <td  class="smalltext">{$lang.state}</td>
                <td>{$client.state}</td>

              </tr>
              <tr>
                <td  class="smalltext">{$lang.email}</td>
                <td>{$client.email}</td> </tr>
				  <tr> <td  class="smalltext">{$lang.country}</td>
                <td>{$countries[$client.country]} </td>
              </tr>


		   {if $client.company=='1'}
              <tr  >
                <td  style="border:none"  class="smalltext">{$lang.company}</td>
                <td style="border:none">{$client.companyname}</td>

              </tr>
			  {/if}

		  {if $extrafields}
		   {foreach from=$extrafields item=field name=f}
				 	{if ($field.type=='Company' && $client.company=='1') || ($field.type=='Private' && $client.company!='1')}

					<tr>


					<td  class="smalltext">{$field.name}</td>

						<td style="border:none">
						{if $field.field_type=='Input'}
						{$client[$field.code]}
						{elseif $field.field_type=='Check'}
							{foreach from=$field.default_value item=fa}
								{if in_array($fa,$client[$field.code])}{$fa} {/if}
							{/foreach}
						{else}

							{foreach from=$field.default_value item=fa}
								{if $client[$field.code]==$fa}{$fa} {/if}
							{/foreach}

						{/if}
						</td>


					</tr>

						{/if}

				 {/foreach}
		  {/if}


  </table>




  {else}
<div class="check">
        <div><input id="day1" type="radio" name="cust_method" value="login" {if $submit.cust_method=='login'}checked='checked'{/if} onclick="{literal}$('#dosignup').fadeOut('fast',function(){$('#dologin').fadeIn('fast')});{/literal}" />
		<span class="check-desc"><label for="day1">{$lang.alreadyclient}</label></span><div class="clear"></div></div>
 <div><input id="day2" type="radio" name="cust_method" value="newone"  {if !isset($submit) || $submit.cust_method!='login' }checked='checked'{/if}  onclick="{literal}$('#dologin').fadeOut('fast',function(){$('#dosignup').fadeIn('fast')});{/literal}" />
		<span class="check-desc"><label for="day2">{$lang.newclient}</label></span><div class="clear"></div></div>


    </div>



  <div id="updater" >
      <div id="dologin" {if $submit.cust_method=='login'}{else}style="display:none"{/if}>{include file='flexislider/ajax.login.tpl}</div>
      <div id="dosignup" {if isset($submit) && $submit.cust_method=='login' }style="display:none"{else}{/if}>{include file='flexislider/ajax.signup.tpl}</div>
 </div>





  {/if}
 {if $tos}
                         <div class="text-on" style="text-align:center;margin-top:20px;"><input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a></div>
  {/if}

                    </div>

                    </form>
			</div>
			<div class="zone-right">
                             <h3 class="slider-title">{$lang.ordersummary}</h3>
                        <div id="cart_summary">
                        {include file='flexislider/cart3_summary.tpl'}


                            </div>

                         <a href="#" onclick="$('#cart4').submit();return false" class="green-button"><span>{$lang.submitorder}</span></a>
                          <div class="clear"></div>

			</div>

		</div>
	  </div>
</div>