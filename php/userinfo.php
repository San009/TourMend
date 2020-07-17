<?php
 	include('db_config.php');

 $response=array();
// $id=$_GET['userId'];
$email=$_GET['email'];
 
  $sql = "SELECT 
    email,username FROM user_info where email='$email' ";
if($result=mysqli_query($db_conn,$sql))
{
$response['error']=false;

$row= mysqli_num_rows($result);

if ($row>0) {
	
 while($row= mysqli_fetch_assoc($result))
{
	$output[]=$row;	
}
echo ($result) ? 
json_encode(array( "code" => 1,"result"=>$output)) :
json_encode(array("code" => 0,"message"=>"Data not found !"));

}

}

 mysqli_close($db_conn);

 ?>