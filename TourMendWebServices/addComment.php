<?php
require_once 'db_config.php';

if (isset($_POST['comment'], $_POST['email'], $_POST['newsId'])) {

    $comment = $_POST['comment'];
    $email = $_POST['email'];
    $newsIdString = $_POST['newsId'];
    $newsId = intval($newsIdString);

    $idQuery = "SELECT id from user_info WHERE email = '$email'";
    $getId = mysqli_query($db_conn, $idQuery);

    $date = date('m/d/Y h:i');



    if ($result = mysqli_fetch_assoc($getId)) {
        $userIdString = $result['id'];
        $userId = intval($userIdString);
        $commentQuery = "INSERT INTO comment_news (user_id, comment, date, news_id) VALUES ('$userId', '$comment', '$date', '$newsId')";
        $addCommment = mysqli_query($db_conn, $commentQuery);
        if ($addCommment) {
            echo (json_encode(array('statusCode' => '1', 'message' => 'Comment added!')));
        } else {
            echo (json_encode(array('statusCode' => '0', 'message' => 'Error while adding comment!')));
        }
    } else {
        echo (json_encode(array('statusCode' => '2', 'message' => 'Error while fetching id!')));
    }
} else {
    echo (json_encode(array('statusCode' => '3', 'message' => 'Error in method!')));
}
