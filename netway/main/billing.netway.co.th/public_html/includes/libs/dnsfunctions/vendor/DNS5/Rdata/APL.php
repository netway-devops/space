<?php

namespace Badcow\DNS\Rdata;
use IPTools\Network;
use IPTools\IP;

class APL implements RdataInterface
{
    use RdataTrait;
    const TYPE = 'APL';
    /**
     * @var Network[]
     */
    private $includedAddressRanges = [];
    /**
     * @var Network[]
     */
    private $excludedAddressRanges = [];
    /**
     * @param Network $ipBlock
     * @param bool     $included True if the resource exists within the range, False if the resource
     *                           is not within the range. I.E. the negation.
     */
    public function addAddressRange(Network $ipBlock, $included = true)
    {
        if ($included) {
            $this->includedAddressRanges[] = $ipBlock;
        } else {
            $this->excludedAddressRanges[] = $ipBlock;
        }
    }
    /**
     * @return Network[]
     */
    public function getIncludedAddressRanges()
    {
        return $this->includedAddressRanges;
    }
    /**
     * @return Network[]
     */
    public function getExcludedAddressRanges()
    {
        return $this->excludedAddressRanges;
    }
    /**
     * {@inheritdoc}
     */
    public function output()
    {
        $string = '';
        foreach ($this->includedAddressRanges as $ipBlock) {
            $string .= IP::IP_V4 === $ipBlock->getFirstIP()->getVersion() ? '1:' : '2:';
            $string .= (string) $ipBlock . ' ';
        }
        foreach ($this->excludedAddressRanges as $ipBlock) {
            $string .= IP::IP_V4 === $ipBlock->getFirstIP()->getVersion() ? '!1:' : '!2:';
            $string .= (string) $ipBlock . ' ';
        }
        return rtrim($string, ' ');
    }
}