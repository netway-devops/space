<?php

/**
 * ถ้า run program "php google_reseller_token_generator.php" แล้ว error 
 *   "error": "invalid_grant",
 *   "error_description": "Bad Request"
 * ให้เอา  if ($client->getRefreshToken()) { ออกเพื่อให้มัน create token ไม่ใช่ refresh token
 */

require_once dirname(__DIR__) . '/public_html/includes/modules/Other/googleresellerprogramhandle/libs/vendor/autoload.php';


if (php_sapi_name() != 'cli') {
    throw new Exception('This application must be run on the command line.');
}

/**
 * Returns an authorized API client.
 * @return Google_Client the authorized client object
 */
function getClient()
{
    $client = new Google_Client();
    $client->setApplicationName('G Suite Reseller API PHP Quickstart');
    $client->setScopes(Google_Service_Reseller::APPS_ORDER);
    $client->setAuthConfig('credentials.json');
    $client->setAccessType('offline');
    $client->setPrompt('select_account consent');

    // Load previously authorized token from a file, if it exists.
    // The file token.json stores the user's access and refresh tokens, and is
    // created automatically when the authorization flow completes for the first
    // time.
    $tokenPath = 'token.json';

    /*
    # IF TOKEN EXPIRE 

    # step 1 
    $authUrl = $client->createAuthUrl();
    printf("Open the following link in your browser:\n%s\n", $authUrl);
    print 'Enter verification code: ';
    exit;

    # step 2
    // Exchange authorization code for an access token.
    $authCode = '4/1AX4XfWgNfLuhmXkjI2S-zRuQuNzavtZt_DhOvpPkZbyXat1D5_zZFZYFffg';
    $accessToken = $client->fetchAccessTokenWithAuthCode($authCode);
    $client->setAccessToken($accessToken);    
    file_put_contents($tokenPath, json_encode($client->getAccessToken()));
    exit;
    */

    if (file_exists($tokenPath)) {
        $accessToken = json_decode(file_get_contents($tokenPath), true);
        $client->setAccessToken($accessToken);
    }

    // If there is no previous token or it's expired.
    if ($client->isAccessTokenExpired()) {
        // Refresh the token if possible, else fetch a new one.
        if ($client->getRefreshToken()) {
            $client->fetchAccessTokenWithRefreshToken($client->getRefreshToken());
        } else {
            // Request authorization from the user.
            $authUrl = $client->createAuthUrl();
            printf("Open the following link in your browser:\n%s\n", $authUrl);
            print 'Enter verification code: ';
            $authCode = trim(fgets(STDIN));

            // Exchange authorization code for an access token.
            $accessToken = $client->fetchAccessTokenWithAuthCode($authCode);
            $client->setAccessToken($accessToken);

            // Check to see if there was an error.
            if (array_key_exists('error', $accessToken)) {
                throw new Exception(join(', ', $accessToken));
            }
        }
        // Save the token to a file.
        if (!file_exists(dirname($tokenPath))) {
            mkdir(dirname($tokenPath), 0700, true);
        }
        file_put_contents($tokenPath, json_encode($client->getAccessToken()));
    }
    return $client;
}


// Get the API client and construct the service object.
$client = getClient();
$service = new Google_Service_Reseller($client);

// Print the first 10 subscriptions you manage.
$optParams = array(
  'maxResults' => 10,
);
$results = $service->subscriptions->listSubscriptions($optParams);

if (count($results->getSubscriptions()) == 0) {
  print "No subscriptions found.\n";
} else {
  print "Subscriptions:\n";
  foreach ($results->getSubscriptions() as $subscription) {
    printf("%s (%s, %s)\n", $subscription->getCustomerId(),
        $subscription->getSkuId(), $subscription->getPlan()->getPlanName());
  }
}



