<?php

if (isset($_GET['page_number'], $_GET['news_id'])) {

    require_once 'db_config.php';

    $news_id = $_GET['news_id'];
    $page_number = $_GET['page_number'];
    $item_count = 6;
    // array for the final response
    $response = array();

    $to = ($page_number - 1) * $item_count;

    $sql = "SELECT * FROM comment_news WHERE news_id = '$news_id' ORDER BY date LIMIT $item_count OFFSET $to";

    $result = mysqli_query($db_conn, $sql);

    if ($result) {
        if (mysqli_num_rows($result) <= 6 && mysqli_num_rows($result) != 0) {
            $response['statusCode'] = '1';
            $response['message'] = 'Comments fetched successfully!';
            $rowArray =  array();

            while ($commentData = mysqli_fetch_assoc($result)) {
                $userInfo = "SELECT username, image FROM user_info WHERE id = '" . $commentData['user_id'] . "'";
                $executeUserInfo = mysqli_query($db_conn, $userInfo);
                $userData = mysqli_fetch_assoc($executeUserInfo);

                $rowItems = array(
                    'id' => $commentData['id'],
                    'userName' => $userData['username'],
                    'userImage' => $userData['image'],
                    'comment' => $commentData['comment'],
                    'date' => $commentData['date'],
                );
                array_push($rowArray, $rowItems);
            }

            $response['comments'] = $rowArray;
            echo json_encode($response);
        } else {
            $response['statusCode'] = '2';
            $response['message'] = 'No more comments available!';

            echo json_encode($response);
        }
        mysqli_close($db_conn);
    } else {
        $response['statusCode'] = '0';
        $response['message'] = 'Couldn\'t fetch comments! Internal server error.';
        echo json_encode($response);
    }
} else echo json_encode(array('statusCode' => '3', 'message' => 'Error in method!'));
return;
