<?php
  
    include("./dbinfo.inc.php");

    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    
    @mysql_select_db($mysql_database) or die( "Unable to select database");
   
   $username = $_POST['username'];
   $touser = $_POST['touser'];
   $topost = $_POST['topost'];
   $set = $_POST['set'];
   $slp = $_POST['slp'];




$jsonlikes['check'] = array();
$jsonlikes['set'] = array();
$jsonlikes['touser'] = array();
$jsonlikes['topost'] = array();

array_push ($jsonlikes['set'],$set);
array_push ($jsonlikes['touser'],$touser);
array_push ($jsonlikes['topost'],$topost);



if ($set=='add'){
   $query= "SELECT username FROM users WHERE username = '$username'";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);
if($num ==0){
}else{
  
   $query="INSERT INTO likes VALUES('','$username','','','$touser','$topost','',CURRENT_TIMESTAMP,'li',0,0)";
     mysql_query($query);

$query= "UPDATE posts SET numlikes=numlikes+1 WHERE username = '$touser' AND postnum = '$topost'";

mysql_query($query);

}
}


if($set == 'check' || $set== 'checkseq' || $set=='add'){
  $query= "SELECT username FROM likes WHERE username = '$username' AND touser='$touser' AND topost='$topost'";
    $result=mysql_query($query);
    $numcheck=mysql_numrows($result);
array_push ($jsonlikes['check'],$numcheck);
}


$query="SELECT * FROM likes WHERE likes.touser='$touser' AND likes.topost='$topost'";

$resultlikes=mysql_query($query);

$numlikes=mysql_numrows($resultlikes);
$jsonlikes['userwholiked'] = array();

$c=0;
    while ($c < $numlikes)
    {
$username=mysql_result($resultlikes,$c,"username");

array_push ($jsonlikes['userwholiked'],$username);


$c++;
    } 

    mysql_close();

require_once("./json/JSON.php");
$json = new Services_JSON();

    sleep(1);



echo json_encode($jsonlikes);
?>