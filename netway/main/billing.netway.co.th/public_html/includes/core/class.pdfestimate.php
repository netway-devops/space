<?php
/* Class to get easly Estimate in PDF
 * USES: TCPDF Class
 *
 * WARNING
 *
 * Changing contents below requires PHP programming skills and you're editing this file on YOUR OWN RISK.
 * Bear in mind that HostBill will not be responsible for any damages caused by editing this file.
 * Fixing issues caused by non-professional changes are not performed by HostBill support team for free.
 */

class PDFEstimate extends corePDFEstimate{



    protected $margin = 20;
    protected $transY;
    protected $notesY;





    protected function estimate_header() {
        if (file_exists($this->imagepaga.'images'.DS.'estimate_'.$this->estimate['status'].'_'.$this->language.'.gif')) {
         $image = $this->imagepaga.'images'.DS.'estimate_'.$this->estimate['status'].'_'.$this->language.'.gif';
         $this->Image($image,0,0,43,43,'','','',2);
        }

        $y = 10; // top margin
        $this->SetFont($this->font,'B',18);
        $this->SetTextColor(48,47,40);

        // Business Name
        $this->setXY($this->margin+5, 2*$y);

        $extension = explode('.', $this->company_img);
        $extension = end($extension);
        if($this->company_img != '' && in_array($extension, array('jpg', 'gif', 'jpeg', 'png')) && file_exists(MAINDIR.$this->company_img)) {
            $this->Image(MAINDIR.$this->company_img,$this->margin+8,2*$y - 5, 70, 18,'','','',2);
            $w = 100;
        } else {
            $this->Cell(0,0,$this->business_name);
            $w=$this->GetStringWidth($this->business_name)+28;
        }
        // Invoice Number

        $this->SetTextColor(104,104,104);
            $this->SetX($w);
            $this->Cell(0,0,$this->lang->translate('customerquote'));

        //Line break
        $this->Ln(20);
    }



    protected function Info() {
        $y = 40; // top margin
        $x = 65; // cell width
        $z = 3; // cell margin

        // LEFT
        $this->setY($y);
        $this->SetFont($this->font,'B',10);
        $this->Cell(0,0 , $this->lang->translate('expirydate'));

        $this->SetFont($this->font,'',10);
        $i=1;

        $this->setY($y+($i*8));
        $this->Cell(0,0 , $this->lang->translate('estimate_date'));
        $i++;

        if($this->clientdata['companyname']!='') {
            $this->setY($y+($i*8));
            $this->Cell(0,0 , $this->lang->translate('company'));
            $i++;
        }

        $this->setY($y+($i*8));
        $this->Cell(0,0 , $this->lang->translate('customer'));
        $i++;

        // RIGHT
        $this->setXY($x+$z,$y);
        $this->Cell(0,0 , $this->estimate['date_expires']);
        $k=1;

        $this->setXY($x+$z,$y+($k*8));
        $this->Cell(0,0 , $this->estimate['date_created']);
        $k++;

        if($this->clientdata['companyname']!='') {
            $this->setXY($x+$z,$y+($k*8));
            $this->Cell(0,0 , $this->clientdata['companyname']);
            $k++;
        }

        $this->setXY($x+$z,$y+($k*8));
        $this->Cell(0,0 , $this->clientdata['firstname'].' '.$this->clientdata['lastname'] );


        //STATUS:
        $this->setXY(2*($x+$z),$y);
        $this->SetFont($this->font,'B',10);
        $this->Cell(0,0 , $this->lang->translate('estimate_id').': ');
        $this->setX(2*($x+$z)+25);
        $this->SetFont($this->font,'',10);
        $this->Cell(0,0 , '#'.$this->estimate['id']);

        $this->setXY(2*($x+$z),$y+8);
        $this->SetFont($this->font,'B',10);
        $this->Cell(0,0 , $this->lang->translate('invoice_status').' ');
        $this->setX(2*($x+$z)+25);

        if($this->estimate['status'] == 'Accepted') {
            $this->SetTextColor(166,202,4);
            $this->Cell(0,0 , $this->lang->translate('Accepted'));
        }
        elseif($this->estimate['status'] == 'Draft') {
           $this->SetTextColor(48,47,40);
            $this->Cell(0,0 , $this->lang->translate('Draft'));
        } elseif($this->estimate['status'] == 'Sent') {
           $this->SetTextColor(48,47,40);
            $this->Cell(0,0 , $this->lang->translate('Sent'));
        } elseif($this->estimate['status'] == 'Invoiced') {
           $this->SetTextColor(48,47,40);
            $this->Cell(0,0 , $this->lang->translate('Invoiced'));
        }
        elseif($this->estimate['status'] == 'Dead') {
            $this->SetTextColor(183,183,183);
            $this->Cell(0,0 , $this->lang->translate('Dead'));
        }

        $this->SetTextColor(48,47,40);


    }

