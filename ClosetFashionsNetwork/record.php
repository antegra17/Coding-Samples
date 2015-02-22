<?php
    include("./dbinfo.inc.php");
    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    @mysql_select_db($mysql_database) or die( "Unable to select database");

   $u= urldecode($_POST['u']);
   $t= urldecode($_POST['t']);
   $tc= urldecode($_POST['tc']);
   $tb= urldecode($_POST['tb']);
   $to= urldecode($_POST['to']);

   $b= urldecode($_POST['b']);
   $bc= urldecode($_POST['bc']);
   $bb= urldecode($_POST['bb']);
   $bo= urldecode($_POST['bo']);

   $f= urldecode($_POST['f']);
   $fc= urldecode($_POST['fc']);
   $fb= urldecode($_POST['fb']);
   $fo= urldecode($_POST['fo']);

   $o= urldecode($_POST['o']);
   $oc= urldecode($_POST['oc']);
   $ob= urldecode($_POST['ob']);
   $oo= urldecode($_POST['oo']);


$query="INSERT INTO outfits VALUES('','$u','$t','$tc','$tb','$to','$b','$bc','$bb','$bo','$f','$fc','$fb','$fo','$o','$oc','$ob','$oo')";


     mysql_query($query);



mysql_close();


?>