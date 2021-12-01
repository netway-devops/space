<?php
if ( ! defined('HBF_APPNAME'))
{
    exit;
}

require_once APPDIR . 'libs/rv_partner/rv_partner.php';

// --- hostbill helper ---
$db             = hbm_db();
$oApi           = new ApiWrapper();
$oPartnet       = new rv_partner();

// --- hostbill helper ---

$clientId   = isset($_POST['client_id'])
    ? $_POST['client_id']
    : $_GET['client_id'];

if (isset($_POST['rvaction']))
{
	$rvact = $_POST['rvaction'];
}
elseif (isset($_GET['rvaction']))
{
	$rvact = $_GET['rvaction'];
}
else
{
	$rvact = null;
}

$aClientDetails = $oApi->getClientDetails(array('id' => $clientId));
$aClient        = $aClientDetails[client];
$email          = $aClient['email'];

/// เปลี่ยนเป็นหาจาก id แทน
$aResult        = $oPartnet->getPatnerQuota($clientId);

//$aResult = $oPartnet->getPatrnetInfomationbyEmail($email);

if ($rvact == 'add' && $aResult == array())
{
	$distributor = $leased = 0;
	if (isset($_POST['distributor']) OR isset($_GET['distributor']))
	{
		$distributor = 1;
	}

	if (isset($_POST['leased']) OR isset($_GET['leased']))
	{
		$leased = 1;
	}

	$aSnd_user = $db->query('
		SELECT
			*
		FROM
			snd_user
		WHERE
			user_email = :user_email
	', array(
	   ':user_email' => $email
    ))->fetchAll();

	if (count($aSnd_user) == 0)
	{
		$snd_id = $clientId;
		$db->query("
			INSERT INTO
				snd_user
					( modate, user_snd, user_email, first_name, last_name, subscribe_email, sta_import )
				VALUES
					( :modate, :user_snd, :user_email, :first_name, :last_name, :subscribe_email, :sta_import )
		", array(
			":modate" => strtotime("now")
			, ":user_snd" => $aClient["id"]
			, ":user_email" => $email
			, ":first_name" => $aClient["firstname"]
			, ":last_name" => $aClient["lastname"]
			, ":subscribe_email" => 1
			, ":sta_import" => 0
		));
	}
	else
	{
		$snd_id = $aSnd_user[0]['user_snd'];
	}

	$aLicenseQuota = $db->query('
		SELECT
			quota_id
		FROM
			license_quota
		WHERE
			user_id = :user_id
	', array(
		':user_id' => $snd_id
	))->fetchAll();

	if (count($aLicenseQuota) == 0)
	{
		$quota_dedicated          = 9999;
		$quota_vps                = 9999;
		$rvsitebuilder_license    = $clientId;
		$aLicenseQuotaInsert      = $db->query('
			INSERT INTO license_quota
				(user_id, hb_user_id, distributor, leased_license, billing_email
				    , quota_total, quota_vps_total, rvsitebuilder_license)
			VALUES
				(:user_id, :hb_user_id, :distributor, :leased_license, :billing_email
				    , :quota_total, :quota_vps_total, :rvsitebuilder_license)
		', array(
			':user_id'                   => $snd_id,
			':hb_user_id'                => $clientId,
			':billing_email'             => $email,
			':distributor'               => $distributor,
			':leased_license'            => $leased,
			':quota_total'               => $quota_dedicated,
			':quota_vps_total'           => $quota_vps,
			':rvsitebuilder_license'     => $rvsitebuilder_license,
		));
	} /// endif

	/// get accounts
	$aClientAccounts = $oApi->getClientAccounts(array(
	   'id' => $clientId
    ));

	foreach ($aClientAccounts['accounts'] as $k => $v)
	{
		/// Update user_id to table rvskin_license
		$updateRvskin = $db->query('
			UPDATE
				rvskin_license
			SET
				user_id = :user_id
			WHERE
				hb_acc  = :hb_acc
		', array(
			':user_id'   => $snd_id,
			':hb_acc'    => $v['id']
		));

		/// Update rvskin_user_snd to table rvsitebuilder_license
		$updateSiteBuilder = $db->query('
			UPDATE
				rvsitebuilder_license
			SET
				rvskin_user_snd = :user_id
			WHERE
				hb_acc = :hb_acc
		', array(
			':user_id'   => $snd_id,
			':hb_acc'    => $v['id']
		));
	} /// endforeach

	$aResult = $oPartnet->getPatrnetInfomationbyEmail($email);
} /// endif

