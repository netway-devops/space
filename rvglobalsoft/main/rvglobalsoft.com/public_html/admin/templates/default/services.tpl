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
                    &raquo; <a href="?cmd=services&action=category&id={$product.category_id}"  class="tload2">
                        {foreach from=$categories item=c}{if $c.id==$product.category_id}{$c.name}{/if}{/foreach}
                    </a>
                    &raquo; <strong>{if !$product.name}{$lang.addnewproduct}{else}{$product.name}{/if}

                </div>
            {/if}
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=services&action=addcategory"  class="tstyled btn btn-success {if $action=='addcategory'}selected{/if}"  ><strong>{$lang.addneworpage}</strong></a> <br />
            <a href="?cmd=services"  class="tstyled {if $action=='default' || $action=='category'  || $action=='editcategory' || $action=='product'}selected{/if} defclass">{$lang.orpages}</a>
            {if isset($admindata.access.menuProductaddons)}
            <a href="?cmd=productaddons"  class="tstyled">{$lang.manageaddons}</a>
            {/if}
            <a href="?cmd=formgroups"  class="tstyled {if $action=='formgroups'}selected{/if}">{$lang.formgroups}</a>
        </td>
        <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont">
                {include file='ajax.services.tpl'}
            </div>
        </td>
    </tr>
</table>

