/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/


SELECT 
	
	{@ Checkout Transaction Info @}

	ct.`id`,
	ct.`seller_id`,
	ct.`buyer_id`,
	ct.`amount`,
	ct.`status`,
	ct.`time`,

	{@ Accounts Info @}

	CONCAT(u1.`fname`,' ', u1.`lname`) as seller_name,
	CONCAT(u2.`fname`,' ', u2.`lname`) as buyer_name,

	u1.`avatar` as seller_avatar,
	u1.`verified` as seller_verified,
	u2.`avatar` as buyer_avatar,
	u2.`verified` as buyer_verified

	FROM `{%t_trans%}` ct

	INNER JOIN `{%t_users%}` u1 ON ct.`seller_id` = u1.`id`

	INNER JOIN `{%t_users%}` u2 ON ct.`buyer_id`  = u2.`id`
	
	WHERE (ct.`seller_id` = {%account_id%} OR ct.`buyer_id` = {%account_id%})

	{%if offset%}
		{%if offset_to == 'lt'%}		
			AND ct.`id` < {%offset%}
		{%endif%}

		{%if offset_to == 'gt'%}		
			AND ct.`id` > {%offset%}
		{%endif%}
	{%endif%}

	{%if keyword%}		
		AND ((u1.`fname` LIKE '%{%keyword%}%' OR u1.`lname` LIKE '%{%keyword%}%') OR (u2.`fname` LIKE '%{%keyword%}%' OR u2.`lname` LIKE '%{%keyword%}%'))
	{%endif%}

	ORDER BY ct.`id` {%order%}

{%if limit%}	
	LIMIT {%limit%}
{%endif%}