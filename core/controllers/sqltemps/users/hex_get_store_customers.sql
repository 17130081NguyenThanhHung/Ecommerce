/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 

	c.`id`, 
	c.`seller_id`, 
	c.`buyer_id`, 
	c.`time`, 
	u.`avatar` as cust_avatar,
	u.`email`,
	u.`phone`,
	u.`username`,
	u.`verified` as cust_verified,
	u.`country_id`,
	CONCAT(u.`fname`,' ', u.`lname`) as cust_name,

	(SELECT COUNT(o.`id`) FROM `{%t_orders%}` o WHERE o.`buyer_id` = c.`buyer_id` AND o.`seller_id` = {%seller_id%}) AS total_orders,

	(SELECT o2.`time` FROM `{%t_orders%}` o2 

			WHERE o2.`seller_id` = {%seller_id%}

			AND o2.`buyer_id` = c.`buyer_id`

		ORDER BY o2.`time` DESC LIMIT 1

	) as last_order

	FROM `{%t_custs%}` c 

	INNER JOIN `{%t_users%}` u ON c.`buyer_id` = u.`id`

	WHERE c.`seller_id` = {%seller_id%}

	{%if offset%}
		{%if offset_to == 'lt'%}		
			AND c.`id` < {%offset%}
		{%endif%}

		{%if offset_to == 'gt'%}		
			AND c.`id` > {%offset%}
		{%endif%}
	{%endif%}

	{%if keyword%}
		AND (u.`fname` LIKE '%{%keyword%}%' OR u.`lname` LIKE '%{%keyword%}%' OR CONCAT(u.`fname`,' ', u.`lname`) LIKE '%{%keyword%}')
	{%endif%}

	ORDER BY c.`id` {%order%}

{%if limit%}	
	LIMIT {%limit%}
{%endif%}