<?php
namespace IPTools;
use Brick\Math\BigInteger;

/**
 * @author Safarov Alisher <alisher.safarov@outlook.com>
 * @link https://github.com/S1lentium/IPTools
 */
class IP
{
    use PropertyTrait;

    const IP_V4 = 'IPv4';
    const IP_V6 = 'IPv6';

    const IP_V4_MAX_PREFIX_LENGTH = 32;
    const IP_V6_MAX_PREFIX_LENGTH = 128;

    const IP_V4_OCTETS = 4;
    const IP_V6_OCTETS = 16;

    /**
     * @var string
     */
    private $in_addr;

    /**
     * @param string ip
     * @throws \Exception
     */
    public function __construct($ip)
    {
        if (!filter_var($ip, FILTER_VALIDATE_IP)) {
            throw new \Exception("Invalid IP address format");
        }
        $this->in_addr = self::_inet_pton($ip);
    }

    /**
     * @return string
     */
    public function __toString()
    {
        return self::_inet_ntop($this->in_addr);
    }

    /**
     * @param string ip
     * @return IP
     * @throws \Exception
     */
    public static function parse($ip)
    {
        if ($ip instanceof IP) {
            return clone $ip;
        } elseif (strpos($ip, '0x') === 0) {
            $ip = substr($ip, 2);
            return self::parseHex($ip);
        } elseif (strpos($ip, '0b') === 0) {
            $ip = substr($ip, 2);
            return self::parseBin($ip);
        } else if (is_numeric($ip)) {
            return self::parseLong($ip);
        }

        return new self($ip);
    }

    /**
     * @param string $binIP
     * @throws \Exception
     * @return IP
     */
    public static function parseBin($binIP)
    {
        if (!preg_match('/^([0-1]{32}|[0-1]{128})$/', $binIP)) {
            throw new \Exception("Invalid binary IP address format");
        }

        $in_addr = '';
        foreach (array_map('bindec', str_split($binIP, 8)) as $char) {
            $in_addr .= pack('C*', $char);
        }

        return new self(self::_inet_ntop($in_addr));
    }

    /**
     * @param string $hexIP
     * @throws \Exception
     * @return IP
     */
    public static function parseHex($hexIP)
    {
        if (!preg_match('/^([0-9a-fA-F]{8}|[0-9a-fA-F]{32})$/', $hexIP)) {
            throw new \Exception("Invalid hexadecimal IP address format");
        }

        return new self(self::_inet_ntop(pack('H*', $hexIP)));
    }

    /**
     * @param string|int $longIP
     * @param string $version
     * @return IP
     */
    public static function parseLong($longIP, $version=self::IP_V4)
    {
        if ($version === self::IP_V4) {
            $ip = new self(long2ip($longIP));
        } else {
            $binary = array();
            for ($i = 0; $i < self::IP_V6_OCTETS; $i++) {
                list($longIP, $re) = BigInteger::of($longIP)->quotientAndRemainder(256);
                $binary[] = $re->toInteger();
            }
            $ip = new self(self::_inet_ntop(call_user_func_array('pack', array_merge(array('C*'), array_reverse($binary)))));
        }

        return $ip;
    }

    /**
     * @param string $inAddr
     * @return IP
     */
    public static function parseInAddr($inAddr)
    {
        return new self(self::_inet_ntop($inAddr));
    }

    /**
     * @return string
     */
    public function getVersion()
    {
        $version = '';

        if (filter_var(self::_inet_ntop($this->in_addr), FILTER_VALIDATE_IP, FILTER_FLAG_IPV4)) {
            $version = self::IP_V4;
        } elseif (filter_var(self::_inet_ntop($this->in_addr), FILTER_VALIDATE_IP, FILTER_FLAG_IPV6)) {
            $version = self::IP_V6;
        }

        return $version;
    }

    /**
     * @return int
     */
    public function getMaxPrefixLength()
    {
        return $this->getVersion() === self::IP_V4
            ? self::IP_V4_MAX_PREFIX_LENGTH
            : self::IP_V6_MAX_PREFIX_LENGTH;
    }

    /**
     * @return int
     */
    public function getOctetsCount()
    {
        return $this->getVersion() === self::IP_V4
            ? self::IP_V4_OCTETS
            : self::IP_V6_OCTETS;
    }

