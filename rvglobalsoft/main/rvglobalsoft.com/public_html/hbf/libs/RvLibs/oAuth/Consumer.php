<?php 
#@LICENSE@#

require_once 'HTTP/OAuth/Consumer.php';
class RVLibs_oAuth_Consumer extends HTTP_OAuth_Consumer
{
    
    public function accept($object)
    {
        $class = get_class($object);
        switch ($class)
        {
        case 'RVLibs_oAuth_Consumer_Request':
            $this->consumerRequest = $object;
            break;
        default:
            parent::accept($object);
        }
    }
}