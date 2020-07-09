<?php
	include('db_config.php');
 $page_number=$_GET['page_number'];
 $item_count=4;

 $to=($page_number-1)*$item_count;
 $response=array();
 $sql="SELECT * FROM tbl_places ";


$result=mysqli_query($db_conn,$sql);
$No_OF_ITEMS=mysqli_num_rows($result);
if($to>$No_OF_ITEMS){
    
    print( "{'status':'End of the page'}");
}

 else
 {
   
   
 $query = "SELECT  * FROM tbl_places  placename LIMIT  $item_count OFFSET $to "; 
      
         if($result=mysqli_query($db_conn,$query))
{
$response['error']=false;

$row= mysqli_num_rows($result);

if ($row>0) {
	
 while($row= mysqli_fetch_assoc($result))
{
	$output[]=$row;	
}
print  (  json_encode($output) );

}

}
         
     }
     
 
 
 
  
	

 


 mysqli_close($db_conn);

 ?>