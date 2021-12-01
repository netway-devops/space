<script type="text/javascript" src="{$template_dir}js/formgroups.js?v={$hb_version}"></script>

<script type="text/javascript">
    loadelements.services = true;
</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td colspan="2"><h3>{$lang.formgroups}</h3></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=services&action=addcategory" class="tstyled btn btn-success"><strong>{$lang.addneworpage}</strong></a>
            <br/>
            <a href="?cmd=services" class="tstyled">{$lang.orpages}</a>
            <a href="?cmd=productaddons" class="tstyled">{$lang.manageaddons}</a>
            <a href="?cmd=formgroups" class="tstyled selected">{$lang.formgroups}</a>
        </td>
        <td valign="top" class="bordered" rowspan="2">
            <div id="bodycont">
                {include file='ajax.formgroups.tpl'}
            </div>
        </td>
    </tr>
</table>

