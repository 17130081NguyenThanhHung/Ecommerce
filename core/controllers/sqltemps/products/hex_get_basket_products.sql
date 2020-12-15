/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 

	b.`id`, 
	b.`user_id`, 
	b.`prod_id`, 
	b.`var_id`, 
	b.`var_type`, 
	b.`quantity` as `qt`, 
	b.`time`, 
	p.`poster`, 
	p.`thumb`, 
	p.`name` as `prod_name`, 
	p.`shipping_cost`, 
	p.`shipping_fee`, 
	p.`payment_method`, 
	v.`col_name`,
	v.`size`,
	v.`var_type` as `var_vartype`,

	CASE 
		WHEN v.`reg_price` IS NULL 

			THEN p.`reg_price`

		ELSE v.`reg_price`

	END AS reg_price,

	CASE 
		WHEN v.`sale_price` IS NULL 

			THEN p.`sale_price`

		ELSE v.`sale_price`
	END AS sale_price

	
	FROM `{%t_basket%}` b 

	INNER JOIN `{%t_prods%}` p ON b.`prod_id` = p.`id`

	LEFT OUTER JOIN `{%t_pvars%}` v ON b.`var_id` = v.`id`

	WHERE b.`user_id` = {%user_id%}

	AND p.`activity_status` = 'active'

	AND p.`status` = 'active'

	AND p.`approved` = 'Y'

	AND p.`editing_stage` = 'saved'

	{%if offset%}		
		AND b.`id` < {%offset%}
	{%endif%}

	ORDER BY b.`id` DESC

{%if limit%}	
	LIMIT {%limit%}
{%endif%}