<?php
class rv_partner
{
	protected $oApi;
	protected $oDB;
	
	public function rv_partner()
	{
		$this->oApi = new ApiWrapper();
		$this->oDB = hbm_db();
	}
	
    public function getPartnerEmail($clientId)
    {
        $aClientDetails   = $this->oApi->getClientDetails(array('id' => $clientId));
        $aClient          = $aClientDetails[client];
        return $aClient['email'];
    }
    
	public function getPatrnetInfomationbyCid($clientId) 
	{
		$aClientDetails = $this->oApi->getClientDetails(array('id' => $clientId));
		$aClient = $aClientDetails[client];
		$email = $aClient['email'];
		return $this->getPatnerQuota($clientId);
	}
	
    public function getPatnerQuota($clientsId)
    {
        return $this->oDB->query('
            SELECT
                quota_id, distributor, leased_license, rvsitebuilder_license
                , quota_total, quota_vps_total
            FROM
                license_quota
            WHERE
                hb_user_id = :hb_user_id
        ', array(
            ':hb_user_id'   => $clientsId
        ))->fetchAll();
    }
    
    
	public function getPatrnetInfomationbyEmail($email) 
	{
		$aResult     = $this->oDB->query('
			SELECT 
				u.user_snd AS user_snd, q.quota_id AS quota_id, q.distributor AS distributor
				, q.leased_license AS leased_license, q.rvsitebuilder_license AS rvsitebuilder_license
				, q.quota_total AS quota_total, q.quota_vps_total AS quota_vps_total, u.user_email AS email
			FROM
				snd_user AS u,
				license_quota AS q
			WHERE
				u.user_email = :email
				AND	u.user_snd = q.user_id
		', array(
			':email' => $email,
		))->fetchAll();
		return $aResult;
	}
	
	public function getRemoveIssueList($quota_id)
	{
		$aQRemoteIPList     = $this->oDB->query('
			SELECT 
				remote_main_ip, remote_sub_first_ip, remote_sub_last_ip, quota_id
			FROM
				remote_issue
			WHERE
				quota_id = :quota_id
			', array(
			':quota_id' => $quota_id
		))->fetchAll();
		return $aQRemoteIPList;
	}
	
	public function addRemoveIssue($quota_id, $email, $mainIP, $subFirstIP, $subLastIP) 
	{
		if ($this->isHaveRemoveIssue($quota_id, $mainIP, $subFirstIP)) {
			return $this->updateRemoveIssue($quota_id, $email, $mainIP, $subFirstIP, $subLastIP);
		} else {
			return $this->insertRemoveIssue($quota_id, $email, $mainIP, $subFirstIP, $subLastIP);
		}
	}
	
	public function insertRemoveIssue($quota_id, $email, $mainIP, $subFirstIP, $subLastIP)
	{
		return $this->oDB->query('
			INSERT INTO remote_issue
				(remote_main_ip, remote_sub_first_ip, remote_sub_last_ip, email, quota_id)
			VALUES
				(:remote_main_ip, :remote_sub_first_ip, :remote_sub_last_ip, :email, :quota_id)
		', array(
			':remote_main_ip' => $mainIP,
			':remote_sub_first_ip' => $subFirstIP,
			':remote_sub_last_ip' => $subLastIP,
			':email' => $email,
			':quota_id' => $quota_id,
		));
	}

	public function updateRemoveIssue($quota_id, $email, $mainIP, $subFirstIP, $subLastIP)
	{
		return $this->oDB->query('
			UPDATE 
				remote_issue
			SET
				email = :email,
				remote_sub_last_ip = :remote_sub_last_ip
			WHERE
				quota_id = :quota_id
				AND remote_main_ip = :remote_main_ip
				AND remote_sub_first_ip = :remote_sub_first_ip
		', array(
			':remote_main_ip' => $mainIP,
			':remote_sub_first_ip' => $subFirstIP,
			':remote_sub_last_ip' => $subLastIP,
			':email' => $email,
			':quota_id' => $quota_id,
		));
	}
	
	public function deleteRemoveIssue($quota_id, $mainIP, $subFirstIP, $subLastIP)
	{
		return $this->oDB->query('
			DELETE FROM
				remote_issue
			WHERE
				quota_id = :quota_id
				AND remote_main_ip = :remote_main_ip
				AND remote_sub_first_ip = :remote_sub_first_ip
				AND remote_sub_last_ip = :remote_sub_last_ip
		', array(
			':quota_id' => $quota_id,
			':remote_main_ip' => $mainIP,
			':remote_sub_first_ip' => $subFirstIP,
			':remote_sub_last_ip' => $subLastIP,
		));
	}
	
	public function isHaveRemoveIssue($quota_id, $mainIP, $subFirstIP)
	{
		$aResult = $this->oDB->query('
			SELECT
				email
			FROM
				remote_issue
			WHERE
				quota_id = :quota_id
				AND remote_main_ip = :remote_main_ip
				AND remote_sub_first_ip = :remote_sub_first_ip
		', array(
			':quota_id' => $quota_id,
			':remote_main_ip' => $mainIP,
			':remote_sub_first_ip' => $subFirstIP,
		))->fetchAll();
		return (count($aResult) > 0) ? true : false;
	}
}
