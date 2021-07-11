<?php
        ob_start();
        $db_server="localhost";
        $db_username="root";
        $db_password="";
        $db_database="tourmend_db";


        $db_conn = mysqli_connect($db_server, $db_username, $db_password, $db_database, 3306);

        if (mysqli_connect_error($db_conn)) {
            die ("Failed to connect! " . mysqli_connect_error());
            return;
        }
?>