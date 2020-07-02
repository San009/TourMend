<?php
	include('db_config.php');

	$email = $_POST['email'];
	$username = $_POST['username'];
	$password = $_POST['password'];

	
	$checkEmail = " SELECT * FROM user_info WHERE email = '$email' ";

	$checkresultEmail = mysqli_query($db_conn, $checkEmail);
	//check if email already exists	
	if (mysqli_num_rows($checkresultEmail) > 0) {
		echo (json_encode(array('statusCode' => '2', 'message' => 'This email address already has an account')));
		return;
	} else {
		$hashedPassword = sha1($password);
		$sql = "INSERT INTO user_info (username, email, password) VALUES ('$username', '$email', '$hashedPassword')";
		
		$executeQurey = mysqli_query($db_conn, $sql);

		if($executeQurey) {
			echo (json_encode(array('statusCode' => '1', 'message' => 'User successfully registered!')));
	   	} else {
			echo (json_encode(array('statusCode' => '0', 'message' => 'Error while registering user!')));
		}
	}

	mysqli_close($db_conn);
	return;

 ?>
