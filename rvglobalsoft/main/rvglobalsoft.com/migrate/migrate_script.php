<?php

$path = dirname(__DIR__);

//Create file .env
$setEnv = createEnv($path);
if ($setEnv == true) {
  print "Create .env successful \n";
}

//Variable for migrate script
$app_env = getEnvVal('app');
$db_host = getEnvVal('db_host');
$db_user = getEnvVal('db_user');
$db_name = getEnvVal('db_name');
$db_pass = getEnvVal('db_pass');
$db_engine = getEnvVal('db_engine');
$db_port = getEnvVal('db_port');
// $dateStartMigrate = "dirinstall=20201221"."\n"."dirmigrate=0"; #hostbill_version2020-12-21



//Test database connection
$connect = testConnectDB($db_host, $db_user, $db_pass, $db_name);
if ($connect == false) {
  exit;
}

//Migrate default data and setting
$migrateDefaultData = migrateDefaultData($db_host, $db_user, $db_pass, $db_name, $path, $dateStartMigrate);
if ($migrateDefaultData == false) {
  print "No need to migrate default data. \n";
}

$migrateDefaultSetting = migrateDefaultSetting($db_host, $db_user, $db_pass, $db_name, $path);
if ($migrateDefaultSetting == false) {
  print "Migrate default setting successful \n";
}

//Find sql file for migrate
$fileToMigrate = checkFileForUpdate(getLastMigrated($path), $path);
if (empty($fileToMigrate['file'])) {
  print "No such file to migrate \n";
  exit;
}

//Migrate new file and update latest version
migrateLatest($db_host, $db_user, $db_pass, $db_name, $fileToMigrate);
$versionUpdate = updateFileLatest($fileToMigrate, $path);
if ($versionUpdate == true) {
  print "Update version successful \n";
}

function testConnectDB($db_host, $db_user, $db_pass, $db_name)
{
  $conn = mysqli_connect($db_host, $db_user, $db_pass);
  if ($conn->connect_error) {
    echo "Connection failed: " . $conn->connect_error;
    mysqli_close($conn);

    return false;
  }
  $sql = "CREATE DATABASE IF NOT EXISTS rvglobal_hostbill";
  if ($conn->query($sql) == true) {
    print "Connect database " . $db_name . " successful \n";
    mysqli_close($conn);

    return true;
  } else {
    print "Error creating database: " . $conn->error;
    mysqli_close($conn);

    return false;
  }
}

function migrateDefaultData($db_host, $db_user, $db_pass, $db_name, $path, $dateStartMigrate): bool
{
  $migrateDefaultDataCMD = "unzip -p $path/migrate/rvglobal_hostbill_default_data.sql.zip | mysql -h $db_host -u$db_user -p$db_pass $db_name";

  if (file_exists("$path/migrate/last_migrated_sql.ini")) {
    $lastMigrated = parse_ini_file("$path/migrate/last_migrated_sql.ini", true);
    $defaultDateMigrate = parse_ini_string( $dateStartMigrate);
    print "You're current version:" . $defaultDateMigrate['dirinstall'] . "\n";
    if (!array_key_exists('dirinstall', $lastMigrated) || $lastMigrated['dirinstall'] == '' || (int)$lastMigrated['dirinstall'] < (int)$defaultDateMigrate['dirinstall']) {
      print "Migrating DefaultData \n";
      shell_exec($migrateDefaultDataCMD);
      print "Migrated DefaultData \n";
      file_put_contents("$path/migrate/last_migrated_sql.ini", $dateStartMigrate);
      print "Create file latest and migrate default success \n";

      return true;
    }
    return false;
  }
  print "Migrating DefaultData \n";
  shell_exec($migrateDefaultDataCMD);
  print "Migrated DefaultData \n";
  file_put_contents("$path/migrate/last_migrated_sql.ini", $dateStartMigrate);
  print "Create file latest and migrate default success \n";

  return true;
}

function getLastMigrated($path): array
{
  $lastMigrated = $path . "/migrate/last_migrated_sql.ini";
  $lastMigratedVersion = parse_ini_file($lastMigrated);

  return $lastMigratedVersion;
}

