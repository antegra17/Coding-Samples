<?php
    include("./dbinfo.inc.php");
 include("./functions.php");



    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    
    @mysql_select_db($mysql_database) or die( "Unable to select database");
   
   $username = $_POST['username'];
   $touser = $_POST['touser'];
   $topost = $_POST['topost'];
   $comment= $_POST['comment'];
    $time=$_POST['time'];
$set= $_POST['set'];
$slp = $_POST['slp'];

$comment=str_replace('1-9-1','\\&',$comment);

 
if ($set=="addrecent" || $set=="loadalladd"){

   $query= "SELECT username FROM users WHERE username = '$username'";
    $result=mysql_query($query);
    $num=mysql_numrows($result);
if($num ==0){
}else{
   $query="INSERT INTO comments VALUES('','$username','','','$touser','$topost','$comment',CURRENT_TIMESTAMP,'co',0,0)";
     mysql_query($query);

$query= "UPDATE posts SET numcomments=numcomments+1 WHERE username = '$touser' AND postnum = '$topost'";

mysql_query($query);
}
}
if ($set=="removerecent" || $set=="removeall"){
    $query="DELETE FROM comments WHERE comments.username='$username' AND comments.touser='$touser' AND comments.topost='$topost' AND comments.time='$time'";
    mysql_query($query);

$query= "UPDATE posts SET numcomments=numcomments-1 WHERE username = '$touser' AND postnum = '$topost'";

mysql_query($query);


}

$jsoncomments = returnComments($touser,$topost,$set);

    mysql_close();

require_once("./json/JSON.php");
$json = new Services_JSON();

sleep(1);
 
echo json_encode($jsoncomments);

?>