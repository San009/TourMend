<?php
if (isset($_GET['email'])) {
    require_once 'db_config.php';

    $email = $_GET['email'];

    $sql = "SELECT username, image FROM user_info where email='$email'";
    if ($result = mysqli_query($db_conn, $sql)) {
        $row = mysqli_num_rows($result);

        if ($row == 1) {

            while ($row = mysqli_fetch_assoc($result)) {
                $output[] = $row;
            }

            echo (json_encode(array("statusCode" => '1', "userName" => $output[0]['username'], "image" => $output[0]['image'], "message" => 'Data found!')));
        } else {
            echo (json_encode(array("statusCode" => '0', "message" => "Data not found!")));
        }
    }

    mysqli_close($db_conn);
} else {
    echo (json_encode(array("statusCode" => '3', "message" => "Error in method!")));
}
