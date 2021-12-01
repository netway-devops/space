<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li class="list-1elem"><a href="#">{$lang.generalconfig}</a></li>
            <li class="list-1elem"><a href="#">{$lang.Ordering}</a></li>
            <li class="list-1elem"><a href="#">{$lang.Support}</a></li>
            <li class="list-1elem"><a href="#">{$lang.Billing}</a></li>
            <li class="list-1elem"><a href="#">{$lang.Mail}</a></li>
            <li class="list-1elem"><a href="#">{$lang.CurrencyName} &amp; {$lang.taxconfiguration}</a></li>
            <li class="list-1elem last"><a href="#">{$lang.Other}</a></li>
            <!--<li class="list-1elem"><a href="#">More</a></li>-->
        </ul>
    </div>

    <div class="list-2">
        <div class="subm1"></div>
        <div class="subm1 haveitems" style="display:none">
            <ul>
                <li {if $action!='orderscenarios'}class="picked"{/if}><a href="#"><span>{$lang.General}</span></a></li>
                <li {if $action=='orderscenarios'}class="picked"{/if}>
                    <a href="?cmd=configuration&action=orderscenarios"><span>{$lang.orderscenarios}</span></a>
                </li>
                <li {if $action=='contracts'}class="picked"{/if}>
                    <a href="?cmd=configuration&action=contracts"><span>{$lang.agreements_contracts}</span></a>
                </li>
            </ul>
        </div>
        <div class="subm1 haveitems" style="display:none">
            <ul>
                <li {if $action!='ticketstatuses'}class="picked"{/if}><a href="#"><span>{$lang.General}</span></a></li>
                <li {if $action=='ticketstatuses'}class="picked"{/if}>
                    <a href="?cmd=configuration&action=ticketstatuses"><span>{$lang.ticketstatuses}</span></a>
                </li>
            </ul>
        </div>
        <div class="subm1 haveitems" style="display:none">
            <ul>
                <li>
                    <a href="?action=download&invoice=preview"
                       onclick="return invoicePreview(this)">
                        <span><b>{$lang.previewinvoice}</b></span>
                    </a>
                <li class="list-2elem"><a href="#"><span>{$lang.invmethod}</span></a></li>
                <li {if $action=='invoicetemplates' || $action=='edittemplate'}class="picked"{/if}>
                    <a href="?cmd=configuration&action=invoicetemplates" ><span>Document Templates</span></a>
                </li>
                <li class="list-2elem"><a href="#"><span>{$lang.creditcards}</span></a></li>
                <li class="list-2elem"><a href="#"><span>{$lang.ACHecheck}</span></a></li>
                <li class="list-2elem"><a href="#"><span>{$lang.clbalance}</span></a></li>
                <li class="list-2elem"><a href="#"><span>Credit notes</span></a></li>
                <li class="list-2elem"><a href="#"><span>Misc.</span></a></li>
            </ul>
        </div>
        <div class="subm1 haveitems" style="display:none">
            <ul>
                <li class="list-4elem"><a href="#"><span>{$lang.mailmethod}</span></a></li>
                <li class="list-4elem"><a href="#"><span>{$lang.mailcustomize}</span></a></li>
            </ul>
        </div>
        <div class="subm1 haveitems" style="display:none">
            <ul>
                <li class="list-3elem"><a href="#"><span>{$lang.maincurrency}</span></a></li>
                <li class="list-3elem"><a href="#"><span>{$lang.addcurrencies}</span></a></li>
                <li {if $cmd=='currencytocountry'}class="picked"{/if}>
                    <a href="?cmd=currencytocountry"><span>Currency to country</span></a>
                </li>
                <li {if $cmd=='taxconfig'}class="picked"{/if}>
                    <a href="?cmd=taxconfig"><span>{$lang.taxes}</span></a>
                </li>
            </ul>
        </div>
        <div class="subm1 haveitems" style="display:none">
            <ul>
                <li class="list-7elem"><a href="#"><span>Client Permissions</span></a></li>
                <li class="list-7elem"><a href="#"><span>Security & Display</span></a></li>
                <li class="list-7elem"><a href="#"><span>Admin portal</span></a></li>
                <li class="list-7elem"><a href="#"><span>GDPR / Data Retention</span></a></li>
                <li {if $cmd=='cancellationreasons'}class="picked"{/if}>
                    <a href="?cmd=cancellationreasons"><span>Cancellation Reasons</span></a>
                </li>
                <li class="list-7elem"><a href="#"><span>Import / Export Config</span></a></li>
            </ul>
        </div>
    </div>
</div>
{literal}
<script>
    $(function(){
        var picked = {/literal}{$picked_tab|default:0}{literal};
        var subpicked = {/literal}{$picked_subtab|default:0}{literal};
        var base = '?cmd=configuration';

        $('#newshelfnav a').each(function(){
            var self = $(this),
                href = self.attr('href');

            if(href.indexOf('#') === 0){
                if(href.length < 2)
                    href = '';

                var parent = self.closest('li')
                if(parent.is('.list-1elem')){
                    var tab =  parent.index();
                    self.attr('href', base + ( tab > 0 ? '&picked_tab=' + tab : '') + href)
                }else{
                    var tab =  parent.closest('.subm1').index(),
                        sub = parent.parent().children('[class^=list]'),
                        subtab = sub.length ? sub.index(parent) : 0;

                    self.attr('href', base
                        + (tab > 0 ? '&picked_tab=' + tab : '')
                        + (subtab > 0 ? '&picked_subtab=' + subtab : '') + href)
                }

            }
        });

        $('#newshelfnav .list-1elem').eq(picked).addClass('active picked');
        $('#newshelfnav .subm1').eq(picked).show().find('li');

    });

    function invoicePreview(l) {
        ajax_update('?cmd=configuration', $('#saveconfigform').serializeObject(), function () {
            window.location = $(l).attr('href');
        });
        return false;
    }
</script>
{/literal}