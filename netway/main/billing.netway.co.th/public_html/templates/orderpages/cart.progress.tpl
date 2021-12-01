{if $custom_overrides.cart_progress}
    {include file=$custom_overrides.cart_progress}
{else}
{if $step!=5 && $step!=0}
    {if $step>2 && (!$cart_contents[2] || $cart_contents[2][0].action == 'hostname')}
        {assign var='pclass' value='asw3'}
    {elseif $step==1 || $cart_contents[2]} 
        {assign var='pclass' value='asw5'}  
    {/if}
    
    <ul id="" class="cart-step" style="margin-bottom: 115px;margin-top: 14px;">
        {if $pclass=='asw5'}		
            <li class="{if $step>=1}active{/if} {$pclass}">			
                {if $step>1}<a href="{$ca_url}cart&step=1">{$lang.mydomains}</a>
                {else}{$lang.mydomains}
                {/if}
            </li>
            <li class="{$pclass} {if $step==2}active{elseif $step>2}{/if}">	
                {if $step>2}<a href="{$ca_url}cart&step=2">{$lang.productconfig2}</a>
                {else}{$lang.productconfig2}
                {/if}
            </li>					

            <li class="{$pclass} {if $step==3}active{elseif $step>3}{/if}">	
                {if $step>3}<a href="{$ca_url}cart&step=3">{$lang.productconfig}</a>
                {else}{$lang.productconfig}
                {/if}
           
            </li>	
        {elseif $pclass=='asw3'}
            <li class="active {if $step>3}{/if}{$pclass}">
                {if $step>3}<a href="{$ca_url}cart&step=3">{$lang.productconfig}</a>
                {else}{$lang.productconfig}
                {/if}
            </li>
        {/if}

        <li class="{if $step==4}active{elseif $step>3}active{/if}{$pclass}">
            {$lang.ordersummary}
        </li>

        <li class="lastone {$pclass}">
            {$lang.checkout}
        </li>
    </ul>

{/if}

{if $step>0 && $step<4}
    <style type="text/css">
        {literal}
            .asw5{
               width:20%     
            }
            .asw3{
               width:30%     
            }
            @media (min-width: 1170px) {
              #cont {
                    width:830px !important;
                }
                
              .cart-step {
                counter-reset: step;
              }
              .cart-step li {
                  list-style-type: none;
                 
                  float: left;
                  font-size: 16px;
                  position: sticky;
                  text-align: center;
                  color: #7d7d7d;
              }
              .cart-step li.asw3:before {
                  width: 30px;
                  height: 30px;
                  content: counter(step);
                  counter-increment: step;
                  line-height: 30px;
                  border: 2px solid #7d7d7d;
                  display: block;
                  text-align: center;
                  margin: 0 auto 10px auto;
                  border-radius: 50%;
                  background-color: white;
              }
              .cart-step li.asw5:before {
                  width: 30px;
                  height: 30px;
                  content: counter(step);
                  counter-increment: step;
                  line-height: 30px;
                  border: 2px solid #7d7d7d;
                  display: block;
                  text-align: center;
                  margin: 0 69px 10px auto;
                  border-radius: 50%;
                  background-color: white;
              }
              .cart-step li:after {
                  width: 100%;
                  height: 2px;
                  content: '';
                  position: absolute;
                  background-color: #7d7d7d;
                  top: 15px;
                  left: -44%;
                  z-index: -1;
              }
              .cart-step li:first-child:after {
                  content: none;
              }
              .cart-step li.active {
                  color: green;
              }
              .cart-step li.active:before {
                  border-color: #55b776;
              }
              .cart-step li.active + li:after {
                  background-color: #55b776;
              }
            }
           @media (max-width: 480px) {
               .cart-step {
                counter-reset: step;
            }
            .cart-step li.asw3{
                list-style-type: none;
                width: 33%;
                float: left;
                font-size: 12px;
                position: sticky;
                text-align: center;
                color: #7d7d7d;
            }
            .cart-step li.asw5 {
                list-style-type: none;
                width: 20%;
                float: left;
                font-size: 11px;
                position: sticky;
                color: #7d7d7d;
            }

            .cart-step li:before {
                width: 30px;
                height: 30px;
                content: counter(step);
                counter-increment: step;
                line-height: 30px;
                border: 2px solid #7d7d7d;
                display: block;
                text-align: center;
                margin: 0 auto 10px auto;
                border-radius: 50%;
                background-color: white;
            }
            .cart-step li.asw3:after {
                width: 100%;
                height: 2px;
                content: '';
                position: absolute;
                background-color: #7d7d7d;
                top: 15px;
                left: -37%;
                z-index: -1;
            }


             .cart-step li.asw5:after {
                width: 100%;
                height: 2px;
                content: '';
                position: absolute;
                background-color: #7d7d7d;
                top: 15px;
                left: -29%;
                z-index: -1;
            }

            #sidemenu{
                width: 340px;
                float: none;
            }
            #floater{
                width: 348px; 
            }
            .cart-step li:first-child:after {
                content: none;
            }
            .cart-step li.active {
                color: green;
            }
            .cart-step li.active:before {
                border-color: #55b776;
            }
            .cart-step li.active + li:after {
                background-color: #55b776;
            }
            .smalltext {
                font-size: 13px;
                line-height: 16px;
            }
                
          }
            @media (max-width: 1196px) {
                #cont {
                    width:100% !important;
                }
                div#sidemenu{
                    position: relative !important;
                }
                div.cloud-step-3{
                    display: block !important;
                    width:95% !important;
                }
            }

            #progress a{
                color: inherit
            }
            /* ulli+description display fix*/
            ul li dl dd, #product_description ol{
                display:none;
            }
        {/literal}
        </style>
    {/if}
{/if}