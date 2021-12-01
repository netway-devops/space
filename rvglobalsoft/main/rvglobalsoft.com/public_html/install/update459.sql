ALTER TABLE hb_tickets ADD scheduled_date DATE NOT NULL AFTER start_date;

CREATE TABLE IF NOT EXISTS hb_oauth_token (
  token varchar(50) NOT NULL,
  usr_id varchar(36) NOT NULL,
  ip_address varchar(25) NOT NULL,
  role int(2) NOT NULL,
  expire int(9) NOT NULL,
  PRIMARY KEY (token),
  UNIQUE KEY token_2 (token,usr_id,ip_address),
  KEY token (token,ip_address,expire)
);


CREATE TABLE IF NOT EXISTS hb_oauth_consumer (
  usr_id int(11) NOT NULL,
  key_phrase varchar(8) NOT NULL,
  billing_privatekey varchar(2000) NOT NULL,
  controlpanel_privatekey varchar(2000) NOT NULL,
  whm_privatekey varchar(2000) NOT NULL,
  PRIMARY KEY (usr_id),
  KEY usr_id (usr_id)
);

CREATE TABLE IF NOT EXISTS hb_oauth_cpuser (
  cpuser_id varchar(35) NOT NULL,
  usr_id int(11) NOT NULL,
  cpusername varchar(16) NOT NULL,
  domainname varchar(255) NOT NULL,
  cpuser_privatekey varchar(2000) NOT NULL,
  key_phrase varchar(8) NOT NULL,
  PRIMARY KEY (cpuser_id),
  KEY cpuser_id (cpuser_id,usr_id,cpusername,domainname)
);

CREATE TABLE IF NOT EXISTS hb_user_session (
  session_id varchar(255) NOT NULL,
  last_updated datetime DEFAULT NULL,
  data_value text,
  usr_id int(11) NOT NULL DEFAULT '0',
  username varchar(64) DEFAULT NULL,
  expiry int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (session_id),
  KEY last_updated (last_updated),
  KEY usr_id (usr_id),
  KEY username (username)
);


REPLACE INTO hb_oauth_consumer (usr_id, key_phrase, billing_privatekey, controlpanel_privatekey, whm_privatekey) VALUES
(1, 'yooPHuRS', '-----BEGIN ENCRYPTED PRIVATE KEY-----\nMIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQImn3zmmudMi8CAggA\nMBQGCCqGSIb3DQMHBAhVlkR3hVAuPgSCBMjaYizazIXjg0wlNML+XBt2LdC0deYA\nTgqrc26VIEIiJ3CM3PE/NRBV+Wsf0Hfp2eip2qxQBTO8mYu0bkfxreOjq/k0IOzL\n553cBscFqo2twvkBnWy0v0R3MaY9szgSK10+UYfGEbgmCHvBH9BKCAd2r2L56z+W\nsU2ZVDxQp8AHfljesTHXsi9q5ETuV6Hsg96VLrcjqwYb6dJZGDtBq9K0JnfCFasI\nOWh0aiWZat+xdsptbGf59T6h/KeKx4kP/O4K0JdbjeZyJyB1UoS5d6i90B0Yk6vp\nLJ9q3OerCAzl70cvEM92NKxJdGRIFMeIFEb/KmwO3/l0sFBK2tq7bCbdNbIF/rof\nofnA8tCRMB/tqk0G/kSZsAx/DK9Ob0OVVuaXhsDVHEs+Nluzz3sioAv+IeE/2UjK\n++TvqHgWZ+eqpmJRHAZt//H35hMJFpO/z+E9Ru+Q6VngmT58Njv8oFND7FC2iPpn\npmNT2LEdHssFOvaP0pMAFzOk4NZQNUMy/NbCHMZsxU1I8PPOECW/B0SuhrgxLUXg\nqqYi7ox5Ltk9rxKfBrTcWnjtN4EEb0kx8eKG7GrJohqg2ZMgfsQ5UOBO39Pjz7JV\nh8zBbQxfPvsGdiliFmFvj0E5wkEJL01lx4wfPSTA7J3VrHaUrN1aCd5Vf09dO1d6\nHwuJBtWd1g3dB4BsG4RfI4OPS2yPdzoCPj+lKf8YAHZ+lo13/rBLD74UBBNdOuFb\nW7P4By9LG0cVP8i8g/nNdGypiURK1zkFRgYvzFX0IbHkefPwd4UGdLRLWxN1XATR\nG1u+DzFyTxSswmu5v9sjNk7xhl6HPYt/IB4lkZJTJ5Wn+AIU7WCKbJU8/vsrdmFk\niRqPYFDIBbMONIzokGJ/wbgMOP1XrEWgfKd2TZEDONflpkHVLXZlSFD4alKpniDA\n+F5XGluZlDPk/5Les9GwkKUn1dK9eqgwlp66PyQgfYSACCS2yOFCUxWaRRky0+yY\nUwY25KFGy6KtMtkuSiyMAoaWCZobdwzcpFoEqLlZBUSpFXJ3EFe3iy5eb8Uir8Ph\nwY7M6PFgMxI6/7xRgTeK2vAthav7LV39QeqrF4qtYLUPx9fpqs6i12CBacLNXj8d\nChO+SlEgQ3XwvUsjYv58E4TAXkEqliOIYCYAnQ2Q603YhmSoGNnUQ6N5EkxfhhM6\ndSYoa1Ecpgnm7IL7wxa5+F30esyna7FxqiYDf7LXbYrxr9PetxUtJTDf4j4t7A7x\nsIWotX/j7zTfEjimnoH2V/6GcRockU2bIgYpSaRDTDDDF+qWTGU9R9nix8144wZs\n67QDM+QQnQGaPha/KDxIy7R/cyUpVEfT9JO7maI6aWUrjQ1dBJeIoaJIA79HIlUe\nA38h6PDYqX5ckzn4jB30AC7BixewueWDf3SJtaVCe1wWzf0QX1DQDM/Xfp1O7Kqy\noan8lTwzQZjn8S3J0bwb8TUbQQHCa1x6kSmwaytGpYB9SZzWzIPI9s6PKkvD260s\nOROfq+LfcPgRK8WFvd4qN6dhBKaYfjs9BOZ1Xnw33Fm7AFf7Q2vUKnR6tJ0HcHu4\nl7XVNiaWBZt+48JjMNbeXwMBWKjjYtBdcD/L1VSQbghBOiY0BZbzmltLhXeKYz0Z\n3zw=\n-----END ENCRYPTED PRIVATE KEY-----', '-----BEGIN ENCRYPTED PRIVATE KEY-----\nMIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQIRL/o8p225RcCAggA\nMBQGCCqGSIb3DQMHBAjAtIb22PVHBwSCBMiRUQ0akYIkUhmHV0QA2mTmiEKfsXYU\nakAj9u2jAHzhgjqOpUy6383F5OHskNgdUZ9sFh0wml2onzmDcE1+/sQY+rL8Uxc2\n/r+BEN8Masi1+RagglwgVh6TBTXimhTAfqMeEsJqwkJJ0PVP5P52jTCwmLlrb9FR\n/qyK01bBvw4Z2lJ/FQC1GwnrlCJ8cJdDWneH/mqXPMszzackZ98iDSuaaaJ8ry3o\nw85nKe6Teriw+xsIEN89R5u2JbEUxRpIrj0z5Qepyfy3zIFLrVfoDM5lZ+IMkuym\nAIsyYy9Tn6GWD1NI4mA6uZlCcTDPIe73+ZopGgfHUboB+TCodLPECtXFbO5Gmtui\njbhmQQjVx8GSSUEsWIgN+4vVwFJqKLLuGqDC7wAeZY+T9gEuIBdGyiLE1xoBlB8N\neoccG0TkkoL+A7QGa8c+GHndCNHa+6bHHiO1IsJ86uj+gzjobxihE9IiHgQLXQJa\nP4wW3S+MJyl4mXmotoVrPGGCSTSgMiSjpTi1Y49aE+Bauvxmf1uM0Lkri7COzN1y\nNzJ5bGjP9duAtCcV/bLnzO2DV9lakwW0oG9uFGSirOFNtvz4Z94AdmVEGDVtuRJo\n5pfeCULN9U0ZZdC09uNO9j1hU6gmrc2KUu/SAROSHYveTRoOKcxYQCOF4NjGZflO\n9uZVZmhy0T64EoVrjgI33OKtHOrrDJRSqfm9Yy7wLJlUhQgUG+jR8iiHJGMuYt9v\nh1IC24378ox0zpK19cv1SWYyrh0N6sfJLXb/14EBW8gAq+MNhjfYwsX8ARLsBgbn\nBW2OjUZVdag09Qr1JD6mYB6TjC5Mt+CI9YqAHguNOIXGnoj8mrp0apoUqeocXWBT\nfROJ3GGSl3sUyxGhM+wsJ4WKa0AV5mziZkXUywL/xqPfyz7ImnE1rBvgpb1vyHPe\nHXVkI7Ty+rdpo+d8PWBxHhXwyQstgKI7Qr+96MIGQAgCqr2iusghGESwogjzIYLp\n1Okx/atK4Y8Xk5VVIKralx1KSm/vsmrrJdu9Kql0iP/aL/K2cMZC6+k8w3QzLypl\ntGSl3frbrVMXEEWoRapQw6EAE7QENw8ItgRI+KGvujPWkShDG/byA1YNCduJVmjf\nlxyqt+5MDJHkB7BW4WsYyius1D0TUvahCGuqdxWDG218XcImEtiOK6iwIxfH/Jcr\nYUEsBAzsZ044zMnLw3TFykNc/O/5tv+xt+5Kie59w/SOz+lhHg31RtSs3daetrDp\nvIHDjZmUwXBMe5jQv3g+h0KznNmY/Ybm7V45q+OkyAwzDL36n41sLE0ZEfaD42X1\nQbpS0U/NBjeABiOY8UPPJA1Cipytje0n9NEQkCeS1plARu/XqLYP84ovXmCCaxlR\nZoghorTuH+w5xLMJMqbeVri8WGlTr6hfqoS9MOrpgsrQEKcSvzM5Ok+mLDvBhlmW\nbvBXYMsjDS7Jkr72aYqz5VUcrrpr7JM+ubYpSbJyI0BOQ8+dXVZ2m3XeI8imUcMp\nI9vAvGuFfHpJHY3ITrjTcdoaNBRXWf/L2EFtVj5gFEIhlem5ID0e2o4+34inkS3O\nBEzBpAXm6Am6CsO0vBtFphfRYpzxld3BHC7UsGfiTOOTTfKGWDPqdmPR9rMHKfm3\nuU0=\n-----END ENCRYPTED PRIVATE KEY-----', '-----BEGIN ENCRYPTED PRIVATE KEY-----\nMIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQI0LcEhyT4RtICAggA\nMBQGCCqGSIb3DQMHBAjVtPzuTaBJfgSCBMiA2nF/wq2IuoQoF3vgWPKs+THKyvUy\nDOPzQSDQpSq+RcZHYQ6G13XDNXJTeG6WdqP77uPTP0xSZfzaIypPez6B1W9eRd9h\n8ZFqhjDbMQKWfZwSr4yX1Ul5geAduNpWMRFXLZoNYbmHOo6hyyXIwV6UXcMhPVOI\n/rb+IxY2/TjML7F6veWNIMTza8TMDJYEKrOpaHoTvSTh3tSMOqFboEPp1SoCMB7u\n5EJKlJ1iDWPDJoF74FmczKSSmCgtllbeKFycCFaszYVO5DIkjW1bCzKN1E/tkh5a\nkBvO+fl9BRqo3utjGH1BkiAlwNBDe1JfE/a/+5bH/PmQfn9ops6iz5EmV5xR0lnT\nDC7Mrr3puumJO7rWCSKsu+hv4C9iIk49ChlF+Wy1F1/xOPzhSyHigFNP46Wq1UAq\nJQ3y2/qlxeKuq54iw3+MeN+Nc1ZU5lUJUh2RFyYRuSzmQBGx7T0ZZ8p/ZHOb4OnS\nCz6Z3bJVqQw9XtV2XMBEp8t8UanxBG1zUuspZ6VBo8NWAMABtcMJL7P8L72681CZ\nsIL2vxRNhKXSxNwDwrvKrVugAi8oYKBS8uM07zCHHRuccoZQ/uz56g0rxKiz0miQ\nXp2ptHuF4D8MWYIUonMLar4ehFFAr9LOla8hF/QTRRxlmRwN9Cp0oraNgynDGRsw\nKVC1xBPpj22Kma9FfiLrI4PA1HVWhrmVdnilrVKAFmduu3VDC77eM4GDw9knugvp\np6ikdvSCoHj1g9hlo8SM0kyi8rpMtswoMChAt+AkT3QA07AsrVTfFE9z+w2jN/kS\nWu4VddsYtdczlbJgpN6t/CwbumGLVKUDh/xAqrnePi4AB2tZXHphCWBI9e6ABXiZ\nzI5Aj5K7M9iCjSmAA8Acv6+NIj0hbl9Pv51qPTto3GAAAJroIQjWGMBmuLs58dV6\nmz/IJYPig/L0BDfxYnf5yLYAytBWa2Ch6zZIRja9D7oo2Vnr0QAe9D4G1u2KcP/S\nnmIforuc3L7SP+PZwt6qTNarKdM2WIyNOtfkGVnDu2MwgOx496M7uuk9wB2Jw40H\nZO0GWzOAnZfqqXr8eGy9uKxma0En7oyeyEEQbL2weuipe2QlS08C+DHrvhD/7brB\ndi9XSkxsoN7DOux570PQDsq81LtPMU3NDPXMp7quT1xusOtV8aSVOtMQqZyfGBJK\naWV/NgHF8LGuSvTFrPRpE//SqWiVD206anG85TUV5PtG5oS0T3PMWZS01s7TLzrc\nsnbfYjLRegQOA92NTY2cfTj9RzCR3jAxkejficG9wiQAB3GeLilcW98fC2KO55Wg\nD50FqgtIbJj1kJK7a0lwrff5NtQ9yj2QogzzxQbCb2M0TTmfygrSrgoFKIXBIk5P\nLq0mIhB8U3a5lCkzKmnqNKyDeCmgUvWbJ29NYmJxxvJy6CAZsjWGGlXN9iVESSpA\nqcRNa4zqAY73rJmf4ohh4VVuRCVTWT7/NVp2Qg0ZR0COWRw8GpG9e+Xzmskz31Aj\ntxd1KTIcYYHJSOO4hxTGREoeKlOD3s0ncMWrsHLQxoFWz89KW3evFO40tWyuEZ3/\nmjWtX3W1bLTuN4s4kf7M0LmHf86Im3zKXA0X4I8Cj8lHO6XTc+9gPCWtJ52Zo0tG\nPkM=\n-----END ENCRYPTED PRIVATE KEY-----');


