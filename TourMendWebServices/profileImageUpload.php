<?php
include('db_config.php');
$image = $_FILES['image'];
$email = $_GET['email'];


$sql = "SELECT image FROM user_info where email='$email'";
if ($result = mysqli_query($db_conn, $sql)) {
	$row = mysqli_num_rows($result);

	if (mysqli_num_rows($result) == 1) {

		while ($row = mysqli_fetch_assoc($result)) {
			$output[] = $row;
		}

		$dlt = $output[0]['image'];

		$file = "Images/profileImages/" . $dlt;
		unlink($file);



		$image = $_FILES['image']['name'];
		$name = "IMG_PROFILE";
		$date = date('mdYhi');
		$ext = ".png";
		$imagePath = 'Images/profileImages/' . $name . $date . $ext;
		$tmp_name = $_FILES['image']['tmp_name'];

		move_uploaded_file($tmp_name, $imagePath);

		$db_conn->query("UPDATE user_info SET image='$name$date$ext' WHERE email='$email'");
	}
} else {
	// If Email and Password did not Matched.
	echo (json_encode(array('statusCode' => '3', 'message' => 'Invalid password!')));
}



mysqli_free_result($result);
mysqli_close($db_conn);
return;
