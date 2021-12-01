<div class="box-product noactive" style="height: auto; min-height: 10px; margin-bottom: 2px; width: 100% !important">
					<div class="box-product-in">
						<div class="box-bell-top"><div></div></div>
							<div class="box-border1">
								<div class="box-border2">
									<div class="fix box-describe-con">
										<div class="box-head" style="text-align: center;">
											<ul class="hidden-list-dots">
												<li>{$responseTitle} #Ticket Id: {$ticketId}</li>
											</ul>
											
											<span></span>
											
										</div>
											{if $gFormData}
												<table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="5">
												    <tbody>
												        {foreach from=$gFormData key=k item="items"}
													        <tr class="tdGray2">
													            <td style="padding-left: 20px;"><strong>{$k}</strong></td>
													            <td>&nbsp;</td>
													            <td class="mrow1">
													                &nbsp;
													            </td>
													        </tr>
												        <tr>
												            <td colspan="3" class="mrow1" style="padding-left: 20px; line-height: 1.2em;">
												                <label>
												                	{if $k == 'urltoedit'}
												                		{assign var=linktodata value=$items}
												                		{$items}
												                	{else}
												                		{$items}
												                	{/if}
												                </label>
												            </td>
												        </tr>
												        {/foreach}
												            	
												    </tbody>
												    </table>
											{else}
												{if $isGForm}
													<script> $('#tosubmitGForm2').html('กรุณากรอก '+$('#tosubmitGForm').html()); </script>
													<p align="center" style="padding:15px; color: gray;">--- ไม่พบ {$responseTitle} #Ticket Id: {$ticketId} นี้ ---</p>
													<p align="center" style="padding:15px; color: gray;" id="tosubmitGForm2" ></p>
												{else}
													<p align="center" style="padding:15px; color: gray;">--- ไม่พบ Google Form ของ Fulfillment นี้ ---</p>
												{/if}
											{/if}			    
									<div class="button-con">
										{if $linktodata}<span style="cursor: pointer" onclick="openLink('{$linktodata}')">แก้ไข</span>{/if}
									</div>
								</div> 				
							</div> 				
						</div>
					</div> 				
				</div>
{literal}
<script>
	function openLink(link){
		window.open(link,'_blank');
	}
</script>
{/literal}
