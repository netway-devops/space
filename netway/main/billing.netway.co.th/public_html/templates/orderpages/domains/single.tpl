<div class="container-step1 domain-single {if $transfer}transfer container-transfer{/if}">
    {if !$transfer}
        <h1 class="title06">{$lang.startdomainssearch}</h1>
    {else}
        <h1 class="title06">
            {$lang.transfer_your_domains} {$lowestprice.price|price:$currency:true:false:false}/
            {if $lowestprice.period > 1}{$lowestprice.period} {$lang.peryear3}
            {else}{$lang.peryear2}
            {/if}!
        </h1>
    {/if}

    <div class="domain-in">
        <form action="" method="post" onsubmit='return check_domain(this, "#updater");'>
            {if $transfer}
                <input type="hidden" name="transfer" />
            {else}
                <input type="hidden" name="register" />
            {/if}
            <input type="hidden" name="action" value="checkdomain"/>
            <input type="hidden" name="singlecheck" value="1"/>
            <input type="hidden" name="domain_cat" value="{$domain_cat}"/>
            {if $claim}
                <input type="hidden" name="claim" value="{$claim|escape}"/>
            {/if}

            <div class="name-select">
                <div class="domain-in-01">www.</div>
                <div class="domain-in-02">
                    <input type="text" name="sld" placeholder="{$lang.yourdomain}" value="{if $check}{$check.sld}{else}{$lang.yourdomain}{/if}"  />
                </div>

                <div class="domain-in-03">
                    <select name="tld" id="single-tld" >
                        {foreach from=$tld item=tldname name=foo}
                            <option value="{$tldname}" {if (!$check.tld && $smarty.foreach.foo.first) || $check.tld==$tldname}selected{/if}>{$tldname}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="button01">
                    <input type="submit" value="{$lang.Go}" />
                </div>
            </div>
        </form>
    </div>

    <div class="domain-after"></div>

    <form action="{$ca_url}cart&amp;step=1&amp;cat_id=register" method="post">
        <input type="hidden" name="tld_cat" value="{$category.id}" /> 
        <input type="hidden" name="ref"  value="1"/>
        <div id="updater">{include file='ajax.checkdomainnew.tpl'}</div>
    </form>

    <div class="clear"></div>

    <div class="linia1"></div>
    <div class="transfer-after">
        <div class="kol-1">
            <h3 class="title08">{$lang.startingat}</h3>
            <div class="cost01" style="padding-bottom: 10px">{$lowestprice.price|price:$currency:true:false:false}<span>{$lang.peryear1} {if $lowestprice.period > 1}{$lowestprice.period} {$lang.peryear3}{else}{$lang.peryear2}{/if}!</span></div>
        </div>
        <div class="kol-2">
            <h3 class="title08">{$lang.supportedtlds}:</h3>
            <ul class="list-domain">
                {foreach from=$tld item=t name=fooc}
                    <li>{$t}</li>
                    {/foreach}
            </ul>
            <div class="cleart"></div>
        </div>

    </div>

    {include file="domainpricing.tpl"}

</div>
<link href="{$orderpage_dir}domains/js/chosen.min.css" rel="stylesheet" type="text/css"/>
<script src="{$orderpage_dir}domains/js/chosen.min.js" type="text/javascript"></script>
{literal}
    <script>
            $(function () {
                $('#single-tld').chosen({width: '100%'});
            })
    </script>
{/literal}