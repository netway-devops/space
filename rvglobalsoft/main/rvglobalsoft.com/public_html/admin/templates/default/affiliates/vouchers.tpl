<form action="" method="post" id="testform">
    {include file="affiliates/configuration_header.tpl"}
    {if $vouchers}
        <div class="blu">
            <a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
        </div>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
                <tr>
                    <th width="20"><input type="checkbox" id="checkall"/></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=code|ASC" class="sortorder">{$lang.couponcode}</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=lastname|ASC"  class="sortorder">{$lang.affiliate}</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=name|ASC"  class="sortorder">Commission Plan</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=value|ASC"  class="sortorder">{$lang.Discount}</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=usage|ASC"  class="sortorder">{$lang.Used}</a></th>   
                </tr>
            </tbody>

            <tbody id="updater">
                {include file='ajax.affiliates.tpl'}
            </tbody>

            <tbody id="psummary">
                <tr>
                    <th></th>
                    <th colspan="9">
                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                    </th>
                </tr>
            </tbody>
        </table>
        <div class="blu">
            {*<input type="submit" value="{$lang.savechanges}" style="font-weight:bold" name="savechanges"/>*}
        </div>
    {else}
        <div class="blank_state blank_services">
            <div class="blank_info">
                <h1>{$lang.affvoucher}</h1>
                {$lang.affvoucher_blank}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    {securitytoken}
</form>