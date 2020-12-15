/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/
SELECT 

	u.`id`, 
	u.`email`,
	u.`avatar`,
	u.`last_active`,
	u.`username`,
	u.`verified`,
	CONCAT(u.`fname`,' ', u.`lname`) as full_name

	FROM `{%t_users%}` u 

	WHERE u.`active` IN ('1','2')

	AND u.`id` IN (SELECT `user_id` FROM `{%t_admins%}`)

	{%if offset%}		
		{%if offset_to == 'gt'%}
			AND u.`id` > {%offset%}
		{%endif%}	

		{%if offset_to == 'lt'%}
			AND u.`id` < {%offset%}
		{%endif%}
	{%endif%}

	{%if keyword%}
		AND (u.`fname` LIKE '%{%keyword%}%' OR u.`lname` LIKE '%{%keyword%}%' OR CONCAT(u.`fname`,' ',u.`lname`) LIKE '%{%keyword%}%')
	{%endif%}

	ORDER BY u.`id` {%order%} 

{%if limit%}	
	LIMIT {%limit%}
{%endif%}