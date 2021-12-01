{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.ticketdepts.tpl.php');
{/php}
{if $action=='add' || $action=='edit'}
    {include file='support_dept/add_edit.tpl'}
{else}
    {include file='support_dept/list.tpl'}
{/if}