<?php
include('db_config.php');
    $image = $_FILES['image'];
    
 
    $imagePath='uploads/'.$image;
    $tmp_name =$_FILES['image'];
    move_uploaded_file($tmp_name,$imagePath);
    $sql = "INSERT INTO user_info (image) VALUES ('$image')";
    $executeQurey = mysqli_query($db_conn, $sql);
    mysqli_close($db_conn);
	return;
 
?>