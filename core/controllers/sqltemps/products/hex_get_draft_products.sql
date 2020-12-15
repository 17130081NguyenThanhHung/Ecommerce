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
	prod.`name`,
	prod.`reg_price`,
	prod.`sale_price`,
	prod.`sku`,
	prod.`sold` as sales,
	prod.`activity_status`,
	prod.`profit`,
	prod.`variation_type`,
	prod.`editing_stage`,
	prod.`approved`,
	prod.`status`,

	CASE 
	
		WHEN prod.`variation_type` IN ('color','size','color_size') 

			THEN (SELECT SUM(var.`quantity`) FROM `{%t_pvars%}` var WHERE var.`prod_id` = prod.`id` AND var.`status` = 'active'  AND var.`activity_status` = 'active')

		ELSE prod.`quantity`

	END AS quantity

	FROM `{%t_prods%}` prod
	
	WHERE prod.`activity_status` = 'active'

	AND prod.`user_id` = {%user_id%}

	AND prod.`editing_stage` = 'unsaved'

	AND prod.`status` IN ('active','inactive','blocked') 

	{%if offset%}		
		{%if offset_to == 'gt'%}
			AND prod.`id` > {%offset%}
		{%endif%}	

		{%if offset_to == 'lt'%}
			AND prod.`id` < {%offset%}
		{%endif%}
	{%endif%}

	ORDER BY prod.`id` {%order%} 

{%if limit%}	
	LIMIT {%limit%}
{%endif%}