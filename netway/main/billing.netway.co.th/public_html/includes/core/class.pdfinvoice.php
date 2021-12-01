<?php

/* Class to get easly Invoice in PDF
 * USES: TCPDF Class
 *
 * Create with:
 * - new PDFInvoice( $id )
 *
 * Contains:
 * - Header : Business_name, invoice_id , invoice_date, due_date
 * - Info: Your_address, Customer_address, Status and if Paid, paid_status
 * - Items: Items and Summary
 * - Transactions: Transactions
 *
 * WARNING 
 *
 * Changing contents below requires PHP programming skills and you're editing this file on YOUR OWN RISK.
 * Bear in mind that HostBill will not be responsible for any damages caused by editing this file.
 * Fixing issues caused by non-professional changes are not performed by HostBill support team for free.
 *
 * 
 */

class PDFInvoice extends corePDF {
    /*
     * SIMPLE OPTIONS
     */

    protected $config = array(
        /*
         * COLORS:
         *
         * format: 'R, G, B', ex: '255,0,0'
         * default: if you want to use default
         *          please leave field empty, for ex:
         *          'companynamecolor' => ''
         */

        'companynamecolor' => '48,47,40', // if displayed - companyname color (on the top)
        'invidcolor' => '104,104,104', // color of invoice id (main number on the top of invoice)
        'invinfo_titlescolor' => '48,47,40', // invoice info titles color - To, From, Status
        'items_tablecolor' => '239,239,239', // Items table color
        'items_tableheadcolor' => '48,47,40', // Items table titles color - Description, Taxed, Qty, Unit Cost and Price
        'trans_tablecolor' => '239,239,239', // Transaction table color
        'trans_tableheadcolor' => '48,47,40', // Transaction table titles color - Transaction Date, Gateway, Transaction ID, Amount
        'notes_headercolor' => '48,47,40', // Notes title color


        /*
         * DISPLAY SETTINGS:
         *
         * format:  true or false
         * default: for default every field is set to TRUE
         *
         *
         */


        'displayimage' => true, // displays image if exists
        'top_displayinvid' => true, // display invoice id (top right corner)
        'top_displayinvdate' => true, // display invoice date (top right corner)
        'top_displayduedate' => true, // display due date (top right corner)

        'toinfo_name' => true, // display clients name
        'toinfo_address1' => true, // display clients address 1
        'toinfo_address2' => true, // display clients address 2
        'toinfo_city' => true, // display clients city
        'toinfo_state' => true, // display clients state
        'toinfo_zip' => true, // display clients postalcode
        'toinfo_country' => true, // display clients country
        'toinfo_extra' => true, // display clients extra info

        'items_displaytax' => true, // display Tax in items table
        'items_displayunitcost' => true, // display Unit Cost in items table
        'items_displayqty' => true, // display Qty in items table

        'display_subtotal' => true, // display subtotal
        'display_credit' => true, // display credit
        'display_taxrate1' => true, // display taxrate 1
        'display_taxrate2' => true, // display taxrate 2

        'show_transactions' => true, // show transaction table
        'show_notes' => true, // show notes (if not empty)
        'show_footer' => true, // show footer (if not empty)
        'font' => 'default', //set custom font name for pdf invoices, use default for standard
        'fontsize' => 10     //default font size
    );

    /*
     * ***********************
     * END OF SIMPLE OPTIONS
     * * * )
     * * 
     */
    protected $margin = 20;
    protected $transY;
    protected $notesY;
    protected $footerY;

