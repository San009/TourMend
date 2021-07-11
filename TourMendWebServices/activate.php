<?php
if (isset($_GET['email'])) {
    require_once 'db_config.php';

    $email = $_GET['email'];
    $updatequery = "UPDATE user_info SET status = 'active' WHERE email = '$email'";
    $update = mysqli_query($db_conn, $updatequery);

    if ($update) {
        echo (json_encode(array('statusCode' => '1', 'message' => 'Account successfully activated!')));
    } else {
        echo (json_encode(array('statusCode' => '0', 'message' => 'Can\'t activate account due to server error!')));
    }
}
