<?php
  
    include("./dbinfo.inc.php");

    include("./functions.php");


    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    
    @mysql_select_db($mysql_database) or die( "Unable to select database");
    
   $username = $_POST['username'];
$touser= $_POST['touser'];
$set=$_POST['set'];

$jsontrack['set'] = array();
$jsontrack['touser'] = array();
$jsontrack['check'] = array();

if($set == 'check' || $set == 'checkfeed'){
  $query= "SELECT username FROM tracks WHERE username = '$username' AND touser='$touser'";
    $result=mysql_query($query);
    $numcheck=mysql_numrows($result);
array_push ($jsontrack['check'],$numcheck);
}

 
if($set == 'track'){

   $query= "SELECT username FROM users WHERE username = '$username'";
    $result=mysql_query($query);
    $num=mysql_numrows($result);

if($num ==0){
}else{

$query="INSERT INTO tracks VALUES ('','$username','','','$touser','','',CURRENT_TIMESTAMP,'tr',0,0)";
mysql_query($query);


$query= "UPDATE users SET trackers=trackers+1 WHERE username = '$touser'";
mysql_query($query);
    
}
}

else if ($set == 'untrack'){
$query="DELETE FROM tracks WHERE username='$username' AND touser='$touser'";
mysql_query($query);

$query= "UPDATE users SET trackers=trackers-1 WHERE username = '$touser'";
mysql_query($query);
     
}
    
   


array_push ($jsontrack['set'],$set);
array_push ($jsontrack['touser'],$touser);


    mysql_close();

require_once("./json/JSON.php");
$json = new Services_JSON();
echo json_encode($jsontrack);

?>
