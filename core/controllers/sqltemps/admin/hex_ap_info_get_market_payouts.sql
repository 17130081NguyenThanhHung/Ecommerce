/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 

	por.`id`, 
	por.`user_id`, 
	por.`pp_link`, 
	por.`amount`, 
	por.`currency`, 
	por.`status`, 
	por.`time`,
	u.`username`,
	u.`avatar`,
	u.`verified`,
	u.`wallet` AS balance,
	CONCAT(u.`fname`, ' ',u.`lname`) AS full_name

	FROM `{%t_pouts%}` por 

	INNER JOIN `{%t_users%}` u ON por.`user_id` = u.`id`

	WHERE por.`id` > 0

	{%if offset%}		
		{%if offset_to == 'gt'%}
			AND por.`id` > {%offset%}
		{%endif%}	

		{%if offset_to == 'lt'%}
			AND por.`id` < {%offset%}
		{%endif%}
	{%endif%}

	{%if status%}		
		AND por.`status` = '{%status%}'
	{%endif%}

	ORDER BY por.`id` {%order%} 

{%if limit%}	
	LIMIT {%limit%}
{%endif%}