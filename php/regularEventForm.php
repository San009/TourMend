<?php



if (isset($_POST['eventName'],$_POST['eventAddress'],$_POST['description'],$_POST['fromDate'],$_POST['toDate'])) {
    include('db_config.php');


    $fromDate = $_POST['fromDate'];
    $toDate = $_POST['toDate'];
    $eventName = $_POST['eventName'];
    $eventAddress = $_POST['eventAddress'];
    $description = $_POST['description'];
    $approval = "pending";
   

   $sql = "INSERT INTO tbl_events (eventName, eventAddress, fromDate, toDate, description,approval) VALUES ('$eventName','$eventAddress','$fromDate','$toDate','$description','$approval')";


    $executeQurey = mysqli_query($db_conn, $sql);

            if ($executeQurey) {
                echo (json_encode(array('statusCode' => '1', 'message' => 'Event submitted!')));
            } else {
                echo (json_encode(array('statusCode' => '0', 'message' => 'Error while submitting event!')));
            }
        
    

    mysqli_close($db_conn);
  
	
	
} else echo (json_encode(array('statusCode' => '4', 'message' => 'Error in method!')));
return;