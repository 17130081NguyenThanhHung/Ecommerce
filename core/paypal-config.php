<?php 
# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@

require_once('libs/paypal/vendor/autoload.php');
$paypal_conf = array(
 	"secret_key"      =>  $hs['config']['paypal_api_key'],
 	"publishable_key" =>  $hs['config']['paypal_api_pass']
);

$paypal = new \PayPal\Rest\ApiContext(
	new \PayPal\Auth\OAuthTokenCredential(
		$hs['config']['paypal_api_key'],
		$hs['config']['paypal_api_pass']
	)
);

$paypal->setConfig(
    array(
    	$hs['config']['paypal_mode']
    )
);

