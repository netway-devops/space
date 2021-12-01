UPDATE hb_oslicenses l
JOIN hb_invoice_items i ON i.id=l.invoice_item AND i.`type`='OSLicense'
JOIN hb_invoices b ON b.id=i.invoice_id
SET l.flag = l.flag | 4
WHERE b.`status`='Paid';