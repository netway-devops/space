{$companylogo}	
{if $invoice.status != 'Paid'}{if $invoice.is_quotation == 4}ใบแจ้งหนี้/Statement{elseif $invoice.is_quotation == 3}ใบส่งของ / Delivery Bill{elseif $invoice.is_quotation == 2}ใบวางบิล / Original Bill Issue{elseif $invoice.is_quotation == 1}ใบเสนอราคา/Quotation{else}ใบสรุปค่าบริการ{/if}{else}{/if}
Order	{$invoice.proforma_id}
{$lang.invoice_date}	{$invoice.date}
{$lang.invoice_due}	{$invoice.duedate}
{$lang.invoice_to}
{if $invoice.billing_contact_id}{$invoice.billing_address|nl2br} {else}{if $client.company == 0}{$client.firstname} {$client.lastname}
{else}{$client.companyname}{/if}
{$client.address1} {$client.address2}
{$client.city}, {$client.state}{$client.postcode}
{$client.country}{/if} 
เลขประจำตัวผู้เสียภาษี: {if $invoice.billing_taxid}{$invoice.billing_taxid}{/if}	{$lang.invoice_from}
บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด
{$invoice.duedate|newaddress}
เลขประจำตัวผู้เสียภาษี: 0135539003143
สำนักงานใหญ่	
{$lang.status}:	{$invoice.status}
{$lang.balance}:	{$transbalance}

{if $invoice.po_number}เลขที่ PO:{/if}	
{$invoice.po_number}
{$lang.invoice_desc} (date format: dd/mm/yyyy)	Quantity	Unit	Unit price	Discount	Net price
{$item.description|invoice_item}	{if $invoice.quantity}{$invoice.quantity}{else}{$item.qty}{/if}	{if $invoice.quantityText}{$invoice.quantityText}{else}{$item.quantity_text}{/if}	{if $item.unit_price!=0.00}{$item.unit_price}{else}{$item.amount}{/if}	{if $item.discount_price}{$item.discount_price}{else}0.00{/if}	{$item.linetotal}
{if $invoice.promotion_code}Promotion code: {$invoice.promotion_code}{/if}	 	 	 	 
{if $client.company == '1'} {assign var="thisTax" value=$invoice.tax|string_format:"%.2f"} {if $thisTax != '0.00'} {if $client.isgovernment == 'Yes'} {assign var="thisTaxX" value=$invoice.tax_wh_1} {assign var="thisTotalTaxX" value=$invoice.total_wh_1} {elseif $invoice.is_tax_wh_15} {assign var="thisTaxX" value=$invoice.tax_wh_15} {assign var="thisTotalTaxX" value=$invoice.total_wh_15} {else} {assign var="thisTaxX" value=$invoice.tax_wh_3} {assign var="thisTotalTaxX" value=$invoice.total_wh_3} {/if}
** กรณีนิติบุคคลหักภาษี ณ ที่จ่าย สามารถหักได้ {if $client.isgovernment == 'Yes'}1{elseif $invoice.is_tax_wh_15}1.5{else}3{/if}% คํานวณจากยอดก่อน vat **
หักภาษี ณ ที่จ่าย {if $client.isgovernment == 'Yes'}1{elseif $invoice.is_tax_wh_15}1.5{else}3{/if}% คือ	{$thisTaxX|string_format:"%.2f"|number_format:2} บาท
รวมค่าบริการทีต้องชําระ คือ	{$thisTotalTaxX|string_format:"%.2f"|number_format:2} บาท
{/if} {/if}	{$lang.subtotal}	{$invoice.subtotal}
Vat ({$invoice.taxrate+0}%)	{$invoice.tax}
{$lang.tax} ({$invoice.taxrate2}%)	{$invoice.tax2}
{$lang.credit}	{$invoice.credit}
{$lang.total}	{$invoice.total}
{$lang.related_trans}
{$lang.trans_date}	{$lang.trans_gtw}	{$lang.trans_id}	{$lang.trans_amount}
{$transaction.date}	{$transaction.module}	{$transaction.trans_id}	{$transaction.amount}
 	 	{$lang.balance}	{$transbalance}
ชื่อบัญชี "บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด"
ธนาคาร	เลขที่บัญชีธนาคาร	ประเภทบัญชี	สาขา	QR Payment
ธนาคาร กรุงเทพ	132-4-73947-1	ออมทรัพย์	บางซื่อ	{$invoice.proforma_id|qrpayment}
 
 
 
ธนาคาร กสิกรไทย	779-2-21214-4	ออมทรัพย์	วงศ์สว่าง ทาวน์ เซ็นเตอร์
ธนาคาร ไทยพาณิชย์	271-2-21268-6	ออมทรัพย์	เซ็นทรัล วงศ์สว่าง
PromptPay	0135539003143	เลขทะเบียนนิติบุคคล 13หลัก	 


หมายเหตุ : ค่าธรรมเนียมในการโอนเงินเป็นความรับผิดชอบของลูกค้า ทางบริษัทฯ จะไม่รับผิดชอบในส่วนนี้ 
สำหรับนิติบุคคลในเขตกรุงเทพฯ และ ปริมณฑล บริษัทฯมีบริการ รับเช็ค วางบิล ในกรณีที่ยอดหน้าเช็คมีมูลค่า 5,000 บาท ขึ้นไป
หากมูลค่าต่ำกว่า 5,000 บาท บริษัทฯ ขอเก็บค่าธรรมเนียมในการดำเนินการ จำนวน 1,000 บาท/ต่อครั้ง

 
หลังจากคุณทําการชําระเงินแล้ว สามารถยืนยันการชําระค่าบริการ ตามวิธีนี้
อีเมล์แจ้งมาที่ payment@netway.co.th
โทรแจ้งเจ้าหน้าที่การเงินที่หมายเลข {$invoice.duedate|newphone} หรือ แฟกซ์สลิปใบโอนเงินมาที่หมายเลข {$invoice.duedate|newfax}
(กรุณาระบุหมายเลข Order หรือ ชื่อโดเมนเนมมาในสลิปใบโอนเงินด้วย)
ที่อยู่สําหรับออกหนังสือรับรองภาษีหัก ณ ที่จ่าย และที่อยู่ในการจัดส่งเอกสาร
บริษัท เน็ตเวย์ คอมมูนิเคชั่น จํากัด {$invoice.duedate|newaddress} 
เลขประจําตัวผู้เสียภาษี 0135539003143
 
** ในกรณีบริษัทฯ ของท่านมีหนังสือรับรองภาษีหัก ณ ที่จ่าย ทางบริษัทฯ ต้องรบกวนท่านส่งเอกสารมาให้ทางเราก่อน 
เมื่อทางบริษัทฯ ได้รับเอกสารแล้ว ทางบริษัทฯ จะดําเนินการส่งใบเสร็จรับเงินให้ท่านทันที **
** เอกสารฉบับนี้ออกโดยระบบดิจิทัล จึงไม่ปรากฏลายเซ็น **	{if $invoice.is_quotation == 2} ผู้รับวางบิล {else} Confirm / ยืนยัน {/if} 

..................................................     ตราประทับ 

วันที่ ....... / ....... / .......