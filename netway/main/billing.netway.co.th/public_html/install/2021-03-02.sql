REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'ssl_san','Subject Alternative Names' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ssl_dcv','Domain Control Validation' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'sslw_csr','Certificate Signing Request' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ssl_for','For' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ssl_dcv_dns1','Please follow the instructions below to complete the DNS Record Verification Method:' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ssl_dcv_dns2','Open your DNS Manager/Zone' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ssl_dcv_dns3','Create the following record using values below:' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ssl_dcv_http1','Please follow the instructions below to complete the HTTP Verification Method:' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ssl_dcv_http2','Download validation file' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'ssl_dcv_http3','Upload the file on your HTTP(S) server so that it can be publicly accessed at the file URL path listed below:' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'partial_invoice_payment_min','The amount of the partial payment is less than the required minimum' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'partial_invoice_payment_max','The amount of the partial payment is greater than the invoice amount' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'partialpayment','Partial payment' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'specifyamounttopay','Specify amount to pay (partial payment)' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'mipartialpaymentvalue','Minimum partial payment amount' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'payfulldueamount','Pay full due amount' FROM hb_language WHERE target!='admin';
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('PartialInvoicePayment', 'off'), ('PartialInvoicePaymentMinimal', '0');