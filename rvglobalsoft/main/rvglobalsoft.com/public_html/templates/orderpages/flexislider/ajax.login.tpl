
<table border="0" cellpadding="0" cellspacing="6" width="80%">
<tr>

<td align="left" colspan="2">
    <label for="username" class="styled">{$lang.email}</label>
      <div class="input"><div><input name="username" value="{$submit.username}" style="width:96%" id="username" class="styled"/></div></div>
</td>
</tr>

<tr>

<td align="left" colspan="2">
    <label for="password"  class="styled">{$lang.password}</label>
    <div class="input"><div><input name="password" type="password"  style="width:96%" id="password" class="styled"/></div></div>
</td>
</tr>
<tr>

<td align="left"  colspan="2" >
    <a href="{$ca_url}root&amp;action=passreminder" class="list_item" target="_blank">{$lang.passreminder}</a>
</td>

</tr>
    </table>


<input type="hidden" name="action" value="login"/>



