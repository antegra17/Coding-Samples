<?php
    include("./dbinfo.inc.php");
include("./functions.php");
    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    @mysql_select_db($mysql_database) or die( "Unable to select database");

$username = $_POST['username'];
$set = $_POST['set'];

$jsontracks['username'] = array();
$jsontracks['foruser'] = array();
$jsontracks['set'] = array();

array_push ($jsontracks['foruser'],$username);
array_push ($jsontracks['set'],$set);

if($set=='tracks'){

$query="SELECT * FROM tracks WHERE username = '$username' ORDER BY touser ASC";
$result = mysql_query($query);
$num=mysql_numrows($result);
}
else if($set=='trackers'){

$query="SELECT * FROM tracks WHERE touser = '$username' ORDER BY username ASC";
$result = mysql_query($query);
$num=mysql_numrows($result);
}

$i=0;
while($i < $num){


if($set=='tracks'){
$touser = mysql_result($result, $i, "touser");
array_push ($jsontracks['username'],$touser);
}else{
$user = mysql_result($result, $i, "username");
array_push ($jsontracks['username'],$user);
}



$i++;
}
mysql_close();

require_once("./json/JSON.php");
$json = new Services_JSON();
 
echo json_encode($jsontracks);

?>
