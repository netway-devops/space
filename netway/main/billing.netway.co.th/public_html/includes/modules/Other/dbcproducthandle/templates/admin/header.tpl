<!--
<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
<link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
-->

<h1>DBC Product Handle</h1>

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter} class="searchon" {/if}>
<tr>
    <td>&nbsp;</td>
    <td  class="searchbox">
        {if isset($oInfo->title)}
            <h3>{$oInfo->title}</h3>
            <div>{$oInfo->desc}</div>
        {/if}
    </td>
</tr>
<tr>
    <td class="leftNav">
        {include file="$tplPath/admin/leftmenu.tpl"}
    </td>
    <td valign="top" class="bordered">
    <div id="bodycont"> 
    
    <div class="nicers2" style="border:none; padding:20px;">
        
        {include file="$tplPath/admin/notification.tpl"}
    