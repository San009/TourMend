<?php

use PHPMailer\PHPMailer\PHPMailer;


if (isset($_POST['email'])) {
    require_once "PHPMailer/PHPMailer.php";
    require_once "PHPMailer/SMTP.php";
    require_once "PHPMailer/Exception.php";
    require_once "db_config.php";

    $mail = new PHPMailer(true);

    //SMTP settings
    $mail->isSMTP();
    $mail->Host = "smtp.gmail.com";
    $mail->SMTPAuth = true;
    $mail->Username = "kailashkandel2@gmail.com";
    $mail->Password = "TourMend@123";
    $mail->Port = 465; //587 for tls
    $mail->SMTPSecure = "ssl"; //next option is tls


    $email = $_POST['email'];

    $checkEmail = "SELECT * FROM user_info WHERE email = '$email'";

    $checkresultEmail = mysqli_query($db_conn, $checkEmail);
    //check if email exists or not	
    if (mysqli_num_rows($checkresultEmail) > 0) {
        $result = mysqli_fetch_assoc($checkresultEmail);
        $randomString = substr(str_shuffle('0123456789'), 0, 6);
        $query = "UPDATE user_info SET reset_code = '$randomString' WHERE email = '$email'";

        $update = mysqli_query($db_conn, $query);
        if ($update) {
            $subject = "Reset Password";
            $username = $result['username'];
            $body = "Hi, $username! You have requested to reset your password. Please enter the key <b>$randomString</b> to verify that it's you and continue.";
            $sender = "kailashkandel2@gmail.com";

            // email settings
            $mail->isHTML(true);
            $mail->setFrom($sender, "TourMend App");
            $mail->addAddress($email);
            $mail->Subject = $subject;
            $mail->Body = $body;

            if ($mail->send()) {
                echo (json_encode(array('statusCode' => '1', 'message' => 'OTP sent to mail!')));
            } else {
                echo (json_encode(array('statusCode' => '3', 'message' => 'Wrong email address')));
            }
        } else {
            echo (json_encode(array('statusCode' => '2', 'message' => 'Server error: Can\'t update!')));
        }
    } else {
        echo (json_encode(array('statusCode' => '0', 'message' => 'Email address not registered!')));
    }
    mysqli_close($db_conn);
}
return;