    protected function Invoice_header() {
        $invoice_translation = ($this->proforma && ($this->invoice['status'] != 'Paid')) ? $this->lang->translate('proforma') : $this->lang->translate('invoice');


        if (file_exists($this->imagepaga . 'images' . DS . 'invoice_' . $this->invoice['status'] . '_' . $this->language . '.gif') && function_exists('imagecreatefrompng')) {
            $image = $this->imagepaga . 'images' . DS . 'invoice_' . $this->invoice['status'] . '_' . $this->language . '.gif';
            $this->Image($image, 0, 0, 43, 43, '', '', '', 2);
        }

        $y = 10; // top margin
        $this->SetFont($this->font, 'B', 14);
        $this->SetTextColor(48, 47, 40);

        // Business Name
        $this->setXY($this->margin + 5, 2 * $y);

        $extension = explode('.', $this->company_img);
        $extension = end($extension);
        if ($this->config['displayimage'] == true && $this->company_img != '' && in_array($extension, array('jpg', 'gif', 'jpeg', 'png')) && file_exists(MAINDIR . $this->company_img)  && function_exists('imagecreatefrompng')) {
            $this->Image(MAINDIR . $this->company_img, $this->margin + 8, 2 * $y - 5, 70, 18, '', '', '', 2);
            $w = 100;
            $invidwidth = 40;
        } else {
            eval('$this->SetTextColor(' . $this->config['companynamecolor'] . ');');
            $this->Cell(0, 0, $this->business_name);
            $w = $this->GetStringWidth($this->business_name) + 28;
            $invidwidth = 65;
        }
        // Invoice Number

        eval('$this->SetTextColor(' . $this->config['invidcolor'] . ');');
        if ($this->getStringWidth($invoice_translation . ' #' . $this->invoiceNumber()) > $invidwidth) {
            $this->SetXY($w, 2 * $y - 6);
            $this->Cell(0, 0, $invoice_translation);
            $this->SetXY($w, 2 * $y);
            $invstr = '#' . $this->invoiceNumber();
            if ($this->getStringWidth($invstr) > $invidwidth) {
                $this->Cell(0, 0, substr($invstr, 0, 12));
                $this->SetXY($w, 2 * $y + 6);
                $this->Cell(0, 0, substr($invstr, 12));
            } else {
                $this->Cell(0, 0, $invstr);
            }
        } else {
            $this->SetX($w);
            $this->Cell(0, 0, $invoice_translation . ' #' . $this->invoiceNumber());
        }

        //Invoice infos
        eval('$this->SetTextColor(' . $this->config['invinfo_titlescolor'] . ');');
        //$this->SetTextColor(48,47,40);
        $this->SetFont($this->font, 'B', $this->fontsize);

        if ($this->config['top_displayinvid']) {
            $x = -35 - $this->getStringWidth($invoice_translation);
            $this->SetXY($x, $y + 5);
            $this->Cell(0, 0, $invoice_translation);
        }

        if ($this->config['top_displayinvdate']) {
            $x = -35 - $this->getStringWidth($this->lang->translate('invoice_date'));
            $this->SetXY($x, $y + 10);
            $this->Cell(0, 0, $this->lang->translate('invoice_date'));
        }

        if ($this->config['top_displayduedate']) {
            $x = -35 - $this->getStringWidth($this->lang->translate('invoice_due'));
            $this->SetXY($x, $y + 15);
            $this->Cell(0, 0, $this->lang->translate('invoice_due'));
        }

        $this->SetTextColor(48, 47, 40);
        $this->SetFont($this->font, '', $this->fontsize);
        if ($this->config['top_displayinvid']) {
            $this->setXY(-30, $y + 5);
            $this->Cell(0, 0, $this->invoiceNumber());
        }

        if ($this->config['top_displayinvdate']) {
            $this->setXY(-30, $y + 10);
            $this->Cell(0, 0, $this->dateformat($this->invoice['date']));
        }

        if ($this->config['top_displayduedate']) {
            $this->setXY(-30, $y + 15);
            $this->Cell(0, 0, $this->dateformat($this->invoice['duedate']));
        }


        //Line break
        $this->Ln(20);
    }

