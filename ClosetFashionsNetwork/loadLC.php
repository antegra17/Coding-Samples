<?php
  
    include("./dbinfo.inc.php");
include("./functions.php");

    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    
    @mysql_select_db($mysql_database) or die( "Unable to select database");
    
   $username = $_POST['username'];
   $set = $_POST['set'];
   $mode = $_POST['mode'];
$guser = $_POST['guser'];
$country = $_POST['country'];

$jsonfeed = returnLC($username,$set,$mode,$guser,$country);

mysql_close();

require_once("./json/JSON.php");
$json = new Services_JSON();
 
echo json_encode($jsonfeed);
    



?>