<script type="text/javascript">loadelements.services = true;</script>
<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/services.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.productsandservices}</h3></td>
        <td>
            {if $action=='product'}
                <div class="breadcrumbs">
                    <a href="?cmd=services"  class="tload2">{$lang.orpages}</a>
                    {foreach from=$categories item=c}
                        {if $c.id==$product.category_id}
                            {if $c.parent_id}
                                {foreach from=$categories item=b}
                                    {if $c.parent_id==$b.id}
                                        &raquo;
                                        <a href="?cmd=services&action=category&id={$b.id}" class="tload2">
                                            {$b.name}
                                        </a>
                                    {/if}
                                {/foreach}
                            {/if}
                            &raquo;
                            <a href="?cmd=services&action=category&id={$product.category_id}"  class="tload2">
                                {$c.name}
                            </a>
                        {/if}
                    {/foreach}
                    &raquo; <strong>{if !$product.name}{$lang.addnewproduct}{else}{$product.name}{/if}</strong>
                </div>
            {elseif $action=='category'}
                <div class="breadcrumbs">
                    <a href="?cmd=services" class="tload2">{$lang.orpages}</a>
                    {if $category.parent_id}
                        {foreach from=$categories item=b}
                            {if $category.parent_id==$b.id}
                                &raquo;
                                <a href="?cmd=services&action=category&id={$b.id}" class="tload2">
                                    {$b.name}
                                </a>
                            {/if}
                        {/foreach}
                    {/if}
                    &raquo; <strong>{$category.name}</strong>
                </div>
            {elseif $action=='addcategory'}
                <div class="breadcrumbs">
                    <a href="?cmd=services" class="tload2">{$lang.orpages}</a>
                    {if $parent.id}
                        &raquo;
                        <a href="?cmd=services&action=category&id={$parent.id}" class="tload2">
                            {$parent.name}
                        </a>
                        &raquo; <strong>{$lang.addnewsubcategory}</strong>
                    {else}
                        &raquo; <strong>{$lang.addneworpage}</strong>
                    {/if}
                </div>
            {/if}
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=services&action=addcategory"  class="tstyled btn btn-success {if $action=='addcategory'}selected{/if}"  ><strong>{$lang.addneworpage}</strong></a> <br />
            <a href="?cmd=services"  class="tstyled {if $action=='default' || $action=='category'  || $action=='editcategory' || $action=='product'}selected{/if} defclass">{$lang.orpages}</a>
            <a href="?cmd=productaddons"  class="tstyled">{$lang.manageaddons}</a>
            <a href="?cmd=formgroups"  class="tstyled {if $action=='formgroups'}selected{/if}">{$lang.formgroups}</a>
        </td>
        <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont">
                {include file='ajax.services.tpl'}
            </div>
        </td>
    </tr>
</table>