    protected function Info() {
        $y = 40; // top margin
        $x = 65; // cell width
        $z = 5; // cell margin
        // TO:
        $this->setY($y);
        $this->SetFont($this->font, 'B', $this->fontsize);
        eval('$this->SetTextColor(' . $this->config['invinfo_titlescolor'] . ');');
        $this->Cell(0, 0, $this->lang->translate('invoice_to'));

        $this->SetTextColor(48, 47, 40);
        $this->SetFont($this->font, '', $this->fontsize);
        $i = 1;

        if ($this->config['toinfo_name']) {
            $client = $this->clientdata['firstname'] . ' ' . $this->clientdata['lastname'];
            if ($this->clientdata['companyname'] != '')
                $client = $this->clientdata['companyname'];


            $client = wordwrap($client, 30, "\r\n", true);
            $clientlines = explode("\r\n", $client);
            foreach ($clientlines as $k => $line) {
                $this->setY($y + ($i * 5));
                $this->Cell(0, 0, $line);
                $i++;
            }
        }

        if ($this->config['toinfo_address1']) {
            if ($this->clientdata['address1'] != '') {
                $addr1 = wordwrap($this->clientdata['address1'], 30, "\r\n", true);
                $addr1lines = explode("\r\n", $addr1);
                foreach ($addr1lines as $k => $line) {
                    $this->setY($y + ($i * 5));
                    $this->Cell(0, 0, $line);
                    $i++;
                }
            }
        }

        if ($this->config['toinfo_address2']) {
            if ($this->clientdata['address2'] != '') {
                $addr2 = wordwrap($this->clientdata['address2'], 30, "\r\n", true);
                $addr2lines = explode("\r\n", $addr2);
                foreach ($addr2lines as $k => $line) {
                    $this->setY($y + ($i * 5));
                    $this->Cell(0, 0, $line);
                    $i++;
                }
            }
        }


        if ($this->clientdata['city'] != '') {
            $city = $this->clientdata['city'];
            if ($this->clientdata['state'] != '') {
                $city.=', ' . $this->clientdata['state'];
            }
            if ($this->clientdata['postcode'] != '') {
                $city.=' ' . $this->clientdata['postcode'];
            }
            $city = wordwrap($city, 30, "\r\n", true);
            $citylines = explode("\r\n", $city);
            foreach ($citylines as $k => $line) {
                $this->setY($y + ($i * 5));
                $this->Cell(0, 0, $line);
                $i++;
            }
        }

        if ($this->config['toinfo_country']) {
            $this->setY($y + ($i * 5));
            $this->Cell(0, 0, $this->clientdata['country2']);
            $i++;
        }

        if ($this->config['toinfo_extra']) {
            $extrai = $this->getExtraInfo();
            if (!empty($extrai)) {
                foreach ($extrai as $kk => $cc) {
                    $this->setY($y + ($i * 5));
                    $this->Cell(0, 0, $kk . ': ' . $cc);
                    $i++;
                }
            }
        }

        // FROM:
        $this->setXY($x + $z, $y);
        $this->SetFont($this->font, 'B', $this->fontsize);
        eval('$this->SetTextColor(' . $this->config['invinfo_titlescolor'] . ');');
        $this->Cell(0, 0, $this->lang->translate('invoice_from'));

        $this->SetTextColor(48, 47, 40);

        $paytotext = wordwrap($this->paytotext, 30, "\r\n", true);
        $paytotextlines = explode("\r\n", $paytotext);

        $this->SetFont($this->font, '', $this->fontsize);
        foreach ($paytotextlines as $k => $line) {
            $this->setXY($x + $z, $y + ($k + 1) * 5);
            $this->Cell(0, 0, $line);
        }

        //STATUS:
        $this->setXY(2 * ($x + $z), $y);
        $this->SetFont($this->font, 'B', $this->fontsize);
        eval('$this->SetTextColor(' . $this->config['invinfo_titlescolor'] . ');');
        $this->Cell(0, 0, $this->lang->translate('invoice_status') . ' ');
        $this->SetTextColor(48, 47, 40);
        $status_width = $this->getStringWidth($this->lang->translate('invoice_status') . ' ');
        $this->setX(2 * ($x + $z) + $status_width);

        if ($this->invoice['status'] == 'Paid') {
            $this->SetTextColor(166, 202, 4);
            $this->Cell(0, 0, $this->lang->translate('Paid'));
            $this->SetTextColor(48, 47, 40);

            if ($this->invoice['datepaid'] != '0000-00-00 00:00:00') {
                $this->SetFont($this->font, '', $this->fontsize);
                $this->setXY(2 * ($x + $z), $y + 5);
                $this->Cell(0, 0, $this->lang->translate('invoice_dpaid') . ' ' . $this->dateformat($this->invoice['datepaid']));
            }
        } elseif ($this->invoice['status'] == 'Unpaid') {
            $this->SetTextColor(89, 15, 39);
            $this->Cell(0, 0, $this->lang->translate('Unpaid'));
        } elseif ($this->invoice['status'] == 'Cancelled') {
            $this->SetTextColor(183, 183, 183);
            $this->Cell(0, 0, $this->lang->translate('Cancelled'));
        }

        $this->SetTextColor(48, 47, 40);
    }

