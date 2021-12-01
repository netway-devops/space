<div class="table-box1 step0">
	<!--#####################SSL-Subject Alternative Names######################-->
	{if $service.symantec_status != 'WAITING_SUBMIT_CSR' && $supportSan && $sanList}
	<div style="width:40%;">
	    <div class="table-header">
	        <p>Subject Alternative Names</p>
	    </div>
	    {assign var=count value=1}
	    <table class="table table-striped account-details-tb tb-sh">
	        {foreach from=$sanList item=eachSan}
	            {if $eachSan != ''}
	            <tr>
	                <td class="w30">{$count++}.</td>
	                <td class="cell-border no-bold">{$eachSan}</td>
	            </tr>
	            {/if}
	        {/foreach}
	    </table>
	</div>
	{/if}
	<!--#END#################SSL-Subject Alternative Names######################-->
	<!--#####################SSL-Message About Your Order######################-->
	{if false && $service.ssl_validation_id != 1 && $service.symantec_status != 'COMPLETED' && $service.authority_orderid != '' && isset($service.order_info.AuthenticationComments)}
	<h4>Message about your order</h4>
	<table class="table table-striped account-details-tb tb-sh">
	    <tr>
	        <th width="30%" class="ssl-information-head">Date</th>
	        <th width="70%" class="ssl-information-head">Message</th>
	    </tr>
	    {foreach from=$service.order_info.AuthenticationComments item=eachAuth}
	        <tr>
	            <td>{$eachAuth.TimeStamp}</td>
	            <td class="cell-border no-bold">{$eachAuth.Message}</td>
	        </tr>
	    {/foreach}
	</table>
	{/if}
	<!--#END#################SSL-Message About Your Order######################-->
	<!--#####################SSL-Authentication Step######################-->
	{if $service.ssl_validation_id != 1 && $service.authority_orderid != ''}
	<h4>Authentication Step</h4>
	<table class="table table-striped account-details-tb tb-sh">
	    <tr>
	        <th width="33%" class="ssl-information-head"></th>
	        <th width="33%" class="ssl-information-head">Status</th>
	        <th width="33%" class="ssl-information-head">Last Updated</th>
	    </tr>
	    {foreach from=$service.order_info.AuthenticationStatus item=eachAuth}
	        <tr>
	            <td>{$eachAuth.AuthenticationStep}</td>
	            <td class="cell-border no-bold">{$eachAuth.Status}</td>
	            <td class="cell-border no-bold">{if $eachAuth.LastUpdated != ''}{$eachAuth.LastUpdated}{else}-{/if}</td>
	        </tr>
	    {/foreach}
	</table>
	{/if}
	<!--#END#################SSL-Authentication Step######################-->
	<!--#####################SSL-CSR Information######################-->
	{if $service.status == 'Active' && $service.symantec_status == 'COMPLETED'}
	<div class="ssl-information-div">
	    <h4>CSR Information</h4>
	</div>
	<table class="table table-striped account-details-tb tb-sh">
	    <tr>
	        <td class="ssl-information-head">Common Name</td>
	        <td class="ssl-information-head">Organization</td>
	        <td class="ssl-information-head">Organization Unit</td>
	        <td class="ssl-information-head">Location</td>
	        <td class="ssl-information-head">State/Province</td>
	        <td class="ssl-information-head">Country</td>
	    </tr>
	    <tr>
	        <td class="no-bold ssl-information-td">{$service.csrInfo.CommonName}</td>
	        <td class="no-bold ssl-information-td">{$service.csrInfo.Organization}</td>
	        <td class="no-bold ssl-information-td">{$service.csrInfo.OrganizationUnit}</td>
	        <td class="no-bold ssl-information-td">{$service.csrInfo.Locality}</td>
	        <td class="no-bold ssl-information-td">{$service.csrInfo.State}</td>
	        <td class="no-bold ssl-information-td">{$service.csrInfo.Country}</td>
	    </tr>
	</table>
	{/if}
	<!--#END#################SSL-CSR Information######################-->
	<!--#####################SSL-Organization Information######################-->
	{if $service.ssl_validation_id != 1 && $service.symantec_status != 'WAITING_SUBMIT_CSR'}
	<div class="ssl-information-div">
	    <h4>Organization Information</h4>
	</div>
	<table class="table table-striped account-details-tb tb-sh">
	    <tr>
	        <td class="ssl-information-head">Organization Name</td>
	        <td class="ssl-information-head">Phone Number</td>
	        <td class="ssl-information-head">Address</td>
	        <td class="ssl-information-head">City</td>
	        <td class="ssl-information-head">State/Province</td>
	        <td class="ssl-information-head">Country</td>
	        <td class="ssl-information-head">Postal Code</td>
	    </tr>
	    <tr>
	        <td class="no-bold ssl-information-td">{$contactInfo.organize.organization_name}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.organize.telephone}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.organize.address}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.organize.city}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.organize.state}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.organize.country}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.organize.postal_code}</td>
	    </tr>
	</table>
	{/if}
	<!--#END#################SSL-Organization Information######################-->
	<!--#####################SSL-Admin & Tech Contact######################-->
	{if false}
	<table class="table table-striped account-details-tb tb-sh">
	    <tr>
	        <td width="50%">
	            <div class="table-header">
	                <p>Admin Contact</p>
	            </div>
	            <table class="table table-striped account-details-tb tb-sh">
	                <tr>
	                    <td width="30%">First Name</td>
	                    <td width="70%" class="cell-border no-bold">{$contactInfo.admin.firstname}</td>
	                </tr>
	                <tr>
	                    <td>Last Name</td>
	                    <td class="cell-border no-bold">{$contactInfo.admin.lastname}</td>
	                </tr>
	                <tr>
	                    <td>Email Address</td>
	                    <td class="cell-border no-bold">{$contactInfo.admin.email_approval}</td>
	                </tr>
	                <tr>
	                    <td>Job Title</td>
	                    <td class="cell-border no-bold">{$contactInfo.admin.job}</td>
	                </tr>
	                <tr>
	                    <td>Telephone Number</td>
	                    <td class="cell-border no-bold">{$contactInfo.admin.telephone}</td>
	                </tr>
	                <tr>
	                    <td>Ext. Number</td>
	                    <td class="cell-border no-bold">{if $contactInfo.admin.ext_number != ''}{$contactInfo.admin.ext_number}{else}-{/if}</td>
	                </tr>
	            </table>
	        </td>
	        <td width="50%">
	            <div class="table-header">
	                <p>Technical Contact</p>
	            </div>
	            <table class="table table-striped account-details-tb tb-sh">
	                <tr>
	                    <td width="30%">First Name</td>
	                    <td width="70%" class="cell-border no-bold">{$contactInfo.tech.firstname}</td>
	                </tr>
	                <tr>
	                    <td>Last Name</td>
	                    <td class="cell-border no-bold">{$contactInfo.tech.lastname}</td>
	                </tr>
	                <tr>
	                    <td>Email Address</td>
	                    <td class="cell-border no-bold">{$contactInfo.tech.email_approval}</td>
	                </tr>
	                <tr>
	                    <td>Job Title</td>
	                    <td class="cell-border no-bold">{$contactInfo.tech.job}</td>
	                </tr>
	                <tr>
	                    <td>Telephone Number</td>
	                    <td class="cell-border no-bold">{$contactInfo.tech.telephone}</td>
	                </tr>
	                <tr>
	                    <td>Ext. Number</td>
	                    <td class="cell-border no-bold">{if $contactInfo.tech.ext_number != ''}{$contactInfo.tech.ext_number}{else}-{/if}</td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	{elseif $service.symantec_status != 'WAITING_SUBMIT_CSR'}
	<div class="ssl-information-div">
	    <h4>Admin Contact</h4>
	</div>
	<table class="table table-striped account-details-tb tb-sh">
	    <tr>
	        <td class="ssl-information-head">First Name</td>
	        <td class="ssl-information-head">Last Name</td>
	        <td class="ssl-information-head">Email Address</td>
	        <td class="ssl-information-head">Job Title</td>
	        <td class="ssl-information-head">Telephone Number</td>
	        <td class="ssl-information-head">Ext. Number</td>

	    </tr>
	    <tr>
	        <td class="no-bold ssl-information-td">{$contactInfo.admin.firstname}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.admin.lastname}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.admin.email_approval}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.admin.job}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.admin.telephone}</td>
	        <td class="no-bold ssl-information-td">{if $contactInfo.admin.ext_number != ''}{$contactInfo.admin.ext_number}{else}-{/if}</td>
	    </tr>
	</table>
	<div class="ssl-information-div">
	    <h4>Technical Contact</h4>
	</div>
	<table class="table table-striped account-details-tb tb-sh">
	    <tr>
	        <td class="ssl-information-head">First Name</td>
	        <td class="ssl-information-head">Last Name</td>
	        <td class="ssl-information-head">Email Address</td>
	        <td class="ssl-information-head">Job Title</td>
	        <td class="ssl-information-head">Telephone Number</td>
	        <td class="ssl-information-head">Ext. Number</td>

	    </tr>
	    <tr>
	        <td class="no-bold ssl-information-td">{$contactInfo.tech.firstname}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.tech.lastname}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.tech.email_approval}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.tech.job}</td>
	        <td class="no-bold ssl-information-td">{$contactInfo.tech.telephone}</td>
	        <td class="no-bold ssl-information-td">{if $contactInfo.tech.ext_number != ''}{$contactInfo.tech.ext_number}{else}-{/if}</td>
	    </tr>
	</table>
	{/if}
	<!--#END#################SSL-Admin & Tech Contact######################-->
</div>