    protected function Items() {
            $y = 80; // top margin

        $x1 = -25; // right margin - Price
        $x2 = -65; // right margin - Unitcost and Summary Infos
        $x3 = -95; // right margin - Taxed
        $x4 = -53; // right margin - Qty
        $this->SetFillColor(239,239,239);
        $this->Rect($this->margin,$y-2,170,8,'F');

        $this->SetFont($this->font,'B',10);

        $this->setXY($this->margin+5,$y);
        $this->Cell(0,0,$this->lang->translate('invoice_desc'));

        $x = $x1 - $this->getStringWidth($this->lang->translate('price'));
        $this->setXY($x,$y);
        $this->Cell(0,0,$this->lang->translate('price'));

        $x = $x2 - $this->getStringWidth($this->lang->translate('unitcost'));
        $this->setXY($x,$y);
        $this->Cell(0,0,$this->lang->translate('unitcost'));

        $x = $x3 - $this->getStringWidth($this->lang->translate('invoice_tax'));
        $this->setXY($x,$y);
        $this->Cell(0,0,$this->lang->translate('invoice_tax'));

        $x = $x4 - $this->getStringWidth($this->lang->translate('qty'));
        $this->setXY($x,$y);
        $this->Cell(0,0,$this->lang->translate('qty'));


        $this->SetFont($this->font,'',10);

        $i=1;
        if(!empty($this->estimate['items'])) {
            foreach($this->estimate['items'] as $item) {
                $this->Rect($this->margin, $y+5+($i*8), 170,0.2,'F');

                $this->setXY($this->margin+5,$y+($i*8));
                $this->cell(0,0,$item['description']);

                $price = $this->currency['sign'] . ' ' . $item['amount'] . ' ' . $this->currency['code'];
                $x = $x2 - $this->getStringWidth($price);

                $this->setXY($x,$y+($i*8));
                $this->cell(0,0,$price);
                $linetotal = $this->currency['sign'] . ' ' . sprintf("%01.2f", $item['linetotal']) . ' ' . $this->currency['code'];

                $x = $x1 - $this->getStringWidth($linetotal);
                $this->setXY($x,$y+($i*8));
                $this->cell(0,0,$linetotal);

                $x = $x4 - $this->getStringWidth($item['qty']);
                $this->setXY($x,$y+($i*8));
                $this->cell(0,0,$item['qty']);
                if($item['taxed'] == 1)
                    $tax='Yes';
                else
                    $tax = 'No';

                $x = $x3 - $this->getStringWidth($tax);
                $this->setXY($x,$y+($i*8));
                $this->cell(0,0,$tax);

                $i++;
            }
        }
        else {
            $this->Rect($this->margin, $y+5+($i*8), 170,0.2,'F');
            $x = 105-($this->getStringWidth('No items to display')/2);
            $this->setXY($x,$y+($i*8));
            $this->cell(0,0,'No items to display.');
            $i++;
        }


        // SUMMARY
        $this->SetFont($this->font,'B',10);

        // SUBTOTAL
            $x = $x2 - $this->getStringWidth($this->lang->translate('subtotal'));
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $this->lang->translate('subtotal'));

            $subtotal = $this->currency['sign'] . ' ' . $this->estimate['subtotal'] . ' ' . $this->currency['code'];
            $x = $x1 - $this->getStringWidth($subtotal);
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $subtotal);
            $i++;

        // CREDIT
            $x = $x2 - $this->getStringWidth($this->lang->translate('credit'));
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $this->lang->translate('credit'));

            $credit = $this->currency['sign'] . ' ' . $this->estimate['credit'] . ' ' . $this->currency['code'];
            $x = $x1 - $this->getStringWidth($credit);
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $credit);
            $i++;

        // TAXRATE 1
        if($this->estimate['taxrate']>0) {
            $tax1 = $this->lang->translate('tax').' ('.$this->estimate['taxrate'].'%)';
            $x = $x2 - $this->getStringWidth($tax1);
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $tax1);

            $tax1 = $this->currency['sign'] . ' ' . $this->estimate['tax'] . ' ' . $this->currency['code'];
            $x = $x1 - $this->getStringWidth($tax1);
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $tax1);
            $i++;
        }

        // TAXRATE 2
        if($this->estimate['taxrate2']>0) {
            $tax2 = $this->lang->translate('tax').' ('.$this->estimate['taxrate2'].'%)';
            $x = $x2 - $this->getStringWidth($tax2);
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $tax2);

            $tax2 = $this->currency['sign'] . ' ' . $this->estimate['tax2'] . ' ' . $this->currency['code'];
            $x = $x1 - $this->getStringWidth($tax2);
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $tax2);
            $i++;
        }

        // TOTAL
            $this->SetFont($this->font,'B',12);
            $x = $x2 - $this->getStringWidth($this->lang->translate('total'));
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $this->lang->translate('total'));

            $total = $this->currency['sign'] . ' ' . $this->estimate['total'] . ' ' . $this->currency['code'];
            $x = $x1 - $this->getStringWidth($total);
            $this->setXY($x,$y+($i*8));
            $this->Cell(0,0 , $total);
            $i+=2;

            $this->notesY = $y+($i*8);

    }



    protected function Notes() {
        $y = $this->notesY+2;
        if($this->estimate['notes']=='')
            return;
        $margin = 10; // additional margin for notes display

        $this->SetFont($this->font,'B',10);
        $this->setY($y);
        $this->cell(0,0,$this->lang->translate('notes'));

        $this->SetFont($this->font,'',10);
        $this->setXY($margin+$this->margin,$y+6);
        $w = 210 - $this->margin*2 - $margin*2;
        $this->MultiCell($w, 4, $this->estimate['notes'], 0, 'L');
    }
}
?>