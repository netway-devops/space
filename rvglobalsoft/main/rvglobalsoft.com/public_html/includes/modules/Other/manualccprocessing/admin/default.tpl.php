<?php
    $data    = $this->get_template_vars('list');
    $newData = sortArray($data);
    $this->assign('newlist',$newData);
    
    
    
    
    
    function sortArray($data){
        usort($data,'cmp');
        return $data;
    }
    function cmp($a, $b){
        return strcmp($a["duedate"],$b["duedate"]);
    }
       
?>