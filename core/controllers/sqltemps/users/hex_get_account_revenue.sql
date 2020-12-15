/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 
	
	{@ Checkout Transaction Info @}

	ct.`id`,
	ct.`amount`,
	ct.`time`

	FROM `{%t_trans%}` ct

	WHERE ct.`seller_id` = {%account_id%}

	{%if date%}
		AND ct.`time` >= '{%date%}'
	{%endif%}