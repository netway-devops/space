{if $totalpages}
    <center class="blu paginercontainer" >
        <strong>{$lang.Page} </strong>
        {section name=foo loop=$totalpages}
            <a href='?cmd={$module}&action=logs&page={$smarty.section.foo.iteration-1}&security_token={$security_token}' class="npaginer
                               {if $smarty.section.foo.iteration-1==$currentpage}
                                   currentpage
                               {/if}"
            >{$smarty.section.foo.iteration}</a>

        {/section}
    </center>
    <script>
        $('.paginercontainer', 'div.slide:visible').infinitepages();
        $('.paginercontainer').show();
        FilterModal.bindsorter('{$orderby.orderby}', '{$orderby.type}');
    </script>
{/if}