/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/


SELECT 
	prod.`id`,
	prod.`poster`, 
	prod.`name`,
	prod.`rating`,
	prod.`reg_price`,
	prod.`sale_price`,
	prod.`sold` as sales

	FROM `{%t_prods%}` prod
	
	WHERE prod.`activity_status` = 'active'

	AND prod.`status` = 'active'

	AND prod.`editing_stage` = 'saved'

	{%if approved%}
		AND prod.`approved` = 'Y'
	{%endif%}

	{%if not_appr%}
		AND prod.`approved` = 'N'
	{%endif%}
	
	{%if user_id%}		
		AND prod.`user_id` = {%user_id%}
	{%endif%}

	{%if catg_id%}		
		AND prod.`category` = '{%catg_id%}'
	{%endif%}

	{%if exclude%}		
		AND prod.`id` NOT IN ({%exclude%})
	{%endif%}

	{%if offset%}		
		AND prod.`id` < {%offset%}
	{%endif%}

	ORDER BY prod.`id` DESC {%if ob_sales%} ,prod.`sold` DESC {%endif%} {%if ob_rating%} ,prod.`rating` DESC {%endif%} 

{%if limit%}	
	LIMIT {%limit%}
{%endif%}