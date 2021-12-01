
<!-- 
{if $offer}
  <ul class="nav nav-tabs">
    {foreach from=$offer item=o}
    <li {if $action=='services' && $cid==$o.id || $service.category_id==$o.id}class='active-nav'{/if}><a href="{$ca_url}clientarea/services/{$o.slug}/"><div class="nav-bg-fix">{$o.name}</div></a></li>
    {/foreach}
    {if $enableFeatures.domains!='off'}
    <li><a href="{$ca_url}clientarea/domains/"><div class="nav-bg-fix">{$lang.mydomains}</div></a></li>
    {/if}
    <li class="more-hidden"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><div class="nav-bg-fix">
    {$lang.more}<span class="caret"></span>
    </div></a>
        <ul id="more-hidden" class="dropdown-menu">
            <div class="dropdown-padding">
            </div>
        </ul>
    </li>
  </ul>
{/if} -->



{literal}
<style>
    .main-container-header .nav-tabs > li.active-nav > a .nav-bg-fix{
       font-size: 15px;
       height: 30px;
       padding: 4px 5px 4px 5px;
       border: solid 1px #969696;
       font-weight: 500;
       background: #14509c;
       color:#FFFFFF;
    }
     .main-container-header .nav-tabs > li > a .nav-bg-fix{
        font-size: 15px;
        height: 30px;
        padding: 4px 5px 4px 5px;
        border: solid 1px #969696;
        font-weight: 500;
        background: #3f88e5;
        color:#FFFFFF;
    }

     .main-container-header .nav-tabs > li > a .nav-bg-fix:hover{
        background: #14509c;
        color:#FFFFFF;
    }
</style>
{/literal}

{if $offer}
  <ul class="nav nav-tabs">
    
    {foreach from=$offer item=o}
        {if $o.total>0}
            <li {if $action=='services' && $cid==$o.id || $service.category_id==$o.id}class='active-nav'{/if}><a href="{$ca_url}clientarea/services/{$o.slug}/"><div class="nav-bg-fix">{$o.name} ({$o.total})</div></a></li>
        {/if}
    {/foreach}
    {if $offer_domains!= 0}
        <li {if $action=='domains'}class='active-nav'{/if}><a href="{$ca_url}clientarea/domains/"><div class="nav-bg-fix">{$lang.mydomains} ({$offer_domains})</div></a></li>
  
    {/if}
    <li style="background-color: #3f88e6"><a href="https://netway.co.th/order"><div class="nav-bg-fix">Order more <i class="fa fa-plus-circle"></i></div></a></li>
  </ul>
{/if}