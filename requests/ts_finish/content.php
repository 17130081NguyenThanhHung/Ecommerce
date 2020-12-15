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

else if(empty($hs['temp_session'])) {
	hs_redirect('404');
}

else {
    $session_id   = $hs['temp_session']['login_hash'];
    $temp_sess_id = $hs['temp_session']['id'];
    $db           = $db->where('user_id', $me['id']);
    $db           = $db->where('session_id', hs_secure($session_id));
    $delete_ts    = $db->delete(T_SESSIONS);
    $db           = $db->where('id', $temp_sess_id);
    $delete_as    = $db->delete(T_ADMIN_SESSIONS);
    $admin_id     = $hs['temp_session']['admin_id'];
	$new_sess_id  = hs_create_user_session($admin_id);


	echo hs_server_message("wait/temp_session_finish");
    hs_redirect_after('merchant_panel/dashboard',5);
}