function checkFileForUpdate($lastMigratedVersion, $path): array
{
  $fileToMigrate = ['dirinstall' => '', 'dirmigrate' => '','file' => []];
  $fileFromInstallPath = glob($path . "/public_html/install/20*.sql");
  $fileFromMigratePath = glob($path . "/migrate/20*.sql");

  if (empty($fileFromMigratePath) && empty($fileFromMigratePath)) {
    return $fileToMigrate;
  }

  foreach ($fileFromInstallPath as $filename) {
    $split = preg_split("/[-|.]+/", basename($filename));
    $version = $split[0] . $split[1] . $split[2];
    if ((int)$version > (int)$lastMigratedVersion['dirinstall']) {
      array_push($fileToMigrate['file'], $filename);
    }
  }

  foreach ($fileFromMigratePath as $filename) {
    $split = preg_split("/[-|.]+/", basename($filename));
    $version = $split[0] . $split[1] . $split[2];
    if ((int)$version > (int)$lastMigratedVersion['dirmigrate']) {
      array_push($fileToMigrate['file'], $filename);
    }
  }

  $date = preg_split("/[-|.]+/", basename(end($fileFromInstallPath)));
  $fileToMigrate['dirinstall'] = (isset($date[0]) && isset($date[1]) && isset($date[2])) ? $date[0] . $date[1] . $date[2] : $lastMigratedVersion['dirinstall'];
  $date = preg_split("/[-|.]+/", basename(end($fileFromMigratePath)));
  $fileToMigrate['dirmigrate'] = (isset($date[0]) && isset($date[1]) && isset($date[2])) ? $date[0] . $date[1] . $date[2] : $lastMigratedVersion['dirmigrate'];

  return $fileToMigrate;
}

function migrateLatest($db_host, $db_user, $db_pass, $db_name, $files_update)
{
  foreach ($files_update['file'] as $file) {
    if (file_exists($file)){
      print "Migrating $file \n";
      $cmd = "mysql -h $db_host -u$db_user -p$db_pass $db_name" . " < " . $file;
      shell_exec($cmd);
      print "Migrated $file \n";
    }
  }

  return true;
}

function updateFileLatest($files_update, $path): bool
{
  $filePath = fopen($path . "/migrate/last_migrated_sql.ini", "w");
  $content = "dirinstall=" . $files_update['dirinstall']."\n";
  $content = $content."dirmigrate=" . $files_update['dirmigrate']."\n";
  fwrite($filePath, $content);
  fclose($filePath);

  return true;
}

function createEnv($path): bool
{
  $env_file = $path . '/.env';
  $contents = [
    'app' => 'local',
    'db_engine' => 'mysql',
    'db_host' => 'mysql',
    'db_user' => 'root',
    'db_pass' => 'secret',
    'db_name' => 'rvglobal_hostbill',
    'db_port' => '3306',
    'hb_templates_c_dir' => $path . '/templates_c',
    'hb_attachments_dir' => 'false',
    'hb_downloads_dir' => 'false',
    'billing_url' => 'https://billing.netway.co.th',
    'cms_url' => 'https://netway.co.th',
    'crm_url' => 'https://crm.zoho.com/crm/org736818608',
    'crisp_url' => 'https://app.crisp.chat/website/928dc456-d257-4727-9fd7-ab9c055607fb',
    'ccEncryptionHash' => '',
    'enable_debug'  =>  'false'
  ];

  if (!file_exists($env_file)) {
    $env = fopen($env_file, "w");
    foreach ($contents as $key => $value) {
      fwrite($env, $key . "=" . $value . "\n");
    }
    fclose($env);

    return true;
  }

  return false;
}

function migrateDefaultSetting($db_host, $db_user, $db_pass, $db_name, $path): bool
{
  $devOnlySetting = $path . '/migrate/devOnlySetting.sql';
  $cmd = "mysql -h $db_host -u$db_user -p$db_pass $db_name" . " < " . $devOnlySetting;
  if (file_exists($devOnlySetting)) {
    print "Migrating $devOnlySetting \n";
    shell_exec($cmd);
    print "Migrated $devOnlySetting \n";
    return true;
  }

  print "Not found devOnlySetting.sql file\n";
  return false;
}

function getEnvVal($env_key): string
{
  $result = "";
  $env_file = dirname(__DIR__) . '/.env';
  $env_query = file_exists($env_file) ? parse_ini_file($env_file) : [];
  foreach ($env_query as $key => $value) {
    if ($env_key == $key) {
      $result = $value;
      break;
    }
  }

  return $result;
}