<?php

namespace Badcow\DNS\Parser;

class StringIterator extends \ArrayIterator
{
    /**
     * StringIterator constructor.
     *
     * @param string $string
     */
    public function __construct($string = '')
    {
        parent::__construct(str_split($string));
    }
    /**
     * @param string $value
     *
     * @return bool
     */
    public function is($value)
    {
        return $value === $this->current();
    }
    /**
     * @param string $value
     *
     * @return bool
     */
    public function isNot($value)
    {
        return $value !== $this->current();
    }
    /**
     * @return string
     */
    public function __toString()
    {
        return implode($this->getArrayCopy());
    }
}