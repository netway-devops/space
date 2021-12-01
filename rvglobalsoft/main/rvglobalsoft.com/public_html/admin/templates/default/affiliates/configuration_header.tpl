<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li class="{if $action=='configuration' && (!$pickedtab)}active{/if}" >
                <a href="?cmd={$cmd}&action=configuration&tab=settings"><span>{$lang.affconfig}</span></a>
            </li>
            <li class="{if $action=='commision' || ($action=='configuration' && $pickedtab == 1)}active{/if}">
                <a href="?cmd={$cmd}&action=configuration&tab=commisions"><span>{$lang.commission_plans}</span></a>
            </li>
            <li class="direct {if $action=='vouchers'}active{/if}">
                <a href="?cmd={$cmd}&action=vouchers"><span>{$lang.affvoucher}</span></a>
            </li>
            <li class="direct {if $action=='campaigns' || $action=='campaign'}active{/if} last">
                <a href="?cmd={$cmd}&action=campaigns"><span>{$lang.affcampaigns}</span></a>
            </li>
        </ul>
    </div>
    <div class="list-2">
        {if $action=='vouchers'}
            <div class="navsubmenu {if $vouchers}hasitems{/if}" >
                <ul>
                    {if $vouchers}
                        <li class="list-2elem">
                            <a class="submiter confirm" name="deletevouchers" href="#"><span>{$lang.deleteselected}</span></a>
                        </li>
                    {/if}
                </ul>
            </div>
        {elseif $action=='commision'}
            <div class="navsubmenu">
                <ul></ul>
            </div>
        {elseif $action=='campaigns'}
            <div class="navsubmenu hasitems">
                <ul>
                    <li class="list-2elem">
                        <a class="" href="?cmd={$cmd}&action=campaign"><span>{$lang.addcampaign}</span></a>
                    </li>
                </ul>
            </div>
        {else}
            <div class="navsubmenu" >
                <ul>

                </ul>
            </div>
            <div class="navsubmenu hasitems" style="display: none;">
                <ul>
                    <li class="list-2elem"><a href="?cmd={$cmd}&action=commision&make=add"><span>{$lang.addcommision}</span></a></li>
                    <li class="list-2elem"><a class="submiter confirm" name="deletecomm" href="#"><span>{$lang.deleteselected}</span></a></li>      
                </ul>
            </div>
        {/if}
    </div>
</div>