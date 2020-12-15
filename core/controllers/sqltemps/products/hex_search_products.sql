/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/


SELECT 
	prod.`id`,
	prod.`name` AS query

	FROM `{%t_prods%}` prod
	
	WHERE prod.`activity_status` = 'active'

	AND prod.`status` = 'active'

	AND prod.`approved` = 'Y'

	AND prod.`editing_stage` = 'saved'

	AND (prod.`name` LIKE '{%keyword%}%' OR prod.`name` LIKE '%{%keyword%}%' OR prod.`name` LIKE '%{%keyword%}' ) 

{%if limit%}	
	LIMIT {%limit%}
{%endif%}