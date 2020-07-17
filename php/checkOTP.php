<?php
if (isset($_POST['otp'], $_POST['email'])) {
    require_once "db_config.php";

    $otpCode = $_POST['otp'];
    $email = $_POST['email'];

    $sql = "SELECT * FROM user_info WHERE email='$email'";
    $result = mysqli_query($db_conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        $otpArray = mysqli_fetch_assoc($result);
        $resetCode = $otpArray['reset_code'];
        if ($resetCode == $otpCode) {
            echo (json_encode(array('statusCode' => '1', 'message' => 'OTP matched!')));
        } else {
            echo (json_encode(array('statusCode' => '0', 'message' => 'OTP didn\'t match!')));
        }
    }
    mysqli_free_result($result);
    mysqli_close($db_conn);
} else echo (json_encode(array('statusCode' => '2', 'message' => 'Error in method/parameter!')));

return;
