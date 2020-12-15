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

else if(empty($_GET['mode']) || in_array($_GET['mode'], array('admin','user')) != true) {
	hs_redirect('/');
}

else if(empty($me['is_root'])) {
	$insert_data    = array(
		'user_id'   => $me['id'],
		'title'     => 'Failed to log in as admin!',
		'message'   => 'You cannot switch to administrator mode, since you are not on the list of our admins.',
		'type'      => 'error',
		'static'    => 'Y',
		'time'      => time()
	);

	$db->insert(T_ANNOUNC,$insert_data);

	hs_redirect('/');
}

else {
	$mode           = strval($_GET['mode']);
	$db             = $db->where('id',$me['id']);
	$chmod2         = (($mode == 'admin') ? '1' : '0');
	$up             = $db->update(T_USERS,array('admin' => $chmod2));
	$ref_url        = http_referer();

	if ($mode == 'admin') {
		$insert_data    = array(
			'user_id'   => $me['id'],
			'title'     => 'Session switched to admin mode!',
			'message'   => 'You are logged in with administrative privileges. Now you can manage the contents of your administrative sections in the market control panel.',
			'type'      => 'success',
			'static'    => 'N',
			'time'      => time()
		);

		$db->insert(T_ANNOUNC,$insert_data);
	}

	if ($ref_url) {
		hs_location($ref_url);
	}

	else {
		hs_redirect('/');
	}
}