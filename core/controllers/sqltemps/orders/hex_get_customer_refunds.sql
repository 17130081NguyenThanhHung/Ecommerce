/*# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@*/

SELECT 
	ord_cnc.`id`,
	ord_cnc.`order_id`,
	ord_cnc.`trans_id`,
	ord_cnc.`prod_id`,
	ord_cnc.`seller_id`,
	ord_cnc.`buyer_id`,
	ord_cnc.`time`,
	ord_cnc.`status`,
	CONCAT(users.`fname`, ' ',users.`lname`) AS cust_name,
	users.`avatar` AS cust_avatar,
	users.`username` AS cust_uname,
	users.`verified` AS cust_verified,
	prods.`name` AS prod_name,

	trans.`method` AS payment_method,
	trans.`amount` AS payment_amount,
	trans.`market_rate` AS payment_fee,
	trans.`stripe_pid`

	FROM `{%t_ord_cnc%}` ord_cnc 

	INNER JOIN `{%t_users%}` users ON ord_cnc.`buyer_id` = users.`id`

	INNER JOIN `{%t_prods%}` prods ON ord_cnc.`prod_id` = prods.`id`

	INNER JOIN `{%t_trans%}` trans ON ord_cnc.`trans_id` = trans.`id`

	WHERE prods.`activity_status` = 'active'

	AND prods.`status` IN ('active','inactive','blocked')

	AND prods.`approved` = 'Y'

	AND prods.`editing_stage` = 'saved'

	{%if offset%}
		{%if offset_to == 'lt'%}		
			AND ord_cnc.`id` < {%offset%}
		{%endif%}

		{%if offset_to == 'gt'%}		
			AND ord_cnc.`id` > {%offset%}
		{%endif%}
	{%endif%}

	ORDER BY ord_cnc.`id` {%order%}

{%if limit%}	
	LIMIT {%limit%}
{%endif%}