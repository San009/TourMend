<?php

	require_once 'db_config.php';

	
	$username = $_POST['username'];
	$password = sha1($_POST['password']);


	$sql = "SELECT * FROM user_info WHERE  password='$password'";
	$result = mysqli_query($db_conn, $sql);
	$row = mysqli_fetch_array($result);

	if (mysqli_num_rows($result) == 1) {

			$sql = "UPDATE user_info SET username='$username' WHERE password='$password'";

			$executeQurey = mysqli_query($db_conn, $sql);
			if ($executeQurey) {
				echo (json_encode(array('statusCode' => '1', 'message' => 'Profile successfully updated!')));
			} else {
				echo (json_encode(array('statusCode' => '0', 'message' => 'Error while updating profile!')));
			}
		
	} else {
		// If Email and Password did not Matched.
		echo (json_encode(array('statusCode' => '3', 'message' => 'Invalid password!')));
	}
	mysqli_free_result($result);
	mysqli_close($db_conn);
return;
