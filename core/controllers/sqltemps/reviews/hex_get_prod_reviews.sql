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
	users.`verified`

	FROM `{%t_reviews%}` reviews

	INNER JOIN `{%t_users%}` users ON reviews.`user_id` = users.`id`

	WHERE reviews.`activity_status` = 'active'

	AND reviews.`prod_id` = {%prod_id%}

	{%if by_ids%}
		AND reviews.`id` IN ({%by_ids%})
	{%endif%}

	{%if offset%}
		AND reviews.`id` < {%offset%}
	{%endif%}

	{%if sortby%}
		AND reviews.`valuation` = {%sortby%}
	{%endif%}

	ORDER BY reviews.`id` DESC

{%if limit%}
	LIMIT {%limit%}
{%endif%}