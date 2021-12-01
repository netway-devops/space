<a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none"></a>
<table width="100%" cellspacing="0" cellpadding="3" border="0" style="" class="table glike">
    <thead>
    <tr>
        <td class="searchbox" colspan="9">
            <div id="hider2" style="text-align:right">
                <a href="?cmd={$cmd}&action=getadvanced&subaction=commissions" class="fadvanced">{$lang.filterdata}</a>
                <a href="?cmd={$cmd}&resetfilter=1" {if $currentfilter}style="display:inline"{/if} class="freseter">{$lang.filterisactive}</a>
            </div>
            <div id="hider" style="display:none"></div>
        </td>
    </tr>
    </thead>

    <thead>
        <tr class="blu">
            <th><a href="?cmd={$cmd}&action={$action}&orderby=id|ASC" class="sortorder">ID</a></th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=number|ASC" class="sortorder">{$lang.Order}</a></th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=|ASC" class="sortorder">{$lang.signupdate}</a></th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=lastname|ASC" class="sortorder">{$lang.affiliate}</a></th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=c_lastname|ASC" class="sortorder">{$lang.Client}</a></th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=total|ASC" class="sortorder">{$lang.Sale}</a></th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=commission|ASC" class="sortorder">{$lang.commission}</a></th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=paid|ASC" class="sortorder">{$lang.approved}</a></th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=coupon_id|ASC" class="sortorder">{$lang.voucher}</a></th>
        </tr>
    </thead>

    <tbody id="updater">
        {include file='ajax.affiliates.tpl'}
    </tbody>

    <tbody id="psummary">
    <tr class="blu">
        <th></th>
        <th colspan="9">
            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
        </th>
    </tr>
    </tbody>
</table> 