<?php 
# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@

if (not_empty($_GET['pd']) && in_array($_GET['pd'], array('profile','product'))) {
	$page_name = strval($_GET['pd']);

	if ($page_name == 'product') {
		$product_id = fetch_or_get($_GET['id'],false);
		if (is_number($product_id)) {
			$db              = $db->where('id',$product_id);
			$db              = $db->where('activity_status','active');
			$db              = $db->where('approved','Y');
			$db              = $db->where('status','active');
			$hs['prod_data'] = $db->getOne(T_PRODUCTS);
			$hs['prod_data'] = ((hs_queryset($hs['prod_data'],'object')) ? hs_o2array($hs['prod_data']) : array());

			if (not_empty($hs['prod_data'])) {
				if (empty($hs['is_logged'])) {
					$hs['prods']  =  hs_get_preview_products(array(
						'limit'   => 50
					));

					$hs['prods']  = ((empty($hs['prods'])) ? array() : $hs['prods']);
					$hs['ghosts'] = ((count($hs['prods']) < 5) ? range(1, (5 - count($hs['prods']))) : array());

					$hs['prod_data']['fs_price']     = hs_money($hs['prod_data']['sale_price']);
					$hs['prod_data']['fr_price']     = hs_money($hs['prod_data']['reg_price']);
					$hs['prod_data']['discount']     = hs_price_discount($hs['prod_data']['reg_price'],$hs['prod_data']['sale_price']);
					$hs['prod_data']['rating_stars'] = hs_rating_stars($hs['prod_data']['rating']);

					echo hs_loadpage('share/product'); exit();
				}
				else {
					hs_redirect(sprintf("product/%d",$product_id));
				}
			}

			else {
				die();
			}
		}
	}
}