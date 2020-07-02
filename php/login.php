<?php
	include('db_config.php');
    
	$email = $_POST['email'];
	$password = sha1($_POST['password']);

	$sql="SELECT * FROM user_info WHERE email='$email' && password='$password'";
	$result=mysqli_query($db_conn, $sql);
	$row=mysqli_fetch_array($result);

	$count=$result->num_rows;

	if($count==1) {
		// Successfully Login Message.
		echo (json_encode(array('statusCode' => '1', 'message' => 'Login Matched')));
		
	} else {
		// If Email and Password did not Matched.
		echo (json_encode(array('statusCode' => '0', 'message' => 'Login Failed')));
	}

	mysqli_free_result($result);
	mysqli_close($db_conn);
	return;
?>