    protected function Items() {
        $y = 85; // top margin
        $x1 = -25; // right margin - Price
        $x2 = -65; // right margin - Unitcost and Summary Infos
        $x3 = -95; // right margin - Taxed
        $x4 = -53; // right margin - Qty
        eval('$this->SetFillColor(' . $this->config['items_tablecolor'] . ');');
        $this->Rect($this->margin, $y - 2, 170, 8, 'F');

        $this->SetFont($this->font, 'B', $this->fontsize);

        eval('$this->SetTextColor(' . $this->config['items_tableheadcolor'] . ');');
        $this->setXY($this->margin + 5, $y);
        $this->Cell(0, 0, $this->lang->translate('invoice_desc'));

        $x = $x1 - $this->getStringWidth($this->lang->translate('price'));
        $this->setXY($x, $y);
        $this->Cell(0, 0, $this->lang->translate('price'));

        if ($this->config['items_displayunitcost']) {
            $x = $x2 - $this->getStringWidth($this->lang->translate('unitcost'));
            $this->setXY($x, $y);
            $this->Cell(0, 0, $this->lang->translate('unitcost'));
        }

        if ($this->config['items_displaytax']) {
            $x = $x3 - $this->getStringWidth($this->lang->translate('invoice_tax'));
            $this->setXY($x, $y);
            $this->Cell(0, 0, $this->lang->translate('invoice_tax'));
        }

        if ($this->config['items_displayqty']) {
            $x = $x4 - $this->getStringWidth($this->lang->translate('qty'));
            $this->setXY($x, $y);
            $this->Cell(0, 0, $this->lang->translate('qty'));
        }


        $this->SetFont($this->font, '', $this->fontsize);
        $this->SetTextColor('48,47,40');
        $i = 0;
        $k = 0;
        if (!empty($this->invoice['items'])) {
            foreach ($this->invoice['items'] as $item) {
                $j = 0; // additional lines of description field
               // $desc = wordwrap($item['description'], 45, "\r\n", true);
                $desc_ = explode("\n", $item['description']);
                $desclines=array();
                foreach($desc_ as $dline) {
                    if(isset($dline[45])) {
                        $dline = wordwrap($dline,45,"\n",true);
                        $dline=explode("\n",$dline);
                        $desclines=array_merge($desclines,$dline);
                    } else {
                        $desclines[]=$dline;
                    }

                }
                if ($y + 6 + ( ($i + count($desclines) - 1 ) * 7) + ($k * 6) > 260) {
                    $this->addPage();
                    $i = 1;
                    $k = 0;
                    $y = $this->margin;
                } else {
                    $i++;
                }
                foreach ($desclines as $line) {
                    $this->setXY($this->margin + 5, $y + ($i * 7) + ($k * 6) + ($j * 6));
                    $this->Cell(0, 0, $line);
                    $j++;
                }



                if ($this->config['items_displayunitcost']) {
                    $price = $this->currency['sign'] . ' ' . $item['amount'] . ' ' . $this->currency['code'];
                    $x = $x2 - $this->getStringWidth($price);
                    $this->setXY($x, $y + ($i * 7) + ($k * 6));
                    $this->cell(0, 0, $price);
                }

                $linetotal = $this->currency['sign'] . ' ' . sprintf("%01.2f", $item['linetotal']) . ' ' . $this->currency['code'];

                $x = $x1 - $this->getStringWidth($linetotal);
                $this->setXY($x, $y + ($i * 7) + ($k * 6));
                $this->cell(0, 0, $linetotal);


                if ($this->config['items_displayqty']) {
                    $x = $x4 - $this->getStringWidth($item['qty']);
                    $this->setXY($x, $y + ($i * 7) + ($k * 6));
                    $this->cell(0, 0, $item['qty']);
                }

                if ($this->config['items_displaytax']) {
                    if ($item['taxed'] == 1)
                        $tax = 'Yes';
                    else
                        $tax = 'No';

                    $x = $x3 - $this->getStringWidth($tax);
                    $this->setXY($x, $y + ($i * 7) + ($k * 6));
                    $this->cell(0, 0, $tax);
                }

                $k+=$j - 1;
                $this->Rect($this->margin, $y + 6 + ($i * 7) + ($k * 6), 170, 0.2, 'F');
            }
        } else {
            $this->Rect($this->margin, $y + 5 + ($i * 8), 170, 0.2, 'F');
            $x = 105 - ($this->getStringWidth('No items to display') / 2);
            $this->setXY($x, $y + ($i * 8));
            $this->cell(0, 0, 'No items to display.');
        }

        $i++;
        $y += $k * 6;

        // CHECK if there is enough space
        $countSummary = 0;
        if ($this->config['display_subtotal'])
            $countSummary++;
        if ($this->config['display_credit'])
            $countSummary++;
        if ($this->config['display_taxrate1'] && $this->invoice['taxrate'] > 0)
            $countSummary++;
        if ($this->config['display_taxrate2'] && $this->invoice['taxrate2'] > 0)
            $countSummary++;

        if ($y + (($i + $countSummary) * 7) > 260) {
            $this->addPage();
            $i = 1;
            $k = 0;
            $y = $this->margin;
        }
        // EOC
        // SUMMARY
        $this->SetFont($this->font, 'B', $this->fontsize);

        // SUBTOTAL
        if ($this->config['display_subtotal']) {
            $x = $x2 - $this->getStringWidth($this->lang->translate('subtotal'));
            $this->setXY($x, $y + ($i * 7));
            $this->Cell(0, 0, $this->lang->translate('subtotal'));

            $subtotal = $this->currency['sign'] . ' ' . $this->invoice['subtotal'] . ' ' . $this->currency['code'];
            $x = $x1 - $this->getStringWidth($subtotal);
            $this->setXY($x, $y + ($i * 7));
            $this->Cell(0, 0, $subtotal);
            $i++;
        }

        // CREDIT
        if ($this->config['display_credit']) {
            $x = $x2 - $this->getStringWidth($this->lang->translate('credit'));
            $this->setXY($x, $y + ($i * 7));
            $this->Cell(0, 0, $this->lang->translate('credit'));

            $credit = $this->currency['sign'] . ' ' . $this->invoice['credit'] . ' ' . $this->currency['code'];
            $x = $x1 - $this->getStringWidth($credit);
            $this->setXY($x, $y + ($i * 7));
            $this->Cell(0, 0, $credit);
            $i++;
        }

        // TAXRATE 1
        if ($this->config['display_taxrate1']) {
            if ($this->invoice['taxrate'] > 0) {
                $tax1 = $this->lang->translate('tax') . ' (' . $this->invoice['taxrate'] . '%)';
                $x = $x2 - $this->getStringWidth($tax1);
                $this->setXY($x, $y + ($i * 7));
                $this->Cell(0, 0, $tax1);

                $tax1 = $this->currency['sign'] . ' ' . $this->invoice['tax'] . ' ' . $this->currency['code'];
                $x = $x1 - $this->getStringWidth($tax1);
                $this->setXY($x, $y + ($i * 7));
                $this->Cell(0, 0, $tax1);
                $i++;
            }
        }

        // TAXRATE 2
        if ($this->config['display_taxrate2']) {
            if ($this->invoice['taxrate2'] > 0) {
                $tax2 = $this->lang->translate('tax') . ' (' . $this->invoice['taxrate2'] . '%)';
                $x = $x2 - $this->getStringWidth($tax2);
                $this->setXY($x, $y + ($i * 7));
                $this->Cell(0, 0, $tax2);

                $tax2 = $this->currency['sign'] . ' ' . $this->invoice['tax2'] . ' ' . $this->currency['code'];
                $x = $x1 - $this->getStringWidth($tax2);
                $this->setXY($x, $y + ($i * 7));
                $this->Cell(0, 0, $tax2);
                $i++;
            }
        }
        // TOTAL
        $this->SetFont($this->font, 'B', $this->fontsize + 2);
        $x = $x2 - $this->getStringWidth($this->lang->translate('total'));
        $this->setXY($x, $y + ($i * 7));
        $this->Cell(0, 0, $this->lang->translate('total'));

        $total = $this->currency['sign'] . ' ' . $this->invoice['total'] . ' ' . $this->currency['code'];
        $x = $x1 - $this->getStringWidth($total);
        $this->setXY($x, $y + ($i * 7));
        $this->Cell(0, 0, $total);
        $i+=2;
        // Y for next function
        $this->transY = $y + ($i * 7);
    }