    /**
     * @return string
     */
    public function getReversePointer()
    {
        if ($this->getVersion() === self::IP_V4) {
            $reverseOctets = array_reverse(explode('.', $this->__toString()));
            $reversePointer = implode('.', $reverseOctets) . '.in-addr.arpa';
        } else {
            $unpacked = unpack('H*hex', $this->in_addr);
            $reverseOctets = array_reverse(str_split($unpacked['hex']));
            $reversePointer = implode('.', $reverseOctets) . '.ip6.arpa';
        }

        return $reversePointer;
    }

    /**
     * @return string
     */
    public function inAddr()
    {
        return $this->in_addr;
    }

    /**
     * @return string
     */
    public function toBin()
    {
        $binary = array();
        foreach (unpack('C*', $this->in_addr) as $char) {
            $binary[] = str_pad(decbin($char), 8, '0', STR_PAD_LEFT);
        }

        return implode($binary);
    }

    /**
     * @return string
     */
    public function toHex()
    {
        return bin2hex($this->in_addr);
    }

    /**
     * @return string
     */
    public function toLong()
    {
        $long = 0;
        if ($this->getVersion() === self::IP_V4) {
            $long = sprintf('%u', ip2long(self::_inet_ntop($this->in_addr)));
        } else {
            $octet = self::IP_V6_OCTETS - 1;
            foreach ($chars = unpack('C*', $this->in_addr) as $char) {
                $long = BigInteger::of(256)->power($octet--)->multipliedBy($char)->plus($long);
            }
        }

        return $long;
    }

    /**
     * @param int $to
     * @return IP
     * @throws \Exception
     */
    public function next($to=1)
    {
        if ($to < 0) {
            throw new \Exception("Number must be greater than 0");
        }

        $unpacked = unpack('C*', $this->in_addr);

        for ($i = 0; $i < $to; $i++)	{
            for ($byte = count($unpacked); $byte >= 0; --$byte) {
                if ($unpacked[$byte] < 255) {
                    $unpacked[$byte]++;
                    break;
                } else {
                    $unpacked[$byte] = 0;
                }
            }
        }

        return new self(self::_inet_ntop(call_user_func_array('pack', array_merge(array('C*'), $unpacked))));
    }

    /**
     * @param int $to
     * @return IP
     * @throws \Exception
     */
    public function prev($to=1)
    {

        if ($to < 0) {
            throw new \Exception("Number must be greater than 0");
        }

        $unpacked = unpack('C*', $this->in_addr);

        for ($i = 0; $i < $to; $i++)	{
            for ($byte = count($unpacked); $byte >= 0; --$byte) {
                if ($unpacked[$byte] == 0) {
                    $unpacked[$byte] = 255;
                } else {
                    $unpacked[$byte]--;
                    break;
                }
            }
        }

        return new self(self::_inet_ntop(call_user_func_array('pack', array_merge(array('C*'), $unpacked))));
    }

    public static function _inet_pton($address){
        if(defined('AF_INET6') || filter_var($address, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4))
            return inet_pton($address);

        $parts = explode(':', $address);
        if (filter_var(end($parts), FILTER_VALIDATE_IP, FILTER_FLAG_IPV4)) {
            //::192.168.0.1 format
            $tail = str_pad(dechex(ip2long(array_pop($parts))), 8, '0', STR_PAD_LEFT);
            $parts = array_merge($parts, str_split($tail, 4));
        }

        $in_addr = '';
        $len = count($parts);
        foreach ($parts as $i => $part) {
            if($part && !ctype_xdigit($part)){
                trigger_error("Unrecognized address {$address}", E_WARNING);
                return false;
            }


            if ($part === '' && $i > 0 && $i < $len - 1) {
                $in_addr .= str_repeat("\x00\x00", 9 - $len);
            } else{
                $in_addr .= pack('n', hexdec($part ?: 0));
            }
        }

        if(strlen($in_addr) != 16){
            trigger_error("Unrecognized address {$address}", E_WARNING);
            return false;
        }


        return $in_addr;
    }

    public static function _inet_ntop($in_addr){
        if(defined('AF_INET6') || strlen($in_addr) < 16)
            return inet_ntop($in_addr);

        $hex = unpack('H*', $in_addr);
        $address =  array_map(function($hex){
            return ltrim($hex,'0') ?: '0';
        }, str_split($hex[1], 4));

        if (in_array(substr($hex[1], 0,24), ['000000000000000000000000', '00000000000000000000ffff'])
            && strcmp(substr($hex[1], 24, 4), '0000') > 0)
        {
            $address[] = long2ip(hexdec(join('', array_splice($address, -2, 2))));
        }

        $short = preg_replace('/:[0:]+:/', "::",  join(':',$address), 1);
        return substr($short, -3) === '::0' ? trim($short, '0') : ltrim($short, '0');
    }

}
