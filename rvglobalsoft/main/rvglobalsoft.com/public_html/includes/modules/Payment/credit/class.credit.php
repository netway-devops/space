<?php
class credit extends PaymentModule {

	protected $modname = 'Credits';

	protected $supportedCurrencies=array('USD');

	protected $description = 'Internal Credit Gateway';

	public function drawForm() {
		if(isset($_POST['paid'])){
			$total = $this->amount;
			$paid = $_POST['paid'];
			$credit = $this->client['credit'];
			$db = hbm_db();
			if($paid <= $credit && $paid > 0.00){
				$api = new ApiWrapper();
				$params = array(
						'id' => $this->invoice_id
						, 'amount' => $paid
						, 'paymentmodule' => $this->getPaymentModule()
						, 'fee' => 0
						, 'date' => date('d/m/Y')
				);

				$addPayment = $api->addInvoicePayment($params);
				if($addPayment['success'] || (!$addPayment['success'] && in_array('account_create_failed', $addPayment['error']))){
					$date = date('Y-m-d H:i:s');
					$balance = $credit-$paid;
					$client_id = $this->client['id'];
					$db->query("
							INSERT INTO
								`hb_client_credit_log`
									(
										`date`
										, `client_id`
										, `in`
										, `out`
										, `balance`
										, `description`
										, `transaction_id`
										, `invoice_id`
										, `admin_id`
										, `admin_name`
									) VALUES (
										'{$date}'
										, '{$client_id}'
										,'0.00'
										,'{$paid}'
										,'{$balance}'
										,'Credit applied to invoice'
										,'0'
										,'{$this->invoice_id}'
										,''
										,''
									)
					");
					$db->query("UPDATE hb_client_billing SET credit = '{$balance}' WHERE client_id = {$client_id}");
					header("Location: {$this->success_url}");
					die();
				}
			}
		}

		$initial = ($this->client['credit'] >= $this->amount) ? $this->amount : $this->client['credit'];

		$color = $this->creditColor($this->client['credit'], $this->amount);

		$showCredit = number_format($this->client['credit'], 2, '.', ',');

		$display = <<<EOF
		<script type="text/javascript">
			$(document).ready(function(){
				$('#paid-credit').change(function(){
					var credit_input = parseFloat($('#paid-credit').val());
					if(credit_input > {$this->amount} && credit_input <= {$this->client['credit']}){
						$('#paid-credit').val({$this->amount});
					} else if(credit_input > {$this->client['credit']}){
						if({$this->client['credit']} > {$this->amount}){
							$('#paid-credit').val('{$this->amount}');
						} else {
							$('#paid-credit').val('{$this->client['credit']}');
						}
					} else if(credit_input < 0.00){
						$('#paid-credit').val('0.00');
					} else {
						$('#paid-credit').val(credit_input.toFixed(2));
					}
				});
			});
		</script>
		<form action="clientarea/invoice/&id={$this->invoice_id}" method="POST">
			<br>
			<input type="hidden" name="invoice_id" value="{$this->invoice_id}"/>
			<input type="hidden" name="amount" value="{$this->amount}"/>
			Your Credit : <font color="{$color}">{$showCredit}</font> USD
EOF;

		if($color == 'orange'){
			$display .= '*';
		}

		$display .= "<br><br>";
		if($this->client['credit'] > 0.00){
			$display .= <<<EOF
			Use Credit : <input type="text" id="paid-credit" name="paid" value="{$initial}" size="5"/> USD
			<br><br>
			<input type="submit" value="Pay now!" />
EOF;
// 			if($this->client['credit'] < $this->amount){
// 				$display .= '&nbsp;&nbsp;<button onclick="window.open(\'clientarea/addfunds/\');" type="button">Add Funds</button>&nbsp;&nbsp;';
// 			}
		} else {
			$display .= '<button onclick="window.open(\'clientarea/addfunds/\');" type="button">Add Funds</button>&nbsp;&nbsp;';
		}

		if($color == 'orange'){
			$display .= <<<EOF
			<br><br>
			<font size="1">* Not enough credit, <a href="clientarea/addfunds/" target="_blank">Add funds</a>.</font>
EOF;
		}
		$display .= "</form>";

		return $display;
	}

	public function getPaymentModule()
	{
		$db = hbm_db();
		$pm_module = $db->query("SELECT id FROM hb_modules_configuration WHERE module = 'credit' AND type = 'Payment'")->fetch();
		return $pm_module['id'];
	}

	public function creditColor($credit, $amount)
	{
		if($credit > 0.00){
			if($credit >= $amount){
				$color = 'green';
			} else {
				$color = 'orange';
			}
		} else {
			$color = 'red';
		}
		return $color;
	}
}
?>