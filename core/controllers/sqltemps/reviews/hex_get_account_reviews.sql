/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 

	{@ Reviews Data @}

	reviews.`id`,
	reviews.`user_id`,
	reviews.`prod_id`,
	reviews.`valuation`,
	reviews.`review`,
	reviews.`activity_status`,
	reviews.`time`,

	{@ Reviewer Data @}

	users.`avatar` as avatar,
	CONCAT(users.`fname`,' ',users.`lname`) as uname,
	users.`username`,
	users.`email`,
	users.`verified`,

	{@ Product Item Data @}
	prods.`name` as prod_name


	FROM `{%t_reviews%}` reviews

	INNER JOIN `{%t_users%}` users ON reviews.`user_id` = users.`id`

	INNER JOIN `{%t_prods%}` prods ON reviews.`prod_id` = prods.`id`
	
	WHERE reviews.`activity_status` = 'active'

	AND prods.`user_id` = {%user_id%}

	AND prods.`approved` = 'Y'

	AND prods.`activity_status` = 'active'

	AND prods.`status` = 'active'

	AND prods.`editing_stage` = 'saved'

	{%if ids%}	
		AND reviews.`id` IN ({%ids%})
	{%endif%}

	{%if offset%}		
		{%if offset_to == 'gt'%}
			AND reviews.`id` > {%offset%}
		{%endif%}	

		{%if offset_to == 'lt'%}
			AND reviews.`id` < {%offset%}
		{%endif%}
	{%endif%}

	{%if valuation%}
		AND reviews.`valuation` IN ({%valuation%})
	{%endif%}

	ORDER BY reviews.`id` {%order%}

{%if limit%}
	LIMIT {%limit%}
{%endif%}