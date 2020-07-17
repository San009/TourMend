<?php
if (isset($_POST['password'], $_POST['email'])) {
    require_once "db_config.php";

    $email = $_POST['email'];
    $password = $_POST['password'];
    $hashedPass = sha1($password);

    $sql = "SELECT * FROM user_info WHERE email='$email'";
    $result = mysqli_query($db_conn, $sql);

    if (mysqli_num_rows($result) == 1) {
        $query = "UPDATE user_info SET password = '$hashedPass' WHERE email = '$email'";
        $updatePass = mysqli_query($db_conn, $query);
        if ($updatePass) {
            echo (json_encode(array('statusCode' => '1', 'message' => 'Password Updated!')));
        } else {
            echo (json_encode(array('statusCode' => '0', 'message' => 'Can\'t update password due to server error!')));
        }
    }
    mysqli_free_result($result);
    mysqli_close($db_conn);
} else echo (json_encode(array('statusCode' => '2', 'message' => 'Error in method!')));
