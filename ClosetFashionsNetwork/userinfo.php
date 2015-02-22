<?php
    include("./dbinfo.inc.php");
    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    @mysql_select_db($mysql_database) or die( "Unable to select database");
   $username = $_GET['username'];


$query= "SELECT username FROM users WHERE username = '$username'";
    $result=mysql_query($query);
    $num=mysql_numrows($result);
    
    echo  "user count: $num <br>";
    
    
    
    $i=0;
    while ($i < $num)
    {
             $id= mysql_result($result,0,"id");
        $username = mysql_result($result,0,"username");
    
        $country= mysql_result($result,0,"country");
$pw= mysql_result($result,0,"pw");
$laston= mysql_result($result,0,"laston");

        
        echo " $i) $username, $country,$pw";

   
        $i++;
}

mysql_close();

?>