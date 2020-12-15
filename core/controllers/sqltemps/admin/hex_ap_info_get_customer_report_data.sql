/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 

	r.`id`, 
	r.`user_id`,
	r.`prod_id`,
	r.`report`,
	r.`seen`,
	r.`time`,
	u.`avatar`,
	u.`email`,
	u.`verified`,
	s.`username` AS prod_seller,

	CONCAT(u.`fname`,' ', u.`lname`) as full_name

	FROM `{%t_reports%}` r 

	INNER JOIN `{%t_users%}` u ON r.`user_id` = u.`id`

	INNER JOIN `{%t_prods%}` p ON r.`prod_id` = p.`id`

	INNER JOIN `{%t_users%}` s ON p.`user_id` = s.`id`

	WHERE r.`id` = {%report_id%}

	AND p.`activity_status` = 'active'

	AND p.`status` = 'active'

	AND p.`approved` = 'Y'

	AND p.`editing_stage` = 'saved'

	LIMIT 1