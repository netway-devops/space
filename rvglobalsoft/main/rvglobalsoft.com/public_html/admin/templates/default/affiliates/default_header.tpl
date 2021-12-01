{literal}
    <style type="text/css">
        .sectioncontent.cpadding td{}
        .sectioncontent td{}
        .newhorizontalnav .list-2 .navsubmenu {background: #FFFFFF; border-bottom: 1px solid #DFDFDF;}
        .newhorizontalnav .list-2 .hasitems {height: 20px; padding: 8px 16px; box-sizing: content-box;}
    </style>
{/literal}
{if $action=='default' || $action=='commissions' || $action=='withdrawals' || $action=='queue' || $action=='statistics'}
    <div class="newhorizontalnav" id="newshelfnav">
        <div class="list-1">
            <ul>
                <li class="direct {if !$action || $action=='default'}active{/if}" >
                    <a href="?cmd={$cmd}"><span>{$lang.Affiliates}</span></a>
                </li>
                <li class="direct {if $action=='commissions'}active{/if}">
                    <a href="?cmd={$cmd}&action=commissions"><span>{$lang.commissions}</span></a>
                </li>
                <li class="direct {if $action=='withdrawals'}active{/if}">
                    <a href="?cmd={$cmd}&action=withdrawals"><span>Withdrawals</span></a>
                </li>
                <li class="direct last {if $action=='queue'}active{/if}">
                    <a href="?cmd={$cmd}&action=queue"><span>Pending withdrawals</span></a>
                </li>
                <li class="direct last {if $action=='statistics'}active{/if}">
                    <a href="?cmd={$cmd}&action=statistics"><span>Statistics</span></a>
                </li>
            </ul>
        </div>
        <div class="list-2">
            <div class="navsubmenu " >
                <ul>
                </ul>
            </div>
        </div>
    </div>
{/if}