    protected function Transactions() {
        $y = $this->transY;
        $x1 = -120; // right margin - gateway
        $x2 = -70; // right margin - Transaction ID
        $x3 = -25; // right margin - amount

        if (empty($this->transactions)) {

            $this->notesY = $this->transY;
            return;
        }

        if ($y > 260) {
            $y = $this->margin;
            $i = 1;
            $k = 0;
            $this->AddPage();
        }
        $this->SetFont($this->font, 'B', $this->fontsize);
        $i = 1;
        $this->setY($y);
        $this->Cell(0, 0, $this->lang->translate('related_trans'));


        eval('$this->SetFillColor(' . $this->config['trans_tablecolor'] . ');');
        eval('$this->SetTextColor(' . $this->config['trans_tableheadcolor'] . ');');
        $this->Rect($this->margin, ($y - 2) + $i * 8, 170, 8, 'F');

        $this->setXY($this->margin + 5, ($y) + $i * 8);
        $this->Cell(0, 0, $this->lang->translate('trans_date'));

        $xgat = $x1 - $this->getStringWidth($this->lang->translate('trans_gtw'));
        $this->setXY($xgat, ($y) + $i * 8);
        $this->Cell(0, 0, $this->lang->translate('trans_gtw'));

        $xtran = $x2 - $this->getStringWidth($this->lang->translate('trans_id'));
        $this->setXY($xtran, ($y) + $i * 8);
        $this->Cell(0, 0, $this->lang->translate('trans_id'));

        $x = $x3 - $this->getStringWidth($this->lang->translate('trans_amount'));
        $this->setXY($x, ($y) + $i * 8);
        $this->Cell(0, 0, $this->lang->translate('trans_amount'));
        $i++;

        $this->SetTextColor(48, 47, 40);
        $y+=2;
        $this->SetFont($this->font, '', $this->fontsize);
        if (!empty($this->transactions)) {
            foreach ($this->transactions as $tran) {
                $this->Rect($this->margin, $y + 5 + ($i * 6), 170, 0.3, 'F');

                $this->setXY($this->margin + 5, $y + ($i * 6));
                $this->cell(0, 0, $this->dateformat($tran['date']));

                $x = $xgat - ($this->getStringWidth($tran['module']) - $this->getStringWidth('Gateway')) / 2;
                $this->setXY($x, $y + ($i * 6));
                $this->cell(0, 0, $tran['module']);

                $x = $xtran - ($this->getStringWidth($tran['trans_id']) - $this->getStringWidth('Transaction ID')) / 2;
                $this->setXY($x, $y + ($i * 6));
                $this->cell(0, 0, $tran['trans_id']);

                $amount = $this->currency['sign'] . ' ' . $tran['amount'] . ' ' . $this->currency['code'];
                $x = $x3 - $this->getStringWidth($amount);

                $this->setXY($x, $y + ($i * 6));
                $this->cell(0, 0, $amount);

                $i++;
            }
        }

        $this->SetFont($this->font, 'B', $this->fontsize + 1);
        $balance = $this->lang->translate('trans_balance') . ' ' . $this->currency['sign'] . ' ' . $this->balance . ' ' . $this->currency['code'];
        $x = $x3 - $this->getStringWidth($balance);
        $this->setXY($x, $y + ($i * 6));
        $this->cell(0, 0, $balance);
        $i++;

        $this->notesY = $y + ($i * 6);
    }

