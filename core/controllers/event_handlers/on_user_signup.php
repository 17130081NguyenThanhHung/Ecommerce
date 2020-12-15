<?php 
# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@

$static_wish_lists = array('Favorite','Sundry','Buy later','Birthday','Gift Ideas');

foreach ($static_wish_lists as $list_name) {
	$insert_array   =  array(
		'user_id'   => $user_id,
		'list_name' => $list_name,
		'hash_id'   => hs_croptxt(sha1($list_name),25),
		'type'      => 'static',
		'time'      => time(),
	); $db->insert(T_WISHLIST,$insert_array);
}

$insert_data       =  array(
	'user_id'      => $user_id,
	'title'        => 'Cookie policy',
	'message'      => 'We use cookies on this website to ensure the functionality of the application and to improve user experience. By using the site, you agree to our cookie policy!',
	'type'         => 'info',
	'static'       => 'Y',
	'time'         => time()
); $db->insert(T_ANNOUNC,$insert_data);
