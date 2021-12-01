{php}
$tplPath    = $this->get_template_vars('tplPath');
include($tplPath . 'admin/leftmenu.tpl.php');
{/php}
<br />
<a href="?cmd={$cmd}&action=default" class="tstyled {if $action == 'default'}selected{/if}"><strong>Home</strong></a><br />
<h3>List of widget</h3>
{foreach from=$aWidgets item=widget}
<a href="?cmd={$cmd}&action=lists&widget={$widget}" class="tstyled {if $action == 'lists' && isset($widgetName) && $widget == $widgetName}selected{/if}">{$allWidgets.$widget.title}</a>
{/foreach}
<br />