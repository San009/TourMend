<?php
if (isset($_POST['email'], $_POST['password'])) {
	require_once 'db_config.php';

	$email = $_POST['email'];
	$password = sha1($_POST['password']);

	$sql = "SELECT * FROM user_info WHERE email='$email' && password='$password'";
	$result = mysqli_query($db_conn, $sql);
	$userDetails = mysqli_fetch_assoc($result);

	if (mysqli_num_rows($result) == 1) {
		if ($userDetails['status'] == 'active') {
			// Successfully Login Message.
			echo (json_encode(array('statusCode' => '1', 'message' => 'Login Matched!')));
		} else {
			echo (json_encode(array('statusCode' => '3', 'message' => 'Activate account first!')));
		}
	} else {
		// If Email and Password did not Matched.
		echo (json_encode(array('statusCode' => '0', 'message' => 'Login Failed!')));
	}

	mysqli_free_result($result);
	mysqli_close($db_conn);
} else echo (json_encode(array('statusCode' => '2', 'message' => 'Error in method!')));
return;
