<?php
namespace Racecore\GATracking\Tracking;
/**
 * Google Analytics Measurement PHP Class
 * Licensed under the 3-clause BSD License.
 * This source file is subject to the 3-clause BSD License that is
 * bundled with this package in the LICENSE file.  It is also available at
 * the following URL: http://www.opensource.org/licenses/BSD-3-Clause
 *
 * Google Documentation
 * https://developers.google.com/analytics/devguides/collection/protocol/v1/
 *
 * @author  Marco Rieger
 * @email   Rieger(at)racecore.de
 * @git     https://github.com/ins0
 * @url     http://www.racecore.de
 * @package Racecore\GATracking\Tracking
 */

class Screenview extends AbstractTracking
{
	/**
	 * Returns the Google Paket for Campaign Tracking
	 *
	 * @return array
	 */
	public function createPackage()
	{
		return array(
            't' 	=> 'screenview',
			'an' 	=> $this->getAppName(),
			'av' 	=> $this->getAppVersion(),
			'aid' 	=> $this->getAppId(),
			'aiid' 	=> $this->getAppInstallerId(),
			'cd' 	=> $this->getContentDescription(),
		);
	}

	public function getAppName()
	{
		return $this->appName();
	}

	public function getAppVersion()
	{
		return $this->appVersion();
	}

	public function getAppId()
	{
		return $this->appId;
	}

	public function getAppInstallerId()
	{
		return $this->appInstallId;
	}

	public function getContentDescription()
	{
		return $this->contentDescription;
	}
}