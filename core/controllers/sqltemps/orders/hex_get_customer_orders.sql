/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 

	o.`id`, 
	o.`seller_id`, 
	o.`buyer_id`, 
	o.`prod_id`, 
	o.`var_id`, 
	o.`var_type`, 
	o.`quantity`, 
	o.`status`, 
	o.`cust_name`, 
	o.`time` as placed_date, 
	u.`avatar` as buyer_avatar,
	u.`verified` as buyer_verified,
	u.`username` as buyer_uname,
	p.`name` as prod_name,

	CASE 
		WHEN v.`id` IS NULL 

			THEN p.`reg_price` 

		ELSE v.`reg_price`
	END AS reg_price,

	CASE 
		WHEN v.`id` IS NULL 

			THEN p.`sale_price` 

		ELSE v.`sale_price`
	END AS sale_price

	FROM `{%t_orders%}` o 

	INNER JOIN `{%t_users%}` u ON o.`buyer_id` = u.`id`

	INNER JOIN `{%t_prods%}` p ON o.`prod_id` = p.`id`

	LEFT OUTER JOIN `{%t_pvars%}` v ON o.`var_id` = v.`id`

	WHERE o.`seller_id` = {%seller_id%}

	AND p.`activity_status` = 'active'

	AND p.`status` IN ('active','inactive','blocked')

	AND p.`approved` = 'Y'

	AND p.`editing_stage` = 'saved'

	{%if offset%}
		{%if offset_to == 'lt'%}		
			AND o.`id` < {%offset%}
		{%endif%}

		{%if offset_to == 'gt'%}		
			AND o.`id` > {%offset%}
		{%endif%}
	{%endif%}

	{%if keyword%}
		AND (o.`cust_name` LIKE '{%keyword%}%' OR o.`cust_name` LIKE '%{%keyword%}%' OR o.`cust_name` LIKE '%{%keyword%}')
	{%endif%}

	ORDER BY o.`id` {%order%}

{%if limit%}	
	LIMIT {%limit%}
{%endif%}