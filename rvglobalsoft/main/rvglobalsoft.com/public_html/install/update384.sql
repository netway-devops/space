UPDATE `hb_language_locales` SET `value`="Account with ID #%s doesn't exist" WHERE `language_id`='1' AND `section`="accounts" AND `keyword`="account_dont_exists";
##########
UPDATE `hb_language_locales` SET `value`="This account package doesn't have addons attached to it yet." WHERE `language_id`='1' AND `section`="accounts" AND `keyword`="noaddons";
##########
UPDATE `hb_language_locales` SET `value`="Integration code for affiliates to incorporate into their websites. Use {$affurl} in referral URLs" WHERE `language_id`='1' AND `section`="affiliates" AND `keyword`="AffIntegration ";
##########
UPDATE `hb_language_locales` SET `value`="Back to News list" WHERE `language_id`='1' AND `section`="announcements" AND `keyword`="backtonews";
##########
UPDATE `hb_language_locales` SET `value`="Hosts allowed" WHERE `language_id`='1' AND `section`="chat" AND `keyword`="allowedhosts";
##########
UPDATE `hb_language_locales` SET `value`="Put this in head section of document, note that chat will only work on hosts you have allowed in list below. This code will also include jquery library, if you're using it, add and nojquery to script SRC." WHERE `language_id`='1' AND `section`="chat" AND `keyword`="embeddescr";
##########
UPDATE `hb_language_locales` SET `value`="Are you sure you want to convert this contact into client profile?" WHERE `language_id`='1' AND `section`="clients" AND `keyword`="convertclientheading";
##########
UPDATE `hb_language_locales` SET `value`="Signups" WHERE `language_id`='1' AND `section`="stats" AND `keyword`="singupbycountrylabel";
##########
UPDATE `hb_language_locales` SET `value`="Field's name and type cannot be empty" WHERE `language_id`='1' AND `section`="clients" AND `keyword`="custempty";
##########
UPDATE `hb_language_locales` SET `value`="Let your customers configure their product during order, gather additional information, bill for product customization" WHERE `language_id`='1' AND `section`="configfields" AND `keyword`="bsdescription";
##########
UPDATE `hb_language_locales` SET `value`="Create new field" WHERE `language_id`='1' AND `section`="configfields" AND `keyword`="createnewcfield";
##########
UPDATE `hb_language_locales` SET `value`="You can offer your customers WHOIS/ID protection for domain purchases. If enabled registrar module adds ID Protection to registered / transferred domain" WHERE `language_id`='1' AND `section`="configfields" AND `keyword`="idprotection-description";
##########
UPDATE `hb_language_locales` SET `value`="Enable your customers to specify quantity of additional configuration items, for example number of IP addresses required" WHERE `language_id`='1' AND `section`="configfields" AND `keyword`="quantity-description";
##########
UPDATE `hb_language_locales` SET `value`="Allowed attachment extension" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="AllowedAttachmentExt";
##########
UPDATE `hb_language_locales` SET `value`="Add PDF Invoice to email notification" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="AttachPDFInvoice_descr";
##########
UPDATE `hb_language_locales` SET `value`="Don't send invoice copies anywhere" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="BCCInvoiceEmails1";
##########
UPDATE `hb_language_locales` SET `value`="Charge automatically stored credit cards" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="CCChargeAuto_dscr";
##########
UPDATE `hb_language_locales` SET `value`="Continue Invoice Creation" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="ContinueInvoices";
##########
UPDATE `hb_language_locales` SET `value`="Don't add late fee" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="LateFeeType0";
##########
UPDATE `hb_language_locales` SET `value`="Run this task once a day - it will schedule upcoming automation events  and execute due ones, based on custom automation queue defined in products" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="TaskScheduler_desc";
##########
UPDATE `hb_language_locales` SET `value`="Change automatically non-renewed domain status to Expired" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="automaticDomainExpire_desc";
##########
UPDATE `hb_language_locales` SET `value`="Attempt to register domains automatically after receiving payment" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="automaticRegisterDomains_desc";
##########
UPDATE `hb_language_locales` SET `value`="Attempt to renew domains automatically after receiving payment" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="automaticRenewDomains_desc";
##########
UPDATE `hb_language_locales` SET `value`="Attempt to transfer domains automatically after receiving payment" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="automaticTransferDomains_desc";
##########
UPDATE `hb_language_locales` SET `value`="Process cancellation requests automatically with Immediate cancellation type" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="cancellationRequests_desc";
##########
UPDATE `hb_language_locales` SET `value`="Attempt to charge stored Credit Cards automatically for due invoices" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="chargeCC_desc";
##########
UPDATE `hb_language_locales` SET `value`="This task attempts to synchronize expiration dates of 10 domains with registrars, from the oldest synchronized domain. For bigger number of domains in HostBill it's good to run this task daily, or weekly." WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="domainSync_desc";
##########
UPDATE `hb_language_locales` SET `value`="Don't send notifications to clients about due payments" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="new_SendPaymentReminderEmails2";
##########
UPDATE `hb_language_locales` SET `value`="Synchronize Pending domains with registrar to check their registration status" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="automaticSynchronizePendingDomains_desc";
##########
UPDATE `hb_language_locales` SET `value`="Generate invoices automatically for services with recurring billing" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="generateInvoices_desc";
##########
UPDATE `hb_language_locales` SET `value`="Calculate prorated amount" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="new_EnableProRata2";
##########
UPDATE `hb_language_locales` SET `value`="You don't have any tasks configured yet" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="notasksyet";
##########
UPDATE `hb_language_locales` SET `value`="If turned off, no emails are sent from HostBill. Useful after migrating from a different system" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="sendeme2";
##########
UPDATE `hb_language_locales` SET `value`="Close tickets non-responded by client automatically after configured amount of time" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="ticketAutoClose_desc";
##########
UPDATE `hb_language_locales` SET `value`="Update conversion rates automatically for used multiple currencies" WHERE `language_id`='1' AND `section`="configuration" AND `keyword`="updateConversionRates_desc";
##########
UPDATE `hb_language_locales` SET `value`="Domain with ID #%s doesn't exist" WHERE `language_id`='1' AND `section`="domains" AND `keyword`="domain_dont_exists";
##########
UPDATE `hb_language_locales` SET `value`="Domain %s transfer process began" WHERE `language_id`='1' AND `section`="domains" AND `keyword`="domain_transfer_beginned";
##########
UPDATE `hb_language_locales` SET `value`="Register a Nameserver's Name" WHERE `language_id`='1' AND `section`="domains" AND `keyword`="registeranameserver";
##########
UPDATE `hb_language_locales` SET `value`="The specified file doesn't exist in downloads folder" WHERE `language_id`='1' AND `section`="downloads" AND `keyword`="file_not_exists";
##########
UPDATE `hb_language_locales` SET `value`="This is just a preview of a template filled with sample data, actual email will be loaded with proper values" WHERE `language_id`='1' AND `section`="emailtemplates" AND `keyword`="thisisjustpreview";
##########
UPDATE `hb_language_locales` SET `value`="Pick one option" WHERE `language_id`='1' AND `section`="estimates" AND `keyword`="pickoneoption";
##########
UPDATE `hb_language_locales` SET `value`="Your current administrator group doesn't allow you to access this cmd/action" WHERE `language_id`='1' AND `section`="global" AND `keyword`="wrong_admingroup";
##########
UPDATE `hb_language_locales` SET `value`="Are you sure you want to stop sharing this ticket?" WHERE `language_id`='1' AND `section`="global" AND `keyword`="unshare_confirm";
##########
UPDATE `hb_language_locales` SET `value`="This module doesn't support the Unsuspended command" WHERE `language_id`='1' AND `section`="global" AND `keyword`="unsuspend_notsupported ";
##########
UPDATE `hb_language_locales` SET `value`="This module doesn't support the Terminate command" WHERE `language_id`='1' AND `section`="global" AND `keyword`="terminate_notsupported";
##########
UPDATE `hb_language_locales` SET `value`="Function isn't supported by this module." WHERE `language_id`='1' AND `section`="global" AND `keyword`="test_not_supported";
##########
UPDATE `hb_language_locales` SET `value`="Ticket Department doesn't exist" WHERE `language_id`='1' AND `section`="global" AND `keyword`="ticketdept_don'texists";
##########
UPDATE `hb_language_locales` SET `value`="This module doesn't support the Suspend command" WHERE `language_id`='1' AND `section`="global" AND `keyword`="suspend_notsupported";
##########
UPDATE `hb_language_locales` SET `value`="You didn't enter a state" WHERE `language_id`='1' AND `section`="global" AND `keyword`="state_error";
##########
UPDATE `hb_language_locales` SET `value`="If you want to reset password again please wait 1 minute before another request." WHERE `language_id`='1' AND `section`="global" AND `keyword`="resetpass_alreadysent2";
##########
UPDATE `hb_language_locales` SET `value`="You didn't enter a password" WHERE `language_id`='1' AND `section`="global" AND `keyword`="password_error";
##########
UPDATE `hb_language_locales` SET `value`="You didn't enter a phone number" WHERE `language_id`='1' AND `section`="global" AND `keyword`="phone_error";
##########
UPDATE `hb_language_locales` SET `value`="You didn't enter a postal code" WHERE `language_id`='1' AND `section`="global" AND `keyword`="postcode_error";
##########
UPDATE `hb_language_locales` SET `value`="Optional extras that you want to offer with this product, with separate billing" WHERE `language_id`='1' AND `section`="global" AND `keyword`="optional_extras";
##########
UPDATE `hb_language_locales` SET `value`="Called method isn't allowed for API access" WHERE `language_id`='1' AND `section`="global" AND `keyword`="method_not_allowed";
##########
UPDATE `hb_language_locales` SET `value`="Your IP is banned for 5 hours due to a third failed attempt log." WHERE `language_id`='1' AND `section`="global" AND `keyword`="ip_banned_login";
##########
UPDATE `hb_language_locales` SET `value`="Are you sure you want to remove this item from order?" WHERE `language_id`='1' AND `section`="global" AND `keyword`="itemremoveconfirm";
##########
UPDATE `hb_language_locales` SET `value`="Your current admin role doesn't  allow you to see this content" WHERE `language_id`='1' AND `section`="global" AND `keyword`="lackpriviliges";
##########
UPDATE `hb_language_locales` SET `value`="Your license is invalid or it hasn't been activated. Please login to the hostbillapp.com clientarea and make sure your domain, IP and path to your installation of HostBill match" WHERE `language_id`='1' AND `section`="global" AND `keyword`="licenseproblem1";
##########
UPDATE `hb_language_locales` SET `value`="Import from WHMCS" WHERE `language_id`='1' AND `section`="global" AND `keyword`="importfromwhmcs";
##########
UPDATE `hb_language_locales` SET `value`="You need to log in firstly,  or use valid token to perform this operation" WHERE `language_id`='1' AND `section`="global" AND `keyword`="invalid_token_foroperation";
##########
UPDATE `hb_language_locales` SET `value`="PHP IMAP extension isn't installed, POP import method won't be working" WHERE `language_id`='1' AND `section`="global" AND `keyword`="imap_not_installed";
##########
UPDATE `hb_language_locales` SET `value`="Allows you to gather additional information from client regarding ordered product." WHERE `language_id`='1' AND `section`="global" AND `keyword`="extra_fields_info";
##########
UPDATE `hb_language_locales` SET `value`="Filter is active, some data may be omitted - reset filter" WHERE `language_id`='1' AND `section`="global" AND `keyword`="filterisactive";
##########
UPDATE `hb_language_locales` SET `value`="Enter your activation code below to activate the HostBill copy." WHERE `language_id`='1' AND `section`="global" AND `keyword`="enteractivationcode";
##########
UPDATE `hb_language_locales` SET `value`="Requested command wasn't recognized by HostBill: %s" WHERE `language_id`='1' AND `section`="global" AND `keyword`="command_not_recognized";
##########
UPDATE `hb_language_locales` SET `value`="This module doesn't support the Create command" WHERE `language_id`='1' AND `section`="global" AND `keyword`="create_notsupported";
##########
UPDATE `hb_language_locales` SET `value`="Your CRON job for HostBill doesn't seem to be working, please verify" WHERE `language_id`='1' AND `section`="global" AND `keyword`="cronnotwork";
##########
UPDATE `hb_language_locales` SET `value`="Your ClientExec version [%s] isn't supported yet. Versions supported are from %s to %s" WHERE `language_id`='1' AND `section`="global" AND `keyword`="cexec_wrongversion";
##########
UPDATE `hb_language_locales` SET `value`="You didn't enter a city" WHERE `language_id`='1' AND `section`="global" AND `keyword`="city_error";
##########
UPDATE `hb_language_locales` SET `value`="Specified input parameters combination isn't allowed for API access" WHERE `language_id`='1' AND `section`="global" AND `keyword`="api_param_notallowed";
##########
UPDATE `hb_language_locales` SET `value`="Attachment delete %s failed" WHERE `language_id`='1' AND `section`="global" AND `keyword`="attachment_delete_fail";
##########
UPDATE `hb_language_locales` SET `value`="You didn't enter address (line 1)" WHERE `language_id`='1' AND `section`="global" AND `keyword`="address_error";
##########
UPDATE `hb_language_locales` SET `value`="Please select packages of accounts you want to add to the HostBill" WHERE `language_id`='1' AND `section`="importaccounts" AND `keyword`="importplease1";
##########
UPDATE `hb_language_locales` SET `value`="There is no product with this package in HostBill. You must create new product." WHERE `language_id`='1' AND `section`="importaccounts" AND `keyword`="thereisnoproductsinhb";
##########
UPDATE `hb_language_locales` SET `value`="Invoice #%s marked Cancelled" WHERE `language_id`='1' AND `section`="invoices" AND `keyword`="inv_markedcancelled";
##########
UPDATE `hb_language_locales` SET `value`="You've set start date of recurring invoices for today – the first invoice will be generated NOW, are you sure?" WHERE `language_id`='1' AND `section`="invoices" AND `keyword`="invoicerecurrnow";
##########
UPDATE `hb_language_locales` SET `value`="This module doesn't support credit card charges" WHERE `language_id`='1' AND `section`="invoices" AND `keyword`="notsupport_cc";
##########
UPDATE `hb_language_locales` SET `value`="Pick one option" WHERE `language_id`='1' AND `section`="invoices" AND `keyword`="pickoneoption";
##########
UPDATE `hb_language_locales` SET `value`="Start date must be today or later" WHERE `language_id`='1' AND `section`="invoices" AND `keyword`="start_from_issue";
##########
UPDATE `hb_language_locales` SET `value`="Knowledgebase articles are organized by categories so your clients can find more easily what they are looking for" WHERE `language_id`='1' AND `section`="knowlegebase" AND `keyword`="blank_kb_desc";
##########
UPDATE `hb_language_locales` SET `value`="There are entries marked for deletion, continue?" WHERE `language_id`='1' AND `section`="langedit" AND `keyword`="lang_confirmtrans";
##########
UPDATE `hb_language_locales` SET `value`="Couldn't add new translation, Keyword:%s too long" WHERE `language_id`='1' AND `section`="langedit" AND `keyword`="newtranslation_faild";
##########
UPDATE `hb_language_locales` SET `value`="Currently you don't have any active modules of this type. Activate one of many modules HostBill offers in \"Inactive\" tab" WHERE `language_id`='1' AND `section`="managemodules" AND `keyword`="blank_mm_desc";
##########
UPDATE `hb_language_locales` SET `value`="Callback URL" WHERE `language_id`='1' AND `section`="managemodules" AND `keyword`="callbackurl";
##########
UPDATE `hb_language_locales` SET `value`="Ban this IP" WHERE `language_id`='1' AND `section`="orders" AND `keyword`="banthisip";
##########
UPDATE `hb_language_locales` SET `value`="Can't get period values for this TLD" WHERE `language_id`='1' AND `section`="orders" AND `keyword`="cantgetperiods";
##########
UPDATE `hb_language_locales` SET `value`="Add new category" WHERE `language_id`='1' AND `section`="predefined" AND `keyword`="addnewcategory";
##########
UPDATE `hb_language_locales` SET `value`="Terminate addon automatically after cancellation request is placed" WHERE `language_id`='1' AND `section`="productaddons" AND `keyword`="new_AutoProcessCancellations1";
##########
UPDATE `hb_language_locales` SET `value`="Autosuspend addon after" WHERE `language_id`='1' AND `section`="productaddons" AND `keyword`="new_EnableAutoSuspension1";
##########
UPDATE `hb_language_locales` SET `value`="Don't suspend addon automatically" WHERE `language_id`='1' AND `section`="productaddons" AND `keyword`="new_EnableAutoSuspension3";
##########
UPDATE `hb_language_locales` SET `value`="Terminate addon automatically after" WHERE `language_id`='1' AND `section`="productaddons" AND `keyword`="new_EnableAutoTermination1";
##########
UPDATE `hb_language_locales` SET `value`="Don't terminate addon automatically" WHERE `language_id`='1' AND `section`="productaddons" AND `keyword`="new_EnableAutoTermination3";
##########
UPDATE `hb_language_locales` SET `value`="Unsuspend addon automatically after receiving due payment" WHERE `language_id`='1' AND `section`="productaddons" AND `keyword`="new_EnableAutoUnSuspension1";
##########
UPDATE `hb_language_locales` SET `value`="Don't unsuspend addon automatically" WHERE `language_id`='1' AND `section`="productaddons" AND `keyword`="new_EnableAutoUnSuspension2";
##########
UPDATE `hb_language_locales` SET `value`="To start configuring servers and services configure modules you'll be using" WHERE `language_id`='1' AND `section`="root" AND `keyword`="tostartconfigservers";
##########
UPDATE `hb_language_locales` SET `value`="Selected API access ID/key has been removed" WHERE `language_id`='1' AND `section`="security" AND `keyword`="api_access_removed";
##########
UPDATE `hb_language_locales` SET `value`="New API access ID/key generated" WHERE `language_id`='1' AND `section`="security" AND `keyword`="new_api_access_added";
##########
UPDATE `hb_language_locales` SET `value`="Do you really want to send message without any text in the body?" WHERE `language_id`='1' AND `section`="sendmessage" AND `keyword`="withoutbody";
##########
UPDATE `hb_language_locales` SET `value`="Do you really want to send message without a subject?" WHERE `language_id`='1' AND `section`="sendmessage" AND `keyword`="withoutsubject";
##########
UPDATE `hb_language_locales` SET `value`="Can't create server without selecting application" WHERE `language_id`='1' AND `section`="servers" AND `keyword`="pick_app_first";
##########
UPDATE `hb_language_locales` SET `value`="Add price" WHERE `language_id`='1' AND `section`="servers" AND `keyword`="addprice";
##########
UPDATE `hb_language_locales` SET `value`="Terminate account automatically after cancellation request is placed" WHERE `language_id`='1' AND `section`="servers" AND `keyword`="new_AutoProcessCancellations1";
##########
UPDATE `hb_language_locales` SET `value`="Don't suspend account automatically" WHERE `language_id`='1' AND `section`="servers" AND `keyword`="new_EnableAutoSuspension3";
##########
UPDATE `hb_language_locales` SET `value`="Terminate automatically account after" WHERE `language_id`='1' AND `section`="servers" AND `keyword`="new_EnableAutoTermination1";
##########
UPDATE `hb_language_locales` SET `value`="Don't terminate account automatically" WHERE `language_id`='1' AND `section`="servers" AND `keyword`="new_EnableAutoTermination3";
##########
UPDATE `hb_language_locales` SET `value`="Don't unsuspend account automatically" WHERE `language_id`='1' AND `section`="servers" AND `keyword`="new_EnableAutoUnSuspension2";
##########
UPDATE `hb_language_locales` SET `value`="New addon" WHERE `language_id`='1' AND `section`="servers" AND `keyword`="nonewaddon";
##########
UPDATE `hb_language_locales` SET `value`="HostBill divides products into Order Pages. Each page can present different style and behavior.You can allow clients to configure their product in one or few steps; you can also offer them a quote." WHERE `language_id`='1' AND `section`="servers" AND `keyword`="orpage_blank1_desc";
##########
UPDATE `hb_language_locales` SET `value`="Tickets haven't been read yet" WHERE `language_id`='1' AND `section`="states" AND `keyword`="tc_active_unread";
##########
UPDATE `hb_language_locales` SET `value`="of %d possible income" WHERE `language_id`='1' AND `section`="states" AND `keyword`="o_pending_small";
##########
UPDATE `hb_language_locales` SET `value`="Are you sure you want to remove this task?" WHERE `language_id`='1' AND `section`="tasklist" AND `keyword`="task_remove_confirm";
##########
UPDATE `hb_language_locales` SET `value`="Note: Taxing is currently disabled; changes made here won't affect frontend." WHERE `language_id`='1' AND `section`="taxconfig" AND `keyword`="taxdisabled";
##########
UPDATE `hb_language_locales` SET `value`="Take additional actions" WHERE `language_id`='1' AND `section`="ticketbans" AND `keyword`="blank_post_header";
##########
UPDATE `hb_language_locales` SET `value`="With the use of macros and filters you can automatically set things like assigned staff member, tags, priority and more, to new tickets." WHERE `language_id`='1' AND `section`="ticketbans" AND `keyword`="blank_post_desc";
##########
UPDATE `hb_language_locales` SET `value`="Filters with final option will stop HostBill from checking other filters if they are matched, that means filters after this one won't get a chance to apply their functions." WHERE `language_id`='1' AND `section`="ticketbans" AND `keyword`="final_desc";
##########
UPDATE `hb_language_locales` SET `value`="SLA (Service Level Agreement) is an agreement you can offer to meet certain standards in your support quality. SLA set for 15 minutes in HostBill means
that if ticket isn't answered within 15 minutes it will be considered as overdue, and escalated. Additionally you can set time in which ticket should be closed (resolved) by a staff member" WHERE `language_id`='1' AND `section`="ticketdeps" AND `keyword`="blanksla";
##########
UPDATE `hb_language_locales` SET `value`="You have to specify a valid URL to another Help Desk that can support ticket sharing e.g. http://hostbill.com/sharing/" WHERE `language_id`='1' AND `section`="ticketshare" AND `keyword`="sharingurl_desc";
##########
UPDATE `hb_language_locales` SET `value`="Helpdesk URL" WHERE `language_id`='1' AND `section`="ticketshare" AND `keyword`="url";
##########
UPDATE `hb_language_locales` SET `value`="Add new TLD" WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="addtld";
##########
UPDATE `hb_language_locales` SET `value`="Supplied TLD(s) exist(s)" WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="already_there";
##########
UPDATE `hb_language_locales` SET `value`="Edit TLD" WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="edtld";
##########
UPDATE `hb_language_locales` SET `value`="Attempt to register domains automatically after receiving payment" WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="new_EnableAutoRegisterDomain1";
##########
UPDATE `hb_language_locales` SET `value`="Generate invoice for domain renewals and renew domain automatically once paid." WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="new_EnableAutoRenewDomain1";
##########
UPDATE `hb_language_locales` SET `value`="Attempt to transfer domains automatically after receiving payment" WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="new_EnableAutoTransferDomain1";
##########
UPDATE `hb_language_locales` SET `value`="TLD added" WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="tld_added";
##########
UPDATE `hb_language_locales` SET `value`="TLD order changed" WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="tld_order_changed";
##########
UPDATE `hb_language_locales` SET `value`="TLD removed" WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="tld_removed";
##########
UPDATE `hb_language_locales` SET `value`="TLD %s updated" WHERE `language_id`='1' AND `section`="tldprices" AND `keyword`="tld_updated";
##########
UPDATE `hb_language_locales` SET `value`="Similar group exists" WHERE `language_id`='1' AND `section`="tldprice" AND `keyword`="thisgroupexists";
##########
UPDATE `hb_language_locales` SET `value`="Credit has been added" WHERE `language_id`='1' AND `section`="transactions" AND `keyword`="credit_added";