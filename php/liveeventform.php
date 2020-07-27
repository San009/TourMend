<?php
if (isset($_POST['userEmail'], $_POST['eventAddress'], $_POST['eventDesc'], $_POST['eventType'])) {
    require_once 'db_config.php';

    $userEmail = $_POST['userEmail'];
    $eventType = $_POST['eventType'];
    $eventAddress = $_POST['eventAddress'];
    $eventDesc = $_POST['eventDesc'];
    $approval = "pending";

    $getUserId = "SELECT id FROM user_info WHERE email='$userEmail'";
    $executeQuery = mysqli_query($db_conn, $getUserId);

    if ($executeQuery) {
        $userInfo = mysqli_fetch_assoc($executeQuery);
        $userId = $userInfo['id'];
    }
    // else statement

    $sql = "INSERT INTO tbl_events (user_id, type, address, description, approval) VALUES ('$userId', '$eventType', '$eventAddress', '$eventDesc', '$approval')";

    $executeQuery = mysqli_query($db_conn, $sql);

    if ($executeQuery) {
        echo (json_encode(array('statusCode' => '1', 'message' => 'Event submitted!')));
    } else {
        echo (json_encode(array('statusCode' => '0', 'message' => 'Error while submitting event!')));
    }
    mysqli_close($db_conn);
} else echo (json_encode(array('statusCode' => '4', 'message' => 'Error in method!')));
return;
