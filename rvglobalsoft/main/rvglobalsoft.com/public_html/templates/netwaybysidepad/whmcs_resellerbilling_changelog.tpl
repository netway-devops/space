{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'whmcs_resellerbilling_changelog.tpl.php');
{/php}

<div class="container reseller">
	<div class="row content">
		<div class="col-md-12">
			<h2>WHMCS Integration Plugins Changelog</h2>
			<h1 class="title">Changelog: </h1> 
			<div>
				{foreach from=$aLog item=foo}
					<div>{$foo}</div>
				{/foreach}
			</div>
		</div>
	</div>
</div>