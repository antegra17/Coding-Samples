<?php
  
    include("./dbinfo.inc.php");
include("./functions.php");

    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    
    @mysql_select_db($mysql_database) or die( "Unable to select database");
    
   $username = $_POST['username'];
   $postnum = $_POST['postnum'];
   $description = $_POST['description'];
   $set = $_POST['set'];
 
if ($set == 'add'){
$query="INSERT INTO posts VALUES ('','$username','$postnum','$description','','','',CURRENT_TIMESTAMP,'po','','')";
mysql_query($query);

$query="SELECT * FROM users WHERE username = '$username'";
$ctyresult = mysql_query($query);

$country = mysql_result($ctyresult,0,"country");



$query= "UPDATE countries SET numposts=numposts+1 WHERE country = '$country'";
mysql_query($query);

$query="SELECT * FROM countries WHERE country = '$country'";
$ctyresult = mysql_query($query);

$countrygot = mysql_result($ctyresult, 0, "country");
$numusers = mysql_result($ctyresult, 0, "numusers");
$numposts = mysql_result($ctyresult, 0, "numposts");

//echo "$countrygot gots $numusers users //$numposts posts";



}
else if ($set == 'remove'){
$query="DELETE FROM comments WHERE touser='$username' AND topost='$postnum'";

mysql_query($query);

$query="DELETE FROM likes WHERE touser='$username' AND topost='$postnum'";

mysql_query($query);

$query="DELETE FROM posts WHERE username='$username' AND postnum='$postnum'";

unlink('./users/'.$username.'/'.$postnum.'.png');
}
    
     mysql_query($query);

if ($set=='retrieve' || $set=='retrievefeed' || $set=='remove'){

$jsonpost = returnPost($username,$postnum,$set);

mysql_close();

require_once("./json/JSON.php");
$json = new Services_JSON();
 
echo json_encode($jsonpost);

 }
else
    
mysql_close();


?>