-- --------------------------------------------------------

--
-- Table structure for table hb_vip_acct
--

CREATE TABLE IF NOT EXISTS hb_vip_acct (
  vip_acct_id int(11) NOT NULL AUTO_INCREMENT,
  vip_info_id int(11) NOT NULL,
  vip_acct_name varchar(100) NOT NULL,
  vip_acct_comment text NOT NULL,
  PRIMARY KEY (vip_acct_id)
);

-- --------------------------------------------------------

--
-- Table structure for table hb_vip_cred
--

CREATE TABLE IF NOT EXISTS hb_vip_cred (
  vip_cred_id int(11) NOT NULL AUTO_INCREMENT,
  vip_acct_id int(11) NOT NULL,
  vip_cred_type varchar(20) NOT NULL,
  vip_cred varchar(20) NOT NULL,
  vip_cred_comment varchar(255) NOT NULL,
  PRIMARY KEY (vip_cred_id)
);

-- --------------------------------------------------------

--
-- Table structure for table hb_vip_info
--


CREATE TABLE IF NOT EXISTS `hb_vip_info` (
  `vip_info_id` int(11) NOT NULL AUTO_INCREMENT,
  `usr_id` varchar(45) NOT NULL,
  `account_id` int(11) NOT NULL,
  `vip_user_prefix` varchar(100) NOT NULL,
  `date_created` int(11) NOT NULL,
  `last_updated` int(11) NOT NULL,
  `ou_number` varchar(30) NOT NULL,
  `billing_cycle_unit` char(1) NOT NULL COMMENT 'Y=Year,M=Month',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `quantity_at_symantec` int(11) NOT NULL DEFAULT '0',
  `certificate_file_name` varchar(200) NOT NULL,
  `certificate_file_type` varchar(100) NOT NULL,
  `certificate_file_size` int(11) NOT NULL DEFAULT '0',
  `certificate_file_path` varchar(200) NOT NULL,
  `certificate_file_content` text NOT NULL,
  `certificate_file_password` varchar(200) NOT NULL,
  `symantec_connection` varchar(200) NOT NULL,
  `md5sum` varchar(50) NOT NULL,
  `date_file_upload` int(11) NOT NULL,
  `date_file_last_upload` int(11) NOT NULL,
  `certificate_expire_date` int(11) NOT NULL,
  `certificate_file_name_p12` varchar(200) NOT NULL,
  `certificate_file_type_p12` varchar(100) NOT NULL,
  `certificate_file_size_p12` int(11) NOT NULL DEFAULT '0',
  `certificate_file_path_p12` varchar(200) NOT NULL,
  `certificate_file_content_p12` text NOT NULL,
  `certificate_file_password_p12` varchar(200) NOT NULL,
  `md5sum_p12` varchar(50) NOT NULL,
  `date_file_upload_p12` int(11) NOT NULL DEFAULT '0',
  `date_file_last_upload_p12` int(11) NOT NULL DEFAULT '0',
  `certificate_expire_date_p12` int(11) NOT NULL DEFAULT '0',
  `subscription_start_date` int(11) NOT NULL,
  `subscription_expire_date` int(11) NOT NULL,
  `can_manage_status` char(1) NOT NULL DEFAULT 'P',
  `status` char(1) NOT NULL,
  `product_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `staff_comment` text NOT NULL,
  `description` text,
  `vip_info_type` varchar(20) NOT NULL COMMENT 'Trial,Upgrade,Paid',
  PRIMARY KEY (`vip_info_id`)
);

-- --------------------------------------------------------

--
-- Table structure for table hb_vip_sv_access_conf
--

CREATE TABLE IF NOT EXISTS hb_vip_sv_access_conf (
  vip_acct_id int(11) NOT NULL,
  sv_allow_all varchar(10) NOT NULL
);

-- --------------------------------------------------------

--
-- Table structure for table hb_vip_sv_access_list
--

CREATE TABLE IF NOT EXISTS hb_vip_sv_access_list (
  vip_acct_id int(11) NOT NULL,
  cpserver_id int(11) NOT NULL
);



-- --------------------------------------------------------

--
-- Table structure for table hb_ssl
--

CREATE TABLE IF NOT EXISTS hb_ssl
(
  ssl_id INT( 3 ) NOT NULL,
  ssl_validation_id INT( 2 ) NOT NULL,
  ssl_authority_id INT( 2 ) NOT NULL,
  ssl_name varchar(255) NOT NULL,
  warranty DECIMAL(10,2) NOT NULL ,
  ssl_multidomain_id INT( 2 ) DEFAULT NULL,
  ssl_defail text DEFAULT NULL,
  issuance_time varchar(255) DEFAULT NULL,
  key_length varchar(255) DEFAULT NULL,
  encryption varchar(255) DEFAULT NULL,
  reissue int(1) DEFAULT NULL,
  green_addressbar int(1) DEFAULT NULL,
  secure_subdomain int(1) DEFAULT NULL,
  non_fqdn int(1) DEFAULT NULL,
  mobile_support int(1) DEFAULT NULL,
  licensing_multi_server int(1) DEFAULT NULL,
  ind int(1) DEFAULT NULL,
  uc int(11) DEFAULT NULL,
  malware_scan int(1) DEFAULT NULL,
  seal_in_search int(1) DEFAULT NULL,
  siteseal_id varchar(5) DEFAULT NULL,
  PRIMARY KEY (ssl_id),
  INDEX ( ssl_id, ssl_authority_id, ssl_validation_id)
);

CREATE TABLE IF NOT EXISTS hb_ssl_authority
(
    ssl_authority_id INT( 2 ) NOT NULL,
    authority_name varchar(50) NOT NULL,
    install_check_url varchar(255) DEFAULT NULL,
    sort int(2) NOT NULL,
    enable int(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (ssl_authority_id),
    INDEX ( ssl_authority_id, authority_name)
);

CREATE TABLE IF NOT EXISTS hb_ssl_validation
(
    ssl_validation_id INT( 2 ) NOT NULL,
    validation_name VARCHAR( 50 ) NOT NULL,
    maximum_contract INT( 2 ) NOT NULL,
    status INT( 1 ) NOT NULL DEFAULT '0',
    PRIMARY KEY (ssl_validation_id),
    INDEX ( ssl_validation_id, validation_name)
);

/*==============================================================*/
/* Table: ssl_type                                             */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS hb_ssl_multidomain
(
    ssl_multidomain_id INT( 2 ) NOT NULL,
    multidomain_name VARCHAR( 50 ) NOT NULL,
    PRIMARY KEY (ssl_multidomain_id),
    INDEX ( ssl_multidomain_id, multidomain_name)
);


/*==============================================================*/
/* Table: ssl_siteseal                                             */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS hb_ssl_siteseal
(
    ssl_siteseal_id INT( 2 ) NOT NULL,
    ssl_authority_id VARCHAR( 2 ) NOT NULL,
    siteseal_name varchar(50) NOT NULL,
    install_url varchar(255) DEFAULT NULL,
    PRIMARY KEY (ssl_siteseal_id),
    INDEX ( ssl_siteseal_id, ssl_authority_id, siteseal_name)
);


/*==============================================================*/
/* Table: webserver_vendor                                       */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS hb_webserver_vendor 
(
  webserver_vendor_id int(2) NOT NULL,
  vender_name varchar(255) NOT NULL,
  PRIMARY KEY (webserver_vendor_id),
  INDEX ( webserver_vendor_id, vender_name)
);


CREATE TABLE IF NOT EXISTS hb_webserver 
(
  webserver_id int(3) NOT NULL ,
  webserver_vender_id int(2) NOT NULL,
  application varchar(255) NOT NULL,
  PRIMARY KEY (webserver_id),
  UNIQUE KEY webserver_vender_id (webserver_vender_id, application)
);

CREATE TABLE IF NOT EXISTS hb_ssl_authority_webserver 
(
  ssl_authority_id int(2) NOT NULL,
  webserver_id int(3) NOT NULL,
  gen_csr_url varchar(255) NOT NULL,
  UNIQUE KEY ssl_authority_id (ssl_authority_id, webserver_id)
);

###################################################################
# ssl_validation
###################################################################
REPLACE INTO hb_ssl_validation (ssl_validation_id, validation_name, maximum_contract, status) VALUES ( '1', 'Domain Validation SSL (DV)', '5', '1');
REPLACE INTO hb_ssl_validation (ssl_validation_id, validation_name, maximum_contract, status) VALUES ( '2', 'Extended Validation SSL (EV)', '2', '1');
REPLACE INTO hb_ssl_validation (ssl_validation_id, validation_name, maximum_contract, status) VALUES ( '3', 'Organization Validation SSL (OV)', '5', '1');
REPLACE INTO hb_ssl_validation (ssl_validation_id, validation_name, maximum_contract, status) VALUES ( '4', 'WildCard SSL', '5', '1');
REPLACE INTO hb_ssl_validation (ssl_validation_id, validation_name, maximum_contract, status) VALUES ( '5', 'SGC SSL', '5', '1');
REPLACE INTO hb_ssl_validation (ssl_validation_id, validation_name, maximum_contract, status) VALUES ( '6', 'UC/SAN SSL', '5', '1');
REPLACE INTO hb_ssl_validation (ssl_validation_id, validation_name, maximum_contract, status) VALUES ( '7', 'Code Signing Certificates', '5', '1');

###################################################################
# ssl_authority
###################################################################
REPLACE INTO hb_ssl_authority (ssl_authority_id, authority_name, install_check_url, sort, enable) VALUES(1, 'Thawte', 'https://search.thawte.com/support/ssl-digital-certificates/index?page=content&id=SO9555&actp=LIST', 2, 1);
REPLACE INTO hb_ssl_authority (ssl_authority_id, authority_name, install_check_url, sort, enable) VALUES(2, 'GeoTrust', 'https://knowledge.geotrust.com/support/knowledge-base/index?page=content&id=SO9557&actp=search&viewlocale=en_US&searchid=1321273782902', 3, 1);
REPLACE INTO hb_ssl_authority (ssl_authority_id, authority_name, install_check_url, sort, enable) VALUES(3, 'Rapid SSL', 'https://knowledge.rapidssl.com/support/ssl-certificate-support/index?page=content&id=SO9556&actp=LIST&viewlocale=en_US', 4, 1);
REPLACE INTO hb_ssl_authority (ssl_authority_id, authority_name, install_check_url, sort, enable) VALUES(4, 'Digicert', 'https://ssl.in.th/wp-content/themes/SSLTheme/products/th/digicert-ssl-plus.html#', 5, 0);
REPLACE INTO hb_ssl_authority (ssl_authority_id, authority_name, install_check_url, sort, enable) VALUES(5, 'Verisign', 'https://knowledge.verisign.com/support/ssl-certificates-support/index?page=content&id=AR1692', 1, 1);
REPLACE INTO hb_ssl_authority (ssl_authority_id, authority_name, install_check_url, sort, enable) VALUES(6, 'Comodo', 'https://comodosslstore.com/checksslcertificate.aspx', 6, 0);
REPLACE INTO hb_ssl_authority (ssl_authority_id, authority_name, install_check_url, sort, enable) VALUES(7, 'GoDaddy', '', 7, 0);

###################################################################
# ssl_multidomain_id
###################################################################
REPLACE INTO hb_ssl_multidomain (ssl_multidomain_id, multidomain_name) VALUES(1, 'Single Domain');
REPLACE INTO hb_ssl_multidomain (ssl_multidomain_id, multidomain_name) VALUES(2, 'Single Domain-Green Bar');
REPLACE INTO hb_ssl_multidomain (ssl_multidomain_id, multidomain_name) VALUES(3, 'Unlimited Sub Domains');
REPLACE INTO hb_ssl_multidomain (ssl_multidomain_id, multidomain_name) VALUES(4, 'Single Domain-SGC- Unlimited Sub Domains');

###################################################################
# Product SSL Detail
###################################################################
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(1, 1, 1, 'Thawte SSL123', 100000.00, 1, '<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>This SSL is the cheapest of Thawte which supports 40-256 bits encryption while displaying the Thawte Trusted Site symbol stamped with the clarify approved date to complete assure your visitors. This is proper with your website, which needs the general encryption through Intranet.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>This is proper with the needing in SSL Certificate which easily issues and spends a few days request with verifying solely the domain owner identity.</li>\r\n    <li>Thawte is a second choice for E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and, etc. The business which wants the security and trustworthy on financial transaction through Internet, including with some government sector, association, or academy chooses the Thawte.</li>\r\n</ul>\r\n<p>&nbsp;</p>', '2 hours', '2048-bit', 'Up to 256-bit', 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(2, 1, 2, 'GeoTrust QuickSSL Premium', 100000.00, 1, '<p>&nbsp;</p>\r\n<p>When clients need to contact you changing the private information through Internet, you''ll need to assure the security to your them. The QuickSSL Premium is able to display GeoTrust True Site stamped with date approval even customer connects via online or on mobile. When users see the symbol, they will have known that your domain has been verified and trusted on any their transactions will kept in encryption.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>This is proper with the needing in SSL Certificate which easily issues and spends a few days request with verifying solely the domain owner identity.</li>\r\n    <li>GeoTrust is another brand which website of government sector, agency, association, academy, including with private company and natural person who wants the economized SSL Certificate selected.</li>\r\n</ul>\r\n<p>&nbsp;</p>', '2 hours', '2048-bit', 'Up to 256-bit', 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(3, 1, 3, 'RapidSSL', 10000.00, 1, '<p>RapidSSL is a single root SSL Certificate which supports root encryption  in 128 &ndash; 256 bits. The root owner is the needed to issue this RapidSSL,  then this certificate is an equitable certificate and already contained  in IE 5.01+, Netscape 4.7+, Mozilla 1+, and other new servers of  windows, including with the Mac base server.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>This is proper with the needing in SSL Certificate which easily issues and spends a few days request with verifying solely the domain owner identity.</li>\r\n    <li>Rapid SSL is a brand which most selected by the private company or natural person who needs the economized SSL Certificate, including with the beginning E-Commerce, software developers, server organizations or administrators.</li>\r\n</ul>', '2 hours', '2048-bit', 'Up to 256-bit', 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(4, 1, 4, 'Digicert SSL Plus', 1000000.00, 1, '<p>Every DigiCert SSL Plus certificate is able to protect both  &quot;yourname.com&quot;  and &quot;www.yourname.com&quot; without any charges. It''s  included with the innovation security. If you selected the DifiCert SSL  Plus certificate, your website will be secured both www.example.com and  example.com (with and without www!) by lesser let the warning works.</p>', '2 hours', '2048-bit', '128/256bit', 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(5, 1, 7, 'Standard SSL', 10000.00, 1, '<p>Standard SSL reduces your time and investment more than half of your  competitors do, including with the security of online transaction with  256 bits encryption. It will protect every website consists of credit  card information and private information of clients. The Standard SSL is  able to work properly with any domains.</p>', '1-2 Days', '2048-bit', '128/256bit', 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(6, 3, 5, 'Symantec Secure Site Pro', 1250000.00, 1, '<p>&nbsp;</p>\r\n<p>If you assured that you have provided the best encryption to your website visitors by SSL Secure Site Pro certificate supports the encryption strength in 128-256 bits. Moreover, you also have VeriSign Secured&reg; symbol on your website to raise the number entering 150 times a day, including being trusted by the United States consumer up to 91%.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate which easily issues and spends not over a few days to verify the domain owner identification and company existence such as company establishment document or company certificate in the order.</li>\r\n    <li>Verisign is proper with E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and etc.</li>\r\n</ul>\r\n<p>&nbsp;</p>', '2 days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(7, 3, 5, 'Symantec Secure Site', 1000000.00, 1, '<div>You see how much important to secure your private information and business transaction through the internet, but look over the strength of encryption and ignore finding the strongest. The Secure Site is able to support the encryption strength in 40-256 bits and also display a VeriSign Secured symbol on your website. This will raise your website access number for 150 times a day, including with being trusted by The United States consumer up to 91%!</div>\r\n<div>&nbsp;</div>\r\n<div><strong>Recommend !!</strong></div>\r\n<ul>\r\n    <li>\r\n    <div>This is proper with the needing in the SSL Certificate which easily issues and spends not over a few days to verify the domain owner identification and company existence such as company</div>\r\n    </li>\r\n    <li>\r\n    <div>Verisign is proper with E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and etc.</div>\r\n    </li>\r\n</ul>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', '2 days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(8, 3, 2, 'GeoTrust True BusinessID', 250000.00, 1, '<div class="detailcont">If you were looking for the most economized SSL  Certificate for your company. The GeoTrust True BusinessID is the  selection. It is able to display GeoTrust True Site stamped with date  approval even customer connects via online or on mobile. When users see  the symbol, they will have known that your domain has been verified and  trusted on any their transactions will kept in encryption.</div>\r\n<div class="detailcont">\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate which  easily issues and spends not over a few days to verify the domain owner  identification and company existence such as company establishment  document or company certificate in the order.</li>\r\n    <li>GeoTrust is another brand which website of government sector,  agency, association, academy, including with private company and natural  person who wants the economized SSL Certificate selected.</li>\r\n</ul>\r\n</div>', '2 Days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(9, 3, 1, 'Thawte SSL Web Server', 250000.00, 1, '<p>This SSL will economize your company investment and prevent the  important information with 40-256 bits encryption. You will also display  the Thawte Trusted Site stamped with date approval to provide the SSL  to your visitors in complete.</p>\r\n<p>&nbsp;</p>\r\n<p><strong><span style="font-size: 12px;">Recommend !!</span></strong></p>\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate which easily issues and spends not over a few days to verify the domain owner identification and company existence such as company establishment document or company certificate in the order.</li>\r\n    <li><span style="font-size: 12px;">Thawte is a second choice for E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and, etc. The business which wants the security and trustworthy on financial transaction through Internet, including with some government sector, association, or academy chooses the Thawte.</span>er with the needing in the SSL Certificate which easily issues and spends not over a few days to verify the domain owner identification and company existence such as company establishment document or company certificate in the order.</li>\r\n</ul>\r\n<p>&nbsp;</p>', '2 Business Days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(10, 3, 6, 'Comodo Instant SSL', 10000.00, 1, '<p>The InstantSSL Certificate will ensure you and your clients in the  business transaction with trust and confident that all information will  not be changed while being in process on Internet. It will raise your  visitors and average of selling while reducing website collapsed. Every  InstantSSL supports up to 2048 bits encryption.</p>', '1-2 Days', '2048-bit', '128/256bit', 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(11, 3, 6, 'Premium SSL', 250000.00, 1, '<p>The InstantSSL Certificate will ensure you and your clients in the  business transaction with trust and confident that all information will  not be changed while being in process on Internet. It will raise your  visitors and average of selling while reducing website collapsed.</p>', '1-2 Days', '2048-bit', '128/256bit', 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(12, 3, 6, 'InstantSSL Pro', 100000.00, 1, '<p>The InstantSSL Certificate will ensure you and your clients in the  business transaction with trust and confident that all information will  not be changed while being in process on Internet. It will raise your  visitors and average of selling while reducing website collapsed.</p>', '1-2 Days', '2048-bit', '128/256bit', 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(13, 2, 5, 'Symantec Secure Site Pro With EV', 1500000.00, 2, '<p>Give your visitors the reliance in the business transaction through your  website by displaying green bar on browser to assure the strongest  security and also prevent the Phishing. According to many tests  discovering more performance 5-87% when using EV Secure Site Pro with EV  with has the encryption 128-256 bits. Users then assured and trust the  strongest encryption on your website. Moreover, you also have VeriSign  Secured&reg; symbol on your website to raise the number entering 150 times a  day, including being trusted by the United States consumer up to 91%.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate specified with Green Address Bar on Browser with verifying strictly spending 7-10 days issues. The domain owner identification and company of requester in company establishment document or company certificate especially signed by Lawyer or CPA are needed to make the order.</li>\r\n    <li>Verisign is proper with -commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and etc.</li>\r\n</ul>\r\n<p>&nbsp;</p>', '5 Days', '2048-bit', 'Up to 256-bit', 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(14, 2, 5, 'Symantec Secure Site With EV', 1500000.00, 1, '<p>Prevent your website with the trustworthy by displaying the green bar at  the URL browser which meaning to the strongest security and Phishing  prevention performance. This is according to many tests regarding the  increase more security performance 5-87% when using VeriSign EV SSL  Secure Site with EV which supports 40-256 bits. That''s why the private  information and business transaction through your website are secured.  Moreover, you also have VeriSign Secured&reg; symbol on your website to  raise the number entering 150 times a day, including being trusted by  the United States consumer up to 91%.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate specified with Green Address Bar on Browser with verifying strictly spending 7-10 days issues. The domain owner identification and company of requester in company establishment document or company certificate especially signed by Lawyer or CPA are needed to make the order.</li>\r\n    <li>Verisign is proper with E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and etc.</li>\r\n</ul>', '5 Days', '2048-bit', 'Up to 256-bit', 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(15, 2, 1, 'Thawte SSL Web Server With EV', 750000.00, 2, '<p>If you wanted visitors trust in your identification with Green Bar on  browser which the most security sign contains the best performance to  prevent Phishing. The Thawte SSL Web Server with EV is the cheapest EV  SSL certificate which provide you a Thawte Trusted Site stamped with  date approval to provide the SSL to your visitors in complete.</p>\r\n<p>\r\n<div><strong>Recommend !!</strong></div>\r\n<ul>\r\n    <li>\r\n    <div>This is proper with the needing in the SSL Certificate provides the Green Address Bar on browser which needs to verify strictly spending 7-10 days. The most requirements are the domain owner identification and company of requester in company establishment document or company certificate especially signed by Lawyer or CPA.</div>\r\n    </li>\r\n    <li>\r\n    <div>Thawte is a second choice for E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and, etc. The business which wants the security and trustworthy on financial transaction through Internet, including with some government sector, association, or academy chooses the Thawte.</div>\r\n    </li>\r\n</ul>\r\n</p>', '5 Business Days', '2048-bit', 'Up to 256-bit', 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(16, 2, 6, 'Comodo EV SGC SSL', 250000.00, 2, '<p>Prevent your client''s confidential information, financial transaction,  and information transference with confident by your identification  verification by these certificates. The website and information  encryption up to 128 &ndash; 256 bits in 99% visitors in trust. The strongest  encryption and clarify identification verification will ensure your  clients even though in Windows and IE older version.</p>', '1-7 days', '2048-bit', '128/256bit', 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(17, 2, 4, 'Digicert EV Plus', 1000000.00, 2, '<p>This consists of the high-quality verification for the best Extended  Validation SSL Certificate to build in your website. The DigiCert''s EV  Plus  is a certificate works to secure both domains specified in  example.com and www.example.com under a single certificate. This means  to your clients will have the Green Address Bar on browser in with and  without &ldquo;www.&rdquo; to protect client''s important information and prevent  your brand from being Phishing and online cheating.</p>', '1-10 Days', '2048-bit', '128/256bit', 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(18, 2, 6, 'Comodo EV SSL', 250000.00, 2, '<p>To keep the level of confident high in clients with your website is  beginning by replacing the address bar for Microsoft&reg; Internet Explorer  with Green Bar. This will ensure that your website has been approved by  Certification Authority (CA) in the most strictly for this industry  founded by CA/Browser Forum.</p>', '1-7 Days', '2048-bit', '128/256bit', 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(19, 2, 2, 'GeoTrust True BusinessID With EV', 500000.00, 2, '<p>The most security SSL Certificate with most economized price, including  with Green Address Bar displaying on browser, is GeoTrust True  BusinessID with EV. It''s SSL Certificate supports 40-256 bits encryption  and displays GeoTrust True Site stamped with date approval even  customer connects via online or on mobile. When users see the symbol,  they will have known that your domain has been verified and trusted on  any their transactions will kept in encryption.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate provides the Green Address Bar on browser which needs to verify strictly spending 7-10 days. The most requirements are the domain owner identification and company of requester in company establishment document or company certificate especially signed by Lawyer or CPA.</li>\r\n    <li>GeoTrust is another brand which website of government sector, agency, association, academy, including with private company and natural person who wants the economized SSL Certificate selected.</li>\r\n</ul>\r\n<p>&nbsp;</p>', '5 Days', '2048-bit', 'Up to 256-bit', 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(20, 4, 1, 'Thawte SSL Web Server Wildcard', 125000.00, 3, '<p>A single certificate prevents all your multiple sub-domains and saves  time and investment by using Wildcard symbol (defined * in front of your  sub-domain name). This will cover all your sub-domains related with the  main domain. This Wildcard SSL will also cover the full performance of  organization verification.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>\r\n    <div>This is proper with the needing in an SSL Certificate which works global for your multiple sub-domains such as *.yourdomain.com, www.yourdomain.com, and mail.yourdomain.com spends not over a few days to issue. This SSL needs to verify the domain owner identification and company existence such as company establishment document or company certificate when making order.</div>\r\n    </li>\r\n    <li>\r\n    <div>Thawte is a second choice for E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and, etc. The business which wants the security and trustworthy on financial transaction through Internet, including with some government sector, association, or academy chooses the Thawte.</div>\r\n    </li>\r\n</ul>', '2 Business Days', '2048-bit', 'Up to 256-bit', 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(21, 4, 6, 'Instant SGC Wildcard SSL', 250000.00, 4, '<p>Protect your sub-domains in your website in unlimited by Instant SGC  Wildcard such as www.yourdomain.com, secure.yourdomain.com, and  signup.yourdomain.com. The Comodo SGC Wildcard certificate is the most  valuable to protect your multi sub-domains in a solely single  Certificate.</p>', '1-2 Days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(22, 4, 4, 'Wildcard Plus', 1000000.00, 3, '<p>The WildCard Plus SSL of DigiCert keeps all your domains in secured.  That means, the certificate for *.example.com will secure to  www.example.com, mail.example.com and other sub-domains as well. In  addition, the WildCard Plus also has more abilities, which not contained  in other kinds of certificate.</p>', '1-2 Days', '2048-bit', '128/256bit', 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(23, 4, 6, 'Premium SSL Wildcard', 250000.00, 3, '<p>Comodo Premium SSL Wildcards protects your multiple sub-domains in  unlimited under a single Wildcard SSL. You will save the investment and  time by easy SSL certificate management in a single but prevent all  sub-domains you have, including with the root keys 2048 bits support for  the future needed.</p>', '1-2 Days', '2048-bit', '128/256bit', 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(24, 4, 2, 'GeoTrust True BusinessID Wildcard', 125000.00, 3, '<div class="detailcont">A single certificate prevents all your multiple  sub-domains and saves time and investment by using Wildcard symbol  (defined * in front of your sub-domain name). This will cover all your  sub-domains related with the main domain. This Wildcard SSL will also  cover the full performance of organization verification.</div>\r\n<div class="detailcont">\r\n<ul>\r\n    <li>This is proper with the needing in an SSL Certificate which  works global for your multiple sub-domains such as *.yourdomain.com,  www.yourdomain.com, and mail.yourdomain.com spends not over a few days  to issue. This SSL needs to verify the domain owner identification and  company existence such as company establishment document or company  certificate when making order.</li>\r\n    <li>GeoTrust is another brand which website of government sector,  agency, association, academy, including with private company and natural  person who wants the economized SSL Certificate selected.</li>\r\n</ul>\r\n</div>', '2 Days', '2048-bit', 'Up to 256-bit', 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(25, 4, 7, 'Standard Wildcard SSL', 10000.00, 3, '<p>Standard Wildcard SSL is used to secure any online transactions, which  provide the encryption up to 256 bits. When without Wildcard, you will  need to have differences SSL certificate for the difference sub-domains  to protect them. The sub-domain is the sub prefix  before your domain  name as an example if you had test.coolexample.com, &quot;test&quot; is meaning to  your sub-domain. Then Wildcard SSL will save your time and certificate  expenses. </p>', '1-2 Days', '2048-bit', '128/256bit', 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(26, 4, 3, 'Rapid SSL Wildcard', 5000.00, 3, '<p>RapidSSL is a single root SSL Certificate which supports root encryption  in 128 &ndash; 256 bits. The root owner is the needed to issue this RapidSSL,  then this certificate is an equitable certificate and already contained  in IE 5.01+, Netscape 4.7+, Mozilla 1+, and other new servers of  windows, including with the Mac base server.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>\r\n    <div>This is proper with the needing in an SSL Certificate which works global for your multiple sub-domains such as *.yourdomain.com, www.yourdomain.com, and mail.yourdomain.com spends not over a few days to issue. This SSL needs to verify the domain owner identification and company existence such as company establishment document or company certificate when making order.</div>\r\n    </li>\r\n    <li>\r\n    <div>Rapid SSL is a brand which most selected by the private company or natural person who needs the economized SSL Certificate, including with the beginning E-Commerce, software developers, server organizations or administrators.</div>\r\n    </li>\r\n</ul>', '2 Days', '2048-bit', 'Up to 256-bit', 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(27, 6, 5, 'Symantec Secure Site Pro with EV + SAN Package', 1500000.00, 2, '<p>Give your visitors the reliance in the business transaction through your  website by displaying green bar on browser to assure the strongest  security and also prevent the Phishing. According to many tests  discovering more performance 5-87% when using EV Secure Site Pro with EV  with has the encryption 128-256 bits. Users then assured and trust the  strongest encryption on your website. Moreover, you also have VeriSign  Secured&reg; symbol on your website to raise the number entering 150 times a  day, including being trusted by the United States consumer up to 91%.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>\r\n    <div>This is proper with the needing in the SSL Certificate specified with Green Address Bar on Browser with verifying strictly spending 7-10 days issues. The domain owner identification and company of requester in company establishment document or company certificate especially signed by Lawyer or CPA are needed to make the order.</div>\r\n    </li>\r\n    <li>\r\n    <div>Verisign is proper with -commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and etc.</div>\r\n    </li>\r\n</ul>', '5 Days', '2048-bit', 'Up to 256-bit', 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(28, 6, 5, 'Symantec Secure Site Pro + SAN Package', 1250000.00, 1, '<p>If you assured that you have provided the best encryption to your  website visitors by SSL Secure Site Pro certificate supports the  encryption strength in 128-256 bits. Moreover, you also have VeriSign  Secured&reg; symbol on your website to raise the number entering 150 times a  day, including being trusted by the United States consumer up to 91%.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>\r\n    <div>This is proper with the needing in the SSL Certificate which easily issues and spends not over a few days to verify the domain owner identification and company existence such as company establishment document or company certificate in the order.</div>\r\n    </li>\r\n    <li>\r\n    <div>Verisign is proper with E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and etc.</div>\r\n    </li>\r\n</ul>', '2 Days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(29, 6, 5, 'Symantec Secure Site With EV + SAN Package', 1500000.00, 2, '<p>Prevent your website with the trustworthy by displaying the green bar at  the URL browser which meaning to the strongest security and Phishing  prevention performance. This is according to many tests regarding the  increase more security performance 5-87% when using VeriSign EV SSL  Secure Site with EV which supports 40-256 bits. That''s why the private  information and business transaction through your website are secured.  Moreover, you also have VeriSign Secured&reg; symbol on your website to  raise the number entering 150 times a day, including being trusted by  the United States consumer up to 91%.</p>\r\n<p><strong>Recommend !!</strong></p>\r\n<ul>\r\n    <li>\r\n    <div>This is proper with the needing in the SSL Certificate specified with Green Address Bar on Browser with verifying strictly spending 7-10 days issues. The domain owner identification and company of requester in company establishment document or company certificate especially signed by Lawyer or CPA are needed to make the order.</div>\r\n    </li>\r\n    <li>\r\n    <div>Verisign is proper with E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and etc.</div>\r\n    </li>\r\n</ul>', '5 Days', '2048-bit', 'Up to 256-bit', 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(30, 6, 5, 'Symantec Secure Site + SAN Package', 1000000.00, 1, '<p>If you assured that you have provided the best encryption to your website visitors by SSL Secure Site Pro certificate supports the encryption strength in 128-256 bits. Moreover, you also have VeriSign Secured&reg; symbol on your website to raise the number entering 150 times a day, including being trusted by the United States consumer up to 91%.</p>\r\n<p>&nbsp;</p>\r\n<div><strong>Recommend !!</strong></div>\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate which easily issues and spends not over a few days to verify the domain owner identification and company existence such as company establishment document or company certificate in the order.</li>\r\n    <li>Verisign is proper with E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and etc.</li>\r\n</ul>\r\n<p>&nbsp;</p>', '2 Days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(31, 6, 2, 'GeoTrust True BusinessID With EV + SAN Package', 500000.00, 2, '<p>The most security SSL Certificate with most economized price, including  with Green Address Bar displaying on browser, is GeoTrust True  BusinessID with EV. It''s SSL Certificate supports 40-256 bits encryption  and displays GeoTrust True Site stamped with date approval even  customer connects via online or on mobile. When users see the symbol,  they will have known that your domain has been verified and trusted on  any their transactions will kept in encryption.</p>\r\n<p>&nbsp;</p>\r\n<div><strong>Recommend !!</strong></div>\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate provides the Green Address Bar on browser which needs to verify strictly spending 7-10 days. The most requirements are the domain owner identification and company of requester in company establishment document or company certificate especially signed by Lawyer or CPA.</li>\r\n    <li>GeoTrust is another brand which website of government sector, agency, association, academy, including with private company and natural person who wants the economized SSL Certificate selected.</li>\r\n</ul>\r\n<p>&nbsp;</p>', '5 Days', '2048-bit', 'Up to 256-bit', 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(32, 6, 4, 'Digicert UC/SAN', 1000000.00, 3, '<p>Unified Communications Certificates (sometime called UC or SAN  Certificates) is a certificate which can secure server up to 150 server  names under a single certificate. This kind of certificate supports  using in Microsoft Exchange Server 2007 and Office Communications Server  approved in security with another platform using even though the host  names are on the difference domains (such as mail.example.com and  mail.example.loca). UC or SAN Certificates give you more value and save  your investment.</p>', '1-2 Days', '2048-bit', 'Up to 256-bit', 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(33, 6, 2, 'GeoTrust True BusinessID + SAN Package', 250000.00, 1, '<div class="detailcont">If you were looking for the most economized SSL  Certificate for your company. The GeoTrust True BusinessID is the  selection. It is able to display GeoTrust True Site stamped with date  approval even customer connects via online or on mobile. When users see  the symbol, they will have known that your domain has been verified and  trusted on any their transactions will kept in encryption.</div>\r\n<div class="detailcont">\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate which  easily issues and spends not over a few days to verify the domain owner  identification and company existence such as company establishment  document or company certificate in the order.</li>\r\n    <li>GeoTrust is another brand which website of government sector,  agency, association, academy, including with private company and natural  person who wants the economized SSL Certificate selected.</li>\r\n</ul>\r\n</div>', '2 Days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(34, 5, 5, 'Symantec Secure Site Pro With EV', 1500000.00, 2, '<p>Give your visitors the reliance in the business transaction through your  website by displaying green bar on browser to assure the strongest  security and also prevent the Phishing. According to many tests  discovering more performance 5-87% when using EV Secure Site Pro with EV  with has the encryption 128-256 bits. Users then assured and trust the  strongest encryption on your website. Moreover, you also have VeriSign  Secured&reg; symbol on your website to raise the number entering 150 times a  day, including being trusted by the United States consumer up to 91%.</p>\r\n<p>\r\n<div><strong>Recommend !!</strong></div>\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate specified with Green Address Bar on Browser with verifying strictly spending 7-10 days issues. The domain owner identification and company of requester in company establishment document or company certificate especially signed by Lawyer or CPA are needed to make the order.</li>\r\n</ul>\r\n</p>', '5 Days', '2048-bit', 'Up to 256-bit', 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(35, 5, 5, 'Symantec Secure Site Pro', 1250000.00, 1, '<p>If you assured that you have provided the best encryption to your  website visitors by SSL Secure Site Pro certificate supports the  encryption strength in 128-256 bits. Moreover, you also have VeriSign  Secured&reg; symbol on your website to raise the number entering 150 times a  day, including being trusted by the United States consumer up to 91%.</p>\r\n<p>\r\n<div><strong>Recommend !!</strong></div>\r\n<ul>\r\n    <li>This is proper with the needing in the SSL Certificate which easily issues and spends not over a few days to verify the domain owner identification and company existence such as company establishment document or company certificate in the order.</li>\r\n    <li>Verisign is proper with E-commerce Online Website, a business which has credit card payment online and online booking service for room service, hotel and travel, bank and financial, Securities company, and etc.</li>\r\n</ul>\r\n</p>', '2 Days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(36, 5, 6, 'Instant SGC Wildcard SSL', 250000.00, 4, '<p>Protect your sub-domains in your website in unlimited by Instant SGC  Wildcard such as www.yourdomain.com, secure.yourdomain.com, and  signup.yourdomain.com. The Comodo SGC Wildcard certificate is the most  valuable to protect your multi sub-domains in a solely single  Certificate.</p>', '1-2 Days', '2048-bit', '128/256bit', 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(37, 5, 6, 'Comodo EV SGC SSL', 250000.00, 2, '<p>Prevent your client''s confidential information, financial transaction,  and information transference with confident by your identification  verification by these certificates. The website and information  encryption up to 128 &ndash; 256 bits in 99% visitors in trust. The strongest  encryption and clarify identification verification will ensure your  clients even though in Windows and IE older version.</p>', '1-7 Days', '2048-bit', '128/256bit', 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(38, 5, 1, 'Thawte SSL SGC SuperCerts', 500000.00, 1, '<p>If you wanted the complicated and strongest encryption for website  visitors on SGC technology provide at least 128 bits security even  though your clients using the older performance server supporting just  40-56 bits. Moreover, you can also display the Thawte Trusted Site   stamped with date approval to provide the SSL to your visitors in  complete.</p>', '2 Business Days', '2048-bit', 'Up to 256-bit', 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(39, 5, 6, 'Instant SGC SSL', 250000.00, 1, '<p>The Comodo SGC SSL will take up the encryption performance in the old  version server 40 bits until the common standard 128 &ndash; 256 bits. That  means, your website is protected and trusted in Internet user even most  of them may use Windows and Internet Explorer in the older version.</p>', '1-2 Days', '2048-bit', '128/256bit', 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, '1');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(40, 7, 5, 'Symantec Code Signing', 0.00, 1, '<p>Symantec Code Signing provides a lot more of platforms and code signing  to increase trustworthy and to grow the download performance up. It will  also decrease the error and security warning message to prevent users  from downloading the unsafe files.</p>\r\n<p>Please select a Code Signing Certificate Type:</p>\r\n<ul>\r\n    <li><strong>Microsoft&reg; Authenticode</strong> :&nbsp;These certificates are used with the Microsoft InetSDK developer tools to sign ActiveX controls, .CAB, .EXE and .DLL files, and other potentially harmful active content on Microsoft platforms.</li>\r\n    <li>\r\n    <div>&nbsp;</div>\r\n    <strong>Sun Java&trade;</strong> :&nbsp;<span style="font-size: 12px;">These certificates are identical to Microsoft Authenticode certificates, and are used by developers to sign macros in Office and other VBA environments.&nbsp;<br />\r\n    </span></li>\r\n    <li><strong>Microsoft Office and VBA </strong>:&nbsp;These certificates include a free time stamping service and can be used to sign .jar and midlet file types. The minimum enrollment requirement is: Internet Explorer&trade; 5.0 or greater, Netscape&trade; 4.7 and greater, Firefox&trade; all versions and Opera all versions.</li>\r\n    <li><strong>Adobe AIR </strong>:&nbsp;These certificates include a free time stamping service and can be used to sign .air and .airi file types. The minimum enrollment requirement is Firefox&trade;.</li>\r\n</ul>\r\n<p>&nbsp;</p>', '1-2 hours', '2048-bit', 'Up to 256-bit', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(41, 7, 4, 'Digicert Code Signing', 0.00, 1, '<p>Digicert Code Signing affords customers to get their software or  applications signed in digital, especially the ones which offer to  download and work in online transaction to ensure those codes will not  be edited or offended in process. The digital code signing which  approved by trustworthy authority will keep the code needless from  unnecessary warning when download.</p>', '3-4 hours', '2048-bit', 'Up to 256-bit', 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, '0');
REPLACE INTO hb_ssl (ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan, seal_in_search, siteseal_id) VALUES(42, 7, 1, 'Thawte Code Signing', 0.00, 1, '<p>The growing up of online is created to be the advantage for developers  to build the applicable codes which convenient to use anywhere, but  means to the growing up of unsafe code and corrupt activities as well.  To prevent the developments from those harm is to have a Thawte Code  Signing certificate which secures your code, including to express the  trustworthy to your users by shrink-wrapped software as well.</p>\r\n<p>&nbsp;</p>\r\n<div>Please select a Code Signing Certificate Type:</div>\r\n<div>&nbsp;</div>\r\n<p><span class="Apple-tab-span" style="white-space:pre">    </span>Thawte&trade; Code Signing Certificate for Mac&trade; :&nbsp;These certificates can be used by Apple developers with a future version of the Apple Mac OS to sign software for electronic distribution. Minimum Browser Requirement: FireFox.</p>\r\n<div><span class="Apple-tab-span" style="white-space:pre">  </span>Thawte&trade; Code Signing Certificate for Java&trade; :&nbsp;These certificates can be used with JavaSoft''s JDK 1.3 and later to sign applets.&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<div><span class="Apple-tab-span" style="white-space:pre">  </span>Thawte&trade; Code Signing Certificate for Microsoft&trade; Authenticode&trade; (Multi-Purpose) :&nbsp;These certificates are used with the Microsoft InetSDK developer tools to sign ActiveX controls, .CAB, .EXE and .DLL files, and other potentially harmful active content on Microsoft platforms.</div>\r\n<div>&nbsp;</div>\r\n<div><span class="Apple-tab-span" style="white-space:pre"> </span>Thawte&trade; Code Signing Certificate for Microsoft&trade; Office and VBA :&nbsp;These certificates are identical to Microsoft Authenticode certificates, and are used by developers to sign macros in Office and other VBA environments.</div>\r\n<div>&nbsp;</div>\r\n<div><span class="Apple-tab-span" style="white-space:pre">  </span>Thawte&trade; Code Signing Certificate for Adobe&trade; AIR&trade; :<span class="Apple-tab-span" style="white-space:pre">    </span>These certificates are used to sign applications for Adobe AIR. Minimum Browser Requirement: FireFox.</div>\r\n<p>&nbsp;</p>', '1-2 hours', '2048-bit', 'Up to 256-bit', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0');


#########################################################################
# ssl siteseal
#########################################################################
REPLACE INTO hb_ssl_siteseal (ssl_siteseal_id, ssl_authority_id, siteseal_name, install_url) VALUES(1, '1', 'Dynamic Displays', 'http://www.thawte.com/ssl/secured-seal/installation-agreement/index.html');
REPLACE INTO hb_ssl_siteseal (ssl_siteseal_id, ssl_authority_id, siteseal_name, install_url) VALUES(2, '2', 'Dynamic Displays', 'http://www.geotrust.com/support/quick-ssl-support/premium-true-site-seal/');
REPLACE INTO hb_ssl_siteseal (ssl_siteseal_id, ssl_authority_id, siteseal_name, install_url) VALUES(3, '3', 'Dynamic Displays', 'http://www.rapidssl.com/ssl-certificate-support/ssl-site-seal/rapidssl.htm');
REPLACE INTO hb_ssl_siteseal (ssl_siteseal_id, ssl_authority_id, siteseal_name, install_url) VALUES(4, '4', 'Dynamic Displays', 'http://www.digicert.com/ssl-support/digicert-security-seal.htm');
REPLACE INTO hb_ssl_siteseal (ssl_siteseal_id, ssl_authority_id, siteseal_name, install_url) VALUES(5, '5', 'Dynamic Displays', 'http://www.verisign.com/ssl/secured-seal/index.html');
REPLACE INTO hb_ssl_siteseal (ssl_siteseal_id, ssl_authority_id, siteseal_name, install_url) VALUES(6, '6', 'Dynamic Displays', 'http://www.instantssl.com/ssl-certificate-products/ssl-certificate-corner-trust.html');
REPLACE INTO hb_ssl_siteseal (ssl_siteseal_id, ssl_authority_id, siteseal_name, install_url) VALUES(7, '7', 'Dynamic Displays', 'https://www.godaddy.com/ssl/ssl-certificates.aspx');

#########################################################################
# ssl webserver vendor
#########################################################################
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(1, '4D, Inc.');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(2, 'Apache');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(3, 'BEA Systems');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(4, 'Cisco');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(5, 'Covalent');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(6, 'F5');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(7, 'IBM');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(8, 'Lotus');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(9, 'Microsoft');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(10, 'Netscape');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(11, 'Netscreen');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(12, 'Nortel');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(13, 'Red Hat');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(14, 'SonicWALL');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(15, 'Stronghold');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(16, 'Sun');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(17, 'Sybase');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(18, 'Tomcat');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(19, 'Oracle');
REPLACE INTO hb_webserver_vendor (webserver_vendor_id, vender_name) VALUES(20, 'Zeus');

#########################################################################
# ssl webserver
#########################################################################
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(1, 1, 'Webstar 4.x');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(2, 2, 'ApacheSSL mod_ssl');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(3, 3, 'WebLogic 6.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(4, 3, 'WebLogic 8.1');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(5, 3, 'WebLogic 10.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(6, 4, 'ACS 3.2');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(7, 5, 'Apache ERS 2.4');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(8, 5, 'Apache ERS 3.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(9, 6, 'BIG-IP');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(10, 7, 'Websphere MQ');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(11, 7, 'HTTP Server - OpenSSL');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(12, 7, 'HTTP Server - IKEYMAN');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(13, 8, 'Domino 5.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(14, 8, 'Domino 6.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(15, 8, 'Domino 7.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(16, 8, 'Domino 8.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(17, 9, 'Windows 2000 - IIS 5.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(18, 9, 'Windows 2003 - IIS 6.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(19, 9, 'Windows 2008 - IIS 7.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(20, 9, 'Exchange 2007');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(21, 9, 'Exchange 2010');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(22, 10, 'iPlanet 4.x');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(23, 10, 'iPlanet 6.x');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(24, 11, 'ScreenOS');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(25, 12, 'SSL Accelerator');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(26, 19, 'Oracle Wallet Manager');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(27, 13, 'Secure Web Server');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(28, 14, 'SSL Offloaders');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(29, 15, 'Stronghold');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(30, 16, 'Java Web Server 6.x');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(31, 16, 'Sun ONE');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(32, 17, 'AS Server w/IIS 5');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(33, 17, 'EA Server');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(34, 18, 'Tomcat');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(35, 20, 'Zeus');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(36, 2, 'Mac OS X Server');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(37, 9, 'Windows NT - IIS 4.0');
REPLACE INTO hb_webserver (webserver_id, webserver_vender_id, application) VALUES(38, 17, 'AS Server w/IIS 4');

CREATE TABLE IF NOT EXISTS hb_ssl_order (
  order_id int(11) NOT NULL,
  usr_id varchar(40) NOT NULL,
  date_created int(11) NOT NULL,
  last_updated int(11) NOT NULL,
  csr text NOT NULL,
  code_certificate text NOT NULL,
  code_ca text NOT NULL,
  date_expire int(11) NOT NULL,
  ssl_id int(3) NOT NULL,
  pid int(11) NOT NULL,
  contract int(2) NOT NULL,
  authority_orderid varchar(50) NOT NULL,
  status_accept tinyint(1) NOT NULL COMMENT '1=ยอมรับ order,0=ไม่ยอมรับ order',
  status_detail int(4) NOT NULL,
  email_approval varchar(255) NOT NULL,
  server_type varchar(150) NOT NULL,
  comment text NOT NULL,
  commonname varchar(255) NOT NULL,
  PRIMARY KEY (order_id),
  KEY ssl_info_id (order_id)
);

CREATE TABLE IF NOT EXISTS hb_res_cpservers (
  cpserver_id int(11) NOT NULL AUTO_INCREMENT,
  usr_id varchar(35) NOT NULL,
  hostname varchar(255) NOT NULL,
  cptype varchar(255) NOT NULL,
  owner_id varchar(35) NOT NULL,
  cp_name varchar(16) NOT NULL,
  PRIMARY KEY (cpserver_id),
  UNIQUE KEY usr_id (usr_id,hostname),
  KEY usr_id_2 (usr_id,hostname,owner_id)
);

CREATE TABLE IF NOT EXISTS hb_res_registry (
  req_key varchar(255) NOT NULL,
  user_id int(11) NOT NULL,
  req_value text NOT NULL,
  UNIQUE KEY req_key_1 (req_key,user_id),
  KEY req_key (req_key,user_id)
);

CREATE TABLE IF NOT EXISTS hb_rvg_currencies (
  code varchar(3) NOT NULL,
  currency varchar(255) NOT NULL,
  rate decimal(10,5) NOT NULL DEFAULT '1.00000',
  PRIMARY KEY (code)
);

REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('AED', 'United Arab Emirates dirham', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('AFN', 'Afghan afghani', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('ALL', 'Albanian lek', 110.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('AMD', 'Armenian dram', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('ANG', 'Netherlands Antillean guilder', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('AOA', 'Angolan kwanza', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('ARS', 'Argentine peso', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('AUD', 'Australian dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('AWG', 'Aruban florin', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('AZN', 'Azerbaijani manat', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BAM', 'Bosnia and Herzegovina convertible mark', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BBD', 'Barbadian dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BDT', 'Bangladeshi taka', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BGN', 'Bulgarian lev', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BHD', 'Bahraini dinar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BIF', 'Burundian franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BMD', 'Bermudian dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BND', 'Brunei dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BOB', 'Bolivian boliviano', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BRL', 'Brazilian real', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BSD', 'Bahamian dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BTN', 'Bhutanese ngultrum', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BWP', 'Botswana pula', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BYR', 'Belarusian ruble', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('BZD', 'Belize dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('CAD', 'Canadian dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('CDF', 'Congolese franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('CHF', 'Swiss franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('CLP', 'Chilean peso', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('CNY', 'Chinese yuan', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('COP', 'Colombian peso', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('CRC', 'Costa Rican colón', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('CUC', 'Cuban convertible peso', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('CVE', 'Cape Verdean escudo', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('CZK', 'Czech koruna', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('DJF', 'Djiboutian franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('DKK', 'Danish krone', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('DOP', 'Dominican peso', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('DZD', 'Algerian dinar', 81.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('EGP', 'Egyptian pound', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('ERN', 'Eritrean nakfa', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('ETB', 'Ethiopian birr', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('EUR', 'Euro', 0.80000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('FJD', 'Fijian dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('FKP', 'Falkland Islands pound', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('GBP', 'British pound[C]', 0.70000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('GEL', 'Georgian lari', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('GHS', 'Ghana cedi', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('GIP', 'Gibraltar pound', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('GMD', 'Gambian dalasi', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('GNF', 'Guinean franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('GTQ', 'Guatemalan quetzal', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('GYD', 'Guyanese dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('HKD', 'Hong Kong dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('HNL', 'Honduran lempira', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('HRK', 'Croatian kuna', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('HTG', 'Haitian gourde', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('HUF', 'Hungarian forint', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('IDR', 'Indonesian rupiah', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('ILS', 'Israeli new shekel', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('INR', 'Indian rupee', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('IQD', 'Iraqi dinar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('IRR', 'Iranian rial', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('ISK', 'Icelandic króna', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('JMD', 'Jamaican dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('JOD', 'Jordanian dinar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('JPY', 'Japanese yen', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('KES', 'Kenyan shilling', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('KGS', 'Kyrgyzstani som', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('KHR', 'Cambodian riel', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('KMF', 'Comorian franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('KPW', 'North Korean won', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('KRW', 'South Korean won', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('KWD', 'Kuwaiti dinar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('KYD', 'Cayman Islands dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('KZT', 'Kazakhstani tenge', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('LAK', 'Lao kip', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('LBP', 'Lebanese pound', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('LKR', 'Sri Lankan rupee', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('LRD', 'Liberian dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('LSL', 'Lesotho loti', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('LTL', 'Lithuanian litas', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('LVL', 'Latvian lats', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('LYD', 'Libyan dinar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MAD', 'Moroccan dirham', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MDL', 'Moldovan leu', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MGA', 'Malagasy ariary', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MKD', 'Macedonian denar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MMK', 'Burmese kyat', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MNT', 'Mongolian tögrög', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MOP', 'Macanese pataca', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MRO', 'Mauritanian ouguiya', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MUR', 'Mauritian rupee', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MVR', 'Maldivian rufiyaa', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MWK', 'Malawian kwacha', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MXN', 'Mexican peso', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MYR', 'Malaysian ringgit', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('MZN', 'Mozambican metical', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('NAD', 'Namibian dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('NGN', 'Nigerian naira', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('NIO', 'Nicaraguan córdoba', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('NOK', 'Norwegian krone', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('NPR', 'Nepalese rupee', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('NZD', 'New Zealand dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('OMR', 'Omani rial', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('PAB', 'Panamanian balboa', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('PEN', 'Peruvian nuevo sol', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('PGK', 'Papua New Guinean kina', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('PHP', 'Philippine peso', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('PKR', 'Pakistani rupee', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('PLN', 'Polish z?oty', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('PYG', 'Paraguayan guaraní', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('QAR', 'Qatari riyal', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('RON', 'Romanian leu', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('RSD', 'Serbian dinar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('RUB', 'Russian ruble', 33.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('RWF', 'Rwandan franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SAR', 'Saudi riyal', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SBD', 'Solomon Islands dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SCR', 'Seychellois rupee', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SDG', 'Sudanese pound', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SEK', 'Swedish krona', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SHP', 'Saint Helena pound', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SLL', 'Sierra Leonean leone', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SOS', 'Somali shilling', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SRD', 'Surinamese dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SSP', 'South Sudanese pound', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('STD', 'São Tomé and Príncipe dobra', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SVC', 'Salvadoran colón', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SYP', 'Syrian pound', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('SZL', 'Swazi lilangeni', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('THB', 'Thai baht', 31.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('TJS', 'Tajikistani somoni', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('TMT', 'Turkmenistan manat', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('TND', 'Tunisian dinar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('TOP', 'Tongan pa?anga', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('TRY', 'Turkish lira', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('TTD', 'Trinidad and Tobago dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('TWD', 'New Taiwan dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('TZS', 'Tanzanian shilling', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('UAH', 'Ukrainian hryvnia', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('UGX', 'Ugandan shilling', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('USD', 'United States dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('UYU', 'Uruguayan peso', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('UZS', 'Uzbekistani som', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('VEF', 'Venezuelan bolívar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('VND', 'Vietnamese ??ng', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('VUV', 'Vanuatu vatu', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('WST', 'Samoan t?l?', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('XAF', 'Central African CFA franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('XCD', 'East Caribbean dollar', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('XOF', 'West African CFA franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('XPF', 'CFP franc', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('YER', 'Yemeni rial', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('ZAR', 'South African rand', 1.00000);
REPLACE INTO hb_rvg_currencies (code, currency, rate) VALUES('ZMK', 'Zambian kwacha', 1.00000);

CREATE TABLE IF NOT EXISTS hb_ssl_recommend_price (
  ssl_id int(3) NOT NULL,
  contract int(3) NOT NULL,
  initial_price decimal(10,2) NOT NULL,
  renewal_price decimal(10,2) NOT NULL,
  UNIQUE KEY ssl_id (ssl_id,contract)
);

REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(1, 12, 59.00, 59.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(1, 24, 103.25, 103.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(1, 36, 147.50, 147.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(1, 48, 191.75, 191.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(2, 12, 75.00, 75.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(2, 24, 131.25, 131.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(2, 36, 187.50, 187.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(2, 48, 243.75, 243.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(3, 12, 17.50, 17.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(3, 24, 30.63, 30.63);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(3, 36, 43.75, 43.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(3, 48, 56.88, 56.88);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(6, 12, 829.00, 829.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(6, 24, 1450.75, 1450.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(6, 36, 2072.50, 2072.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(6, 48, 2694.25, 2694.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(7, 12, 319.00, 319.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(7, 24, 558.25, 558.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(7, 36, 797.50, 797.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(7, 48, 1036.75, 1036.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(8, 12, 89.00, 89.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(8, 24, 155.75, 155.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(8, 36, 222.50, 222.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(8, 48, 289.25, 289.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(9, 12, 111.00, 111.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(9, 24, 194.25, 194.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(9, 36, 277.50, 277.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(9, 48, 360.75, 360.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(13, 12, 1199.00, 1199.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(13, 24, 2098.25, 2098.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(14, 12, 829.00, 829.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(14, 24, 1450.75, 1450.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(15, 12, 529.00, 529.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(15, 24, 925.75, 925.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(19, 12, 179.00, 179.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(19, 24, 313.25, 313.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(20, 12, 519.00, 519.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(20, 24, 908.25, 908.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(24, 12, 359.00, 359.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(24, 24, 628.25, 628.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(24, 36, 897.50, 897.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(24, 48, 1166.75, 1166.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(26, 12, 129.00, 129.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(26, 24, 225.75, 225.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(26, 36, 322.50, 322.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(26, 48, 419.25, 419.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(27, 12, 5995.00, 5995.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(27, 24, 10491.25, 10491.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(28, 12, 4145.00, 4145.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(28, 24, 7253.75, 7253.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(28, 36, 10362.50, 10362.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(28, 48, 13471.25, 13471.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(29, 12, 4145.00, 4145.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(29, 24, 7253.75, 7253.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(30, 12, 1635.00, 1635.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(30, 24, 2861.25, 2861.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(30, 36, 4087.50, 4087.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(30, 48, 5313.75, 5313.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(31, 12, 350.00, 350.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(31, 24, 612.50, 612.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(33, 12, 250.00, 250.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(33, 24, 437.50, 437.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(33, 36, 625.00, 625.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(33, 48, 812.50, 812.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(34, 12, 1199.00, 1199.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(34, 24, 2098.25, 2098.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(35, 12, 829.00, 829.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(35, 24, 1450.75, 1450.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(35, 36, 2072.50, 2072.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(35, 48, 2694.25, 2694.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(38, 12, 349.00, 349.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(38, 24, 610.75, 610.75);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(38, 36, 872.50, 872.50);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(38, 48, 1134.25, 1134.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(40, 12, 459.00, 459.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(40, 24, 803.25, 803.25);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(42, 12, 199.00, 199.00);
REPLACE INTO hb_ssl_recommend_price (ssl_id, contract, initial_price, renewal_price) VALUES(42, 24, 348.25, 348.25);


CREATE TABLE IF NOT EXISTS hb_ssl_reseller_price (
  ssl_id int(5) NOT NULL,
  usr_id int(11) NOT NULL,
  contract int(3) NOT NULL,
  initial_price decimal(10,2) NOT NULL,
  renewal_price decimal(10,2) NOT NULL,
  currency varchar(4) NOT NULL,
  billing_pid varchar(50) NOT NULL,
  UNIQUE KEY ssl_id (ssl_id, usr_id,contract,currency),
  KEY ssl_price_reseller_id (usr_id,ssl_id)
);

CREATE TABLE IF NOT EXISTS hb_res_serverlist (
  hostname char(255) NOT NULL,
  usr_id int(11) NOT NULL,
  type text NOT NULL,
  adminname varchar(64) NOT NULL,
  disabled int(1) NOT NULL,
  UNIQUE KEY hostname (hostname,usr_id)
);

--
-- Update 12/06/2013
--
CREATE TABLE IF NOT EXISTS hb_ssl_order_cpuser (
  id int(11) NOT NULL AUTO_INCREMENT,
  cp_user_id varchar(50) NOT NULL,
  owner_id int(11) NOT NULL,
  owner_order_id varchar(255) NOT NULL,
  owner_invoiceid varchar(255) NOT NULL,
  hb_order_id int(11) NOT NULL,
  ssl_id int(3) NOT NULL,
  csr text NOT NULL,
  email_approval varchar(255) NOT NULL,
  commonname varchar(255) NOT NULL,
  servertype varchar(255) NOT NULL,
  status_order int(11) NOT NULL,
  order_date int(11) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS hb_res_customfields (
  usr_id int(11) NOT NULL,
  relid int(11) NOT NULL,
  csr int(11) NOT NULL,
  email_approval int(11) NOT NULL,
  commonname int(11) NOT NULL,
  servertype int(11) NOT NULL,
  UNIQUE KEY usr_id (usr_id,relid)
);

CREATE TABLE IF NOT EXISTS hb_ssl_webserver_vendor 
(
  webserver_vendor_id int(2) NOT NULL,
  vender_name varchar(255) NOT NULL,
  PRIMARY KEY (webserver_vendor_id),
  INDEX ( webserver_vendor_id, vender_name)
);


CREATE TABLE IF NOT EXISTS hb_ssl_webserver 
(
  webserver_id int(3) NOT NULL ,
  webserver_vender_id int(2) NOT NULL,
  application varchar(255) NOT NULL,
  PRIMARY KEY (webserver_id),
  UNIQUE KEY webserver_vender_id (webserver_vender_id, application)
);

REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(1, '4D, Inc.');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(2, 'Apache');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(3, 'BEA Systems');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(4, 'Cisco');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(5, 'Covalent');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(6, 'F5');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(7, 'IBM');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(8, 'Lotus');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(9, 'Microsoft');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(10, 'Netscape');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(11, 'Netscreen');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(12, 'Nortel');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(13, 'Red Hat');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(14, 'SonicWALL');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(15, 'Stronghold');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(16, 'Sun');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(17, 'Sybase');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(18, 'Tomcat');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(19, 'Oracle');
REPLACE INTO hb_ssl_webserver_vendor (webserver_vendor_id, vender_name) VALUES(20, 'Zeus');

REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(1, 1, 'Webstar 4.x');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(2, 2, 'ApacheSSL mod_ssl');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(3, 3, 'WebLogic 6.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(4, 3, 'WebLogic 8.1');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(5, 3, 'WebLogic 10.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(6, 4, 'ACS 3.2');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(7, 5, 'Apache ERS 2.4');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(8, 5, 'Apache ERS 3.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(9, 6, 'BIG-IP');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(10, 7, 'Websphere MQ');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(11, 7, 'HTTP Server - OpenSSL');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(12, 7, 'HTTP Server - IKEYMAN');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(13, 8, 'Domino 5.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(14, 8, 'Domino 6.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(15, 8, 'Domino 7.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(16, 8, 'Domino 8.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(17, 9, 'Windows 2000 - IIS 5.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(18, 9, 'Windows 2003 - IIS 6.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(19, 9, 'Windows 2008 - IIS 7.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(20, 9, 'Exchange 2007');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(21, 9, 'Exchange 2010');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(22, 10, 'iPlanet 4.x');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(23, 10, 'iPlanet 6.x');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(24, 11, 'ScreenOS');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(25, 12, 'SSL Accelerator');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(26, 19, 'Oracle Wallet Manager');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(27, 13, 'Secure Web Server');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(28, 14, 'SSL Offloaders');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(29, 15, 'Stronghold');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(30, 16, 'Java Web Server 6.x');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(31, 16, 'Sun ONE');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(32, 17, 'AS Server w/IIS 5');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(33, 17, 'EA Server');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(34, 18, 'Tomcat');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(35, 20, 'Zeus');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(36, 2, 'Mac OS X Server');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(37, 9, 'Windows NT - IIS 4.0');
REPLACE INTO hb_ssl_webserver (webserver_id, webserver_vender_id, application) VALUES(38, 17, 'AS Server w/IIS 4');


--
-- Add Field `hb_coupons` เอาแบบเพิ่ม field ก่อนครับ คราวหลังจะไม่ทำครับ !!
-- Update Time 19 มิ.ย. 2556
-- Update Field ที่ Server Rvglobalsoft.com แล้ว
--
ALTER TABLE `hb_coupons` ADD `view_order_cart0` INT( 5 ) NOT NULL AFTER `notes` ;
ALTER TABLE `hb_coupons` ADD `view_order_cart3` INT( 5 ) NOT NULL AFTER `view_order_cart0` ;
ALTER TABLE `hb_coupons` ADD `view_coupon_details` TEXT NOT NULL AFTER `view_order_cart3` ;

--
-- Add Field `hb_client_billing` เอาแบบเพิ่ม field :cardholder เก็บชื่อผู้ถือบัตร
-- Update Time Time 31 ก.ค 2556
-- Update Field ที่ Server Rvglobalsoft.com แล้ว
--
ALTER TABLE `hb_client_billing` ADD `cardholder` VARCHAR( 128 ) NOT NULL AFTER `overideduenotices` 

--
-- Add Field `hb_price_app_rvcpanel` สำหรับ cpanel
-- price_code : m,q,s,a,b,t (Monthly,Quarterly,Semi-Annually,Annually ,Biennially,Triennially )
-- cpl_group : get by cpanel
-- cpl_package : get by cpanel
-- Update Time Time 31 ก.ค 2556
-- Update Field ที่ Server Rvglobalsoft.com แล้ว

CREATE TABLE `rvglobal_hostbill`.`hb_price_app_rvcpanel` (
`product_id` INT( 11 ) NOT NULL ,
`price_code` CHAR( 1 ) NOT NULL ,
`cpl_group` VARCHAR( 10 ) NOT NULL ,
`cpl_package` VARCHAR( 10 ) NOT NULL ,
UNIQUE (
`product_id` ,
`price_code`
)
) ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci;



--
-- Add Field `hb_rvcpanel_manage_log` สำหรับ cpanel
-- Update Time 31 ก.ค 2556
-- Update Field ที่ Server Rvglobalsoft.com แล้ว
--
CREATE TABLE IF NOT EXISTS `hb_rvcpanel_manage_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `licenseid` int(11) NOT NULL,
  `ip` VARCHAR(16) NOT NULL,
  `reason` text CHARACTER SET utf8 NOT NULL,
  `date_log` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `action` varchar(20) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

### Add date '2013-06-17' ###
ALTER TABLE `hb_knowledgebase_cat` ADD `google_drive_id` VARCHAR( 64 ) NOT NULL;
ALTER TABLE `hb_knowledgebase_cat` ADD `sync_date` INT NOT NULL;
ALTER TABLE `hb_knowledgebase` ADD `google_drive_file_id` VARCHAR( 64 ) NOT NULL AFTER `options`;
ALTER TABLE `hb_knowledgebase` ADD `last_sync_date` INT NOT NULL;
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('nwLastKbCategorySyncWithGoogleDrive', '0');


### Add date "2013-08-20" BooM ###
CREATE TABLE IF NOT EXISTS `hb_oauth_appsuser` (
  `appsuser_id` varchar(50) NOT NULL,
  `cpuser_id` varchar(50) NOT NULL,
  `privatekey` varchar(2500) NOT NULL,
  `key_phrase` varchar(8) NOT NULL,
  `domainname` varchar(255) NOT NULL,
  `app_name` varchar(255) NOT NULL,
  PRIMARY KEY (`appsuser_id`),
  KEY `appsuser_id` (`appsuser_id`)
) ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci;
