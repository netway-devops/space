{php}

$notification   = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
$noticType      = isset($notification['type']) ? $notification['type'] : '';
$noticMessage   = isset($notification['message']) ? $notification['message'] : '';

$this->assign('noticType', $noticType);
$this->assign('noticMessage', $noticMessage);

$_SESSION['notification'] = array();
{/php}

{if $noticType}
<div class="alert alert-{$noticType}">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <h4>{$noticType|capitalize}</h4>
  {$noticMessage}
</div>
{/if}