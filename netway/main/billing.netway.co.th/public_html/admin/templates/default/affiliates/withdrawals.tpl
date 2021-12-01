<a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none"></a>
<table width="100%" cellspacing="0" cellpadding="3" border="0" style="" class="table glike">
    <tbody>
    <tr>
        <th><a href="?cmd={$cmd}&action={$action}&orderby=date|ASC" class="sortorder">Date</a></th>
        <th><a href="?cmd={$cmd}&action={$action}&orderby=aff_id|ASC" class="sortorder">Affiliate</a></th>
        <th><a href="?cmd={$cmd}&action={$action}&orderby=amount|ASC" class="sortorder">{$lang.Amount}</a></th>
        <th><a href="?cmd={$cmd}&action={$action}&orderby=method|ASC" class="sortorder">Method</a></th>
        <th><a href="?cmd={$cmd}&action={$action}&orderby=note|ASC" class="sortorder">Notes</a></th>
    </tr>
    </tbody>
    <tbody id="updater">
    {include file='ajax.affiliates.tpl'}
    </tbody>
    <tbody id="psummary">
    <tr>
        <th colspan="9">
            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
        </th>
    </tr>
    </tbody>
</table>