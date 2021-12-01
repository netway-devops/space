{if $bdstats}

<div class="wbox">
			<div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
			<div class="wbox_content">
                            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker table table-striped">
                               {if $bdstats.bandwidth} <tr>
                                <td width="160" align="right">{$lang.monthlybandwidth}</td>
                                <td style="font:10px Verdana,sans-serif">
									<div style="width:120px;">
										{$bdstats.bandwidth.usage} / {if $bdstats.bandwidth.limit=='unlimited'}&#8734;{else}{$bdstats.bandwidth.limit}MB{/if}<br />
										<div style="position:relative;width:100%;height:10px;border:1px solid #CCCCCC">
											<div style="position:absolute;background:#3fa0cf;height:10px;width:{$bdstats.bandwidth.ratio}%"></div>
										</div>
									</div>
								</td>
                                </tr> {/if}
                                {if $bdstats.disk} <tr>
                                <td width="160" align="right">{$lang.diskspaceusage}</td>
                                <td style="font:10px Verdana,sans-serif">
									<div style="width:120px;">
									{$bdstats.disk.usage} / {if $bdstats.disk.limit=='unlimited'}&#8734;{else}{$bdstats.disk.limit}MB{/if}<br />
									<div style="position:relative;width:100%;height:10px;border:1px solid #CCCCCC">
										<div style="position:absolute;background:#3fa0cf;height:10px;width:{$bdstats.disk.ratio}%"></div>
									</div>
									</div>
								</td>
                                </tr> {/if}
                            </table>
                        </div>
                      </div>
{/if}