    protected function Notes() {
        if ($this->notesY)
            $y = $this->notesY + 2;
        else
            $y = $this->transY + 2;

        $margin = 10; // additional margin for notes display
        if ($this->invoice['notes'] == '')
            return;

        if ($y > 260) {
            $y = $this->margin;
            $i = 1;
            $k = 0;
            $this->AddPage();
        }
        eval('$this->SetTextColor(' . $this->config['notes_headercolor'] . ');');
        $this->SetFont($this->font, 'B', $this->fontsize);
        $this->setY($y);
        $this->cell(0, 0, $this->lang->translate('notes'));

        $this->SetFont($this->font, '', $this->fontsize);
        $this->setXY($margin + $this->margin, $y + 6);
        $w = 210 - $this->margin * 2 - $margin * 2;

        $this->SetTextColor('48,47,40');
        $notes = wordwrap($this->invoice['notes'], 90, "\r\n", true);
        $noteslines = explode("\r\n", $notes);


        foreach ($noteslines as $k => $line) {
            $this->setXY($margin + $this->margin, $y + ($k + 1) * 5);
            $this->Cell(0, 0, $line);
            $i++;
        }
        $this->footerY = $y + ($k * 6) + 6;
    }

    protected function DisplayFooter() {
        if ($this->footerY){
            $y = $this->footerY;
        }elseif ($this->notesY){
            $y = $this->notesY;
        }else{
            $y = $this->transY;
        }

        $y+=15;
        if ($this->footer == '')
            return;

        if ($y > 260) {
            $y = $this->margin;
            $i = 1;
            $k = 0;
            $this->AddPage();
        }
        $this->SetFillColor('48,47,40');
        $this->SetTextColor('48,47,40');

        $this->Rect($this->margin + 5, $y, 160, 0.3, 'F');
        $this->SetFont($this->font, '', $this->fontsize);
        $this->setY($y);

        $footer = wordwrap($this->footer, 70, "\r\n", true);
        $footerlines = explode("\r\n", $footer);
        $posY = $y;

        foreach ($footerlines as $k => $line) {
            $w = $this->GetStringWidth($line);
            $posY += 5;
            if($this->checkPageBreak(5, $posY)){
                $posY = $this->margin;
            }

            $xmarg = (150 - $w > 0) ? (150 - $w) / 2 : 0;
            $this->setXY($this->margin + 10 + $xmarg, $posY);
            $this->Cell(0, 0, $line, 0, 0, 'C');
        }
    }

}
