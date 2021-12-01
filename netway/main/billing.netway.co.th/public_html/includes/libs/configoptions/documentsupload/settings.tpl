
<div class="clear"></div><label for="text-keya">File count limit<small>Maximum number of files customer can upload trough this form</small></label>
<input id="text-keya" type="text" name="config[filelimit]" value="{$field.config.filelimit|escape}" />

<div class="clear"></div><label for="text-keyaa">Allowed extensions<small>Comma separated list of allowed extensions (i.e.: .png,.pdf,.jpg)</small></label>
<input id="text-keyaa" type="text" name="config[extensions]" value="{$field.config.extensions}" />

<div class="clear"></div><label for="text-keyaaa">File size limit<small>Max uploaded file size (in MBytes)</small></label>
<input id="text-keyaaa" type="text" name="config[filesize]" value="{$field.config.filesize}" />
