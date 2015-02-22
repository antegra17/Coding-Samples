<?php
  
    include("./dbinfo.inc.php");

    include("./functions.php");


    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    
    @mysql_select_db($mysql_database) or die( "Unable to select database");
    
   $cuser = $_POST['cuser'];
$about= $_POST['about'];
$pref=$_POST['pref'];
$country=$_POST['country'];

$pref=str_replace('1-9-1','\\&',$pref);
$about=str_replace('1-9-1','\\&',$about);



$query= "UPDATE users SET description='$about' WHERE username = '$cuser'";
mysql_query($query);

$query= "UPDATE users SET preferences='$pref' WHERE username = '$cuser'";
mysql_query($query);

$query="SELECT * FROM users WHERE username = '$cuser'";
$result=mysql_query($query);
$oldcty=mysql_result($result,0,"country");

$query= "UPDATE countries SET numusers=numusers-1 WHERE country = '$oldcty'";


$query= "UPDATE users SET country='$country' WHERE username = '$cuser'";
mysql_query($query);




$query="SELECT * countries WHERE country = '$country'";
$result=mysql_query($query);
$num=mysql_numrows($result);

if($num == 0){
$query="INSERT INTO countries VALUES('','$country',1,0)";
     mysql_query($query);
} else{
$query= "UPDATE countries SET numusers=numusers+1 WHERE country = '$country'";
mysql_query($query);
}



    
echo "1";
    mysql_close();


?>
