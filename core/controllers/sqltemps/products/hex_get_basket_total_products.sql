/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 

	COUNT(basket.`id`) AS total_items

	FROM `{%t_basket%}` basket 

	INNER JOIN `{%t_prods%}` prods ON basket.`prod_id` = prods.`id`

	WHERE basket.`user_id` = {%user_id%} AND prods.`activity_status` = 'active' AND prods.`status` = 'active' AND prods.`approved` = 'Y' AND prods.`editing_stage` = 'saved';