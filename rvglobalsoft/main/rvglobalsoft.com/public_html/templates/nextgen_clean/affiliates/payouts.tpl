<div class="bordered-section article">
    <h2 class="bbottom">{$lang.withdrawallogs}</h2>
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table table-striped fullscreen">
        <colgroup class="firstcol"></colgroup>
        <colgroup class="alternatecol"></colgroup>

        <colgroup class="firstcol"></colgroup>
        <colgroup class="alternatecol"></colgroup>

        <colgroup class="firstcol"></colgroup>
        <tbody>
            <tr>
                <th><a href="?cmd=affiliates&action=payouts&orderby=date|ASC" class="sortorder">{$lang.date}</a></th>
                <th><a href="?cmd=affiliates&action=payouts&orderby=amount|ASC" class="sortorder">{$lang.withdrawn}</a></th>
                <th><a href="?cmd=affiliates&action=payouts&orderby=note|ASC" class="sortorder">{$lang.note}</a></th>
            </tr>
        </tbody>
        <tbody id="updater">
            {include file='affiliates/ajax.payouts.tpl'}
        </tbody>
    </table>
    <div class="right p19 pt0">
        <div class="pagelabel left ">{$lang.page}</div>
        <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
            {section name=foo loop=$totalpages}
                <button class="btn {if $smarty.section.foo.iteration==1}active{/if}" onclick="pageswitch(this);">{$smarty.section.foo.iteration}</button>
            {/section}
        </div>
        <input type="hidden" id="currentpage" value="0" />
    </div>
    <script>
        {literal}
        function pageswitch(btn) {
            $('#pageswitch').children().each(function () {
                $(this).removeClass('active');
            });
            $(btn).addClass('active');
        }
        {/literal}
    </script>
    <div class="clear"></div>
    <a href="{$ca_url}affiliates&amp;action=payouts" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages">
</div>