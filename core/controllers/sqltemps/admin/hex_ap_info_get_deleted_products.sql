/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/


SELECT 
	prod.`id`,
	prod.`poster`, 
	prod.`thumb`, 
	prod.`name` AS prod_name,
	prod.`reg_price`,
	prod.`sale_price`,
	prod.`sold` as sales,
	prod.`activity_status`,
	prod.`time`,
	user.`avatar` AS seller_avatar,
	CONCAT(user.`fname`, ' ', user.`lname`) AS seller_name,

	(SELECT COUNT(*) FROM `{%t_orders%}` ord WHERE ord.`prod_id` = prod.`id`) AS total_orders

	FROM `{%t_prods%}` prod

	INNER JOIN `{%t_users%}` user ON prod.`user_id` = user.`id`
	
	WHERE prod.`activity_status` = 'active'

	AND prod.`status` = 'deleted'

	{%if offset%}		
		{%if offset_to == 'gt'%}
			AND prod.`id` > {%offset%}
		{%endif%}	

		{%if offset_to == 'lt'%}
			AND prod.`id` < {%offset%}
		{%endif%}
	{%endif%}

	{%if keyword%}
		AND prod.`name` LIKE '%{%keyword%}%'
	{%endif%}

	ORDER BY prod.`id` {%order%} 

{%if limit%}	
	LIMIT {%limit%}
{%endif%}