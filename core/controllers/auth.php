<?php 
# @*****************************************************************************@
# @	Group 4 Thương mại điện tử Cô Châu											@
# @ @github group4: https://github.com/17130081NguyenThanhHung/Ecommerce-Group4 @
# @ @author1_url: https://www.facebook.com/TheSaltOfTheEarthTheLightOfTheWorld/	@
# @ @author1_email: 17130081@st.hcmuaf.edu.vn                            		@
# @*****************************************************************************@

function hs_is_logged($platform = "web") {
    if (isset($_POST['access_token'])) {
        $id = hs_get_userfromsession_id($_POST['access_token'], $platform);
        if (is_numeric($id) && !empty($id)) {
            return true;
        }
        else {
            return false;
        }
    }

    if (isset($_SESSION['user_id']) && !empty($_SESSION['user_id'])) {
        $id = hs_get_userfromsession_id($_SESSION['user_id']);
        if (is_numeric($id) && !empty($id)) {
            return true;
        }
    } 
    
    else if (isset($_COOKIE['user_id']) && !empty($_COOKIE['user_id'])) {
        $id = hs_get_userfromsession_id($_COOKIE['user_id']);
        if (is_numeric($id) && !empty($id)) {
            return true;
        }
    }

    else {
        return false;
    }
}

function hs_get_userfromsession_id($session_id, $platform = 'web') {
    global $db;
    if (empty($session_id)) {
        return false;
    }
    
    $platform   = hs_secure($platform);
    $session_id = hs_secure($session_id);
    $return     = $db->where('session_id', $session_id);
    $return     = $db->where('platform', $platform);
    return $db->getValue(T_SESSIONS, 'user_id');
}

function hs_signout_user() {
    global $db;
    if (not_empty($_SESSION['user_id'])) {
        $db->where('session_id', hs_secure($_SESSION['user_id']));
        $db->delete(T_SESSIONS);
    }

    if (not_empty($_COOKIE['user_id'])) {
        $db->where('session_id', hs_secure($_COOKIE['user_id']));
        $db->delete(T_SESSIONS);
        unset($_COOKIE['user_id']);
        setcookie('user_id', null, -1);
    }

    @session_destroy();
}

function hs_send_mail($data = array()) {
    global $hs, $db;
    try {
        require_once('core/mailer.php');
        $email_from      = $data['from_email'] = hs_secure($data['from_email']);
        $to_email        = $data['to_email']   = hs_secure($data['to_email']);
        $subject         = $data['subject'];
        $data['charSet'] = hs_secure($data['charSet']);

        
        if ($hs['config']['smtp_or_mail'] == 'mail') {
            $mail->IsMail();
        } 

        else if ($hs['config']['smtp_or_mail'] == 'smtp') {
            $mail->isSMTP();
            $mail->SMTPDebug   = false;
            $mail->Host        = $hs['config']['smtp_host'];
            $mail->SMTPAuth    = true;
            $mail->Username    = $hs['config']['email'];
            $mail->Password    = $hs['config']['smtp_password'];
            $mail->SMTPSecure  = $hs['config']['smtp_encryption'];
            $mail->Port        = $hs['config']['smtp_port'];
            $mail->SMTPOptions = array(
                'ssl'          => array(
                    'verify_peer'       => false,
                    'verify_peer_name'  => false,
                    'allow_self_signed' => true
                )
            );  
        } 

        else {
            return false;
        }

        $mail->IsHTML($data['is_html']);
        $mail->setFrom($data['from_email'], $data['from_name']);
        $mail->addAddress($data['to_email'], $data['to_name']);
        $mail->Subject = $data['subject'];
        $mail->CharSet = $data['charSet'];
        $mail->MsgHTML($data['message_body']);

        if ($mail->send()) {
            $mail->ClearAddresses();
            return true;
        }
    } 

    catch (Exception $e) {
       return false; 
    }
}