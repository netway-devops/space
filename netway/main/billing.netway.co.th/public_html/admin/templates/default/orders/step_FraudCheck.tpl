{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'orders/step_FraudCheck.tpl.php');
{/php}

{if $fraud_out}
    {if is_array($fraud_out)}
    <table width="100%" cellpadding="2" cellspacing="0">
        {foreach from=$fraud_out item=f key=k name=checker}
            {if $smarty.foreach.checker.index%3=='0'}<tr>{/if}
            {if $k!='explanation'} <td width="16%" align="right"><strong>{$k}</strong></td><td width="16%" align="left">{$f}</td>{/if}
            {if $smarty.foreach.checker.index%3=='5'}</tr>{/if}
        {/foreach}
    </table>
        {if $fraud_out.explanation}
            <b>{$lang.Explanation}: </b>
            {$fraud_out.explanation}
        {/if}
    {else $fraud_out}
        <b>{$lang.Explanation}: </b>
        {$fraud_out}
    {/if}
{else}
    {if $step.status=='Failed'}
        <span class="info-failed">Step was marked as Failed, which means order is probably fraudulent.</span> <br/>
        If automated fraud verification was wrong you can change it as complete using button below.<br/><br/>
        <a class="menuitm " href="?cmd=orders&action=executestep&step=FraudCheck&order_id={$details.id}&security_token={$security_token}&skip=true" onclick="return confirm('Are you sure?');"><span>Mark Fraud Prevention as Complete (not fraud)</span></a>
        <br/><br/>


    {/if}
    {if $details.fraud}
        {foreach from=$details.fraud item=fro name=loop}
            {if !$smarty.foreach.loop.first}</br>
            {/if}
            {if $fro.module}
                {if $details.status=='Fraud'}
                    <div class="bigger" style="margin-bottom:10px;">
                        <strong>{$fro.name}</strong>
                         - <strong>
                        {if $details.fraudout[$fro.module].riskScore}
                            {$lang.fraudscore}: <span style="color:#{if $smarty.foreach.loop.last}FF00{else}00CC{/if}00">{$details.fraudout[$fro.module].riskScore}%</span>
                        {else}
                            {if $smarty.foreach.loop.last}<span style="color:#FF0000">Failed</span>
                            {else}<span style="color:#00CC00">Pass</span>
                            {/if}
                        {/if}
                        </strong>
                    </div>

                    <div style="padding:5px;font-size:11px;" >
                        {if $details.fraudout[$fro.module]}
                            {include file="orders/step_FraudCheck.tpl" fraud_out=$details.fraudout[$fro.module]}
                        {else}
                            {include file="orders/step_FraudCheck.tpl" fraud_out=$fro.output}
                        {/if}
                    </div>
                {else}
                    <div class="bigger" style="margin-bottom:10px;">
                        <strong>{$fro.name}</strong>
                         - <strong>
                        {if $details.fraudout[$fro.module].riskScore}
                            {$lang.fraudscore}: <span style="color:#00CC00">{$details.fraudout[$fro.module].riskScore}%</span>
                        {else}
                            <span style="color:#00CC00">Pass</span>
                        {/if}
                        </strong>
                        <a href="#" onclick="$('#frauddetails{$fro.module}').show();
                         ajax_update('?cmd=orders&action=frauddetails&fraudmodule={$fro.module}&id={$details.id}',{literal} {}{/literal}, '#frauddetails{$fro.module}', true);
                         $(this).hide();
                         return false;">{$lang.getdetailedinfo} </a>
                    </div>
                    <div style="padding:5px;display:none;font-size:11px;" id="frauddetails{$fro.module}" ></div>
                {/if}
            {else}
                {if $step.output}
                    <span class="info-success">{$step.output}</span>
                {else}
                    <div class="bigger" style="margin-bottom:10px;"><strong>No fraud prevention module is active</strong></div>
                {/if}
            {/if}
        {/foreach}
     {else}
        {if $step.output}
            <span >{$step.output}</span>
            {/if}
    {/if}


    {if $step.status=='Failed'}
    
        {if $aFraud.moduleName == 'hostingfree_fraudprotection'}
        
        <div id="fraudArea" class="ticketmsg ticketmain">
            
    
            <table border="0" cellpadding="2" cellspacing="2" class="bgWhite">
            <tr>
                <td>
                    Upload เอกสารสำเนาบัตรประจำตัวประชาชน<br />
                    {if $aFraud.cfvidcard}<a href="../attachments/{$aFraud.cfvidcard}" target="_blank">{$aFraud.cfvidcard}</a>{/if}<br />
                    <input type="text" id="idcardFile" name="idcardFile" value="{$aFraud.cfvidcard}" placeholder="--- ยังไม่มี idcard file ---" readonly="readonly" style="width: 270px;" />
                    <div id="fileUploaderIDCard"></div>
                </td>
            </tr>
            </table>
            
            
            {literal}
            <script language="JavaScript">
            $(document).ready( function () {
                
                var uploaderIDCard  = new qq.FileUploader({
                    element: document.getElementById('fileUploaderIDCard'),
                    action: '?cmd=fulfillmenthandle&action=upload',
                    params: {},
                    uploadButtonText: 'Upload',
                    onComplete: function(id, fileName, responseJSON){
                        var idcardFile  = responseJSON.filename;
                        $('#idcardFile').val(idcardFile);
                        
                        $('div#fraudArea').addLoader();
                        $.post('?cmd=clienthandle&action=updateCustomfield', {
                            clientId    : {/literal}{$details.client_id}{literal},
                            field       : 'idcard',
                            value       : idcardFile
                        }, function (result) {
                            $('#preloader').remove();
                            document.location = '?cmd=orders&action=executestep&step=FraudCheck&order_id={/literal}{$details.id}{literal}&security_token={/literal}{$security_token}{literal}&skip=true';
                        });
                        
                    }
                });
                
            });
            </script>
            {/literal}
            
        </div>
        
        {else}
        
        <span class="info-failed">Step was marked as Failed, which means order is probably fraudulent.</span> <br/>
        If automated fraud verification was wrong you can change it as complete using button below.<br/><br/>
        <a class="menuitm " href="?cmd=orders&action=executestep&step=FraudCheck&order_id={$details.id}&security_token={$security_token}&skip=true" onclick="return confirm('Are you sure?');"><span>Mark Fraud Prevention as Complete (not fraud)</span></a>
        <br/><br/>
        {/if}

    {/if}


{/if}