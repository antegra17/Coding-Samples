<?php
    include("./dbinfo.inc.php");
include("./functions.php");
    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    @mysql_select_db($mysql_database) or die( "Unable to select database");

$searchuser = $_POST['searchuser'];

$jsonsearch['username'] = array();
$jsonsearch['searchuser'] = array();
$jsonsearch['set'] = array();

array_push ($jsonsearch['searchuser'],$searchuser);
array_push ($jsonsearch['set'],$set);


$query="SELECT * FROM users WHERE username = '$searchuser' ORDER BY username ASC";
$result = mysql_query($query);
$num=mysql_numrows($result);


$i=0;
while($i < $num){



$username = mysql_result($result, $i, "username");
array_push ($jsonsearch['username'],$username);



$i++;
}
mysql_close();

require_once("./json/JSON.php");
$json = new Services_JSON();
 
echo json_encode($jsonsearch);

?>
