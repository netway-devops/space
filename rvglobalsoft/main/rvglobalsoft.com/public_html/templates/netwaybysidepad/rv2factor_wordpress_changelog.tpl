{php}
$f_chlog = @file('/home/rvglobal/public_html/rvchangelog/rv2factor_wordpress_changelog.txt');
//$f_chlog = @file('/home/darawan/public_html/rvchangelog/rv2factor_wordpress_changelog.txt');
$aData = array();
for($i=0;$i<count($f_chlog);$i++){
    array_push($aData,$f_chlog[$i]);
}

$this->assign('aLog', $aData);
{/php}

{foreach from=$aLog item=foo}
	{$foo} <br />
{/foreach}
