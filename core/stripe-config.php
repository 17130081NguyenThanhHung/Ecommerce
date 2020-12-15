<?php 
# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@

require_once('libs/stripe/vendor/autoload.php');
$stripe_conf = array(
 	"secret_key"      =>  $hs['config']['stripe_api_key'],
 	"publishable_key" =>  $hs['config']['stripe_api_pass']
);

\Stripe\Stripe::setApiKey($stripe_conf['publishable_key']); 
