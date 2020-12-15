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

$hs['page_title']       = hs_translate('Privacy & Policy of - {%name%}',array('name' => $hs['config']['name']));
$hs['page_desc']        = $hs['config']['description'];
$hs['page_kw']          = $hs['config']['keywords'];
$hs['pn']               = 'privacy_policy';
$hs['header_st']        = true;
$hs['doc_page_content'] = hs_ap_info_get_static_page('doc_privacy_policy');
$hs['doc_page_content'] = ((not_empty($hs['doc_page_content'])) ? $hs['doc_page_content'] : hs_redirect('404'));
$hs['doc_page_content'] = htmlspecialchars_decode($hs['doc_page_content']);
$hs['site_content']     = hs_loadpage('privacy_policy/content');