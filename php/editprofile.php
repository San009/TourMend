<?php
	include('db_config.php');

	$email = $_POST['email'];
	$username = $_POST['username'];
	$password = sha1($_POST['password']);
	$sql="SELECT * FROM user_info WHERE  password='$password'";
	$result=mysqli_query($db_conn, $sql);
	$row=mysqli_fetch_array($result);

	$count=$result->num_rows;
	if($count==1) {
	
	$checkEmail = " SELECT * FROM user_info WHERE email = '$email' ";

	$checkresultEmail = mysqli_query($db_conn, $checkEmail);
	//check if email already exists	
	if (mysqli_num_rows($checkresultEmail) > 0) {
		echo (json_encode(array('statusCode' => '2', 'message' => 'This email address already has an account')));
		return;
	} else {
		
		$sql = "UPDATE  user_info SET username='$username', email='$email' WHERE password='$password'";
		
		$executeQurey = mysqli_query($db_conn, $sql);
	}
		if($executeQurey) {
			echo (json_encode(array('statusCode' => '1', 'message' => 'User successfully updated!')));
	   	} else {
			echo (json_encode(array('statusCode' => '0', 'message' => 'Error while updating user!')));
		}
}else {
	// If Email and Password did not Matched.
	echo (json_encode(array('statusCode' => '0', 'message' => 'Login Failed')));
}
mysqli_free_result($result);
	mysqli_close($db_conn);
	return;

 ?>
