
           <?php   
           include('db_config.php');
           $sql = "SELECT * FROM tbl_places";  
           
// Creating SQL command to fetch all records from Fruits Table.

  
$result = $db_conn->query($sql);
 
if ($result->num_rows >0) {
 
 
 while($row[] = $result->fetch_assoc()) {
 
 $item = $row;
 
 $json = json_encode($item);
 
 }
 
} else {
 echo "No Data Found.";
}
 echo $json;
 $db_conn->close();
 
?>