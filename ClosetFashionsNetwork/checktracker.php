<?php
    include("./dbinfo.inc.php");
    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    @mysql_select_db($mysql_database) or die( "Unable to select database");


   $cuser = $_POST['cuser'];


$query= "SELECT username FROM loads WHERE username = '$cuser'";
    $result=mysql_query($query);
    $num=mysql_numrows($result);
if($num ==0){
$query="INSERT INTO loads VALUES('','$cuser',1)";
     mysql_query($query);
}else{
   
$query= "UPDATE loads SET times=times+1 WHERE username = '$cuser'";

mysql_query($query);
}

$newcount=0;

$querylaston="SELECT laston FROM users WHERE username = '$cuser'";
    $resultlaston=mysql_query($querylaston);
    $laston = mysql_result($resultlaston,0,"laston");

$tempquery = "CREATE TABLE temptracks SELECT * FROM tracks";
mysql_query($tempquery);

$tempquery = "CREATE TABLE tempcomments SELECT * FROM comments";

mysql_query($tempquery);

$query="(SELECT * FROM posts JOIN tracks WHERE (tracks.username = '$cuser' AND posts.username = tracks.touser) OR (tracks.username ='$cuser' AND tracks.touser = '$cuser' AND posts.username ='$cuser'))

UNION (SELECT * FROM comments JOIN tracks WHERE (tracks.username = '$cuser' AND comments.username = tracks.touser) OR (tracks.username ='$cuser' AND tracks.touser = '$cuser' AND comments.username ='$cuser') OR (tracks.username ='$cuser' AND tracks.touser = '$cuser' AND comments.touser ='$cuser')) 

UNION (SELECT * FROM comments JOIN tempcomments WHERE tempcomments.username = '$cuser' AND comments.topost = tempcomments.topost AND comments.touser = tempcomments.touser AND comments.username != '$cuser' AND comments.touser != '$cuser') 


UNION (SELECT * FROM likes JOIN tracks WHERE (tracks.username = '$cuser' AND likes.username = tracks.touser) OR (tracks.username ='$cuser' AND tracks.touser = '$cuser' AND likes.touser ='$cuser'))

UNION (SELECT * FROM tracks JOIN temptracks WHERE (temptracks.username = '$cuser' AND tracks.username = temptracks.touser) OR (temptracks.username ='$cuser' AND temptracks.touser = '$cuser' AND tracks.touser ='$cuser'))

ORDER BY 8 DESC";
    
$result=mysql_query($query);
    $num=mysql_numrows($result);
    
   $query="DROP TABLE temptracks";
   mysql_query($query);

$query="DROP TABLE tempcomments";
   mysql_query($query);

$query="DROP TABLE tempposts";
   mysql_query($query);

$query="DROP TABLE templikes";
   mysql_query($query);


$t=0;
if($t<$num){
$username =            mysql_result($result,$t,"username");
   $type = mysql_result($result,$t,"type");
   $time = mysql_result($result,$t,"time");

while($time > $laston && $t<$num)
{
  if ($t != $num-1)
{
    $usernamen = mysql_result($result,$t+1,"username");
$timen = mysql_result($result,$t+1,"time");
$typen = mysql_result($result,$t+1,"type");

if($usernamen == $username && $timen == $time && $typen==$type){}
else{
     
      $newcount++;
}

}//close if t is not equal num - 1
else {
$newcount++;}

$t++;

if($t<$num){
$username =            mysql_result($result,$t,"username");
   $type = mysql_result($result,$t,"type");
   $time = mysql_result($result,$t,"time");}//close

}//close while

}//close if t less than num


echo "$newcount";

mysql_close();


?>