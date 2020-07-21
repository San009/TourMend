<?php



if (isset($_POST['eventaddress'], $_POST['description'])) {
    include('db_config.php');

    $eventaddress = $_POST['eventaddress'];
    $description = $_POST['description'];
    $eventType =$_POST['eventType'];
      
            $sql = "INSERT INTO tbl_events (eventaddress, eventType,description) VALUES ('$eventaddress','$eventType','$description')";

            $executeQurey = mysqli_query($db_conn, $sql);

            if ($executeQurey) {
                echo (json_encode(array('statusCode' => '1', 'message' => 'User successfully registered!')));
            } else {
                echo (json_encode(array('statusCode' => '0', 'message' => 'Error while registering user!')));
            }
        
    

    mysqli_close($db_conn);
  
	
	
} else echo (json_encode(array('statusCode' => '4', 'message' => 'Error in method!')));
return;