if ($aResult == array())
{
	$this->assign('client_id', $clientId);
	$this->assign('client_name', $aClient['firstname'].' '.$aClient['lastname']);
	$this->assign('isNotConvertToPatrnet', true);
}
else
{
	$quota_id          = $aResult[0]['quota_id'];
	$aQRemoteIPList	   = $oPartnet->getRemoveIssueList($quota_id);

	$this->assign('isNotConvertToPatrnet', false);
	$this->assign('isNocQuotaId', $aResult[0]['quota_id']);
	$this->assign('isDistributor', ($aResult[0]['distributor'] == 1) ? 'Yes' : 'No');
	$this->assign('isLeasedLicense', ($aResult[0]['leased_license'] == 1) ? 'Yes' : 'No');
    $this->assign('dedicatedQuota', $aResult[0]['quota_total']);
    $this->assign('vipQuota', $aResult[0]['quota_vps_total']);
	$this->assign('partnetQuotaID', $quota_id);

	$aRemoteList = array();

	foreach ($aQRemoteIPList as $v)
	{
		if ($v['remote_sub_first_ip'] ==  $v['remote_sub_last_ip'])
		{
			$aRemoteList[] = "{$v['remote_main_ip']}.{$v['remote_sub_first_ip']}";
		} /// endif
		else
		{
			$aRemoteList[] = "{$v['remote_main_ip']}.{$v['remote_sub_first_ip']}-{$v['remote_sub_last_ip']}";
		} /// endelse
	} /// endforeach

	$this->assign('remoteIPList', count($aRemoteList) > 0
        ? join(', ', $aRemoteList)
        : 'NO DATA!!'
    );
	$this->assign('leasedLicenseType', '');

	$aAccounts = $db->query('
		SELECT
			ac.id AS acct_id, ac.product_id AS product_id, p.category_id AS category_id
		FROM
			hb_accounts AS ac, hb_products AS p
		WHERE
			ac.client_id = :client_id
			AND ac.product_id = p.id
	', array(
		':client_id' => $clientId,
	))->fetchAll();

	$aNocAccts = array();

	foreach ($aAccounts as $aAcct)
	{
		// Product category_id 8 is NOC Licenses, that is patrnet
		if ($aAcct['category_id'] == 8)
		{
			$aAccountDetails = $oApi->getAccountDetails(array('id' => $aAcct['acct_id']));

			if (isset($aAccountDetails['success']) && $aAccountDetails['success'] == 1)
			{
				$aAcctDetail                    = $aAccountDetails['details'];
				$aNocAccts[$aAcct['acct_id']]   = array(
					'product_id'       => $aAcct['product_id'],
					'product_name'     => $aAcctDetail['product_name'],
				);

				foreach($aAcctDetail['custom'] as $key => $val)
				{
                    if ($val['variable'] == 'min_quantity')
                    {
                    	$aNocAccts[$aAcct['acct_id']]['min_quantity'] = $val['qty'];
                    } /// endif

                    if ($val['variable'] == 'price_is_fixed')
                    {
                    	$aNocAccts[$aAcct['acct_id']]['price_is_fixed'] = $val['qty'];
                    } /// endif

                    if ($val['variable'] == 'price_for_fixed')
                    {
                    	$aNocAccts[$aAcct['acct_id']]['price_for_fixed'] = $val['data'][$key];
                    } /// endif
                } /// endforeach
			} /// endif
		} /// endif
	} ///endforeach

	$this->assign('aNocAccts', $aNocAccts);

	/// Update user_snd for old account
	$aClientAccounts = $oApi->getClientAccounts(array('id' => $clientId));

	foreach ($aClientAccounts['accounts'] as $aAcct)
	{
		$aSBLicense = $db->query('
			SELECT
				license_id
			FROM
				rvsitebuilder_license
			WHERE
				hb_acc = :hb_acc
				AND (
				   rvskin_user_snd    = "0"
				   OR rvskin_user_snd = ""
                )
		', array(
			':hb_acc' => $aAcct['id']
		))->fetchAll();

		if ($aSBLicense > 0)
		{
			foreach ($aSBLicense as $key => $val) {
				$updateSiteBuilder = $db->query('
					UPDATE
						rvsitebuilder_license
					SET
						rvskin_user_snd = :user_id
					WHERE
						license_id = :license_id
					', array(
						':user_id'    => $aResult[0]['user_snd'],
						':license_id' => $val['license_id']
				));
			} /// endforeach
		} /// endif

		$aSKLicense = $db->query('
			SELECT
				license_id
			FROM
				rvskin_license
			WHERE
				hb_acc = :hb_acc
				AND (
				    user_id    = "0"
				    OR user_id = ""
                )
		', array(
			':hb_acc' => $v['id']
		))->fetchAll();

		if ($aSKLicense > 0)
		{
			foreach ($aSKLicense as $key => $val)
			{
				$updateSiteBuilder = $db->query('
					UPDATE
						rvskin_license
					SET
						user_id = :user_id
					WHERE
						license_id = :license_id
					', array(
						':user_id'    => $aResult[0]['user_snd'],
						':license_id' => $val['license_id']
				));
			} /// endforeach
		} /// endif
	} /// endforeach
} /// endelse

