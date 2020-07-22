<?php



if (isset($_POST['eventAddress'],$_POST['description'],$_POST['eventType'])) {
    include('db_config.php');

    $eventaddress = $_POST['eventAddress'];
    $description = $_POST['description'];
    $eventType =$_POST['eventType'];
      
            $sql = "INSERT INTO tbl_events (eventAddress, eventType,description) VALUES ('$eventaddress','$eventType','$description')";

            $executeQurey = mysqli_query($db_conn, $sql);

            if ($executeQurey) {
                echo (json_encode(array('statusCode' => '1', 'message' => 'Event submitted!')));
            } else {
                echo (json_encode(array('statusCode' => '0', 'message' => 'Error while submitting event!')));
            }
        
    

    mysqli_close($db_conn);
  
	
	
} else echo (json_encode(array('statusCode' => '4', 'message' => 'Error in method!')));
return;