{php}
$templatePath   = $this->get_template_vars('widget');
include($templatePath['template'] .'.php');
{/php}

<link rel="stylesheet" href="includes/types/widgets/domainforwardinghandle/style.css" type="text/css" />

{if $rvcustomtemplate}
    {include file=$rvcustomtemplate}
{/if}