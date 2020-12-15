<?php 
# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@

if (empty($hs['is_logged'])) {
	hs_redirect('auth');
}

$hs['page_title']    =  hs_translate('Notifications - {%name%}',array('name' => $hs['config']['name']));
$hs['page_desc']     =  $hs['config']['description'];
$hs['page_kw']       =  $hs['config']['keywords'];
$hs['pn']            =  'notifications';
$hs['header_st']     =  true;
$hs['notifications'] =  hs_get_notifications(array(
	'recipient_id'   => $me['id'],
	'limit'          => 20,
));

if (not_empty($hs['notifications'])) {
	$hs['site_content'] = hs_loadpage('notifications/content');
}

else {
	$hs['site_content'] = hs_loadpage('notifications/includes/no_st_notifications');
}