/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 
	{@ Chat user info @}

	user.`id` as user_id,
	user.`username`,
	CONCAT(user.`fname`,' ',user.`lname`) as name,
	user.`avatar`,
	user.`verified` as verified_user,

	{@ Chat conversations info @}

	convers.`id` as chat_id, 
	convers.`time`, 

	{@ Select_ last message from_ user conversation @}

		(SELECT  message.`message`  FROM `{%t_messages%}` message  WHERE 

			(message.`sent_by` = convers.`user_one` AND message.`sent_to` = convers.`user_two` AND message.`deleted_fs1` = 'N') OR

			(message.`sent_by` = convers.`user_two` AND message.`sent_to` = convers.`user_one` AND message.`deleted_fs2` = 'N')

		ORDER BY message.`id` DESC LIMIT 1) AS last_message,

	{@ End_ Subquery @}

	{@ Select_ unseen messages total from_ user conversation @}

		(SELECT  COUNT(m.`id`) FROM `{%t_messages%}` m WHERE (m.`sent_to` = {%user_id%} AND m.`sent_by` = convers.`user_two`) AND m.`seen` = 0) AS new_messages

	{@ End_ Subquery @}

FROM `{%t_convs%}` convers INNER JOIN `{%t_users%}` user ON convers.`user_two` = user.`id`

	WHERE convers.`user_one` = {%user_id%}

	{%if offset%}
		AND convers.`id` < {%offset%}
	{%endif%}

  	ORDER BY convers.`time` DESC 

{%if limit%} 
	LIMIT {%limit%}
{%endif%}