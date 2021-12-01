<?php
$widgets = $this->get_template_vars('widgets');
$mainPath = $this->get_template_vars('template_path');
$service = $this->get_template_vars('service');
$accountId = $service['id'];
$mainPath .= '../../';
$widgets_new = array();
foreach($widgets as $eachWidgets){
	$widget_name = 'widget_' . $eachWidgets['name'];
	$file_path = $mainPath . $eachWidgets['location'] . 'widget.' . $eachWidgets['name'] . '.php';
	if(file_exists($file_path)){
		require_once $file_path;
		$mainClass = new $widget_name();
		if(method_exists($mainClass, 'widgetActive') && $mainClass->widgetActive($accountId)){
			array_push($widgets_new, $eachWidgets);
		}
	}
}
$this->assign('widgets', $widgets_new);
?>