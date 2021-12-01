{php}
$date_now = date("Y-m-d");
$date_show = '2020-07-29';
$this->assign('date_now',$date_now);
$this->assign('date_show',$date_show);
{/php}

<div class="container-box">
	<div class="container">
	{include file="addthis.tpl"}
		<div class="rv_inpage">
			<div class="contact col-md-12">
				<div class="block marr">
					<h1>Corporate Headquarters</h1><br />
					<div>
						<div class="col-md-4" style="margin-right:10px; height:150px;"><img src="{$template_dir}images/logorvglobalsoft.jpg" alt="RVSkin" width="257" height="93" align="absmiddle" /></div>
						<div class="col-md-7" style="margin-top:10px;"><b>Netway Communication Co.,Ltd.</b><br />
							<p>
								57/25 Village No.9, Bang Phut Sub-district, Pak Kret District, <br>Nonthaburi Province 11120 THAILAND.
								<br /><br />
								Tel: +6620551095
							</p>
							{/if}
							Email: <a href="mailto:marketing@rvglobalsoft.com">Marketing@rvglobalsoft.com</a>
						</div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<div class="clear"></div>
			<div class="col-md-12">
				<div class="col-md-4 block">
					<h5>Business Inquiries</h5>
					<div>Questions about business requirements, products, specifications, pricing &amp; licensing, partnership, marketing, and media inquiry.</div><br />
					<div><a href="mailto:marketing@rvglobalsoft.com" class="c-more">Click here</a></div>
				</div>
				<div class="col-md-4 block">
					<h5>Customer Service Inquiries</h5>
					<div>Questions about reseller accounts,
	registration, operations, and other customer-related issues.</div><br />
					<div><a href="{$ca_url}tickets/new/" class="c-more">Click here</a></div>
				</div>
				<div class="col-md-4 block">
					<h5>Technical Inquiries</h5>
					<div>Questions about technical support,
	troubleshooting, change log, and other technical problems.</div><br />
					<div><a href="{$ca_url}tickets/new/" class="c-more">Click here</a></div>
				</div>
			</div>
	</div>
	</div>
		<div class="clear"></div>
		<br /><br />
</div>


{include file='notificationinfo.tpl'}
