<?php

namespace Badcow\DNS\Parser;

class RDataTypes
{
    /**
     * @var array
     */
    public static $names = [self::TYPE_A, self::TYPE_NS, self::TYPE_CNAME, self::TYPE_SOA, self::TYPE_PTR, self::TYPE_MX, self::TYPE_TXT, self::TYPE_AAAA, self::TYPE_OPT, self::TYPE_AXFR, self::TYPE_ANY, self::TYPE_AFSDB, self::TYPE_APL, self::TYPE_CAA, self::TYPE_CDNSKEY, self::TYPE_CDS, self::TYPE_CERT, self::TYPE_DHCID, self::TYPE_DLV, self::TYPE_DNSKEY, self::TYPE_DS, self::TYPE_IPSECKEY, self::TYPE_KEY, self::TYPE_KX, self::TYPE_LOC, self::TYPE_NAPTR, self::TYPE_NSEC, self::TYPE_NSEC3, self::TYPE_NSEC3PARAM, self::TYPE_RRSIG, self::TYPE_RP, self::TYPE_SIG, self::TYPE_SRV, self::TYPE_SSHFP, self::TYPE_TA, self::TYPE_TKEY, self::TYPE_TLSA, self::TYPE_TSIG, self::TYPE_URI, self::TYPE_DNAME];
    const TYPE_A = 'A';
    const TYPE_NS = 'NS';
    const TYPE_CNAME = 'CNAME';
    const TYPE_SOA = 'SOA';
    const TYPE_PTR = 'PTR';
    const TYPE_MX = 'MX';
    const TYPE_TXT = 'TXT';
    const TYPE_AAAA = 'AAAA';
    const TYPE_OPT = 'OPT';
    const TYPE_AXFR = 'AXFR';
    const TYPE_ANY = 'ANY';
    const TYPE_AFSDB = 'AFSDB';
    const TYPE_APL = 'APL';
    const TYPE_CAA = 'CAA';
    const TYPE_CDNSKEY = 'CDNSKEY';
    const TYPE_CDS = 'CDS';
    const TYPE_CERT = 'CERT';
    const TYPE_DHCID = 'DHCID';
    const TYPE_DLV = 'DLV';
    const TYPE_DNSKEY = 'DNSKEY';
    const TYPE_DS = 'DS';
    const TYPE_IPSECKEY = 'IPSECKEY';
    const TYPE_KEY = 'KEY';
    const TYPE_KX = 'KX';
    const TYPE_LOC = 'LOC';
    const TYPE_NAPTR = 'NAPTR';
    const TYPE_NSEC = 'NSEC';
    const TYPE_NSEC3 = 'NSEC3';
    const TYPE_NSEC3PARAM = 'NSEC3PARAM';
    const TYPE_RRSIG = 'RRSIG';
    const TYPE_RP = 'RP';
    const TYPE_SIG = 'SIG';
    const TYPE_SRV = 'SRV';
    const TYPE_SSHFP = 'SSHFP';
    const TYPE_TA = 'TA';
    const TYPE_TKEY = 'TKEY';
    const TYPE_TLSA = 'TLSA';
    const TYPE_TSIG = 'TSIG';
    const TYPE_URI = 'URI';
    const TYPE_DNAME = 'DNAME';
    /**
     * @param string $type
     *
     * @return bool
     */
    public static function isValid($type)
    {
        return false !== array_search($type, self::$names);
    }
}