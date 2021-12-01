{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'rvglobalsoft_apikey.tpl.php');
{/php}
<h3 style="margin-bottom:5px">RV Global Soft API Key</h3>
<p>
API Key คือ Public Key ที่ใช้สำหรับเชื่อมต่อเข้ากับ api.rvglobalsoft.com ถ้า API Key ผิดพลาด จะมีผลให้ Reseller ที่เข้ามาใช้งาน Shop ไม่สามารถทำงานบางส่วนได้.
</p>
{if $showapikey.warning}
<p>
<font color="red">คำเตือน: {$showapikey.warning}</font>
</p>
{/if}
<p>
<textarea rows="10" cols="100" readonly="true">{$showapikey.publickey}</textarea>
</p>
<p>
<b>API Connection status:</b> {$showapikey.apiconnection}
</p>