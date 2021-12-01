{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'services/category_codename.tpl.php');
{/php}

{if $isActiveModuleDBCIntegration}
{if $smarty.get.action == 'category' || $smarty.get.action == 'editcategory'}
<script language="JavaScript">
{literal}
$(function() {
    $('#categorycodename').keyup(function(e) {
        this.value = this.value.replace(/[^a-zA-Z0-9]/, '').toUpperCase();
    });

    $('form[name="category_add_edit"]').off('submit').on('submit', function() {
        if ($('#category_id').val() !== undefined) {
            $.post('?cmd=dbc_integration&action=update_cateroty_to_DBC', {catid: $('#category_id').val()}, function(rasponse, status) {})
        }
        return true;
    })
});

function submitCategoryCodename(id, codename) {
    $.post('?cmd=dbc_integration&action=ajaxValidateCategoryCodename', { codename: codename}, function(rasponse, status) {
        if (rasponse.data.isError !== undefined && rasponse.data.isError == true) {
            $('#categorycodename').value = '';
            alert(rasponse.data.message);
        } else {
            if (rasponse.data.available == true) {
                $.post('?cmd=dbc_integration&action=ajaxUpdateCodenameToCategoryID', {cat_id: id, codename: codename}, function(rasponse, status) {
                    if (rasponse.data.isError !== undefined && rasponse.data.isError == true) {
                        alert(rasponse.data.message);
                    } else {
                        location.reload();
                    }
                });
            } else {
                alert('Category codename is not available.');
            }
        }
    });
}
{/literal}
</script>
{/if}

{if $action == 'category' && isset($category.id)}
<p>
    <b>DBC Category Code Name: </b>
    {if trim($category.codeName) == ''}
    <input value="{$category.codeName}" style="font-size: 16px !important; font-weight: bold;" class="inp" size="4" maxlength="4" name="codeName" id="categorycodename{$codenameRandId}" />
    <a onclick="submitCategoryCodename('{$category.id}', $('#categorycodename{$codenameRandId}').val());" class="menuitm menu-auto ajax">Save</a>
    {assign var=codenameRandId value=10|mt_rand:200}
    {else}
    {$category.codeName}
    {/if}
</p>
{elseif ($action == 'editcategory' && isset($category.id))}
<tr>
    <td width="160" align="right" class="fs11"><b>DBC Category Code Name: </b></td>
    <td class="fs11" colspan="2">
    {if $action=='editcategory' && trim($category.codeName) == ''}
        {assign var=unique_id value=10|mt_rand:200}
        <input value="{$category.codeName}" style="font-size: 16px !important; font-weight: bold;" class="inp" size="4" maxlength="4" name="codeName" id="categorycodename{$codenameRandId}" />
        <a onclick="submitCategoryCodename('{$category.id}', $('#categorycodename{$codenameRandId}').val());" class="menuitm menu-auto ajax">Save</a>
        {assign var=codenameRandId value=10|mt_rand:200}
    {else}
        {$category.codeName}
    {/if}
    </td>
</tr>
{/if}
{/if}
