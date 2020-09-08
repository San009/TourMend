<?php

if (isset($_GET['page_number'])) {

    require_once 'db_config.php';

    $page_number = $_GET['page_number'];
    $item_count = 6;
    // array for the final response
    $response = array();

    $to = ($page_number - 1) * $item_count;

    $sql = "SELECT * FROM tbl_news ORDER BY headLine LIMIT $item_count OFFSET $to";

    $result = mysqli_query($db_conn, $sql);

    if ($result) {
        if (mysqli_num_rows($result) <= 6 && mysqli_num_rows($result) != 0) {
            $response['statusCode'] = '1';
            $response['message'] = 'Data fetched successfully!';
            $rowArray =  array();

            while ($row = mysqli_fetch_assoc($result)) {
                $rowItems = array(
                    'id' => $row['id'],
                    'headLine' => $row['headLine'],
                    'image' => $row['image'],
                    'des'=> $row['des'],
                    
                );
                array_push($rowArray, $rowItems);
            }

            $response['news'] = $rowArray;
            echo json_encode($response);
        } else {
            $response['statusCode'] = '2';
            $response['message'] = 'No more data available!';

            echo json_encode($response);
        }
        mysqli_close($db_conn);
    } else {
        $response['statusCode'] = '0';
        $response['message'] = 'Couldn\'t fetch data! Internal server error.';
        echo json_encode($response);
    }
} else echo json_encode(array('statusCode' => '3', 'message' => 'Error in method!'));
return;
