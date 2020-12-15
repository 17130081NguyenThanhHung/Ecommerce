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
	prod.`sold` as sales,
	prod.`activity_status`,
	prod.`variation_type`,
	prod.`approved`,
	prod.`time`,

	(SELECT COUNT('*') FROM `{%t_pvars%}` WHERE `activity_status` = 'active' AND `status` = 'active' AND `prod_id` = prod.`id`) AS variations

	FROM `{%t_prods%}` prod
	
	WHERE prod.`activity_status` = 'active'

	AND prod.`status` IN ('active','inactive','blocked')

	AND prod.`editing_stage` = 'saved'

	AND prod.`approved` = 'N'

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