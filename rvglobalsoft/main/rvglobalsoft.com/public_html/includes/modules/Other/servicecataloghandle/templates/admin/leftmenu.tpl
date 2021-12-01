<a class="tstyled {if $action == '' || $action == 'default'}selected{/if}" href="?cmd=module&module=servicecataloghandle">Home</a>
<a class="tstyled {if $action == 'servicecatalog'}selected{/if}" href="?cmd=module&module=servicecataloghandle&action=serviceCatalog">Service Catalog</a>
<a class="tstyled {if $action == 'browse' && ($oInfo->type != 'incidentkb' && $oInfo->type != 'incidentKB')}selected{/if}" href="?cmd=module&module=servicecataloghandle&action=browse">----- Browse</a>
<a class="tstyled {if $action == 'incidentkb' || $action == 'viewincidentkb'}selected{/if}" href="?cmd=module&module=servicecataloghandle&action=incidentKB">Incident KB</a>
<a class="tstyled {if $action == 'browse' && ($oInfo->type == 'incidentkb' || $oInfo->type == 'incidentKB')}selected{/if}" href="?cmd=module&module=servicecataloghandle&action=browse&type=incidentKB">----- Browse</a>

{if preg_match('/^(siripen|prasit|panya)/', $oAdmin->email)}
<a class="tstyled {if $action == 'globalemailtemplate'}selected{/if}" href="?cmd=module&module=servicecataloghandle&action=globalEmailTemplate">----- Global Email Template</a>
{/if}
