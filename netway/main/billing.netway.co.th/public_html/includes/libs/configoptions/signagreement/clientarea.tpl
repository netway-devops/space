<a target="_blank" href="?cmd=contracts&action=pdf_agreement&hash={$cst.data[$cst.value]}">
    {if $tpl_name|strpos:"2019" !== false}<i class="material-icons">picture_as_pdf</i>{/if}
    {$cst.contracts[$cst.config.contract]}
</a>