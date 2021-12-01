{*
    Available variables to use in this template:

    {$invoice|@invoice}                     Invoice ID Formatted
    {$invoice.id}                           Invoice DB ID
    {$invoice.status}                       Invoice status
    {$invoice.client_id}                    Invoice Client ID
    {$invoice.date}                         Invoice date
    {$invoice.duedate}                      Invoice Due date
    {$invoice.paybefore}                    Invoice Pay Before date
    {$invoice.datepaid}                     Invoice Date Paid
    {$invoice.subtotal}                     Invoice subtotal
    {$invoice.credit}                       Invoice credit
    {$invoice.tax}                          Invoice tax amount
    {$invoice.taxrate}                      Invoice tax rate
    {$invoice.tax2}                         Invoice tax2 amount
    {$invoice.taxrate2}                     Invoice tax2 rate
    {$invoice.total}                        Invoice total
    {$invoice.order_id}                     Invoice Order ID
    {$invoice.order_number}                 Invoice Order
    {$invoice.items}                        Invoice Items Array
        {$invoice_item.id}                  Invoice Item ID
        {$invoice_item.type}                Invoice Items Type
        {$invoice_item.item_id}             Invoice Item Related ID
        {$invoice_item.description}         Invoice Item Description
        {$invoice_item.amount}              Invoice Item Amount
        {$invoice_item.taxed}               Invoice Item Is Taxed
        {$invoice_item.tax_rate}            Invoice Item Tax rate
        {$invoice_item.tax}                 Invoice Item Tax Amount
        {$invoice_item.qty}                 Invoice Item QTY
    {$invoice.currency}                     Invoice Related Currency Array
        {$invoice.currency.code}            Invoice Related Currency Code
        {$invoice.currency.iso}             Invoice Related Currency ISO
        {$invoice.currency.sign}            Invoice Related Currency Sign
        {$invoice.currency.rate}            Invoice Related Currency Rate
    {$invoice.payment_module_name}          Invoice Payment Module Name
    {$invoice.payment_module}               Invoice Payment Module ID
    {$invoice.type}                         Invoice Type (values: order, renew)

*}

<h3>{$lang.payment_was_not_completed}</h3>
<p>{$lang.payment_was_not_completed_desc}</p>